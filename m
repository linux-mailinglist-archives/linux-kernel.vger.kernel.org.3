Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E34A905B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355606AbiBCV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355569AbiBCV7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:59:05 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74665C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:59:05 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so3742788otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=jApEEKPPEesUGF7pUKn75jeWUbjNZyZyCRrMteIrvwg=;
        b=Buy290N/yQvLU8Quc992ySg6dNM0zHWEK7NjrpKMoURh7Zi2P4pDQBLMy5ZF06YVJI
         WXOPsT11G8Sl9HFXZ17cKvsCz/oAtyhfCf3Qh35aU/V3yzY4t8XBiKujF/2ZGrnGWNpj
         V+gFahIHlPBBtj8BTksC7stbGOpSDLFtQaBds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=jApEEKPPEesUGF7pUKn75jeWUbjNZyZyCRrMteIrvwg=;
        b=qiuZnwM9ss5mfWuNGR+bqUbXwLCCGBhqIGy1sCZsvwiTFHvvxyLyRhQxVjQHL7xn/W
         pEho/CY0URRMZEpwi9a1B6xHAHCJSAcBIbm4I2K4WizWvWCgCcodiPIVcufD0Zk2vvWd
         rpIwuX1i9uprkSSGAa/3Mjtal5Hd5CfB2Isk4pFR8Y5BCep9y6+EY5uaRWh+OfRuswaO
         MQ7ZE5rDEpSnctfGWtoQvrfay4kcGzEwwi+q64iclRnjqSg9phr5b+NAI8lfBiT3ntLK
         FL3vQBkNPzXRMb/3dyWfezJ54keNOj9EHBsSJRv0KZZuOUgfh6ajxK6YoEAkDA1znbOC
         BV9A==
X-Gm-Message-State: AOAM530Fcuwj2CUyJLw+tCMdFeS99O1Tt81vRLFpOf447B3WBvyHPila
        uH99yLj9Ec1oHturmJCAOnMuyVE41LLgsZrDdcwn96K73W0=
X-Google-Smtp-Source: ABdhPJw0gK+pVS0/00IuIsk2vMvTkFbxMoaFsmgKDmLqthmZ5xXaB4S5bfTjw8W60l+XU1f3BuTSYn6xf0cE0lrnaio=
X-Received: by 2002:a9d:6f06:: with SMTP id n6mr63202otq.159.1643925544771;
 Thu, 03 Feb 2022 13:59:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:59:04 +0000
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UKKZaHHz3-idahLg-ey3xmSZWKeTVVipzpZNQAkUVKmQ@mail.gmail.com>
References: <20220202212348.1391534-1-dianders@chromium.org>
 <20220202132301.v3.9.I5f367dcce8107f2186b2aad4aef0dfcfafa034b9@changeid>
 <CAE-0n51N4wB7aTRbZR3zh3hjz56vdkFNwOSuKjU7n9gd_JDcvA@mail.gmail.com> <CAD=FV=UKKZaHHz3-idahLg-ey3xmSZWKeTVVipzpZNQAkUVKmQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:59:04 +0000
Message-ID: <CAE-0n50Xb2qwDDOCaLwZPr5-YES3gYyA+7218=EXa4ZSJuFGjw@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] arm64: dts: qcom: sc7280: Disable pull from pcie1_clkreq
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-02-03 13:53:09)
> Hi,
>
> On Thu, Feb 3, 2022 at 1:42 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2022-02-02 13:23:43)
> > > I believe that the PCIe clkreq pin is an output. That means we
> > > shouldn't have a pull enabled for it. Turn it off.
> >
> > It sounds like it's a request from the PCI device to the PCI phy that
> > the clk should be on. I googled pcie clkreq open drain and this pdf[1]
> > says
> >
> > "The CLKREQ# signal is an open drain, active low signal that is driven
> > low by the PCI Express M.2 add-I Card function to request that the PCI
> > Express reference clock be available (active clock state) in order to
> > allow the PCI Express interface to send/receive data"
> >
> > so presumably if there isn't an external pull on the signal the open
> > drain feature will not work and the PCIe device won't be able to drive
> > it low.
> >
> > [1] https://advdownload.advantech.com/productfile/PIS/96FD80-P512-LIS/Product%20-%20Datasheet/96FD80-P512-LIS_datasheet20180110154919.pdf
>
> Yeah, I had some trouble figuring this out too, so if someone knows
> better than me then I'm more than happy to take advice here. I thought
> I had found something claiming that "clkreq" was an output and on the
> schematic I have from Qualcomm it shows an arrow going out from the
> SoC for this signal indicating that it's an output from the SoC. Of
> course, those arrows are notoriously wrong but at least it's one piece
> of evidence that someone thought this was an output from the SoC.
>
> Hrm, but I just checked the sc7280 "datasheet" which claims that this
> is an input. Sigh.
>
> I guess the options are:
> * If we're sure this is an input to the SoC then I think we should
> remove the drive-strength, right?
> * If we don't know then I guess we can leave both?

I'll wait for qcom folks to confirm. Maybe it's bidirectional because it
is an open drain signal. I'm showing my cards that I'm no PCIe expert :)

>
>
> In any case, for now we can just drop this patch?
>

Sounds good to me. It needs to be resolved through for herobrine-r1?
