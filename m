Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0967C5319DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiEWUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiEWUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:12:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE79CF7D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gi33so22637214ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuG3WOfwg7N2zjjXVVXzvW7nWRrDlxN2WcRKWNRMyhE=;
        b=mrGGDzsrU2CViHCIngHNzFab2RkysD3zDLUmKSfKQIzBeth56u1JarRpzXUsIZ1DOz
         Coj5tjyBwiv2O6tafwNcLVfuOGqDQIckY2GMGrPm14EiCEUafsgJSMmUl0k7svyTjzJY
         EIIpExGLw6hyzIL+hIhVjAFHh0egExaERVA08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuG3WOfwg7N2zjjXVVXzvW7nWRrDlxN2WcRKWNRMyhE=;
        b=kw/FuNhNRCt3bIZk7vjoMUomjRTugaVsnf8XJvQRlAzHidIVPrZZJUK7dr3ClHuyj/
         /YbqCzpkFxv+M5nuK5CHqaY4TdwoXUzVpw8/bQij42mONq25Jf+bchHPHW3oseq3cIj0
         v/3BamndzTIQM2ZGu1Bmhud1wwHFmbKl/EWqMrhZ/0CsSa22sTuOij5hccUY8uzskuFS
         qLC3cxlVC752456Q+05juxn/UR829FZZypBtKoOP5fkT8C7fYDGHn1+ynoGzUCNLhUaP
         2JcQnDvwsxypgkZIVe145sKq97rWlXMp5bwYAnL7mrARMwHaHMzMzQlSw3Um8sqXRTVr
         ku9Q==
X-Gm-Message-State: AOAM531YNuOEF2YwY5AcQa4YUw0pvsMFXE99s8kf0kzU2rsNFAUBWOwK
        pyEoGWrLY2B1trCrz/DkllENgkGBLtVns85NTb0=
X-Google-Smtp-Source: ABdhPJxC/iuHGIT0Zp4M1T5l4yD+0WBGixcE6uuylDXSotE/JaRDeG/wE5af7oXda13Yvp2Qfd8wkQ==
X-Received: by 2002:a17:906:4b55:b0:6fe:c52c:68c9 with SMTP id j21-20020a1709064b5500b006fec52c68c9mr9530334ejv.491.1653336765700;
        Mon, 23 May 2022 13:12:45 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id b18-20020a056402139200b0042ab87ea713sm8539362edv.22.2022.05.23.13.12.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:12:44 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id u27so22071770wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:43 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr11198208wry.513.1653336763435; Mon, 23
 May 2022 13:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220523123157.v2.1.I47ec78581907f7ef024f10bc085f970abf01ec11@changeid>
 <20220523123157.v2.2.I3d1b5a109675a0cc90e66a4e0b45cb823edbdee7@changeid>
In-Reply-To: <20220523123157.v2.2.I3d1b5a109675a0cc90e66a4e0b45cb823edbdee7@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 May 2022 13:12:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U7qRbLc915tzhcYVmBd=r=YdwX6VQZebW9Ujy=FX24NA@mail.gmail.com>
Message-ID: <CAD=FV=U7qRbLc915tzhcYVmBd=r=YdwX6VQZebW9Ujy=FX24NA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Enable keyboard
 backlight for villager
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

On Mon, May 23, 2022 at 12:34 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Villager has a backlit keyboard, enable support for the backlight.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
