Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21EE4E6AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355210AbiCXWhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiCXWho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:37:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C3BAB83
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:36:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qx21so11955045ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6IOeNLpJyv8LNAg0lIn+GQLMzUbl9r7/TJFCZNGFfI=;
        b=dGR+6YPVvBEoetW1oLf+P+zyYE0iBwuXw+PtnY7E9zECYTvAPHLgKdxN0F5oLHWXI2
         hFbNqFIdty29VuOjAZlLV4A2PE7MfkwddEWJFez5qCBGTpqBh/5MQzHz4FP6wuFyPuw1
         h4JAD83gjbqFuL3aFtb3g14/klmt1aHjKUaJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6IOeNLpJyv8LNAg0lIn+GQLMzUbl9r7/TJFCZNGFfI=;
        b=Tyj7+A0M6i85aO3ZCMnsysEV8ZMSPV/ASCcMj8VAMEOGibPfHv2T4/iKs5d03ZBE/W
         umSlvTQkVtLxegSzsY7OkmV3Kc6aDmLhkDRbPm+DBy4s4uKAIxKSCVIXEpN0flvPoPob
         1xakrzbTYi8Wmgx9ocs4Au4e164XdaRIGkeyobQEKEBapE5mZuu3Pem8P4G/rRxcD7DN
         Vxe97paxp9b+XWWcJcak3onFzpUQ0Ch+Ghk/OkTGxsW4mTCQAWMxrwuniEZtwTm/OijE
         d6umnR09YXK4D3+otPKgRwQ9nO3h8r5Y3lii5uiRIOaLJk8/nli2uDsGPDEiSZvQJkDC
         q69g==
X-Gm-Message-State: AOAM533r8Z1sdezabio9tnLL9uzEcyvvKra9rQyIpe/aiSK5LQre/kTy
        6dI2giZu5doKnq2V+EFvzi7ZqTv4Ko4Xvd62
X-Google-Smtp-Source: ABdhPJzrQEzrabhBfD/AwUUq3Q7J+ZM8ARF2YE6ZjTQeT6doUETVbIG0Dt74myqpp0yyNanN1HFgFQ==
X-Received: by 2002:a17:906:a046:b0:6b9:20c:47c1 with SMTP id bg6-20020a170906a04600b006b9020c47c1mr8170222ejb.615.1648161369936;
        Thu, 24 Mar 2022 15:36:09 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id d24-20020a1709067a1800b006e021f4c1c3sm1631482ejo.166.2022.03.24.15.36.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 15:36:09 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id d7so8534098wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:36:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr6123801wrc.513.1648161368223; Thu, 24
 Mar 2022 15:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220324223331.876199-1-swboyd@chromium.org>
In-Reply-To: <20220324223331.876199-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Mar 2022 15:35:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UdB-RNXQeQsyzMF0hu6Z3vz1wRRiqQwvepY_TuQDHKuw@mail.gmail.com>
Message-ID: <CAD=FV=UdB-RNXQeQsyzMF0hu6Z3vz1wRRiqQwvepY_TuQDHKuw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Fix sar1_irq_odl node name
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 3:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This node should be named sar1-irq-odl, not sar0-irq-odl. Otherwise
> we'll overwrite the settings for sar0 with what is intended for sar1,
> leading to probe failures for sar1 that are quite confusing.
>
> Fixes: 116f7cc43d28 ("arm64: dts: qcom: sc7280: Add herobrine-r1")
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Oops! Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
