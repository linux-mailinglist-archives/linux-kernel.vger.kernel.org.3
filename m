Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89F5858B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 07:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiG3FMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 01:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiG3FMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 01:12:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE447756C;
        Fri, 29 Jul 2022 22:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B7D1CE2CA6;
        Sat, 30 Jul 2022 05:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A25C433C1;
        Sat, 30 Jul 2022 05:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659157958;
        bh=J0jncB453LqAsaLE70VcuO0s4Eydbl6K2uhHte8LJSk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XtfOXrBuLgp8u1+SVJw6W3HP8/j20L6DiVVK9aavirk0d0c8Uf9AQjZIFBt5hAgzH
         VClBURWfW7mc0eXsEBJC6S3VNFKTFzMJk12sShFJVSbMeRb6c/oo354TvVhQjsopDf
         7Q+y39+mUqwIwStaRwpfa49QSLD/MELtSjZCBdCN2OcdbDsWc1NFsXUE07BCDosti4
         ETj04hZbgwaM7tx1IZ79Dsdi+A7sVHi22JlcquiDwoI6uMA0tVi5Ff8trdBaQqX7/2
         lXYUflkNXZxkRXayIOUh2n+EIKgry3BtARN/CMuFH74ZbOFFUIKQ0Izk1xBqSYBHaa
         d9ohk2f79VdhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 122275C04B1; Fri, 29 Jul 2022 22:12:38 -0700 (PDT)
Date:   Fri, 29 Jul 2022 22:12:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     sfr@canb.auug.org.au, harry.wentland@amd.com, sunpeng.li@amd.com,
        arnd@arndb.de, alexander.deucher@amd.com, linux@roeck-us.net,
        linux-next@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Stack-frame warnings in display_mode_vba_32.c
Message-ID: <20220730051238.GR2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220730022532.GA1234397@paulmck-ThinkPad-P17-Gen-1>
 <85a49b72-8bb7-b3b3-8a69-2c90cda8079d@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85a49b72-8bb7-b3b3-8a69-2c90cda8079d@igalia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:41:55PM -0300, André Almeida wrote:
> Hi Paul,
> 
> Às 23:25 de 29/07/22, Paul E. McKenney escreveu:
> > Hello!
> > 
> > I am seeing the following in allmodconfig builds of recent -next on x86:
> > 
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function ‘DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation’:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1659:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >  1659 | }
> >       | ^
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function ‘dml32_ModeSupportAndSystemConfigurationFull’:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2480 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >  3799 | } // ModeSupportAndSystemConfigurationFull
> >       | ^
> 
> I think they are fixed at amd-staging-drm-next:
> 
> git log --oneline amd/amd-staging-drm-next
> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> 953daa61981b drm/amd/display: Reduce stack size in the mode support function
> 361e705e712d drm/amd/display: reduce stack for
> dml32_CalculatePrefetchSchedule
> f2dbf5a4dd1e drm/amd/display: reduce stack for
> dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
> a0a68cda2ef8 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
> ca6730ca0f01 drm/amd/display: reduce stack for
> dml32_CalculateSwathAndDETConfiguration
> 593eef8c1a5e drm/amd/display: reduce stack size in dcn32 dml (v2)
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c

Very good, thank you!  I will test again on the next -next.

							Thanx, Paul

> > Bisection located the commit shown below.  Doing an allmodconfig build
> > on this commit reproduces the error, its parent builds fine.
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 3876a8b5e241081b2a519f848a65c00d8e6cd124
> > Author: Guenter Roeck <linux@roeck-us.net>
> > Date:   Tue Jul 12 15:42:47 2022 -0700
> > 
> >     drm/amd/display: Enable building new display engine with KCOV enabled
> >     
> >     The new display engine uses floating point math, which is not supported
> >     by KCOV. Commit 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov
> >     is enabled") tried to work around the problem by disabling
> >     CONFIG_DRM_AMD_DC_DCN if KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS
> >     are enabled. The result is that KCOV can not be enabled on systems which
> >     require this display engine. A much simpler and less invasive solution is
> >     to disable KCOV selectively when compiling the display enagine while
> >     keeping it enabled for the rest of the kernel.
> >     
> >     Fixes: 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov is enabled")
> >     Cc: Arnd Bergmann <arnd@arndb.de>
> >     Cc: Leo Li <sunpeng.li@amd.com>
> >     Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > 
> > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> > index b4029c0d5d8c5..96cbc87f7b6b8 100644
> > --- a/drivers/gpu/drm/amd/display/Kconfig
> > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > @@ -6,7 +6,7 @@ config DRM_AMD_DC
> >  	bool "AMD DC - Enable new display engine"
> >  	default y
> >  	select SND_HDA_COMPONENT if SND_HDA_CORE
> > -	select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> > +	select DRM_AMD_DC_DCN if (X86 || PPC64)
> >  	help
> >  	  Choose this option if you want to use the new display engine
> >  	  support for AMDGPU. This adds required support for Vega and
> > diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
> > index 273f8f2c8e020..b9effadfc4bb7 100644
> > --- a/drivers/gpu/drm/amd/display/dc/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> > @@ -25,6 +25,9 @@
> >  DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
> >  
> >  ifdef CONFIG_DRM_AMD_DC_DCN
> > +
> > +KCOV_INSTRUMENT := n
> > +
> >  DC_LIBS += dcn20
> >  DC_LIBS += dsc
> >  DC_LIBS += dcn10
