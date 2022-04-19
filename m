Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5D50705A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbiDSOau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiDSOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:30:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371812C12C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:28:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y20so13161347eju.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nj2bwCdNC7HwvELjhLY4xYS1yLs5HxcxFqDH74I+UnY=;
        b=B3SiqcstytlQ82E04Waa6/M3nW29rmiBNUkLFmC9WM7jnffgpNy6IjRFV0crd0hF7R
         kcF8m9ktNN+w8ii5kTtxi7D8LCi3jl+5QjVAHw3yc5CQBdM3VTFLDGas2ytvluL/OURr
         GHEZ7O/R/ENukYVhf76eBTjEKHNirDS9hihnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nj2bwCdNC7HwvELjhLY4xYS1yLs5HxcxFqDH74I+UnY=;
        b=CAnSZtIW8WY1ZrosIXnxfAYQrmu/tf+HEa4/ohgbCiQ1bDy2xC5InQLhU/pcZiiTf3
         tD5hF/KRyJ+757KZxFVpecSb8SY/0P4vAreriKXXqcfYkjey+uINh8QN2i+CDifp4U38
         R3zLkPmatIWRVlAgdlcdQocozyYy/5j4yucyA2mWqzakD/JMhgZGxyt7dSliWdiscBTB
         ujnVrG+h3aosf2TzZ1Rquow9m4W4PBiqsD6s/6+E2IP91xAatjn/o2CB6jI7n808XqCc
         pAvT/DUJxrEO6rrjIuN7PlUr/cpRKt5wEGIOe3fzE873MNkTGQz2zhr34FCatG9YTbC9
         EGVw==
X-Gm-Message-State: AOAM531wzUKx23eXO09eydNTjUJdpaLZ/zLZf7VFbQXZYbERWIMe3hiV
        YUwz2/MgJlc+8/X8kXpnWnksIxbI+ILFRiRm
X-Google-Smtp-Source: ABdhPJyXtSJX/tiy8kglP2G7pTe6seEi5MN5NCG+LaXeQn6D0f9fvXqrVWvIhoJn4GfzVGPQqxdHag==
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id l7-20020a170906794700b006da892f2503mr13622980ejo.710.1650378480304;
        Tue, 19 Apr 2022 07:28:00 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402045800b0041614c8f79asm8631806edw.88.2022.04.19.07.27.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:27:59 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id i20so22660718wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:27:58 -0700 (PDT)
X-Received: by 2002:a05:6000:1105:b0:20a:80b4:bcaf with SMTP id
 z5-20020a056000110500b0020a80b4bcafmr11868665wrw.679.1650378478239; Tue, 19
 Apr 2022 07:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <1650349697-13540-1-git-send-email-quic_vnivarth@quicinc.com> <1650349697-13540-3-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1650349697-13540-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Apr 2022 07:27:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W6R9iPt1aCDpq4BRBfZ+KFUsOAUKCOhY2KQo_GpMhoiQ@mail.gmail.com>
Message-ID: <CAD=FV=W6R9iPt1aCDpq4BRBfZ+KFUsOAUKCOhY2KQo_GpMhoiQ@mail.gmail.com>
Subject: Re: [V4 2/2] arch: arm64: dts: qcom: sc7280-qcard: Configure cts
 pinctrl to bias-bus-hold
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 11:28 PM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> WLAN rail was leaking power during RBSC/sleep even after turning BT off.
> Change sleep pinctrl configuration to handle same.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v4: modify subject of patch to indicate file it is applying to
> v3: apply same change to active state and other sc7280*.dts* as well
> v2: used bias-bus-hold as per review comments
> v1: intial patch used bias-disable for sleep pinctrl in sc7280-idp only
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

You should have carried my tag forward. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
