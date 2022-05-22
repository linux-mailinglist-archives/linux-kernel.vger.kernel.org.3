Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053D85304C0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbiEVQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiEVQqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:46:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98342C3F;
        Sun, 22 May 2022 09:45:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso627337otp.8;
        Sun, 22 May 2022 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A3MW2E4hPy/aQENWXOJ2JWZ+xI8KBMasjdB1XQlQXhk=;
        b=fKUUM7yY2M3lYi3DacllA37dpumIb+5hsm4dGf862dt912aTwJh8O+JEDrr8XE4/Ao
         /O+xEx8SUbw2Z+V0qTdJmLn/1+t41l7ol0S7LAxefEQMBwC1XJhqQOtfCtIB73JgXOR3
         OvjT1vbQbn93hcd2cAQdnZVGk8QLX4BxAh2XE/2kB3vu5Gun01Sq2aL6hCWl19gFDqS+
         lXWmOGGP8f4NAEyrFbYAffWuz9qh/9lkvljoE2Tk7ZAPBhSnGZIGz36rtY1x1R/nCoRr
         KMy1HxbOp1tN4zmy2vN1V9LnSn1Tz1sizrk7jMXsGuDrFlZBLzLp+P6BMJ3xlz9i09Q4
         zZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A3MW2E4hPy/aQENWXOJ2JWZ+xI8KBMasjdB1XQlQXhk=;
        b=PsV6Dl6fWHWkcpYhMc6q8FdySKWwq3RV9w6/8IK0SIX6uI7v/20RQf6atR3OjfVy3k
         xBnlmcmUr/aFHAEbYDAYHBY61G8VQ2ErPneOP1QsK6UQUbpQlraOHApvgy1tP6Zy8a4S
         4CizkQODhv6OSnvOF8sKvSr0C0zG8Nj3Yt7eOesyLPOhqkpHXeW8xT4RlEp/Af9LpDGa
         2KmxknrNRAaeu8bqYj9e0FiEMJufvn/VuB0bnCO0UkHQgmb6AXfcpvcWW7cPVL/vW5iV
         SypR7jHGfCZs+4Xr5kL1/sv86EoDXXshPI5w85RbS+xvGVRPlhsomkwQC8P4c6ubJM+R
         tVzw==
X-Gm-Message-State: AOAM533MBEXeGN/fuLr9rOi77m2dBqixXL2YOjsifoIKRBslam3JP245
        JU6DvbDkmtPiOVg0Hu3UiPc=
X-Google-Smtp-Source: ABdhPJwF7V+fwRvOwZOSp3lwb6vsxQ0qSZ6aw4g7kZDyU1NwNpYq17KF/k0k72MH8MxbQ3y6RscDVw==
X-Received: by 2002:a05:6830:124e:b0:60a:fff3:c05b with SMTP id s14-20020a056830124e00b0060afff3c05bmr2616441otp.264.1653237955725;
        Sun, 22 May 2022 09:45:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12-20020a4a390c000000b0035eb4e5a6cbsm3423043ooa.33.2022.05.22.09.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 09:45:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6d691a7d-7601-a077-fc8e-67e0c4917615@roeck-us.net>
Date:   Sun, 22 May 2022 09:45:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 06/19] watchdog: npcm_wdt: Add NPCM845 watchdog support
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-7-tmaimon77@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220522155046.260146-7-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 08:50, Tomer Maimon wrote:
> Add Nuvoton BMC NPCM845 watchdog support.
> The NPCM845 uses the same watchdog as the NPCM750.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>   drivers/watchdog/npcm_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 28a24caa2627..0b91a3fbec09 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -231,6 +231,7 @@ static int npcm_wdt_probe(struct platform_device *pdev)
>   static const struct of_device_id npcm_wdt_match[] = {
>   	{.compatible = "nuvoton,wpcm450-wdt"},
>   	{.compatible = "nuvoton,npcm750-wdt"},
> +	{.compatible = "nuvoton,npcm845-wdt"},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, npcm_wdt_match);

Acked-by: Guenter Roeck <linux@roeck-us.net>
