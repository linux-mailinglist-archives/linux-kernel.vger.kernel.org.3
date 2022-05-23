Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B065317C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiEWUMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiEWUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:12:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA5A9BADF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jx22so17688527ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZXLD0VurYCh4Xqp/G9KEyyGkpU1wTIUGVr+sFogb9o=;
        b=Fj0W+N17zW6yRB4z6FkPqWEjRsyQ3VQSEGzXc/5AmfMrpkVI6MFFl9VFv9gD4moqur
         MJO9gvDkoO1boyRj1TJD795LktG2BjimRT2Gu1I300lL3fWQ5usYaZLYclexuSqNF45Y
         FdBoQBnUnSSAAH6TSh8d0dYmyZ1QnEiVktIcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZXLD0VurYCh4Xqp/G9KEyyGkpU1wTIUGVr+sFogb9o=;
        b=D/36bQt0hDRttEeZvZqEK4yQgh1YpJsWtZV5v2EqbH8eMcekJC3GeiLiWP2tH0mPMh
         wLtGSPpIgxI6urcLLG8Dxx1PdNK+LnkWALtjHpYEDhEsZY+CEk80bMANpUV25TjdbbUm
         cMBJ+odR7gNADzGB/YuyVlForyfP8roZ6H46rG+OAkEZ/fP6sXA2EdG87LB66UgpGOtk
         HT1XbUBFHVBCgSsgkocIRVtUZxbY4wIp+FXcQa5Z/XbV0AitH1JNG6XyZzxV8xnrIPMd
         /jOMz8J6KyHD2ljfZQprzFjgefQw67EjDKeJg+FoVDNjOrj6X+AWXYQJlPEpstvbGRaP
         edLA==
X-Gm-Message-State: AOAM530C9agCuUlcIs4MjIcjoUbrz/v74iRrzY31Nmyqce3Fgxf/QtHZ
        oxzKEoOLaW52WpZvoVhlOQddNVQeypSX2Ev1ms0=
X-Google-Smtp-Source: ABdhPJwD0zRGmtolfeMRS1TFwVgogcW8shHH2Tg1bBK496Cb3Lpy1iLPIsogHQNcUzfKHwM0seMgZw==
X-Received: by 2002:a17:907:6d05:b0:6fe:c506:9239 with SMTP id sa5-20020a1709076d0500b006fec5069239mr9316493ejc.539.1653336733792;
        Mon, 23 May 2022 13:12:13 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906500400b006fed787478asm1826853ejj.92.2022.05.23.13.12.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:12:11 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id u27so22070195wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:11 -0700 (PDT)
X-Received: by 2002:a05:6000:1c03:b0:20e:5cac:1eb5 with SMTP id
 ba3-20020a0560001c0300b0020e5cac1eb5mr20567416wrb.422.1653336730934; Mon, 23
 May 2022 13:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220523123157.v2.1.I47ec78581907f7ef024f10bc085f970abf01ec11@changeid>
In-Reply-To: <20220523123157.v2.1.I47ec78581907f7ef024f10bc085f970abf01ec11@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 May 2022 13:11:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XAVrBuOiHJju+xsLbzEvdMjRO2a7U8T9j=H85xuBQrdA@mail.gmail.com>
Message-ID: <CAD=FV=XAVrBuOiHJju+xsLbzEvdMjRO2a7U8T9j=H85xuBQrdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7280: herobrine: Don't disable
 the keyboard backlight node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 23, 2022 at 12:32 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On herobrine boards the keyboard backlight is controlled through the
> PWM LED driver. Currently both the PWM LED node and the node for the
> keyboard backlight are disabled in sc7280-herobrine.dtsi, which
> requires boards with a backlit keyboard to enable both nodes. There
> are no other PWM LEDs on herobrine boards besides the keyboard
> backlight, delete the 'disabled' status from the keyboard backlight
> node, with that boards only have to enable the 'pwmleds' node for
> keyboard backlight support.
>
> Also add a label to the 'pwmleds' node to allow board files to refer to
> it with a phandle.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
