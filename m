Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8035A4335
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiH2G0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH2G0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:26:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FDC1F605
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:26:04 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oSYDh-0002hT-9s; Mon, 29 Aug 2022 08:26:01 +0200
Message-ID: <1200fe58-72de-5372-a0f0-2ac93b6aeccc@pengutronix.de>
Date:   Mon, 29 Aug 2022 08:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] nvmem: u-boot-env: fix crc32 casting type
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Tom Rini <trini@konsulko.com>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel test robot <lkp@intel.com>
References: <20220818043837.28698-1-zajec5@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220818043837.28698-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafał,

On 18.08.22 06:38, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This fixes:
> drivers/nvmem/u-boot-env.c:141:17: sparse: sparse: cast to restricted __le32
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment variables")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/nvmem/u-boot-env.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index 9b9abfb8f187..fb993ef4249f 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -138,7 +138,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>  		data_offset = offsetof(struct u_boot_env_image_redundant, data);
>  		break;
>  	}
> -	crc32 = le32_to_cpu(*(uint32_t *)(buf + crc32_offset));
> +	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));

I had to do a double take to make sure alignment is not violated.
It's not, because crc32_offset is always zero.

How about rewriting this as

  /* CRC32 is always at offset 0 */
  crc32 = le32_to_cpup(buf);

To make the alignment clear to the reader?

>  	crc32_data_len = priv->mtd->size - crc32_data_offset;
>  	data_len = priv->mtd->size - data_offset;
>  

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
