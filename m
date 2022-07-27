Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E658280F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiG0N55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiG0N5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:57:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F201F2F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:57:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p5so10487572edi.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zK2lTYN74IqKqZwsLWQgkra8zcwd3I1tBfPS/duxTDE=;
        b=eP1FhJrWO5R/3mIx4/oX2k7sNSEnfKppdcAjLwrGJf5LY+avDukYGRSUnzk2W87wPj
         hqh+0MCjd3iqzYW2AvCBCA4y/gA9838FMw/qMHm6SwHsmzXcPrz1eqeYGjs103YiGO8H
         ld7zOZomaTT3RyGZ9wzl0FMRQLObuHrgpNLcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zK2lTYN74IqKqZwsLWQgkra8zcwd3I1tBfPS/duxTDE=;
        b=JyXHsy7UzmYoDLHFLMzySHodXs9kZk1EjGQYlSCyn2VnOiB7ULLfGG3dWg4R0Qo0Yp
         qHlHSMHxV20mgUiHaoh1XO/1BfRYyhwzfMa8gili9JJbX0FxdsRGT6TO7/Ik44LmdK6j
         hR4XVnzoRiknewOCN2WdFxqpBl9SySBYmCc3R2dTWDnSlWGcdYA/DrTohmvwzfRbOaqk
         bWICOS0vGbMsoGf5evg7IbRVgMvmlDSx7+ThfHLFNFTyQ31Pfta6fa4qp9iweAipUe0E
         jdBFZsR7L6LL+fixaqu9Udqy/hz+wC4cn3LhzM3n4CS8pLP62LLKLd3VA4KMQDOU2o7h
         E9vA==
X-Gm-Message-State: AJIora93YaeZWQYjKVSMpvjs7R2M9djBnTHcUwBdjJJeYUdppgEqG9rh
        InIFfKgHZtxsERieWl+DXcHMQ9AshXckY/6m
X-Google-Smtp-Source: AGRyM1skQdjd2OQyRy99AdnMBcMkr9SCR1tNRwZaWJNaCHRXmXRuVU1asaX9DMGnTBte6b/wKbIROQ==
X-Received: by 2002:a05:6402:5212:b0:43a:ad74:b336 with SMTP id s18-20020a056402521200b0043aad74b336mr23234757edd.16.1658930271136;
        Wed, 27 Jul 2022 06:57:51 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7dbcf000000b0043bbc9503ddsm10258204edt.76.2022.07.27.06.57.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:57:50 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id k11so23892880wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:57:50 -0700 (PDT)
X-Received: by 2002:a05:600c:2e48:b0:3a3:1ce3:3036 with SMTP id
 q8-20020a05600c2e4800b003a31ce33036mr3078599wmf.188.1658930260190; Wed, 27
 Jul 2022 06:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220725174810.1.If1f94fbbdb7c1d0fb3961de61483a851ad1971a7@changeid>
 <661fa514-cd37-e062-3294-c844b7f0b894@quicinc.com>
In-Reply-To: <661fa514-cd37-e062-3294-c844b7f0b894@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Jul 2022 06:57:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHhfLn+S8F60EPoC0ip6YzmrihfTz=KmmauXHCxof2QQ@mail.gmail.com>
Message-ID: <CAD=FV=UHhfLn+S8F60EPoC0ip6YzmrihfTz=KmmauXHCxof2QQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] drm/msm/dsi: Don't set a load before
 disabling a regulator
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 26, 2022 at 4:53 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> On 7/25/2022 5:49 PM, Douglas Anderson wrote:
> > As of commit 5451781dadf8 ("regulator: core: Only count load for
> > enabled consumers"), a load isn't counted for a disabled
> > regulator. That means all the code in the DSI driver to specify and
> > set loads before disabling a regulator is not actually doing anything
> > useful. Let's remove it.
> >
> > It should be noted that all of the loads set that were being specified
> > were pointless noise anyway. The only use for this number is to pick
> > between low power and high power modes of regulators. Regulators
> > appear to do this changeover at loads on the order of 10000 uA. You
> > would a lot of clients of the same rail for that 100 uA number to
>
> I guess you meant "you would need a lot of clients"

Yeah, sorry. :( I'll fix it up if I need a v3.


> > @@ -259,15 +259,7 @@ static inline struct msm_dsi_host *to_msm_dsi_host(struct mipi_dsi_host *host)
> >   static void dsi_host_regulator_disable(struct msm_dsi_host *msm_host)
> >   {
> It seems like now we can drop this function dsi_host_regulator_disable()
> entirely and just call regulator_bulk_disable() ?

Sure, if you want. One could still argue that it provides a tiny bit
of abstraction and avoids the caller from having to know where to find
the number of regulators and all that, but I can go either way. Is
this worth a v3, do you think? If so, I might tack it on at the end of
the series.

Note that I say "v3" because I actually included this patch in a
larger series and called that series "v2" [1].


[1] https://lore.kernel.org/r/20220726173824.1166873-1-dianders@chromium.org
