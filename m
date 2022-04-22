Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7663F50B0BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444325AbiDVGnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444475AbiDVGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:42:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4EB50B3E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E458B82A95
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619B2C385A0;
        Fri, 22 Apr 2022 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650609578;
        bh=9yNligLg42qTGCwDgsfnc18X93RVA0YWjVpK6l85LYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Du/D+WacTmgccwMBXa1I0QgQNaTWCbTMAg/IYkHY6EUmKHShaHzA1J5pdnQJlFuII
         DBeRKXKEnoCbCczrKk2Dv1lriuLFRNYA8p0y6Rbr1vki1vkVZGgpOpP+nmz9OTgkL7
         HdnKm/TSe6AGVfKLqx+dNDNEj1MNvwn4j/Sib8ao=
Date:   Fri, 22 Apr 2022 08:39:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martyn Welch <martyn@welchs.me.uk>
Cc:     Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <YmJNqMjXEc4KGrJ8@kroah.com>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <YmA4QIRfx2QPhEJi@kroah.com>
 <3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:16:05PM +0100, Martyn Welch wrote:
> On Wed, 2022-04-20 at 18:43 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wrote:
> > > This patch series modify the vme_user driver's place in
> > > menuconfig (1/3), fixes a missing `depends on` line in a Kconfig
> > > file
> > > (2/3), and rearrages the directory tree for the driver allowing a
> > > more
> > > straightforward comprehension of its contents (3/3).
> > > 
> > > The 'vme_user/' driver is the only remaining vme-family driver in
> > > the
> > > 'staging/' tree, but its structure, entry in menuconfig and
> > > building
> > > routines are still attached to the 'vme/' subtree now outside
> > > 'staging/'. The present patchset fixes it.
> > > 
> > > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> > 
> > What about deleting the vme drivers entirely?
> 
> I assume you're suggesting deleting the "vme_user" driver from the
> staging directory?

Yes, at the very least given that no one has tried to fix it up and get
it out of staging in many years.

> > Martyn, anyone still using these?
> > 
> 
> I'm fairly sure that the actual VME drivers for the hardware bridges
> (the bits not in staging) are still being used based on the
> conversations I've had today. I'm just trying to find out whether the
> vme_user bit is actively being used.

If the non-staging vme drivers are still being used, that's great.  But
if not, those too should be dropped.

thanks,

greg k-h
