Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397258C24E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiHHERD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiHHERA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:17:00 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA35F1183F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 21:16:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10e615a36b0so9361794fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 21:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=A1wQCN+G4M0V+6iscdY6rHphe27jvr6cvhQav4ATh4g=;
        b=nhupKK7xasVVbtSVOhRdLJMsQ2LhjS6UtriAqRLXljpCMaLNKxLm8NpX8xPevInbmD
         pVdMC1GqDlyaeV+VNvIjq8fboL0jdOEXkuvsXe/dScrW0lXzKTmzAH4VvmY2aIqrXYan
         k+SuhI0S40GulBJFJ0jXzvSF8exODF8W2CtwxQ9dKlh8eHcGusyvLkMPWL93/FDVGgCx
         KLEyw495xIr+KXgNqwYELDTbcjnCtcS3TgK1QXOmKPCzuC5dbOe37s2oiTFT/M8Aq9xV
         j86eDiPl/1Dcq/JywF+/1xi3tojqYD2jCixmVnut0e8UyRWD7wVO6eb/WjNnkyLQoVOC
         kaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=A1wQCN+G4M0V+6iscdY6rHphe27jvr6cvhQav4ATh4g=;
        b=VXmxHs6nTyHaixulcEhBKTPNzzDrIhCG6feIwA0Ee1LFwopQIeVlX/JmU+4aihMc5A
         2dZZOJ9hxtiUZxicnkikDBsQRqVOI+SZp0+b5pjltMw+6P67kuSSSek99nSuiXAtVn8n
         sOZ5Q3ryj23nEygW8Y5OtHbpPYuJ18BPAHJkKyGLLRFipRtJ5ItyRlgOW3xsQd7Zm0ef
         gWEnwR8NMYgJglZFvfUHismx9bx4sHXQFOO4nLYWdovhycJMnWI4moVuSGY2mkzwUeID
         xplPLyuvMZ+G+aMyryGvRzj8gHBNfXvNWkdhiZAqDG6I30G0Eq5JiV9Nd4K5lXQkghzC
         VqMQ==
X-Gm-Message-State: ACgBeo1ULInwR/nKNaDS+G5I6hwpR5nWAAddMAeeyGmKRZW4gp3VsIQ/
        /rqGQgKJ7PuIaHkTO6eFfZURvg==
X-Google-Smtp-Source: AA6agR75dIdMIrCZ6M5BWdLYUfC/wGKyZq7QqmGYD5iCbAbL/Os4tkFoP8YSIGPlOY0u2bfkmwMNJw==
X-Received: by 2002:a05:6870:a689:b0:10c:289b:78df with SMTP id i9-20020a056870a68900b0010c289b78dfmr7905740oam.25.1659932217063;
        Sun, 07 Aug 2022 21:16:57 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u11-20020a9d4d8b000000b00636d76b607bsm849528otk.30.2022.08.07.21.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 21:16:56 -0700 (PDT)
Date:   Sun, 7 Aug 2022 21:19:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Molly Sophia <mollysophia379@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: qcom: sc8180x: Fix gpio_wakeirq_map
Message-ID: <YvCO2SfpXtTfawW5@ripper>
References: <20220807122645.13830-1-mollysophia379@gmail.com>
 <20220807122645.13830-2-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807122645.13830-2-mollysophia379@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 07 Aug 05:26 PDT 2022, Molly Sophia wrote:

> Currently in the wakeirq_map, gpio36 and gpio37 have the same wakeirq
> number, resulting in gpio37 being unable to trigger interrupts.
> It looks like that this is a typo in the wakeirq map. So fix it.
> 

Thank you for finding this, I've been scratching my head about the
i2c-hid interrupts on this gpio for a while now. This indeed looks like
a typo, and the documentation confirms that 44 is the correct PDC irq
line.

> Signed-off-by: Molly Sophia <mollysophia379@gmail.com>

Fixes: 97423113ec4b ("pinctrl: qcom: Add sc8180x TLMM driver")
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-sc8180x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc8180x.c b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> index 6bec7f143134..b4bf009fe23e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> @@ -1582,7 +1582,7 @@ static const int sc8180x_acpi_reserved_gpios[] = {
>  static const struct msm_gpio_wakeirq_map sc8180x_pdc_map[] = {
>  	{ 3, 31 }, { 5, 32 }, { 8, 33 }, { 9, 34 }, { 10, 100 }, { 12, 104 },
>  	{ 24, 37 }, { 26, 38 }, { 27, 41 }, { 28, 42 }, { 30, 39 }, { 36, 43 },
> -	{ 37, 43 }, { 38, 45 }, { 39, 118 }, { 39, 125 }, { 41, 47 },
> +	{ 37, 44 }, { 38, 45 }, { 39, 118 }, { 39, 125 }, { 41, 47 },
>  	{ 42, 48 }, { 46, 50 }, { 47, 49 }, { 48, 51 }, { 49, 53 }, { 50, 52 },
>  	{ 51, 116 }, { 51, 123 }, { 53, 54 }, { 54, 55 }, { 55, 56 },
>  	{ 56, 57 }, { 58, 58 }, { 60, 60 }, { 68, 62 }, { 70, 63 }, { 76, 86 },
> -- 
> 2.25.1
> 
