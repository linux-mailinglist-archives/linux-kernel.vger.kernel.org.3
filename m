Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC223588DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiHCNzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiHCNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:54:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005B2A26E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:54:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gk3so19440066ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0kFvvVa1Ry8lFNFwqRcLz5HfPPFKIoO5GClVTFVHKAo=;
        b=Pm+xw36k75MgbBYWtIlvzPVrEx1sxmMi8PhC7QjORA4TpioAt1Y653gXwcZnqM9GAJ
         uRV1XrvItB7XOV23G8z6Tztth/UWRNpO9yBmRRYZxXJI+jL2XiuM4cAujb2TzKuEofAQ
         AScoKYAzpWNkClXatjzcWb6M+Nhj0lckjKEBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0kFvvVa1Ry8lFNFwqRcLz5HfPPFKIoO5GClVTFVHKAo=;
        b=KAgUCuYBVmIGcL7sdI5csCLjbroZRTlUnUE6UFAp9Bp3Nlo1aHAjlrbmIU7F1eiGGg
         HXyFSQrG2isJlfeEh9hgLhD3UDGXECchCKJJMWTMRpuWrWRDWhryd3pCvdhEHO8dnKE7
         fbmcUa0w4cnjSRzD12U3trWUgkVfHyIsFW2rnJXsrQjHuMa7Px86fSXMf/SwG6yEyRZG
         BpoR2JYSzxwGkhFImWsH9E4fO3wfM9t5wcQ4g+ign9UVMEIc4d9cruAs9AMiXE3B1PHl
         vfVNGzpQXimxvB0UFlcEavKnSZc2ojyHyU7Bp0jNj+JAPHMsJPw4BGSmIbkKtF6kDx0s
         qGEw==
X-Gm-Message-State: AJIora8ivh6VdeIv7DSThHtP36x+T3VFA9ou+trP9fnqACw8mmm4tNC/
        8vZmguchKc1MHQ2LHQdK+ouXc6JR8bueD6XE
X-Google-Smtp-Source: AGRyM1uk/mf+SB9ceQV38NSHI9Wdsu4QISmWSuX1+GQKaavtfGKa5qUkia+wRpMldkEyOS/bUaWY5g==
X-Received: by 2002:a17:907:7f94:b0:72b:47da:4bf3 with SMTP id qk20-20020a1709077f9400b0072b47da4bf3mr20747279ejc.157.1659534848158;
        Wed, 03 Aug 2022 06:54:08 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906304700b0072b92daef1csm7421005ejd.146.2022.08.03.06.54.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 06:54:08 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso972745wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:54:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1549:b0:3a3:2aa2:6f60 with SMTP id
 f9-20020a05600c154900b003a32aa26f60mr2974636wmg.57.1659534836576; Wed, 03 Aug
 2022 06:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.5.I55a9e65cb1c22221316629e98768ff473f47a067@changeid> <228e5e34-6467-a75b-129d-2b37b32acf13@linaro.org>
In-Reply-To: <228e5e34-6467-a75b-129d-2b37b32acf13@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Aug 2022 06:53:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRM=KvnBGwgOLtfAEcAejPkQ8M9TFQGuu+832zR8z1nA@mail.gmail.com>
Message-ID: <CAD=FV=XRM=KvnBGwgOLtfAEcAejPkQ8M9TFQGuu+832zR8z1nA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/msm/dsi: Take advantage of devm_regulator_bulk_get_const()
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 3, 2022 at 12:19 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 03/08/2022 01:37, Douglas Anderson wrote:
> > As of the commit 1de452a0edda ("regulator: core: Allow drivers to
> > define their init data as const") we no longer need to do copying of
> > regulator bulk data from initdata to something dynamic. Let's take
> > advantage of that.
> >
> > In addition to saving some code, this also moves us to using
> > ARRAY_SIZE() to specify how many regulators we have which is less
> > error prone.
> >
> > This gets rid of some layers of wrappers which makes it obvious that
> > we can get rid of an extra error print.
> > devm_regulator_bulk_get_const() prints errors for you so you don't
> > need an extra layer of printing.
> >
> > In all cases here I have preserved the old settings without any
> > investigation about whether the loads being set are sensible. In the
> > cases of some of the PHYs if several PHYs in the same file used
> > exactly the same settings I had them point to the same data structure.
> >
> > NOTE: Though I haven't done the math, this is likely an overall
> > savings in terms of "static const" data. We previously always
> > allocated space for 8 supplies. Each of these supplies took up 36
> > bytes of data (32 for name, 4 for an int).
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Ah, so to array conversion is already done. That's great.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
>
> > ---
> >
> > Changes in v3:
> > - Do all the PHYs too.
>
> It would have been easier if DSI and DSI PHY were split to separate patches.

One of the earlier patches in the series (where we remove the
"disable" load) was harder to split since the DSI and DSI PHY code was
sharing a single data structure. Once I had one patch touching both at
the same time I figured I'd keep them all like that. If you need me to
rework them to be separate patches to make it easier to land then
please yell. Otherwise I'll assume it's OK.

-Doug
