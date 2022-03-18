Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6BC4DD1C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiCRANg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiCRANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:13:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F65A13927D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:12:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so13775839ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlfqT3gCisJBMTAg9owO2Ux8q0knKebgrHQt0YZbpxI=;
        b=nBDhznL6GSZim3PdexrPGQqpwQ4fFBAapWTmPPNrAt0uN427dmLC1mJrI8HXE1C1kx
         upaggKMpoTVkewUUN8f4G2ccK2tUnREtzjnOO9fkjvE2aXhO73VuvMgL2JxHG1mUNou7
         E4BgOMO9zLLV6AZpoxwm0FAG5//90kHjahP1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlfqT3gCisJBMTAg9owO2Ux8q0knKebgrHQt0YZbpxI=;
        b=qqeN57/H2kkz54yIlroY+K3D38Jwr0+lyqnq55amyflUyHbdT9BAwXpWNXQs465AWd
         jD7wv6s2Bne+CTCXSoBeskMtnon1KJ3U5vtBPt+OaAnPEVDdoRHevzcie0fvEaceWQst
         ePtfsSSG0t9So1vLen214hP829xbc8C2zOE+QpsyvX/ASknP9dK/cLiJ+VKlA/UzeyIl
         4rTswvSj2mxliTOxW4UWyuuM5UrtBJa3b0IyzZaJzWEtGwVFU83kS75S8ruc58bZKT7K
         aGFdY6tDLyPBSnky1dulxjk5lURzwGKr6ULXQI2B/cxt4FzXjKk3fisNo/KxxStZb1LO
         HAkw==
X-Gm-Message-State: AOAM533ibuSHEUuDB+KU5p8jltcYP/Bri8fEv1xOTGsqLIFxhbErTJsl
        6U3jMQeuPjNe7vN2K8SQJVyPYQQkSgApj6Vf1xQ=
X-Google-Smtp-Source: ABdhPJyw8q7qrs2U4ii62rgCdhosmFk44CJGoVIKVdrbpm6q1JhU0uln6Y/C0eWgJLz21P3q3bgsBg==
X-Received: by 2002:a17:906:c1c6:b0:6d5:cc27:a66c with SMTP id bw6-20020a170906c1c600b006d5cc27a66cmr6799352ejb.650.1647562333536;
        Thu, 17 Mar 2022 17:12:13 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id jg28-20020a170907971c00b006dbd9d72c03sm2998228ejc.128.2022.03.17.17.12.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 17:12:12 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h23so9023947wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:12:12 -0700 (PDT)
X-Received: by 2002:adf:fc47:0:b0:203:dda1:4311 with SMTP id
 e7-20020adffc47000000b00203dda14311mr6191933wrs.301.1647562331786; Thu, 17
 Mar 2022 17:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <1647269217-14064-1-git-send-email-quic_vpolimer@quicinc.com> <1647269217-14064-2-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1647269217-14064-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Mar 2022 17:11:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4SWtyz4fFEmvKD_N-2ioS4R65UDZRU7utQm=0CSzp=g@mail.gmail.com>
Message-ID: <CAD=FV=V4SWtyz4fFEmvKD_N-2ioS4R65UDZRU7utQm=0CSzp=g@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] drm/msm/disp/dpu1: set mdp clk to the maximum
 frequency in opp table during probe
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_kalyant <quic_kalyant@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 14, 2022 at 7:47 AM Vinod Polimera
<quic_vpolimer@quicinc.com> wrote:
>
> use max clock during probe/bind sequence from the opp table.
> The clock will be scaled down when framework sends an update.
>
> Fixes: 25fdd5933("drm/msm: Add SDM845 DPU support")

The "Fixes:" format is a little wrong. Should have more digits and a
space before the parenthesis. AKA:

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")

> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

This looks good to me now other than the bad Fixes tag. I presume
you'll want to spin with the extra verbosity in the CL description
that Stephen asked for, though.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
