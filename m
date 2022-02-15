Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB24B760D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiBOTEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:04:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiBOTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:04:14 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A6EF94ED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:04:03 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id m185so25107294iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9oIpTmWH153dZPbERckgwcW88amB5wLeggsaAJv2ZI=;
        b=nQBCpjZ8lrNiWaxU4Wg2alyfbeoW6NWsW4O4lUAYOIf3kh4200lqryhrnZrd/i0dTg
         Os4bogB5jd/j3L1NssRvTvI7jkV+eA8agcBWgmGTe/9nQdwQpTAKMKJOh/BEGUqxxhQR
         LIPxM/gXNHIQgpzqCktJVYqGCILCSn5RwW+Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9oIpTmWH153dZPbERckgwcW88amB5wLeggsaAJv2ZI=;
        b=DNLYVvM/rFESHedJAls7+kx3Gtx+poM+ILr61urCGUAHf/XSUNmCvSDkgQPE6xcRWK
         y1uBPdBQwx8T15z5kangbuvXOrpJQvaLs3CiCAomc5VIddGVn6tdkv0xRKpH8dtwShlI
         7QuHt+IiD3drju7uTkrih5rH673pb9twaHaabL8ZXOIQTfxZjQJEiEY1Pf+l8ePgg4tl
         erSgScbM/aJpMxpVQZTjRpfdW/t5WIHetvHyqRIp7f/PNYlyNyUeQC+pUlGN8rU3GPvK
         lSuAcXrnCufjsQ4xMeL/+NMvMRHbHNcOxNieq2AQsAxaI3Ffutzp366p4XVPRptyFWak
         Ip9Q==
X-Gm-Message-State: AOAM5326VsnjIFCp9KwYh4e6nT3p2ijD+20naeJd7oQL1o+BoOLw6XVc
        RuveuANocAkxe5BR12dPrrnZ9l6IPNvERA==
X-Google-Smtp-Source: ABdhPJyH3beCUTCtI0dFm2daXdXbFUp1IswgHfPY2eP2XwUqWkid1tU8zy2kVKWxAdXRWaQld/secA==
X-Received: by 2002:a05:6638:164b:: with SMTP id a11mr205860jat.57.1644951842919;
        Tue, 15 Feb 2022 11:04:02 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id m5sm23998868iov.36.2022.02.15.11.04.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 11:04:02 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id r144so25074381iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:04:02 -0800 (PST)
X-Received: by 2002:a05:6638:168d:: with SMTP id f13mr243041jat.44.1644951842244;
 Tue, 15 Feb 2022 11:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20220119204345.3769662-1-mka@chromium.org> <20220119124327.v20.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
 <YgJMkFAxjazkUDZd@kroah.com> <YgLCswtX/0THkzXT@google.com>
 <CAD=FV=WMP8M5HTRNv9_scvrytbpE0iBdUack=XaHoypGNLJeVA@mail.gmail.com> <Ygv3FSDS/fq1oePy@kroah.com>
In-Reply-To: <Ygv3FSDS/fq1oePy@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Feb 2022 11:03:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpF=BMKxjkX6xciWP=q=3qQ_dCusBX8KJ4GjubuqN2nQ@mail.gmail.com>
Message-ID: <CAD=FV=XpF=BMKxjkX6xciWP=q=3qQ_dCusBX8KJ4GjubuqN2nQ@mail.gmail.com>
Subject: Re: [PATCH v20 5/5] arm64: dts: qcom: sc7180-trogdor: Add nodes for
 onboard USB hub
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 15, 2022 at 10:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 15, 2022 at 09:54:54AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Feb 8, 2022 at 11:21 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > On Tue, Feb 08, 2022 at 11:57:20AM +0100, Greg Kroah-Hartman wrote:
> > > > On Wed, Jan 19, 2022 at 12:43:45PM -0800, Matthias Kaehlcke wrote:
> > > > > Add nodes for the onboard USB hub on trogdor devices. Remove the
> > > > > 'always-on' property from the hub regulator, since the regulator
> > > > > is now managed by the onboard_usb_hub driver.
> > > > >
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > > ---
> > > >
> > > > No DT maintainer approval yet?  :(
> > >
> > > Bjorn usually just picks DT changes into the QCOM tree when they are
> > > ready, so I wouldn't interpret anything into the lack of an explicit
> > > Ack.
> >
> > Right, so the expectation is that this patch wouldn't land through the
> > USB tree but would instead land through the Qualcomm tree, probably a
> > revision after the code lands in the USB tree to avoid dependency
> > problems.
>
> But our tools pick up the whole series.  I can't just do "i will pick
> patches 1-4 only" easily, and neither can any other maintainer.
>
> Why not just get their ack so that I know it can come through the USB
> tree?  That's what normally happens for other changes like this where a
> driver change is required first.

Huh. That's the first time I've heard that and I'm pretty used to
patches in a series going through different trees, but it would be OK
w/ me if Bjorn was willing to Ack this. Bjorn: what say you? I guess
alternatively Matthias could send two series: one with the code and a
later one with the dts.

-Doug
