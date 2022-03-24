Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4D4E6B21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355698AbiCXXUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiCXXUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:20:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDB950474
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:18:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x34so7341914ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phJ29Q0oulgzNrgAvihLKJetqMSFkbRI+rXLgF7X63I=;
        b=n/KJIFD1TlTOr/ubtWBTuWeulAPYxgaayq8TjqsdWISywCjK0dKJb9y2q1winHNuKE
         bfS9tdeUu5BAxqElAthBLgO2OMmhSHkLtYqzqQRC+drblnmOwRqDooshVgDBhG/wl2EV
         9VzjecApbwudJorSvB87tsHR/F9XwQJNLTEU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phJ29Q0oulgzNrgAvihLKJetqMSFkbRI+rXLgF7X63I=;
        b=WwgXbaNJOzQUU7hO3NGsVdUsvfft8mLCugH+waI0s6eTHh7lP1+ywGPVrL679GVqvu
         BOgLgGJTt+rRRqPBXC1IBB9JF41DWWluWXU9E55iJ5yJqEnHm3OjXxaOmOCv4GDyTpym
         toM5APzGOe6rhrRONPp/r2z0I7soWhi6iIp2xOMooVTiycYd8LCeYli6Ia5HxvWXYSyv
         go1fTLAu6LDgo1+/XqSl/LrAvGd18fs7hsiuQvm8nnBdsBs8kEnutO6+uLtjyjzsqQj1
         xDUCpnqBb7HdJTjOo5kysyPxwzM9JLKC00xy3R1QqoF0D2FoODieKctwMxYeRb/785D+
         XZQQ==
X-Gm-Message-State: AOAM531nY7oSU5kkfT2KyVsPU8cwtZQ3NviLg0ZHwEoamZIzZCfWjVGb
        jlPRlX2aAtGqdwxewunsdl5AEtmO5zkRbXSq
X-Google-Smtp-Source: ABdhPJxktr6gzAjwaccF59nB6AXP02ZqlFBQEiqKxYMptiQCyViPrlNCvr3lLvHa6iwUNamZ0DO7lQ==
X-Received: by 2002:aa7:c755:0:b0:419:2f66:e22c with SMTP id c21-20020aa7c755000000b004192f66e22cmr9280940eds.381.1648163924557;
        Thu, 24 Mar 2022 16:18:44 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm2031743edt.3.2022.03.24.16.18.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 16:18:43 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id r13so8616800wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:18:43 -0700 (PDT)
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr6224813wrc.513.1648163922979; Thu, 24
 Mar 2022 16:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220324160222.v2.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
In-Reply-To: <20220324160222.v2.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Mar 2022 16:18:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ui=+uN+rpjmArbH_7a==Bt2Z2b-NYodSB9sJKWuS2jdA@mail.gmail.com>
Message-ID: <CAD=FV=Ui=+uN+rpjmArbH_7a==Bt2Z2b-NYodSB9sJKWuS2jdA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add device tree for
 herobrine villager
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 4:02 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add a basic device tree for the herobrine villager board.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> This patch depends on "arm64: dts: qcom: sc7280: herobrine: disable some
> regulators by default" [1].
>
> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20220316172814.v1.3.Iad21bd53f3ac14956b8dbbf3825fc7ab29abdf97@changeid/
>
> Changes in v2:
> - enable the regulator 'pp3300_codec', which is by default disabled
>   with by the patch "arm64: dts: qcom: sc7280: herobrine: disable some
>   regulators by default"
>
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sc7280-herobrine-villager-r0.dts | 284 ++++++++++++++++++
>  2 files changed, 285 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
