Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC4561752
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiF3KJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiF3KJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:09:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA641273;
        Thu, 30 Jun 2022 03:09:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q9so26520468wrd.8;
        Thu, 30 Jun 2022 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aEi52rAKRZGKuKlHNzJFi9trcKiCjqJ5mBhWrvY9RWU=;
        b=QOYuiKTo/xpDNF6RQC0OLHZ7XjOmumfqnu32brFBuO91B4NyETFc0Eb9gABmnPngTe
         JH+sgookHLXrrEZKrKaesZXRAcYnNySeby0ml6OasS8i1zjH8coF0u6uqQOizr3IYrQs
         Pz54+FIRsup3ZyLbtZdmZIN/YNqVIbvVB2c3h3QLPCadQgBt/Hh7rUi7vQm5jd3G8HJj
         4czLIE0lhhzOUT+YQ7TGNJnL3N5hs6o8DR41OeI+ed2VndZJYu3ruSTadTqESO0iPSW4
         9rmrnqhp4/nq4QWlP1kmq7As03PlmD4mEI30Iiwey9jtNBZ17oGCIT34QmBf/bB4YW7k
         R3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEi52rAKRZGKuKlHNzJFi9trcKiCjqJ5mBhWrvY9RWU=;
        b=BFA3kJkyEVdBxlxJPk1kA/qOR8AJ5o63GLZiWPp/hn7sBW5dD8c19EdIR3UTmo6KRT
         jVTCkKi0NOyVGs4joxmkurwafZK/XHfk8fCgnp2iYjf60ISsQ6mqpKH+xJ08Z3L97z/R
         ZRxkoUYkBUk6i/NBMNwwBBGYHltC6DaPSJF7/H9zR8iewclmB8mZkg8E4GxJIseBdnnm
         kBor2qQvfDw9djbgNYt+/LIzQkfxsxoyRe+xQhlzrOOMZJWf9orUTHjQXYs/PAU5MIhC
         BYLSQouJh3X+RQYsCPFlF/QeZkJw21vkgDidYoiZRnkq913kVwKxqg5z6rUBZXvUm0Nw
         k4Uw==
X-Gm-Message-State: AJIora+CG5vUH/EbMJFPIp2bbY8VPJIl0+qmXplPkqvNXzxfcSAVXECl
        RnqE2PLsIagFrwkZF7ADgmc=
X-Google-Smtp-Source: AGRyM1tkxQQhFI/4L94pxAE+TTmDdAsP4keILlyzIgMtnausNzfjeQm2k3gFl/OcWtdzjC7LJTlxLg==
X-Received: by 2002:a5d:526b:0:b0:21a:3c94:cf36 with SMTP id l11-20020a5d526b000000b0021a3c94cf36mr7299419wrc.535.1656583790131;
        Thu, 30 Jun 2022 03:09:50 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003a04b0bcb43sm5959334wmi.40.2022.06.30.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:09:49 -0700 (PDT)
Message-ID: <7bc81026-957e-caf9-c04b-7ad3b9b5d367@gmail.com>
Date:   Thu, 30 Jun 2022 11:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/6] media: ov5693: count num_supplies using array_size
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-2-tommaso.merciai@amarulasolutions.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <20220630074525.481790-2-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello - sorry, hadn't had much time to look  at this series.

On 30/06/2022 08:45, Tommaso Merciai wrote:
> Instead of hardcode OV5693_NUM_SUPPLIES in a define is better use
> ARRAY_SIZE function to count the number of supplies from
> ov5693_supply_names array
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>


Reviewed-by: Daniel Scally <djrscally@gmail.com>

> ---
> Changes since v3:
>  - Add reviewed-by tag, suggested by Jacopo, Krzysztof
>
>  drivers/media/i2c/ov5693.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index 117ff5403312..f410333c4c67 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -127,11 +127,15 @@
>  #define OV5693_LINK_FREQ_419_2MHZ		419200000
>  #define OV5693_PIXEL_RATE			167680000
>  
> -/* Miscellaneous */
> -#define OV5693_NUM_SUPPLIES			2
> -
>  #define to_ov5693_sensor(x) container_of(x, struct ov5693_device, sd)
>  
> +static const char * const ov5693_supply_names[] = {
> +	"avdd",		/* Analog power */
> +	"dovdd",	/* Digital I/O power */
> +};
> +
> +#define OV5693_NUM_SUPPLIES	ARRAY_SIZE(ov5693_supply_names)
> +
>  struct ov5693_reg {
>  	u32 reg;
>  	u8 val;
> @@ -352,11 +356,6 @@ static const s64 link_freq_menu_items[] = {
>  	OV5693_LINK_FREQ_419_2MHZ
>  };
>  
> -static const char * const ov5693_supply_names[] = {
> -	"avdd",
> -	"dovdd",
> -};
> -
>  static const char * const ov5693_test_pattern_menu[] = {
>  	"Disabled",
>  	"Random Data",
