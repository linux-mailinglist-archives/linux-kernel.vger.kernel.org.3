Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3B511A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiD0NOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiD0NOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:14:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E325B421
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 628CCB826F0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6848C385AC;
        Wed, 27 Apr 2022 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651065051;
        bh=+XL1/pmjJfKpo6NH3R6GZKWySie+sXzNve8evJAXkxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ3p4YhmGkdA9T4JUgl6tUfv5uZfcF8eWjkqjLRu84AAtOkd1ChGYmvaFI8YZWWWg
         kJi1m+oxgElN9Kx32RefgzDdhbafu6n4x19KHa441+i74cRCCZtNFQG2xgLkVwgoDQ
         44rxGyQlHUjO9NDaqAU8eGDypZDOwNoJoF0cs+No=
Date:   Wed, 27 Apr 2022 15:10:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <YmlA1w124Ws2z/RV@kroah.com>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <YmA4QIRfx2QPhEJi@kroah.com>
 <3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk>
 <YmJNqMjXEc4KGrJ8@kroah.com>
 <20220427121851.4e2rjbbabw5sh3lk@AN5Bruno>
 <Ymk3qimGl1tTjpSL@kroah.com>
 <20220427124114.woiiuxr6pnxvadwg@AN5Bruno>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427124114.woiiuxr6pnxvadwg@AN5Bruno>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:41:14AM -0300, Bruno Moreira-Guedes wrote:
> On Wed, Apr 27, 2022 at 02:31:38PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 27, 2022 at 09:18:51AM -0300, Bruno Moreira-Guedes wrote:
> > > Hello,
> > > 
> > > On Fri, Apr 22, 2022 at 08:39:36AM +0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Apr 21, 2022 at 08:16:05PM +0100, Martyn Welch wrote:
> > > > > On Wed, 2022-04-20 at 18:43 +0200, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wrote:
> > > > > > > This patch series modify the vme_user driver's place in
> > > > > > > menuconfig (1/3), fixes a missing `depends on` line in a Kconfig
> > > > > > > file
> > > > > > > (2/3), and rearrages the directory tree for the driver allowing a
> > > > > > > more
> > > > > > > straightforward comprehension of its contents (3/3).
> > > > > > > 
> > > > > > > The 'vme_user/' driver is the only remaining vme-family driver in
> > > > > > > the
> > > > > > > 'staging/' tree, but its structure, entry in menuconfig and
> > > > > > > building
> > > > > > > routines are still attached to the 'vme/' subtree now outside
> > > > > > > 'staging/'. The present patchset fixes it.
> > > > > > > 
> > > > > > > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> > > > > > 
> > > > > > What about deleting the vme drivers entirely?
> > > > > 
> > > > > I assume you're suggesting deleting the "vme_user" driver from the
> > > > > staging directory?
> > > > 
> > > > Yes, at the very least given that no one has tried to fix it up and get
> > > > it out of staging in many years.
> > > 
> > > While I cannot comment anything on that regard, I imagine the v4 I sent
> > > a couple of days ago will wait for that decision, right?
> > 
> > I do not know what you are referring to, sorry.  My staging patch queue
> > is empty right now.
> Ohhh, okay, no problem, I have sent a v4 around 6 days ago and thought
> you were waiting on this definition.

If I did not take it, please resend.

thanks,

greg k-h
