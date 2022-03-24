Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E94E5CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiCXBht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiCXBhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:37:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E9392D26
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648085772; x=1679621772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gsAck33gFP7RxtLhhR89Z8++2bilhvSOMcQfDm+nq8c=;
  b=dLRqcfJ/ESUXXCJ1mdjDeGFlPmyQmfZcx64CRmPCAK6MqME/DAdXkhI6
   av1sjFJmKPlKeIPMIAZx8cm4aD66AKasdZOdAXwioM1pAGogSS59y2GaX
   WPEEYIh9fCLTVaXXZt0BASGmnFnRfGsNbfYE+wj3kLDTXA/VBqb2+fe/E
   xYhOnCVAoQTSksmZQMzjV5sNUV+x2bdCC3yOvktSmUzlglD80eEttAEZl
   LpIaLJ2tejsJsC6K0Tin34B7pFp/yEGObAbUo0dh3aGW5eKrOrkIuKHJV
   RJmI9CPRmXcvc/RsLp4dDJDmtYeckx8oOqU2WLi9OapAixOYvaeLZe1rh
   g==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="195019574"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 09:36:08 +0800
IronPort-SDR: AbmD+NIGJ9PggOa3+Y23j7q+mQ8+M/PnaL7b8R5OcKDiyE/tMKNHRynA1I9GLFiUzwLoIqmCVK
 SdrIpJ5rURL2NRM0VBAi7k0IYwCLpBB0yCNyAvPUjPPwfHmP09WOHfMqRiRkH8yO1imQwXCZ0h
 eK6NJWYt9RUiIjipvdmokop2L01+7A9pIsRKIQ93KUSh5vnuOIDFWK0ct+5qwcEy1vasBkQmtp
 prlYKrJLevF0Fsg/5TA3sgiWRkKDNKINcmCAKMK3zrtTc1+ePK2rNMOkoFcAVZa8asbpKp+mOi
 fXC152Z6kb9NT1tp4XLWG09A
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:07:05 -0700
IronPort-SDR: ZzySKjSLnTrVhy7Xx6Z2DmxND2svWcSzSBr2o3f6a1Btw+GBoHrttq7ATxZJowrWjXY0Su6gv9
 UBYKQxPP/4Y7JEhV7s7WbaimAtmQydDvk+pUe5oSnY7R2sfl38D9NlN+vhjtdCyxEsypagyArN
 ZDM88199yqnAT4v0SP1AXk3QcttMf9V2WAOriZRHaKggLyZHyy+W4fno13y36oJ0QtN5yLH9Yn
 6+AYxiCGbVphkvA0ZduLKLQ8srX1MaUnkZdYp8Likoy9SPr73FgO8iN3qObBLUlW02v4U6Cy5o
 1+0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:36:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP79420ZBz1SVp3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:36:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648085767; x=1650677768; bh=gsAck33gFP7RxtLhhR89Z8++2bilhvSOMcQ
        fDm+nq8c=; b=k1Rwmz/bIjpWeV8Jh9O+EbBMvmLx9z7xfmIXdZERzPVelBEkNcu
        suPyirWqQUEQCdXl1NZc7HD1Eq+ByEt4xdFv12VJEfRbaSQ/sZnUK7YTWf9HbZOs
        /jf7VwHNqAI31TRUOfa2aivNHcnh6BKKiVGrB85Vs58zeinbV1s3P0fSz3UBcuSj
        b2NutWJjlUr5XdEoC3k8r1jpi4bhwDu3oz9T+kSKRQzV1MNJV3v73MyIJ0IQSqkM
        9Pf1dRiu656y/WTLviLM9AfrqZT1hVNpeBtJaNaWYcpFpqoHXBuGVtUAp7tVRLpp
        AGWVWHTRES83kA/3APp8w3RlRN9LVCjLWJw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JkfarEMN03Wm for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 18:36:07 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP7916Yjlz1Rvlx;
        Wed, 23 Mar 2022 18:36:05 -0700 (PDT)
Message-ID: <b2a8b347-8029-9df3-edcd-a526ba3eef82@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 10:36:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 06/21] ata: libahci_platform: Add function returning a
 clock-handle by id
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-7-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-7-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Since all the clocks are retrieved by the method
> ahci_platform_get_resources() there is no need for the glue-drivers to be
> looking for some particular of them in the kernel clocks table again.
> Instead we suggest to add a simple method returning a device-specific
> clock with passed connection ID if it is managed to be found. Otherwise
> the function will return NULL. Thus the glue-drivers won't need to either

"glue-drivers" is really unclear. What do you mean ?

> manually touching the hpriv->clks array or calling clk_get()-friends. The
> AHCI platform drivers will be able to use the new function right after the
> ahci_platform_get_resources() method invocation and up to the device
> removal.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
>  include/linux/ahci_platform.h  |  3 +++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index d805ddc3a024..4fb9629c03ab 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
>  
> +/**
> + * ahci_platform_find_clk - Find platform clock
> + * @hpriv: host private area to store config values
> + * @con_id: clock connection ID
> + *
> + * This function returns point to the clock descriptor of the clock with
> + * passed ID.
> + *
> + * RETURNS:
> + * Pointer to the clock descriptor on success otherwise NULL
> + */
> +struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
> +{
> +	struct clk *clk = NULL;
> +	int i;
> +
> +	for (i = 0; i < hpriv->n_clks; i++) {
> +		if (!strcmp(hpriv->clks[i].id, con_id)) {
> +			clk = hpriv->clks[i].clk;
> +			break;
> +		}
> +	}
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> +
>  /**
>   * ahci_platform_enable_clks - Enable platform clocks
>   * @hpriv: host private area to store config values
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 49e5383d4222..fd964e6a68d6 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/compiler.h>
>  
> +struct clk;
>  struct device;
>  struct ata_port_info;
>  struct ahci_host_priv;
> @@ -21,6 +22,8 @@ struct scsi_host_template;
>  
>  int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
> +struct clk *
> +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);

No users for this function ?

>  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>  int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);


-- 
Damien Le Moal
Western Digital Research
