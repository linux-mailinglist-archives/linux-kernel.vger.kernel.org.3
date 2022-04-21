Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1959509731
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384639AbiDUGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352027AbiDUGKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638510FED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39920B82291
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AC8C385A1;
        Thu, 21 Apr 2022 06:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650521246;
        bh=tJutOd3GoiHApO8x8cRPu2cmW09w1QwvO/Abq1COO+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogeLoKrBGY5L/ck0iWpcANy9i1We9gG89FtUIdKH6rzaaNFDheCi6DGhU3ZVGrL17
         vo7HWgrjbh73xbJSdPh5ACxJBTmmh74IUODEsyRVky5omqEE5rlMkYfhqiA4luA7dD
         UvJWJntkjc7Cl/SLPctM7wL3bKaN20QUwQ47TGQE=
Date:   Thu, 21 Apr 2022 08:07:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 2/3] staging: vme: Add VME_BUS dependency to Kconfig
Message-ID: <YmD0mx+nMsFk4Ohr@kroah.com>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <00de5644d7c2f8c8878eccf86b761e0602732080.1650321310.git.codeagain@codeagain.dev>
 <20220418233929.zz32dil4u6hbwtqv@AN5Bruno>
 <YmA4ILK5Gv/Gdaso@kroah.com>
 <20220420211258.j23biocryjkuz3qo@AN5Bruno>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420211258.j23biocryjkuz3qo@AN5Bruno>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 06:12:58PM -0300, Bruno Moreira-Guedes wrote:
> On Wed, Apr 20, 2022 at 06:43:12PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 18, 2022 at 08:39:29PM -0300, Bruno Moreira-Guedes wrote:
> > > Please, disregard the following message as there's a typo in the prefix.
> > > 
> > > On Mon, Apr 18, 2022 at 08:31:09PM -0300, Bruno Moreira-Guedes wrote:
> > > > The KConfig file for VME_USER ('drivers/staging/vme/devices/Kconfig')
> > > > sourced at "drivers/vme/boards/KConfig" misses a `depends on` line for
> > > > VME_BUS, which is unnoticeable for menuconfig users who aren't be able
> > > > to select it through this interface without setting the CONFIG_VME_BUS
> > > > option because it's nested on VME_BUS menu entry.
> > > ...
> > > >  	  VME windows in a manner at least semi-compatible with the interface
> > > > -- 
> > > > 2.35.3
> > > > 
> > > 
> > > It's already sent a new copy with the proper version number. Nothing's
> > > changed except for the message ID and the v2 typo.
> > 
> > I can't handle 2 v2 of this same commit, our tools get very confused (as
> > do people.)  Would you be able to unwind this if you were in my
> > position?
> I really apologize for this confusion, I really did some mistakes on my
> local branch and had to edit the patches manually to reapply them. While
> working on that I accidentally missed to change the 'v2' to 'v3'. My
> mistake.
> 
> Though, there's no 2 v2s, the new one I sent is a v3 as is the rest of
> this thread. So, would it be necessary to unwind anything anyway? 

Yes, as I don't see a v3 here.  All I see is a mess of commits in a
thread and not a way to easily determine which ones to, and not to,
apply/ignore.

Make it blindingly obvious for me (and everyone else) which is your
latest patch series and which to apply/review.

Remember, some of us get thousands of emails a day to deal with, and
right now I have over 2000 in my review queue to get through.  Making my
life simpler is the best thing if you want your patch to be accepted.

thanks,

greg k-h
