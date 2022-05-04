Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7E51A13D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350826AbiEDNtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350805AbiEDNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:49:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB325167E9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:45:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq17so2997898ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uv7Hp42LV/vTpm+weT4So5OI48akf0l91Vs3/APjQVg=;
        b=nkKNa9OSox+I2AggVlih55mls2Es/JkmCEZAwb77r66baliDbgU8EDdLzRGFczo0yP
         FSgfD+O+c4tXzxuOhPQHxvOUlJ9D5AQyRZZw0NkeftBD0NlLvEyt0MjIhMJ+lu1gyRhR
         iFOd5IJGpYOdHePtcc3S7VnKeBkakc2CkiZbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uv7Hp42LV/vTpm+weT4So5OI48akf0l91Vs3/APjQVg=;
        b=nYrv8a9UD4TV8P+MnAPxbU5gfDr67Z/lStI9Bt9qLlk3As1/MFwwOgRVsdqANrTYa3
         dZhdm38+9RFqHaPhfk+sxLLaUFundmnaGqCMxdQNtTcCKTH7R7PCMNdoyRDQvGCqJ8TR
         UchaJmV2oyojp4S3J+/CP2uWAfGjQtR+Yv4+Dd2XyDWUypmwojKVMJ21rJHvtD6pf40u
         TJkysxKSXC6uKr29F/IhEjYH5YOx/JgEXRmKBOPRUNjVv1m07//zIV3YGO4En7z2bzKF
         H88v7/MvTFjrHdDezr684oVYiP/SRVFfX6U9FAGerPzFsU5LcznKdc9jJ65DzCzRzyQt
         kLrg==
X-Gm-Message-State: AOAM530+6oXo4sknXcTPbPsLPJOZXtx6k61PI4xfWCoRdEycGba1APhW
        WcRS2lHGY2iAIx3QqYJXLAW2mY9rA8uMQmhB81I=
X-Google-Smtp-Source: ABdhPJwU/bBPQXlVlIcJgE/imAfaahKZUCNf8SDvrGQSlq/MWMI2bfj8dBersXMBvTg8uCSXZtn5sQ==
X-Received: by 2002:a17:907:3c81:b0:6e6:cf3e:6e14 with SMTP id gl1-20020a1709073c8100b006e6cf3e6e14mr20598091ejc.181.1651671928168;
        Wed, 04 May 2022 06:45:28 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id og34-20020a1709071de200b006f3ef214da7sm5765078ejc.13.2022.05.04.06.45.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 06:45:26 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id b19so2082773wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:45:26 -0700 (PDT)
X-Received: by 2002:a05:6000:c7:b0:20a:d8c1:d044 with SMTP id
 q7-20020a05600000c700b0020ad8c1d044mr16774023wrx.422.1651671925564; Wed, 04
 May 2022 06:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
In-Reply-To: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 May 2022 06:45:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U9XfOancqNOGCWKEkP2jD4CHw6NHY8mdALG7D-7OLMTw@mail.gmail.com>
Message-ID: <CAD=FV=U9XfOancqNOGCWKEkP2jD4CHw6NHY8mdALG7D-7OLMTw@mail.gmail.com>
Subject: Re: [PATCH V4 0/4] Add PM8350C PMIC PWM support for backlight
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

Pavel,

On Mon, Feb 21, 2022 at 9:55 PM Satya Priya <quic_c_skakit@quicinc.com> wrote:
>
> This series depends on [1], which adds driver for Qualcomm LPG.
>
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=615848
>
> Satya Priya (4):
>   dt-bindings: leds: Add pm8350c pmic support
>   leds: Add pm8350c support to Qualcomm LPG driver
>   arm64: dts: qcom: pm8350c: Add pwm support
>   arm64: dts: qcom: Enable pm8350c pwm for sc7280-idp2

I see Bjorn's patch in your tree. Thanks!

...could you add patch #1 and #2 from this series too? They are both
small and ready to go.

-Doug
