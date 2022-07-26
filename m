Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5678E580EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbiGZI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiGZI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:28:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562432FFDC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:28:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so19089273wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAKHknFtsvT1+469TMaGtV4FNnDqf7wnEERMTyMAfco=;
        b=FUUrWzuDishjz9cWOzadM6Gl14xPV+esI8ec68cYC8L7HNGTMZO71Vz0SsxSvz/d/M
         qRyNp9YUPMSZGVuqzZ6UD0rqiJw/qW+gV6aDzdqByjID17FYpJDMFkICUnmAEE0vu10t
         H5b6bqv3WvhstO48+JQ5pMzSWALXBv0YWf6q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAKHknFtsvT1+469TMaGtV4FNnDqf7wnEERMTyMAfco=;
        b=IEaiZtHax130uLno5L6PRFTvma6WkmL+lBAHC3aHOxd+vD+5w9jM87XbawYJaRWp4n
         uc+q+6WhF7vn2Jvyv5Gy+5uau1wN5cNWppG/+vMRD1pAcLmUt8vPJWKxDEv7o8c3MLTl
         JohxeszpAndEt+6bbpFSwoW7AILzTLhANb2TgT6Fv8KWXa7fZ1C0dwMuiLgSiGtxQ/VD
         dkrVMj/+yGfB1+0EY7vZ9kMsRV88CQacBKnaZhrE8x4sDSRzhOUUW1Uq0BUQNgd0CwBR
         Q2VuZ1ZSLZLexCP9mZTcbK8YEFaaptgz0+UOZEpjQDyuQmFogQFbo/R6VD9TQwKCPJAk
         ku3Q==
X-Gm-Message-State: AJIora8Hdxm/cw0dlj0FglXzbeJNY4CrXOihkIAnWxJ+e6TrQmrMp9FB
        N+8TSPYcO9H8X8K05aDYCwUHbszrPIfhCxt1vi2tMA==
X-Google-Smtp-Source: AGRyM1t/lZNz8m3urqK9JXJr8NpFEnVRSKywvR7SNPRuB0E8haJrZ/ZUTHOWy4RG+PM3vnOlQFpwUR8D2fNwB3WOo5s=
X-Received: by 2002:a5d:59a9:0:b0:21e:5e6a:6a8e with SMTP id
 p9-20020a5d59a9000000b0021e5e6a6a8emr10795876wrr.190.1658824085827; Tue, 26
 Jul 2022 01:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220725082447.2613231-1-treapking@chromium.org>
 <5856610d-510f-46dc-63b2-79e571956a7c@collabora.com> <CAEXTbpeHy6-WjLOyWFkncoHzBPM+6qq4w-kUoZj7=05gf8YBjw@mail.gmail.com>
 <bcb8c2b4-a1ab-8646-9fcb-034a70f5a329@collabora.com> <CAEXTbpeEkpgFjQfONM030k8drcfYzOoWnB_FUqFptd-27YRqNg@mail.gmail.com>
 <a91e09c8-377f-7143-2c66-11ef09552d8e@collabora.com>
In-Reply-To: <a91e09c8-377f-7143-2c66-11ef09552d8e@collabora.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 26 Jul 2022 16:27:54 +0800
Message-ID: <CAEXTbpeddwN1vqsmRvgvqmWhtKqkKeKhvtKHAzTneZBrkhSa0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173-oak: Switch to SMC watchdog
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 4:19 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 26/07/22 07:55, Pin-yen Lin ha scritto:
> > On Mon, Jul 25, 2022 at 6:31 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 25/07/22 12:19, Pin-yen Lin ha scritto:
> >>> On Mon, Jul 25, 2022 at 4:39 PM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 25/07/22 10:24, Pin-yen Lin ha scritto:
> >>>>> Switch to SMC watchdog because we need direct control of HW watchdog
> >>>>> registers from kernel. The corresponding firmware was uploaded in
> >>>>> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> >>>>>
> >>>>
> >>>> There's a fundamental issue with this change, I think.
> >>>>
> >>>> What happens if we run this devicetree on a device that does *not* have
> >>>> the new(er) firmware?
> >>>
> >>> I haven't tried this patch with an older firmware. I'll manage to
> >>> build one for this.
> >>>>
> >>>> The kernel *shall not* get broken when running on devices that are running
> >>>> on older firmware, especially because that's what was initially supported
> >>>> and what is working right now.
> >>>
> >>> Actually the current approach does not work *right*. The device boots,
> >>> but the watchdog does not work properly.
> >>>
> >>
> >> Is this a Chromebook firmware specific issue?
> >
> > I'm not sure if this is a Chromebook-specific issue. The internal
> > issue thread only discussed this for the Chromebook firmware.
> >>
> >>> Also, all MT8173 ChromeOS devices have this firmware updated, and we
> >>> don't have other upstream users apart from mt8173-evb. Do we want to
> >>> support the developers that are running upstream linux with their
> >>> MT8173 boards?
> >>>
> >>
> >> Upstream shall not be just about one machine: if we add support for a SoC there,
> >> we shall support the SoC-generic things in the SoC-specific DTSI, and the machine
> >> specific things in the machine-specific devicetrees.
> >>
> >> Chromebooks are not the only machines using the MT8173 SoC (Chuwi, Amazon also do
> >> have products using MT8173), so we shall not make the main mt8173.dtsi incompatible
> >> with these machines.
> >
> > I don't see their DTS files uploaded to the upstream kernel. So we
> > still want to support them even if they didn't upstream their changes?
> >
>
> The point is not about having to support them, but about not making things
> harder for them, in case any community person wants to add support for these
> upstream.
>
> By rule, everything SoC-generic goes to soc.dtsi; everything board-specific
> goes to board.dts(i).
>
> > Does it make sense if we move the modification to mt8173-elm.dtsi? The
> > device should be running ChromeOS AP firmware if it uses or references
> > mt8173-elm.dtsi. Also, all the MT8173 Chromebooks were shipped with
> > the "new" firmware from the very beginning. We just somehow didn't
> > upstream this around the time.
>
> Moving this to mt8173-elm.dtsi is the only sensible option, as this is something
> that was addressed in Chromebooks' firmwares and it's not a SoC hardware spec.
>
> So yes, please.
>
> The disablement of the MMIO watchdog should also be done in mt8173-elm.dtsi, and
> please please please, make sure to add a comment in the devicetree saying that
> we're disabling that one because the SMC wdog operates on the same MMIO.
>
> Regards,
> Angelo

Thanks for your detailed explanation. I'll move the modifications to
mt8173-elm.dtsi and add comments in v2.

Regards,
Pin-yen
>
> >>
> >>>>
> >>>> For this reason, I think that we should get some code around that checks
> >>>> if the SMC watchdog is supported and, if not, resort to MMIO wdog.
> >>>
> >>> What is the expected way to support this backward compatibility? Do we
> >>> put the old compatible strings ("mediatek,mt8173-wdt" and
> >>> "mediatek,mt6589-wdt") after "arm,smc-wdt" and reject it in the
> >>> drivers if the firmware does not support it?
> >>
> >> I don't know what's the best option to support both cases... Perhaps a good one
> >> would be to check (in mtk_wdt? or in arm_smc_wdt?) if the arm_smc_wdt is actually
> >> supported in firmware, so if the SMC one is registered, we skip the other.
> >>
> >>>>
> >>>> Regards,
> >>>> Angelo
> >>>>
> >>>>
> >>>>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>     arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++----
> >>>>>     1 file changed, 2 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >>>>> index a2aef5aa67c1..2d1c776740a5 100644
> >>>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >>>>> @@ -528,10 +528,8 @@ power-domain@MT8173_POWER_DOMAIN_MFG {
> >>>>>                         };
> >>>>>                 };
> >>>>>
> >>>>> -             watchdog: watchdog@10007000 {
> >>>>> -                     compatible = "mediatek,mt8173-wdt",
> >>>>> -                                  "mediatek,mt6589-wdt";
> >>>>> -                     reg = <0 0x10007000 0 0x100>;
> >>>>> +             watchdog {
> >>>>> +                     compatible = "arm,smc-wdt";
> >>>>>                 };
> >>>>>
> >>>>>                 timer: timer@10008000 {
> >>>>>
> >>>>
> >>>>
> >>
> >>
>
