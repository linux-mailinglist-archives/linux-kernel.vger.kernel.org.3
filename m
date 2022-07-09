Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF89456C7B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGIHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIHeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 03:34:06 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FC44E621
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 00:34:03 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id A4yToJjXqN260A4yTo5RSC; Sat, 09 Jul 2022 09:34:01 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 09 Jul 2022 09:34:01 +0200
X-ME-IP: 90.11.190.129
Message-ID: <e2eab942-f122-7e37-e3a3-c8a1e153c91b@wanadoo.fr>
Date:   Sat, 9 Jul 2022 09:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] ASoC: amd: fix for variable set but not used warning
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     amadeuszx.slawinski@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, zhuning@everest-semi.com,
        kernel test robot <lkp@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707132613.3150931-1-Vijendar.Mukunda@amd.com>
 <20220707132613.3150931-3-Vijendar.Mukunda@amd.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220707132613.3150931-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 07/07/2022 à 15:26, Vijendar Mukunda a écrit :
> Fix below kernel warning.
>>>> sound/soc/amd/acp-es8336.c:200:13: warning: variable 'ret' set but
>>>> not used [-Wunused-but-set-variable]
> 

Hi,
this patch, looks odd to me.


> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   sound/soc/amd/acp-es8336.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
> index 90f4e5809c72..e1479ae684e9 100644
> --- a/sound/soc/amd/acp-es8336.c
> +++ b/sound/soc/amd/acp-es8336.c
> @@ -206,6 +206,8 @@ static int st_es8336_late_probe(struct snd_soc_card *card)
>   		dev_err(card->dev, "can not find codec dev\n");

The next devm_acpi_dev_add_driver_gpios() will fail, should we return 
immediately?

>   
>   	ret = devm_acpi_dev_add_driver_gpios(codec_dev, acpi_es8336_gpios);
> +	if (ret)
> +		dev_warn(card->dev, "Failed to add driver gpios\n");

Should we return immediately?
>   
>   	gpio_pa = gpiod_get_optional(codec_dev, "pa-enable", GPIOD_OUT_LOW);
>   	if (IS_ERR(gpio_pa)) {
> @@ -213,6 +215,7 @@ static int st_es8336_late_probe(struct snd_soc_card *card)
>   				    "could not get pa-enable GPIO\n");
>   		gpiod_put(gpio_pa);
>   		put_device(codec_dev);
> +		return ret;

Here, we return 'ret' which is what is returned by 
devm_acpi_dev_add_driver_gpios(). So there doesn't seem to be a link 
with this block which checks for gpiod_get_optional() errors.

Moreover, returning an error for something that is optional 
(gpiod_get_optional()) looks strange.

Finally, should an error be returned, maybe PTR_ERR(gpio_pa) would be 
better here.


Just my 2c.

CJ

>   	}
>   	return 0;
>   }

