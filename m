Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3E52F43D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiETUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbiETUIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:08:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA015F6EE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:08:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gh17so4488579ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqeP5rdlyT9Ojb1o/Y+c7yG6gWz0o8Ya2ALrWN0i/h4=;
        b=A6tATn1zlH3Ye7b1NXpayU3ySugX53PcyxEpLXWt24vF/to1SKuRlxfJtdLplXWXfq
         A0noXbVj2uPtYxryi/uvbqcqTk9arKbWsQfNmCzY6HfD5gaBDDeHd01OvZk9xwBmCj94
         IDsrT/ihzL2ZJm9QRmpcunQ9T/lHggMYZ7qko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqeP5rdlyT9Ojb1o/Y+c7yG6gWz0o8Ya2ALrWN0i/h4=;
        b=3lqS15wdYSWzUqKaQTkr3XbylbOSZLHJXc64DcNfLFxOHNxloty+AS5DERV6Fh5HoG
         h5jnJ0GqyWkZp3iSFrZ2FrmhQhDJXn1e4xJz8VffGltDpjY944Y6MLLckDlECO3N29cX
         yxhIJ1LZjMEIyc0wyLLfav0asAYEp9+iAjkuIWnvRPatY+13VRYld7oku4FFwCl2V9t9
         i/d+DKW6fxMCZnApnnh4IdLqG4bolF+gyYwr2L7Ye0//LYJokCe9ona9ixFm5y0ge6Cz
         psYu6pP9ba7lnG0cf0Pc7wg82mraJyaKqBBi0YeWYq2I9GS6TB8gxsW24bgO7uIZ6vXc
         xLOQ==
X-Gm-Message-State: AOAM532FLoFydvnvD2DmcMFrRWfIOXhgLtGv6OKJjE4SkgUgDrbtHxka
        1puPiCeh104+U8+OzudhUIYgyZPtldfOeOAlpnM=
X-Google-Smtp-Source: ABdhPJxSLLhajuSsJnMsgmwtv7UMA5WN5hAnuoC5GC5jcfG6f4hdHR4N2qMygMj7y7dCI7ZnPR+BHw==
X-Received: by 2002:a17:907:7da2:b0:6f4:dcb8:7b7 with SMTP id oz34-20020a1709077da200b006f4dcb807b7mr10132657ejc.443.1653077286954;
        Fri, 20 May 2022 13:08:06 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7df82000000b0042abfe32ac8sm4666694edy.30.2022.05.20.13.08.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:08:06 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso4919234wmp.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:08:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr9500680wmb.199.1653077285694; Fri, 20
 May 2022 13:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220518155252.1.I176d4254c79cfaafa38cbe36f066f02f819df9b6@changeid>
In-Reply-To: <20220518155252.1.I176d4254c79cfaafa38cbe36f066f02f819df9b6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 13:07:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+4JhN8EScFDZAiduo6zy7c0pbr6EOJpSo25ctOW-zRA@mail.gmail.com>
Message-ID: <CAD=FV=X+4JhN8EScFDZAiduo6zy7c0pbr6EOJpSo25ctOW-zRA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Enable wifi for Chrome OS boards
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Kevin Lund <kglund@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 3:53 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Enable the 'wifi' and 'remoteproc_wpss' nodes for all sc7280
> based Chrome OS boards. Delete the corresponding entries from
> sc7280-idp.dtsi since this file includes sc7280-chrome-common.dtsi.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 13 +++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 11 -----------
>  2 files changed, 13 insertions(+), 11 deletions(-)

Looks right to me. You're also adding the firmware-name, but:

* That's in the bindings.

* The name you have there matches what's in the linux-firmware
repository in commit 0d5e9f7e0aa1 ("ath11k: WCN6750 hw1.0: add to
WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1")

Hmmm, I guess one question is whether this same firmware would also be
used for other, non-Chrome sc7280 devices. If so then the
firmware-name probably belongs straight in sc7280.dtsi? I suppose that
could always happen in a future change if/when we have other sc7280
devices and it's clear that they're sharing firmware. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
