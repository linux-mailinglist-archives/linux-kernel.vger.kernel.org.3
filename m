Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7958705C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiHAS0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiHAS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:26:16 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69304E0CC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:26:14 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Ia7Do2ZzH9qatIa7Docuu3; Mon, 01 Aug 2022 20:26:12 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 01 Aug 2022 20:26:12 +0200
X-ME-IP: 90.11.190.129
Message-ID: <dac8e781-5c2b-4ba1-34a7-d902ba060b29@wanadoo.fr>
Date:   Mon, 1 Aug 2022 20:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: rawnand: denali: Fix a possible resource leak in
 denali_pci_probe
Content-Language: en-US
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
References: <20220801080315.1713934-1-gongruiqi1@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220801080315.1713934-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/08/2022 à 10:03, GONG, Ruiqi a écrit :
> Call pci_release_regions() to retrieve the allocated resource when
> devm_ioremap() or denali_init() failed.
> 

Hi,
this is not correct.

First, should you be right, you should also update the .remove() 
function the same way.

Second, at the beginning there is pcim_enable_device() call.
This looked like magic to me when I first saw it, but this function 
makes some pci_ functions work just as it they were pcim_ functions.

See pcim_enable_device() ([1]), at line 2132.
When pcim_release() ([2]) is called by the framework, then regions are 
released at line 2079

CJ

[1]: https://elixir.bootlin.com/linux/v5.19/source/drivers/pci/pci.c#L2118
[2]: https://elixir.bootlin.com/linux/v5.19/source/drivers/pci/pci.c#L2071

> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>   drivers/mtd/nand/raw/denali_pci.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
> index de7e722d3826..40943cda0914 100644
> --- a/drivers/mtd/nand/raw/denali_pci.c
> +++ b/drivers/mtd/nand/raw/denali_pci.c
> @@ -74,21 +74,22 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   		return ret;
>   	}
>   
> +	ret = -ENOMEM;
>   	denali->reg = devm_ioremap(denali->dev, csr_base, csr_len);
>   	if (!denali->reg) {
>   		dev_err(&dev->dev, "Spectra: Unable to remap memory region\n");
> -		return -ENOMEM;
> +		goto out_release_pci;
>   	}
>   
>   	denali->host = devm_ioremap(denali->dev, mem_base, mem_len);
>   	if (!denali->host) {
>   		dev_err(&dev->dev, "Spectra: ioremap failed!");
> -		return -ENOMEM;
> +		goto out_release_pci;
>   	}
>   
>   	ret = denali_init(denali);
>   	if (ret)
> -		return ret;
> +		goto out_release_pci;
>   
>   	nsels = denali->nbanks;
>   
> @@ -116,6 +117,8 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   
>   out_remove_denali:
>   	denali_remove(denali);
> +out_release_pci:
> +	pci_release_regions(dev);
>   	return ret;
>   }
>   

