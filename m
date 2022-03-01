Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46B4C9165
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiCARWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiCARWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:22:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185C13F7F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:21:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i11so22910736eda.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4kKl8QGooJd4blFxXWK5FL64wYyB/9eBiL1aDG5cnC0=;
        b=NqTQCDYuexrHCqcYN7yvD/vWOHnaDLIia6bWQYHUYOxhWU+2MBAr1DuF9IxxVWG9NL
         4jk0G1dPP/rlDhCuRgrHzmPRTrAlRVIOMzIAnl2X8fogbZf3su4YMFi6ImkUUtRjCRQN
         4m/umqkWZpXsYVobFC0jDrwgo09g8qIg5Lm5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4kKl8QGooJd4blFxXWK5FL64wYyB/9eBiL1aDG5cnC0=;
        b=8NwF4b7ZN4ynwZ2Oy5oqFD4soZccSsZ7/Kr3Vt10iloMe+bGySr+x9GPYDPLJug56W
         SXbgzBX9D4PIxciIISzXQOxg/iMK2m0l1y2XY0L8XqijSYSXh0mJWWiNIlDabHbmHKA5
         +9Crqszd/0JAZCxV0oMaGxx1Cuww98CbwIW5Fs1NBvYB9QFxTRWXav7bHZcCH1k1AQlq
         Hdmtf4K2GrsCkQl2Ooc1IFxySg6kaEhpBRNWSNxv+iLJhl7TXJ5SLIE1mk7cfk7Y7/A3
         nO+vuLQwY7YjLShsq3FmwNsAMvWFkFTYk87HbQyiSY9eLICCqhiL30iAFJ4UEEReT8vF
         AaRw==
X-Gm-Message-State: AOAM530rjh/CcBsBoEWNcpYeFqRg3OC6M5FcOFqOCsxP2UCQjrCWSPDz
        oQnXIb3W1ge6Ha4DdCgTKIdlJHnDPiyr/zM5
X-Google-Smtp-Source: ABdhPJw6+Uhgf3eVVtSkGHZzfCi1szpd+1spQP8AG326M77N2LnNekpivNe/5jHhJhenRedjhO8RGQ==
X-Received: by 2002:a05:6402:c10:b0:40f:33cd:a39 with SMTP id co16-20020a0564020c1000b0040f33cd0a39mr25437530edb.234.1646155295892;
        Tue, 01 Mar 2022 09:21:35 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id cq9-20020a056402220900b00413c9ab6377sm2087898edb.27.2022.03.01.09.21.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:21:34 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ay10so3782181wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:21:34 -0800 (PST)
X-Received: by 2002:a5d:64ea:0:b0:1ea:8148:6b97 with SMTP id
 g10-20020a5d64ea000000b001ea81486b97mr19720919wri.679.1646155293603; Tue, 01
 Mar 2022 09:21:33 -0800 (PST)
MIME-Version: 1.0
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com> <1645509309-16142-3-git-send-email-quic_c_skakit@quicinc.com>
In-Reply-To: <1645509309-16142-3-git-send-email-quic_c_skakit@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Mar 2022 09:21:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xj377iCjfXz-MA31y7+=nMMH8bsP4ZC13ao0BOCfNd4A@mail.gmail.com>
Message-ID: <CAD=FV=Xj377iCjfXz-MA31y7+=nMMH8bsP4ZC13ao0BOCfNd4A@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] leds: Add pm8350c support to Qualcomm LPG driver
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 21, 2022 at 9:55 PM Satya Priya <quic_c_skakit@quicinc.com> wrote:
>
> Add pm8350c compatible and lpg_data to the driver.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V2:
>  - Added const for lpg_channel_data[] struct.
>
> Changes in V3:
>  - Correct the num_channels and add respective base addresses.
>
> Changes in V4:
>  - Remove .pwm_9bit_mask, add .triled_base and .triled_mask.
>
>  drivers/leds/rgb/leds-qcom-lpg.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Tested-by: Douglas Anderson <dianders@chromium.org>

I'm very interested in knowing if there's anything blocking this patch
(and the one from Bjorn that it depends on) from landing. Thanks! :-)

-Doug
