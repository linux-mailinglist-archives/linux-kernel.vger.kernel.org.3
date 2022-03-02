Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5638B4CAAAC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiCBQnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243599AbiCBQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:43:06 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893B114F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:42:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw13so4908126ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/OHrbBOSzQoNIMp4yIse8lL5E3OuoeVt5dK0c4ZOz4=;
        b=Q5NMvvWPoa1JXTZDJe5s1ZV4XNfqE8mrsFpXI0anaiU2bXxNMjkr2TIusHZrgDAfQg
         GvuXrd5vGYsRvy+p3jRvKTDcIn5hiRh8sDfrIGZ2tGoTz1MK8bw67hxOF31U0LItDiTr
         buhlylZrDBKEhmZMQCpKBn48eZeeFDrZSlX1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/OHrbBOSzQoNIMp4yIse8lL5E3OuoeVt5dK0c4ZOz4=;
        b=E1LWmUFAWhvNkxmkuacG7nRcyMarwC5IxkuTnXPWiGma9+rdm2nkiiXw1hPB9JSDLd
         KKhtzjnW+K6ufke7KcMwFht7QMnhtoNsEcU7z2pio0+hrXgd6DuVXD0BCCAuYQDSlrFO
         gYPC30ySNfYfgMezfwgCgtmG3fSVtrfjpld5cQ9EtiCoSgiWEIYaEj535Y2Zf8jK9Mwk
         ef+33KklmQSdOb8JMqDNT3BqUwq/cbVJu81dN50arjygu7PjLlyP8vmw1XxrOBT9TdXh
         OEsg0+ujuFJNwye1LdReSZGb2+e2uPkXNO0Ugc7YkKUw9pGN2JrU1h60Fe8Qg8fcdiMP
         4ajA==
X-Gm-Message-State: AOAM532YkyjgBRy1IfyBsCALTUcL5+XuKRgqmSQKaCI7Xi4klE0r2HD1
        9usYmdQgzk98J7jmNOA5/XQp+MyI0PB3Y+v1
X-Google-Smtp-Source: ABdhPJw3oY7wwfVs+FBD2f8LQq1HF3B0QBDVz8bXARV7u1b7vkB0ZkCuU8PzcsqTweEyXj7gpgnRTw==
X-Received: by 2002:a17:906:4cca:b0:6ce:6a06:bf7 with SMTP id q10-20020a1709064cca00b006ce6a060bf7mr24328647ejt.109.1646239339802;
        Wed, 02 Mar 2022 08:42:19 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm3413293edw.72.2022.03.02.08.42.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 08:42:19 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id j17so3770817wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:42:19 -0800 (PST)
X-Received: by 2002:a5d:6543:0:b0:1ef:7194:3efc with SMTP id
 z3-20020a5d6543000000b001ef71943efcmr19660822wrv.422.1646239338601; Wed, 02
 Mar 2022 08:42:18 -0800 (PST)
MIME-Version: 1.0
References: <1644843828-20464-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1644843828-20464-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Mar 2022 08:42:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XtkXganjG=ddgaq4-p+cAK1c4jqG=8Ux_xxdUrPpXhVA@mail.gmail.com>
Message-ID: <CAD=FV=XtkXganjG=ddgaq4-p+cAK1c4jqG=8Ux_xxdUrPpXhVA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Configure cts sleep pinctrl to
 bias-disable for sc7280-idp
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        msavaliy@qti.qualcomm.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 14, 2022 at 5:04 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> WLAN rail was leaking power during RBSC/sleep even after turning BT off.
> Change sleep pinctrl configuration to handle same.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index d623d71..de18319 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -516,10 +516,10 @@
>                 pins = "gpio28";
>                 function = "gpio";
>                 /*
> -                * Configure a pull-down on CTS to match the pull of
> -                * the Bluetooth module.
> +                * Configure a disable on CTS to lower power usage
> +                * when BT is turned off.
>                  */
> -               bias-pull-down;
> +               bias-disable;

Why is sc7280 different from all of the previous devices? Did the
Bluetooth firmware change or are we measuring a different case? I know
we spent a lot of time carefully choosing each of these pulls before
so before changing them we should understand what changed.

CTS is an input from the AP's perspective, right? From the AP's
perspective then the case we need to be careful of is to prevent this
line from every floating while the AP is turned on. Specifically,
consider this case:

1. AP is powered on but has no pull on this line

2. The Bluetooth chip is powered off or otherwise configured to not
drive this line.

In that case the line will be floating. Its voltage will wander
around, influenced by other parts of the system. The downside here is
that, so I'm told, this will cause power draw on the AP. Each time the
voltage on the line floats between trigger points that the AP is
watching for it will trigger some logic in the AP and cause power
consumption. That's really not ideal.

So by disabling this pull you need to be _really_ sure that there's no
case where the AP is on and the Bluetooth chip is powered off / not
driving the line. In the past I don't think we were convinced of this,
which is why we configured a pull but tried to match it with what the
Bluetooth chip would do anyway.


So... How about using bias-bus-hold instead? That has the advantage of
keeping the line from floating but also shouldn't cause a constant
power draw. I believe it was created _exactly_ to deal with this type
of case. I don't think I was even aware that we supported
bias-bus-hold the last time we had this discussion and it seems like
it would solve the problem nicely. Does it work for you?

-Doug
