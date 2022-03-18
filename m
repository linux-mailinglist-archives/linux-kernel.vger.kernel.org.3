Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493F4DE2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiCRUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiCRUw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:52:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306BC10CF17
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:51:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a8so19243715ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1qM/WmTAXskaF+yjSfV1y7KJpm/uUXfuoW9PJStJes=;
        b=VZWZ0IzAl1rOPM/z/xPexnHEnRbP829O+gSjjudc/IoKBdhcgQ5ifOZ8tWROZHiH5W
         q/7uP7NMyRTkfS8VYLjs0FCwhzGBx92LSOB+VlbawpNo99xryRkqiwgs3scnW+4ck7y8
         37fv7JFN2lAqn2m/eDQCxzp3ipxCejSClREu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1qM/WmTAXskaF+yjSfV1y7KJpm/uUXfuoW9PJStJes=;
        b=tXlcP9C1St/Uz30u7NIbRTGgYRnHN8JAIa6VtsDcNZpFhskE+YCQtDnhyw9sDa50uV
         kvFxuIhFoJ/GAKttedPwQ7xPp1bMoDID+vEB0Wq1QLsnrpUE+8hLzpjbIO9dYTrSyVLl
         dceKlBVWJQ6fvuEiejuLMc1EjGctPqBWvlz+/PnVQvdAFZj7YvF2Da24bxI0ljKmXPmV
         QI0Pwb18OIXbjMYajUr4Hj5vLCT6BJ4mwX3pRHMl67NrSmEMBAkDu5rDF2S0rLauznMM
         PMzxd4FNB5uNkey3LeuEfavQu6sYbyl8zyt5D0ZZKNfvAGZzBBCZSlTe1AjYqmT+E5Bb
         q0qg==
X-Gm-Message-State: AOAM531GHOVbbX4fkJxT7oN6JXxTq9NkiNBETcwHe7twXuaHmBzcyDIH
        XMn6qqt3wNMAMCPS3OYhzH6ofqqqosmskjtxoH0=
X-Google-Smtp-Source: ABdhPJwjf8Aa/keVhouC8QNYI4Yf7BSwn6sT9PoBsbpAbS1sz6qoXzc/2XL0G2IUjPiniC3eCwbj7A==
X-Received: by 2002:a17:907:9687:b0:6df:8f17:c16b with SMTP id hd7-20020a170907968700b006df8f17c16bmr9282249ejc.363.1647636668451;
        Fri, 18 Mar 2022 13:51:08 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id ne42-20020a1709077baa00b006d76251f4e7sm4308770ejc.109.2022.03.18.13.51.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 13:51:07 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id j18so3580686wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:51:07 -0700 (PDT)
X-Received: by 2002:a5d:4491:0:b0:203:f63a:e89b with SMTP id
 j17-20020a5d4491000000b00203f63ae89bmr3997914wrq.342.1647636667105; Fri, 18
 Mar 2022 13:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220317010640.2498502-1-swboyd@chromium.org> <20220317010640.2498502-2-swboyd@chromium.org>
In-Reply-To: <20220317010640.2498502-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Mar 2022 13:50:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UF3E=4YFRLKZjY3Dp+xzR9rg5FK=Ovq+a=VrcSvwU=8g@mail.gmail.com>
Message-ID: <CAD=FV=UF3E=4YFRLKZjY3Dp+xzR9rg5FK=Ovq+a=VrcSvwU=8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7280-herobrine: Drop outputs on
 fpmcu pins
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 16, 2022 at 6:06 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Having these pins with outputs is good on a fresh boot because it puts
> the boot and reset pins in a known "good" state. Unfortunately, that
> conflicts with the fingerprint firmware flashing code. The firmware
> flashing process binds and unbinds the cros-ec and spidev drivers and
> that reapplies the pin output values after the flashing code has
> overridden the gpio values. This causes a problem because we try to put
> the device into bootloader mode, bind the spidev driver and that
> inadvertently puts it right back into normal boot mode, breaking the
> flashing process.
>
> Fix this by removing the outputs. We'll introduce a binding for
> fingerprint cros-ec specifically to set the gpios properly via gpio APIs
> during cros-ec driver probe instead.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Fixes: 116f7cc43d28 ("arm64: dts: qcom: sc7280: Add herobrine-r1")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
