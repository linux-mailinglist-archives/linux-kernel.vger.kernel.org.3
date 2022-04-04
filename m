Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB594F1897
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378622AbiDDPkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378617AbiDDPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:40:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD85F59
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:38:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so17341765ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtedD6FM09IE5LoSxarN6jcAT2s5M/K/DaVAu90VEgY=;
        b=TgjWxw2Tu2SNr1XQhx6UNYoyLIPR7tEDNZMnMuejypmnlzQS0brHnvULAnzuYnuKdk
         SUcnC2kLH/U+5QdXxknWTEMfSMTrTE+8iFovtpKTFyMqAposqZoFoyoStZ112CbIO8aT
         OJC7nQk0t5jXiwAiqELcaMygw1cSF5nP5vPX8EdX1zK7P7wIZ7DA+j3Uf+oGsvykFr8A
         +eYgBJHPYAnih7TwzjK/jlyE0XgHdPvA+8KbSRO/0dXFG1tcNodnjL49zy6fsWdFL5tL
         l+zEv+P7E+ZQiUCb2LKK38cVVLz3RIMnvI5s1gdA6R7zTK10DdJfVgoGh8L7zOvEwOk3
         N7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtedD6FM09IE5LoSxarN6jcAT2s5M/K/DaVAu90VEgY=;
        b=53LLuynxoU1xJ6MWDQ0zJ6TnkA46gole5Im514xpOr9lU/LtpAWgVbQFWOj2Sz+hj0
         p1KEwrV21dmIaMN+b/ATpsq+biGJtI3TdhIbWNpgwEDFKsY5kBQzMKRBqJjTfS8qUWK7
         HQZKwMFLb+pE8sORwSV2QBOdXIAisBYE6gMOBxFQB5KMa8ZxCB1uFBdNeJwddQWGEzD1
         nQKDqxwvraBSW5JmOp7ZFXAZI9+eAZQ9xkXD/dGcIO+g+7Ygyz/K4US51/aV93gdebDI
         RQ0G1yQOA+QlHNU8iZWYpKRE7tsHhVcls+gmaHjqif/CFpKb3L/4Ke+FWTu7X34e/Mqs
         Ba2A==
X-Gm-Message-State: AOAM533/5UY04mnYQa/YqkFUyuXCJOdZd7qLJ6dXxvG/EH61PdM0jbLy
        EbTWcBWpeGuYLkXdY519KMg0su9IO6t3boSFSAlyGA==
X-Google-Smtp-Source: ABdhPJxjxfAWOjP0Rg4CpsTHWBMkYr4sFaAA4HVxbRip7CKBJKVdsKQZcRxwN7VR09drWMM/O/TxBzQ5ja7Lg5ChdEs=
X-Received: by 2002:a17:907:9506:b0:6da:b4cd:515b with SMTP id
 ew6-20020a170907950600b006dab4cd515bmr676585ejc.602.1649086713585; Mon, 04
 Apr 2022 08:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220404090047.581523-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220404090047.581523-1-arnaud.pouliquen@foss.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 4 Apr 2022 09:38:22 -0600
Message-ID: <CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com>
Subject: Re: [PATCH] arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

On Mon, 4 Apr 2022 at 03:01, Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> In the patch 617d32938d1b: "rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl", we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
>
> Fixes: 617d32938d1b ("rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl", 2022-01-24)

A date should not appear in a Fixes tag - please remove.  I would also
remove the entire tag since there was nothing wrong with commit
617d32938d1b.  Re-organising and splitting things up is part of normal
kernel development, and that process often implies modifications to
the kernel config files.

Same comment for the other 2 patches.

Thanks,
Mathieu


> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
>
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> ---
>  arch/arm/configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index 9981566f2096..2e7e9a4f31f6 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -241,6 +241,7 @@ CONFIG_QCOM_Q6V5_PAS=y
>  CONFIG_QCOM_Q6V5_PIL=y
>  CONFIG_QCOM_WCNSS_PIL=y
>  CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_QCOM_GLINK_SMEM=y
>  CONFIG_RPMSG_QCOM_SMD=y
>  CONFIG_QCOM_COMMAND_DB=y
> --
> 2.25.1
>
