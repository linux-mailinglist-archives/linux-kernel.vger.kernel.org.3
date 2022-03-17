Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4104DCC17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiCQRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiCQRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:10:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81ED0AA1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:09:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d10so12053698eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnkSvmM2RLTDcYPOq9eNhcQfzzwiY4NpXIDwpU3VaFI=;
        b=Sornkk7buwSd+gYZlnieoa57pLOfbYNReimDpIoQUCqc2gwZHaDs9iAVjq005u12w5
         J8p8dTXstxDAcKqyEA9kqn9FuC5a6+YzzOsPOnvi0BFf2FXuYm8M/hDJwg0wSy5Cetx9
         sihyGtiVhTTPr1nqqxsNkcq8b5m17V2XJG5VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnkSvmM2RLTDcYPOq9eNhcQfzzwiY4NpXIDwpU3VaFI=;
        b=2ORMm82B/FMS6RiAwrNhZVPMrdMnlq6yVMRpTiP19j4Cuqkv1sJ5GwaPbfzyil97jk
         vzUsveOB2z3I+Km5+PHmLdb+/GeE9VQSgj73QkNx6vzIaOh7PTqRYYuzgfttta7fb+kO
         RTOQvu2yO2Z7IAHk1rQkMDOM6irrTO8Tg4Jtsb8fNc30EQ45b9E3E53hXkTX1S4nxJyp
         UBuSuoklBBF0cIgRSVpWerhcQ74GrU/9RKZcUXcfk/Vlfw+WpGDe7EZ5FCeylpOuVDcC
         F9cWapuQj9fwzIc06LoUSHjSRY9cZExM5e1qXn1vv7WEPgUxXIbp5WZ4HwXHocuLxvJ/
         jRig==
X-Gm-Message-State: AOAM532EdU01SPy0ZOJxeBKPI4iYmsg76hI7WYf9umYpVJt8fLonE/R8
        iy4TO4oRJx6dJiNIUXnWjPiBuEJHK30xTNFe
X-Google-Smtp-Source: ABdhPJysIKt7xKe9fG/wRT05CT/0XK6jJphesM/DwPt9C1KLUT90luL7haYe60wUxBi/zYvBA1qH1A==
X-Received: by 2002:a17:907:9487:b0:6da:881a:a4b8 with SMTP id dm7-20020a170907948700b006da881aa4b8mr5556594ejc.88.1647536941496;
        Thu, 17 Mar 2022 10:09:01 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm2666508ejd.155.2022.03.17.10.09.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 10:09:00 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r10so8283138wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:09:00 -0700 (PDT)
X-Received: by 2002:a5d:53c6:0:b0:203:ee27:12ff with SMTP id
 a6-20020a5d53c6000000b00203ee2712ffmr2577669wrw.422.1647536940103; Thu, 17
 Mar 2022 10:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.4.I37bdb77fdd06fb4143056366d7ec35b929528002@changeid>
In-Reply-To: <20220316172814.v1.4.I37bdb77fdd06fb4143056366d7ec35b929528002@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Mar 2022 10:08:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UiRSHgX-TAy5vsCJ0k6bLWJO9oOd4CVHJ+8vnM_5pMOw@mail.gmail.com>
Message-ID: <CAD=FV=UiRSHgX-TAy5vsCJ0k6bLWJO9oOd4CVHJ+8vnM_5pMOw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: qcom: sc7280: Add CRD rev5
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Mar 16, 2022 at 5:28 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add support for Qualcomm's SC7280 CRD rev5 (aka CRD 3.0/3.1).
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 313 ++++++++++++++++++
>  2 files changed, 314 insertions(+)

Since I already pre-reviewed this patch before it was posted, I have
no comments. ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
