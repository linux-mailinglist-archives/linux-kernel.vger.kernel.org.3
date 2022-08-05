Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB958B069
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiHETch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHETcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECBC1A810
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB9261A18
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 19:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE23C43140
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659727953;
        bh=mfEh6ybw6rE7/YvSjSNtL1TZqU0Vwg2ccAlpa8gmxCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LX1rWOzm68paQ6IF/V/Z7Jyc4mrDJMxk18613pIutd20SJHjYfs8ZhEb+NcRWW05d
         MXovB+DdlRSYT/gY3UIS7oUWTnQ6Ma47JwlMLJ2KnAmdSKv5rbgaSpS2BtD2/28tq4
         rB1JGnZgbQBUwc6ohYPWw+vYSmCvEqBTbnujzgvplYHbExArH2u2i3DUWOv8LBCE7g
         ScShm5/Xl1O0DZjH6hn6562iDgdMKwrr3b80zPM5FwwhwBnYEAnjLxH5S+is3Jhp9p
         plohILwpbGdi9lOPyJmrVHVYDzrzbXoMNGgzVr7pUDH3A3H1U39o2wxM/bwqRJexqt
         3iAmOBvR3Rk3A==
Received: by mail-ej1-f51.google.com with SMTP id a7so6715293ejp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 12:32:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo3l/0Ol2w6CMs1rkk4Ehdox5T/WXGe/WoA/zccmO5XvEh3MWu63
        Wcsg13Jrc3KFJq0kayozI7jMN0YX9PktRAaYNPo=
X-Google-Smtp-Source: AA6agR6sufpPn7fKAXba69irZ//FbrrVb5P7LMB5EmBMDbLarfIv7nL6lJv4uXFV2w0bUTCcP1jOVQ494qKG5VTQJm8=
X-Received: by 2002:a17:907:28d6:b0:731:5d0:4401 with SMTP id
 en22-20020a17090728d600b0073105d04401mr2212923ejc.765.1659727951560; Fri, 05
 Aug 2022 12:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian> <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
 <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
 <YuwvfsztWaHvquwC@dev-arch.thelio-3990X> <9fb73284-7572-5703-93d3-f83a43535baf@amd.com>
 <CAK8P3a3Fv=_+GV9r=k4jP72zZOjJowL-GOue-51EhyVDBaEfEw@mail.gmail.com> <Yu1bMqL5tsbq1ojj@dev-arch.thelio-3990X>
In-Reply-To: <Yu1bMqL5tsbq1ojj@dev-arch.thelio-3990X>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 5 Aug 2022 21:32:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
Message-ID: <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 8:02 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Fri, Aug 05, 2022 at 06:16:45PM +0200, Arnd Bergmann wrote:
> > On Fri, Aug 5, 2022 at 5:32 PM Harry Wentland <harry.wentland@amd.com> wrote:
> > While splitting out sub-functions can help reduce the maximum stack
> > usage, it seems that in this case it makes the actual problem worse:
> > I see 2168 bytes for the combined
> > dml32_ModeSupportAndSystemConfigurationFull(), but marking
> > mode_support_configuration() as noinline gives me 1992 bytes
> > for the outer function plus 384 bytes for the inner one. So it does
> > avoid the warning (barely), but not the problem that the warning tries
> > to point out.
>
> I haven't had a chance to take a look at splitting things up yet, would
> you recommend a different approach?

Splitting up large functions can help when you have large local variables
that are used in different parts of the function, and the split gets the
compiler to reuse stack locations.

I think in this particular function, the problem isn't actually local variables
but either pushing variables on the stack for argument passing,
or something that causes the compiler to run out of registers so it
has to spill registers to the stack.

In either case, one has to actually look at the generated output
and then try to rearrange the codes so this does not happen.

One thing to try would be to condense a function call like

                dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(

&v->dummy_vars.dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport,
                        mode_lib->vba.USRRetrainingRequiredFinal,
                        mode_lib->vba.UsesMALLForPStateChange,

mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
                        mode_lib->vba.NumberOfActiveSurfaces,
                        mode_lib->vba.MaxLineBufferLines,
                        mode_lib->vba.LineBufferSizeFinal,
                        mode_lib->vba.WritebackInterfaceBufferSize,
                        mode_lib->vba.DCFCLK,
                        mode_lib->vba.ReturnBW,
                        mode_lib->vba.SynchronizeTimingsFinal,

mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
                        mode_lib->vba.DRRDisplay,
                        v->dpte_group_bytes,
                        v->meta_row_height,
                        v->meta_row_height_chroma,

v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters,
                        mode_lib->vba.WritebackChunkSize,
                        mode_lib->vba.SOCCLK,
                        v->DCFCLKDeepSleep,
                        mode_lib->vba.DETBufferSizeY,
                        mode_lib->vba.DETBufferSizeC,
                        mode_lib->vba.SwathHeightY,
                        mode_lib->vba.SwathHeightC,
                        mode_lib->vba.LBBitPerPixel,
                        v->SwathWidthY,
                        v->SwathWidthC,
                        mode_lib->vba.HRatio,
                        mode_lib->vba.HRatioChroma,
                        mode_lib->vba.vtaps,
                        mode_lib->vba.VTAPsChroma,
                        mode_lib->vba.VRatio,
                        mode_lib->vba.VRatioChroma,
                        mode_lib->vba.HTotal,
                        mode_lib->vba.VTotal,
                        mode_lib->vba.VActive,
                        mode_lib->vba.PixelClock,
                        mode_lib->vba.BlendingAndTiming,
                        .... /* more arguments */);

into calling conventions that take a pointer to 'mode_lib->vba' and another
one to 'v', so these are no longer passed on the stack individually.

       Arnd
