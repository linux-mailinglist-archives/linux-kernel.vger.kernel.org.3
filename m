Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACF5B13EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIHFRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:17:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D6BD1F2;
        Wed,  7 Sep 2022 22:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4C27B81F05;
        Thu,  8 Sep 2022 05:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C45C433C1;
        Thu,  8 Sep 2022 05:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662614237;
        bh=aY+4jyT4b1htONdVNHh0+w7cNyo+79xZD5hrCdXk8dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5pKL/olty8aLxKn+CXfeqTREfa79fOg2uq7sV1L01DqLgActG1aXxl+0oG9lyseS
         5WK1SAWX+97YNtmfxmBq+AQ7j7972P96CPf0TPdNp/v+GQXO8HTCNy9oAd3U3W4cDM
         flqxEZu9kOUVAyuAGMq73634K+1JtJ1bcGLWh6k89KKEFwgeFoYuLxGzVIi6OEAz4A
         06+mWlK0PZAd9ZKVSjnF3XW/riivc118E/77O8VhnfTbPFPVR7dQhteO/AGPTZWNAK
         lrEPRsPzKoPkGfR2fO3isX//2gJDeweerOOsscHrt2JR9oO/XRlLdya23ApJ8ENcRt
         vMfvELMKuyo9w==
Date:   Thu, 8 Sep 2022 08:17:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH] security/keys: Remove inconsistent __user annotation
Message-ID: <Yxl614jNUYvYywUc@kernel.org>
References: <20220907121230.21252-1-vincenzo.frascino@arm.com>
 <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
 <CAHC9VhQytyFMvq-M0YrqzKxJDyj58KKG0XDjBfTV02sYCzeALQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQytyFMvq-M0YrqzKxJDyj58KKG0XDjBfTV02sYCzeALQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:43:17AM -0400, Paul Moore wrote:
> On Wed, Sep 7, 2022 at 10:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 9/7/22 05:12, Vincenzo Frascino wrote:
> > > The declaration of keyring_read does not match the definition
> > > (security/keys/keyring.c). In this case the definition is correct
> > > because it matches what defined in "struct key_type::read"
> > > (linux/key-type.h).
> > >
> > > Fix the declaration removing the inconsistent __user annotation.
> > >
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: James Morris <jmorris@namei.org>
> > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > ---
> > > Note: This issue was discovered during the porting of the linux kernel
> > > on Morello [1].
> > >
> > > [1] https://git.morello-project.org/morello/kernel/linux
> >
> > FTR, I have sent this same patch 3 times.
> > Good luck.
> 
> David or Jarkko, this patch is both trivial and obviously correct,
> please merge this into the keys tree for the next merge window else
> I'll take it via the LSM tree.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

I picked it to my tree.

BR, Jarkko
