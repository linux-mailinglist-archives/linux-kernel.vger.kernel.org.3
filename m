Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E74FE575
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiDLP6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357469AbiDLP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:57:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB18388
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40D2ACE1F65
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0B4C385A1;
        Tue, 12 Apr 2022 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649778889;
        bh=dbQHjtWTndQ3IhJbJ7Bf8ue3XoQqen/tZP8psUGBdro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0Flk52zzKTiOJtrDbgYOw3HQZfvDWYR5IKWnmBiBv05GWrNgJEFRwVa7lDxf2EDo
         SZIZG3XhBYGNiBN8PR23PBJWk6w73PpfhJ23BSXmSq0vypF4dM+TRah0cQD6APe0xP
         zZBeatO+KMyPwMoUvG1R1aTl//Qvq68wnbq4gPXw=
Date:   Tue, 12 Apr 2022 17:54:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vme: Adjusted VME_USER in Kconfig
Message-ID: <YlWgxjZk8kiwARtL@kroah.com>
References: <20220401050045.3686663-1-codeagain@codeagain.dev>
 <YkaW0ThT8Ah3z0wW@kroah.com>
 <YkaXRpIElW1BwKGb@kroah.com>
 <37e5203d1efd310ea82cf91c18c6a07eea743ac7.camel@codeagain.dev>
 <Ykl/iBR+pDaaLImA@kroah.com>
 <20220412151432.zsdxrag7myyzgv6o@AN5Bruno>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412151432.zsdxrag7myyzgv6o@AN5Bruno>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:14:32PM -0300, Bruno Moreira-Guedes wrote:
> On Sun, Apr 03, 2022 at 01:05:44PM +0200, Greg Kroah-Hartman wrote:
> > 
> >On Fri, Apr 01, 2022 at 03:21:50PM -0300, Bruno wrote:
> >> With my tests in my, I have found two other things that I think are
> >> remarkable to mention. First one is a missing `depends on` line for
> >> `VME_BRIDGE` in drivers/staging/vme/devices/Kconfig, not visible
> >> because they were in the same tree, but now unveiled. I'm fixing it,
> >> do you think it's best to add it in the same patch?
> > 
> > Make that a second patch, and resend it as part of a patch series since
> > your first patch here is gone from my queue.
> 
> This patch is already sent, so I'll trim most of this message to avoid
> duplicating the discussions. There's only one thing I'd like some input
> first, if you don't mind.
> 
> >> Do you think it would be interesting for a future patch to provide
> >> some output when drivers from the staging tree are present in the
> >> running kernel image?
> > 
> > If you can figure out how to do so, that would be interesting to see.
> I think I might have figured out. In "include/modules.h" and
> "include/init.h" I happened to notice the driver initialization is
> handled by some macros. After some inspection through gcc -E and looking
> how they are defined, I figured out a scenario (when MODULE is not
> defined) where the module_init() macro is defined as (among other
> things) an inline initcall function that wraps the driver initialization
> function.
> 
> So I thought about implementing it by creating a -DSTAGING flag in 
> drivers/staging/Makefile, and then using this macro to make an #ifdef
> STAGING to add a similar inline wrapping function, except that in this
> case the function makes a pr_warning() before calling the initialization
> function.
> 
> Do you think it would be a good way of solving that?

Yes, that would be a possible way, try it and see!

greg k-h
