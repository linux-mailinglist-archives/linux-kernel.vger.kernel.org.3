Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF954DC53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359571AbiFPH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359075AbiFPH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:59:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF0A5B88E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 267A4B8216B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C85C34114;
        Thu, 16 Jun 2022 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655366359;
        bh=41Nfy8nYx5+5ii3qZFKdbZr8M6cIMyD7SxlE9FrazxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7Esxt5DI+0KOn270wjP8jdVV/ksDpVj8xg52yQJY0c7etBJVRW6xv1jYy8+arQrv
         EhVf5jTfMUTiPeMdtY7BAGrE3HCrC6SyoAPMjktP2PYxVuIQPojYldEP9JdRhzahYe
         rKUd/KmpDow1oaPXbHiZ4YctE/Q7s0qFXNbi9WuEIWo3O4UVbXI7xpdu55ggsOiI9A
         ZNzWl0B35u9PC2ozvwZY13y0MGzblcIMQ7adTRAE2eZYBCTJ9p/FNgxBEc0F4pnenC
         tNbIwUKcMhy2qMFDulbpM8+guS+8824q8jK3zSEWnCZJJPHOZ3MNA+esCOQ9hUidG1
         Ha9SQLuD+hXLw==
Date:   Thu, 16 Jun 2022 09:59:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fs fix for v5.19-rc3
Message-ID: <20220616075915.otq7xzchci5jbh6z@wittgenstein>
References: <20220615103751.2342910-1-brauner@kernel.org>
 <CAHk-=win6+ahs1EwLkcq8apqLi_1wXFWbrPf340zYEhObpz4jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=win6+ahs1EwLkcq8apqLi_1wXFWbrPf340zYEhObpz4jA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:31:32AM -0700, Linus Torvalds wrote:
> On Wed, Jun 15, 2022 at 3:39 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > This fixes an issue where we fail to change the group of a file when the caller
> > owns the file and is a member of the group to change to. This is only relevant
> > on idmapped mounts.
> 
> Pulled, but this code makes me go "Eww".
> 
> I do get the feeling that maybe we should have some kind of static
> type help here, with "unmapped" and "filesystem mapped" uid/gid values
> having different types, the same way we have kuid_t vs uid_t for
> user-namespace mapping.
> 
> Because it feels like the problem here is that "kgid_t" has different
> meanings depending on context.
> 
> In fact, just within that one function, we have *three* very different kgid_t's:
> 
>  - the argument to the function is a "kgid_t gid", which has *not*
> been mapped into the filesystem mapping (why not?)
> 
>  - the function itself declares a "kgid_t kgid", which is the inode
> group ID mapped into the mount
> 
>  - it how additionally has that thied "kgid_t mapped_gid", which is
> the first 'gid' mapped into the mount
> 
> and honestly, I find that hugely confusing. The naming doesn't exactly
> clarify things either (ie "gid" is a "kgid_t", not a "git_t", and so
> is "kgid" - not helpful).
> 
> And being confusing with no type system support isn't a great thing.
> 
> So I'm wondering if <linux/mnt_idmapping.h> might be able to do the
> same kind of things we do in <linux/uidgid.h>.
> 
> NOTE: I did not look into just how hugely painful that would be. Maybe
> the above is the rantings of a madman.

I'm actually looking into this and have been for a while. I had thought
about this from the start but just now have time to play with this!
