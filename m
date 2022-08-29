Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092FB5A523E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiH2Qwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH2Qwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:52:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E6F7AC0D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:52:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e195so1103150iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YQCZ5HXSfGZcA8bcBTLo0V3fSltEFeq1A11Jwesd6xE=;
        b=kYSctfKLBfS+DN/xG+rtV9Jy92t2ysJSmULWExywhnmeM6p58gImEdKuuQ1ee3JaaH
         tCdETv8lpg7U8P8M5yqFbeAkxkP2XBk0PkR7q4a3m/7FpDHGhF4/eGxenF4e1bHaiw9B
         II2LQsvExAMznOJMpU3H80SLkzQWY/ro6k9KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YQCZ5HXSfGZcA8bcBTLo0V3fSltEFeq1A11Jwesd6xE=;
        b=tTT1B51u4HitAHql9AXy/L2Hv1t8YzUyoRoK+D1I5Wcc5ErNmCL+toNH1h6Zje/czz
         o9KUp1neOa5BxdvQCStIrjMm6Mqt/xldXmAuEnTQAkPnKt6Nh4K1j6B6wRJx2b47jimY
         g9AyfHTgp2rHgZBF0UkC9vQ2CoMYKxuDKGKqSBRCe5WiY3/Lg1XYJdSniInfp4pd4Bex
         FMI7SJe2d46puis/0EXttZuRcD5CN7wd1JWIxDoE9IWNHzIfqReOw41Hv/xAjtg+iBM1
         13wZjY0Gq5SszjtuASJ2+iujfHJB/1sCUiFM50K5tb50pT/dz8pgy+S6ALYwBsq9R5+3
         jwIg==
X-Gm-Message-State: ACgBeo0XQP4ilBYig0WcEVuZAPPOOE6XyTj5sak2tHx10XqwHFgCoUVE
        OYj6V2B8OMIHsIstHPFbqqDSpIzYPdXrXTa4
X-Google-Smtp-Source: AA6agR5R4kHwgTW6tJd1EttpQkEzZ8bHczrLsbT7jKF2PmUTB8IJMJFTVanMKX+sJyGdlov7bDziWg==
X-Received: by 2002:a02:9101:0:b0:341:a089:e855 with SMTP id a1-20020a029101000000b00341a089e855mr10265397jag.230.1661791964273;
        Mon, 29 Aug 2022 09:52:44 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id t18-20020a02b192000000b0034689175166sm4445236jah.86.2022.08.29.09.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:52:43 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id e195so1103063iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:52:43 -0700 (PDT)
X-Received: by 2002:a05:6602:2dcb:b0:68b:7804:e924 with SMTP id
 l11-20020a0566022dcb00b0068b7804e924mr2910751iow.54.1661791962863; Mon, 29
 Aug 2022 09:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220829094435.1.I4534cf408373478dd6e84dc8b9ddd0d4e1a3f143@changeid>
In-Reply-To: <20220829094435.1.I4534cf408373478dd6e84dc8b9ddd0d4e1a3f143@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Aug 2022 09:52:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvpoK-z8pU0u+oKPahSA3sgwj+1u9DtJX4nRq4xOO24g@mail.gmail.com>
Message-ID: <CAD=FV=WvpoK-z8pU0u+oKPahSA3sgwj+1u9DtJX4nRq4xOO24g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-qcard: Add alias 'wifi0'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

On Mon, Aug 29, 2022 at 9:44 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add the alias 'wifi0' for the WiFi interface on the Qcard. The alias
> is needed by the BIOS which patches the WiFi MAC address read from
> the VPD (Vital Product Data) into the device tree.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
