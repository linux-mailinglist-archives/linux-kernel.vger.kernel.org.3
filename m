Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E44FC691
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiDKVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiDKVSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:18:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D11D32B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:15:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lc2so12880585ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3IPKba47VHgKeeSAVtwOFmES8+Ru1c827vSgPVijTU=;
        b=EOnIBkqU4gAnFTiOCLuuFJuYrgMFSYtiBJzSaGkZhWnqDoH7SY2EVy1Wolr2JY+s1/
         GyAySIrorqGQ2K1QrPWNJOesbKQvhPoaTxKwZNEl5RzrcglL3fjjESgXCExNPX/fI2Ue
         qiSGZ4q5xIUeoA3H9DI8cr5VuAKNL1LKU4xDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3IPKba47VHgKeeSAVtwOFmES8+Ru1c827vSgPVijTU=;
        b=GvRPbtAQAa+1JNBjrbez93OR2bIg9lEaWK4Tg96tQohMQx9mztQwqO7CiiviUGwmkI
         Qkjo2HS0Z8+BL3BnPVwPIb0t/dJNGUev5VUNu5j6HNzOVGfNFLZ1nkqhSxCU/Uaejv5C
         FO47KCikZ3DEdHoQv6D8tVwJfxxBsOoHhkHbhRGoI/m7+rfLiuUeic7+NSMNa1I7UY4Z
         K97geqlhqngQm7lwWkrmizdtTQoal50N2elH7gi6ws+GCrzCuufhqE78f7DUJRanlTZB
         ZM2kwLOzsUEhkU58nSz5X7dA7wOtQv0Sxnz1H0zWm55lYfm3LV0nUN0bwyuyffmE4Rp/
         houw==
X-Gm-Message-State: AOAM531ihS/uQdhRIoJVbmgSRF/wlCEdpUL3d9+OgVxkqQUuRfJwDzIj
        IEwRoMNyj9L7tAC2fCoMq+8Ex74saou63fev
X-Google-Smtp-Source: ABdhPJx4gNal8C0ZANUpZzEW7cttWiPRULD77hWCuouL9GG0AsRb7AXnwL0pa4XLsA+yLVSvwPbmsw==
X-Received: by 2002:a17:907:980d:b0:6d6:f910:513a with SMTP id ji13-20020a170907980d00b006d6f910513amr30129837ejc.643.1649711749626;
        Mon, 11 Apr 2022 14:15:49 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id kk23-20020a170907767700b006e8a6e53a7bsm628181ejc.139.2022.04.11.14.15.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 14:15:49 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id r7so10709370wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:15:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3ca4:b0:38e:54d0:406d with SMTP id
 bg36-20020a05600c3ca400b0038e54d0406dmr922556wmb.199.1649711748286; Mon, 11
 Apr 2022 14:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220411141332.v2.1.I9f06fec63b978699fe62591fec9e5ac31bb3a69d@changeid>
In-Reply-To: <20220411141332.v2.1.I9f06fec63b978699fe62591fec9e5ac31bb3a69d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Apr 2022 14:15:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8sWD0ktzFLou1m4RSoutj7N22hjCjFVS2xqB_Lnb8KQ@mail.gmail.com>
Message-ID: <CAD=FV=X8sWD0ktzFLou1m4RSoutj7N22hjCjFVS2xqB_Lnb8KQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280-herobrine: Audio codec wants
 1.8V, not 1.62V
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 11, 2022 at 2:14 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The L2C rail on herobrine boards is intended to go to the audio
> codec. Let's override the 1.62V specified in the qcard.dtsi file to be
> 1.8V.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Adjust Qcard regulator override section heading
>
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

...and I somehow forgot to add in from v1:

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
