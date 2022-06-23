Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41DF557636
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiFWJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFWJDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:03:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B31034;
        Thu, 23 Jun 2022 02:03:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s10so22453207ljh.12;
        Thu, 23 Jun 2022 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ozaotd6LY3ERvzpwuGvbQZTaC8kPny1azl5sB1Hldp8=;
        b=N+E4E6aBHykbEoIC0lGs7IRiK7feaBLf/CkLd78oSXziwtTtGtoy3tXA3mN4u+M1+H
         2lEeyKhEQm7uMBzKjVgfV32iv3ycYBLlXefCytlCiYeWvc1vlkkqeVdHyvQa/4I7awPw
         +yqS6OsEIt1tCt5xFxEtaCt0oLEVSvoZwtAwW4dIcdORniXK5c03omQkgHXW3VVUbG5+
         pCxDaxADdI5OOyGHM8VigOdxW8fFm9ClSBdiUkl8+LnNLmV81U1i7QDLpG5qCPGM/ib4
         ezVP1RIDjW8Fye2pDE0ph9F+Vj4aLCnvOMeonKSMKU9+nmoEZVsNcW8/ABtqbLZ0wEk1
         ujjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ozaotd6LY3ERvzpwuGvbQZTaC8kPny1azl5sB1Hldp8=;
        b=ST7gKjaVJZOeD90Q9EPyW/QaPZRPgHCYBzo+5KyYdKaIYc31SycMLjyzh48hBHYsDe
         QIYYJj8NK8MHtL7aswKOqapRG6eIZhvvblK7Yi0A9QarMy7OUQNtm7On8D5gju8wfDRq
         PlSvcFH9ZHkNvybprFPB1X4e6vbM7g0ygZDhpnSWjgK0+cE8Qd5Nk+lore75hCO6EawN
         X8dLXrBG33xPHZEF2zYVrm/Bfeo0mH+q64r6RiBq4ZXH2hRaj9UirZdGAu8eS9/wT1zb
         UOZjScmNlUxd8HODkLVwKdmuZkTfK+7z2iLlef+1kWurvba5R4I/mjH/dsiiC1yYXMjc
         Tmuw==
X-Gm-Message-State: AJIora9PZdFD7g29azr+qUAcUMhw5sb0VreDBvDSBY0c6iVRHT7BZmBB
        VgSTw5wiN+njt+1c5c51SFA=
X-Google-Smtp-Source: AGRyM1vF1zU4Gj87rqZsJvaSlU5/WAIf+VWD8fk9zG8OB0wQ+t7uncoazUPPDPmBI+qN6/ToK7aL7g==
X-Received: by 2002:a05:651c:1609:b0:25a:86a5:9eab with SMTP id f9-20020a05651c160900b0025a86a59eabmr4055972ljq.61.1655975028288;
        Thu, 23 Jun 2022 02:03:48 -0700 (PDT)
Received: from [172.16.189.61] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s16-20020a05651c201000b0025a73f7aa3bsm1153452ljo.96.2022.06.23.02.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 02:03:47 -0700 (PDT)
Message-ID: <415e6876-9304-9493-369e-d5eca0238bea@gmail.com>
Date:   Thu, 23 Jun 2022 12:03:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 02/49] regmap-irq: Fix offset/index mismatch in
 read_sub_irq_data()
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <20220620200644.1961936-3-aidanmacdonald.0x0@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220620200644.1961936-3-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 23:05, Aidan MacDonald wrote:
> We need to divide the sub-irq status register offset by register
> stride to get an index for the status buffer to avoid an out of
> bounds write when the register stride is greater than 1.
> 
> Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>   drivers/base/regmap/regmap-irq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index 4f785bc7981c..a6db605707b0 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -387,6 +387,7 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
>   		subreg = &chip->sub_reg_offsets[b];
>   		for (i = 0; i < subreg->num_regs; i++) {
>   			unsigned int offset = subreg->offset[i];
> +			unsigned int index = offset / map->reg_stride;
>   
>   			if (chip->not_fixed_stride)
>   				ret = regmap_read(map,
> @@ -395,7 +396,7 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
>   			else
>   				ret = regmap_read(map,
>   						chip->status_base + offset,
> -						&data->status_buf[offset]);
> +						&data->status_buf[index]);
>   
>   			if (ret)
>   				break;

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
