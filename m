Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108BE520C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiEJDmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiEJDkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:40:40 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5EA220DD;
        Mon,  9 May 2022 20:36:22 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e5e433d66dso16894881fac.5;
        Mon, 09 May 2022 20:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O5Zna85Vq8b8w5dS9maW5sjIe37UVYxBLIqtZ95PN3Y=;
        b=dCuWjV5mbmgA3Q2CNvAf2Xy5gjFs/KqhYBFyu5gMWB+vkyjE845Hpn3fseCLSHcYhZ
         xahV8FsrJXqWzjmPbdX2TzotT5XGds5iKOM8iXLIaJxj2uf5PgwA9Wd3jrRWwp3WBmYu
         yUJZ2M5BHx3RobC+qvbBSpxx+QByD0kJL1CWpk0/0JzUXOIsiyRdYa2N68dLJagVIMnb
         eR1f0aG6bPJrxm502fEmwv8Mpu/qteu8i/0tZJaSGi+8ah3o9M+Mq+Fb2Da462YixTpU
         muTsViJ9Xaw8uAmDB4R2zBU6uz3I3c21Ah5iLlFUoXpdqbnUmeM28VTN1W6IEpzjRHrA
         s5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O5Zna85Vq8b8w5dS9maW5sjIe37UVYxBLIqtZ95PN3Y=;
        b=bQg/9Nj5d5212CEVK3lV5mAV8Zdg9IbFtLnXKDs6xXfDQ3FnxD+KNHykAkj0IpF5B9
         3KuyTv23Lq7My1wzxc2fJs1xWYDleD0IUAWTEheZ+zxmynBsgkJW41tiYEQSecEXxmNF
         3VmV4pvIR3kD6O0Fj8+v6HcoMUVhH29JUNF5FdpdSGitcqQUD6uAIIWeeZH3aBcX7QpH
         M7oiLYEg2AdnWbklKHQHPt6M7Dc7gjjFx2yg7a/pYZyL2NLhhIVTL1jpiEjQn2QU686V
         pph+djJAoXjnDFv/PIHYRln4AjO9a0uwFUuEuP+jxT6EYY5xdu1UyiSHoII4XSzcg2CL
         ZWXg==
X-Gm-Message-State: AOAM531d6EqzOhbZEuDIIEZz1O0r45oEa2FiCGjmDnYBn9ZhO2uc/p0r
        +tVCZcEbFs1nDTguv3w7tmw=
X-Google-Smtp-Source: ABdhPJwLuC+HUAjgP+D9wIF1ftz0XxqbsHdsTkk2ngkkLpSv1crtEWzsMvopu0qSPAu+5F3yStYq3A==
X-Received: by 2002:a05:6871:887:b0:ed:4b3b:2bc4 with SMTP id r7-20020a056871088700b000ed4b3b2bc4mr12066047oaq.278.1652153781845;
        Mon, 09 May 2022 20:36:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m33-20020a056870562100b000edf80be4ecsm4885091oao.58.2022.05.09.20.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 20:36:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <514da5d6-9044-181f-bdd1-84b5b9abd346@roeck-us.net>
Date:   Mon, 9 May 2022 20:36:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] usb: typec: tcpci_mt6360: Update for BMC PHY setting
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, bryan_huang@richtek.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1652147092-19255-1-git-send-email-u0084500@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1652147092-19255-1-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 18:44, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Update MT6360 BMC PHY Tx/Rx setting for the compatibility.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Hi,
> 
> Recently, there's some USBPD MT6360 IOP issue from the user.
>>From our RD's comment, BMC PHY Tx/Rx setting need to be updated for
> the compatibility issue.

I think this needs to be a bit more detailed. What compatibility issue ?
Compatibility with what ?

Thanks,
Guenter

> ---
>   drivers/usb/typec/tcpm/tcpci_mt6360.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> index f1bd9e0..8a952ea 100644
> --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> @@ -15,6 +15,9 @@
>   
>   #include "tcpci.h"
>   
> +#define MT6360_REG_PHYCTRL1	0x80
> +#define MT6360_REG_PHYCTRL3	0x82
> +#define MT6360_REG_PHYCTRL7	0x86
>   #define MT6360_REG_VCONNCTRL1	0x8C
>   #define MT6360_REG_MODECTRL2	0x8F
>   #define MT6360_REG_SWRESET	0xA0
> @@ -22,6 +25,8 @@
>   #define MT6360_REG_DRPCTRL1	0xA2
>   #define MT6360_REG_DRPCTRL2	0xA3
>   #define MT6360_REG_I2CTORST	0xBF
> +#define MT6360_REG_PHYCTRL11	0xCA
> +#define MT6360_REG_RXCTRL1	0xCE
>   #define MT6360_REG_RXCTRL2	0xCF
>   #define MT6360_REG_CTDCTRL2	0xEC
>   
> @@ -106,6 +111,27 @@ static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>   	if (ret)
>   		return ret;
>   
> +	/* BMC PHY */
> +	ret = mt6360_tcpc_write16(regmap, MT6360_REG_PHYCTRL1, 0x3A70);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, MT6360_REG_PHYCTRL3,  0x82);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, MT6360_REG_PHYCTRL7, 0x36);
> +	if (ret)
> +		return ret;
> +
> +	ret = mt6360_tcpc_write16(regmap, MT6360_REG_PHYCTRL11, 0x3C60);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, MT6360_REG_RXCTRL1, 0xE8);
> +	if (ret)
> +		return ret;
> +
>   	/* Set shipping mode off, AUTOIDLE on */
>   	return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
>   }

