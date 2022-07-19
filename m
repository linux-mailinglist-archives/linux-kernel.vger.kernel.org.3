Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514DF579402
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiGSHTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiGSHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:19:50 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E63932DAD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:19:49 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10d6cdf829aso2286788fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sbnnlm1/PjMSPmudPPg+00uf3vfTognMn8oMjSHYKvA=;
        b=YvreDaoClCfLMVh0kuegRr5Tb20TtMuxjFsoBfeQ/aKfhGhBmftcSgjY4V2Eg+zSgl
         FfyMhei9a9x1UwCOdq2HcUOaccXm4XzQ0NnNDXOcLgmYZL+zL3GQAn7DDfRiicse28f1
         RN5kaIQCf4Z4fi199iVfV3TpzhhwXflVj8guQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sbnnlm1/PjMSPmudPPg+00uf3vfTognMn8oMjSHYKvA=;
        b=V3SncA94dpB4VfU9cdSrdfPi3H4COZLMCA/26KMaM482kBR57Zwht+cByiM33Bq8mS
         PrG2F+ExPu9CgcfGDnsj5CTC9sZzLL3JFH2avDKM5LKgE/WUtIuAHrkcjqtMZx0IiEBe
         DSscxKz3M9ufI0+9qAtUzXG5rEGoaWpoLU1FfT7bVLc/i5MufeAi4cg2YcFXT4ugBxWU
         HiiySrvIy8fPAG7k7RwLL7hMFdYWdPr1OqRblaCVaPZa28mvLe2QQ6VgU+SNcJJR4kkz
         7T5WPq42NVFEjqEUYvnXjNp+bC5OfHZ4I8u6gqP7wiyY5CNqKlyfdzd99JaYZ1uW8dtN
         OJxw==
X-Gm-Message-State: AJIora+L40RFmV5zaBWH8a9BWmpU/+S9v7zJwvEzelizJa5Izssw67em
        LJU8CmxlavUV1YvzkBoSaA8WqAusoSf2ENDsCMnGsw==
X-Google-Smtp-Source: AGRyM1tdmvnEmkKpCicr8GGagWVe2Y/bXDhFisbQ7fpg4AqrDBUi60mDeIFUloIr9xJ8nhMLsB/zEqXvdphhfCcaqo4=
X-Received: by 2002:aca:db56:0:b0:33a:3dd5:86ed with SMTP id
 s83-20020acadb56000000b0033a3dd586edmr11336531oig.0.1658215188633; Tue, 19
 Jul 2022 00:19:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Jul 2022 03:19:48 -0400
MIME-Version: 1.0
In-Reply-To: <0c050434-27ca-1099-d93d-8ad6ace3396e@quicinc.com>
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220709112837.v2.5.I7291c830ace04fce07e6bd95a11de4ba91410f7b@changeid>
 <CAD=FV=XzvcjS51q78BZ=FPCEVUDMD+VKJ70ksCm5V4qwHN_wRg@mail.gmail.com>
 <c022538d-c616-8f1a-e1c2-c11b5f0de670@quicinc.com> <e4dcdd8d-18a9-8da3-7ac3-6cc792139f70@quicinc.com>
 <CAE-0n52TG3hsytN5nRU7W=S6PffSj8yQDmuicN0-qxoW-jxiZQ@mail.gmail.com> <0c050434-27ca-1099-d93d-8ad6ace3396e@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 19 Jul 2022 03:19:48 -0400
Message-ID: <CAE-0n53J=dADDTrydVuNZzw38dW_-+Baf8cfn0Q6DSVX_6cLNg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v2 5/7] arm64: dts: qcom: sc7280: Update gpu
 register list
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>, quic_rjendra@quicinc.com
Cc:     devicetree@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akhil P Oommen (2022-07-18 23:37:16)
> On 7/19/2022 11:19 AM, Stephen Boyd wrote:
> > Quoting Akhil P Oommen (2022-07-18 21:07:05)
> >> On 7/14/2022 11:10 AM, Akhil P Oommen wrote:
> >>> IIUC, qcom gdsc driver doesn't ensure hardware is collapsed since they
> >>> are vote-able switches. Ideally, we should ensure that the hw has
> >>> collapsed for gpu recovery because there could be transient votes from
> >>> other subsystems like hypervisor using their vote register.
> >>>
> >>> I am not sure how complex the plumbing to gpucc driver would be to allow
> >>> gpu driver to check hw status. OTOH, with this patch, gpu driver does a
> >>> read operation on a gpucc register which is in always-on domain. That
> >>> means we don't need to vote any resource to access this register.

Reading between the lines here, you're saying that you have to read the
gdsc register to make sure that the gdsc is in some state? Can you
clarify exactly what you're doing? And how do you know that something
else in the kernel can't cause the register to change after it is read?
It certainly seems like we can't be certain because there is voting
involved.

> >>>
> >>> Stephen/Rajendra/Taniya, any suggestion?
> > Why can't you assert a gpu reset signal with the reset APIs? This series
> > seems to jump through a bunch of hoops to get the gdsc and power domain
> > to "reset" when I don't know why any of that is necessary. Can't we
> > simply assert a reset to the hardware after recovery completes so the
> > device is back into a good known POR (power on reset) state?
> That is because there is no register interface to reset GPU CX domain.
> The recommended sequence from HW design folks is to collapse both cx and
> gx gdsc to properly reset gpu/gmu.
>

Ok. One knee jerk reaction is to treat the gdsc as a reset then and
possibly mux that request along with any power domain on/off so that if
the reset is requested and the power domain is off nothing happens.
Otherwise if the power domain is on then it manually sequences and
controls the two gdscs so that the GPU is reset and then restores the
enable state of the power domain.
