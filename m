Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC09A4C0224
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiBVTnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiBVTnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:43:06 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8FEBC09
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:42:39 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s5so15741615oic.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=tHHrQuSWi58Byx8KIrTnO3jC3OlHbtYfA548Skw/vVk=;
        b=Thn1gy4F9LDXT+Y1U9VDZf1kI0pRTYFEQrKi7aieN5nYbldDAVZ6BJik23Hru52Zcn
         r+UjTboIY+/MK7NuFGVqibLvjgamJ7R5VKYjFoQlQBCuPBgTZxYgG3bQMOilDssOuuWn
         TCsVaig9doPZbl7giEMe/8IiTkEoEK4ILVrUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=tHHrQuSWi58Byx8KIrTnO3jC3OlHbtYfA548Skw/vVk=;
        b=6S7havfEVbI5/rY/GEpWZhptqsH9DQcgkSB9Kxc8BX7nUzXYfPnPjJysHLbK5+Sglu
         bMz9g0lDlrefrDGugz0oh6tt2F33ag5mgV3EZxaxgs9uP7P7ZK3ehx7UP8Ik8JdSI8ku
         6BtPrjVxBk+jZSeTJpNmr2oYdfcRhgKctZFSaCy2QTlf93Jfvt6U5FeawTmxPT2lxpfM
         CRe+/d5j9AtJhIF4L3d/u3qDn2Ivam5cm0HjTUptVXADzRvwJqMq8WtXJFymYl6jG7Zh
         yPrzXEfY0L1ek5gfityCMvuJW9mOzWikVkLnufW7gXslJbMXNayBq7SVHG7qzhFXPs/y
         YyMA==
X-Gm-Message-State: AOAM533IZx+yZ5rvGmGmoJ1DR8HOhTT4Puc/CRIgP7MW1wYT07xNJr9V
        p99A6UfigIskOItQxDVOkYVV9X0dE8t3ErVv8RuJdw==
X-Google-Smtp-Source: ABdhPJxZ52ezKmoUqfjedGIIW4Ty4dTio7wMBusWG2Qqyp7uDWt0Dx8ARcCmp+baGQTchg2Ict/x9PMcFhbsByrf03s=
X-Received: by 2002:a05:6808:f88:b0:2d4:c8c2:b898 with SMTP id
 o8-20020a0568080f8800b002d4c8c2b898mr2798658oiw.112.1645558958512; Tue, 22
 Feb 2022 11:42:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Feb 2022 19:42:38 +0000
MIME-Version: 1.0
In-Reply-To: <1645509309-16142-3-git-send-email-quic_c_skakit@quicinc.com>
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com> <1645509309-16142-3-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Feb 2022 19:42:38 +0000
Message-ID: <CAE-0n538_a=j9NjVyZfvVwN2KNEFqu9cX03pa_6LZXyc6FVYNw@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] leds: Add pm8350c support to Qualcomm LPG driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
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

Quoting Satya Priya (2022-02-21 21:55:07)
> Add pm8350c compatible and lpg_data to the driver.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---

Still

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
