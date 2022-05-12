Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2172524CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353833AbiELMfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353828AbiELMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:34:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064176F484
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:34:56 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9658F2223A;
        Thu, 12 May 2022 14:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652358895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGSqzt2IwevyC1nZjVg1zbzsKwHqQFbjkeSfynQ0Mno=;
        b=IGtFsl6AnRFEwP6qV9E5VAF/zvs8akRinmrkYsNvL1wrySsQ3LNjmmBdXgaxjmvXDlduGH
        +ecsCEx+Bd+LSK0yvafNlFzKm68iWmHy85hNOTydiy8zpn9sjeJdC4n2nyg0fCW+ZRQo3w
        lgTz9ank2l4AzIlgeQfk8JOO67vKwD0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 May 2022 14:34:54 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix format specifier
In-Reply-To: <20220512123213.fzly4gollonlo27p@ti.com>
References: <20220512112027.3771734-1-michael@walle.cc>
 <20220512123213.fzly4gollonlo27p@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ea3a10d91129e4948eabc4bed8cf22fe@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-05-12 14:32, schrieb Pratyush Yadav:
> Hi Michael,
> 
> On 12/05/22 01:20PM, Michael Walle wrote:
>> The intention was to print the JEDEC ID in the following format:
>>   nn nn nn
>> 
>> In this case format specifier has to be "%*ph". Fix it.
>> 
>> Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via 
>> debugfs")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/debugfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/debugfs.c 
>> b/drivers/mtd/spi-nor/debugfs.c
>> index bf9fda5d4d0b..4b972bd4b80d 100644
>> --- a/drivers/mtd/spi-nor/debugfs.c
>> +++ b/drivers/mtd/spi-nor/debugfs.c
>> @@ -81,7 +81,7 @@ static int spi_nor_params_show(struct seq_file *s, 
>> void *data)
>>  	int i;
>> 
>>  	seq_printf(s, "name\t\t%s\n", info->name);
>> -	seq_printf(s, "id\t\t%*phn\n", SPI_NOR_MAX_ID_LEN, nor->id);
>> +	seq_printf(s, "id\t\t%*ph\n", SPI_NOR_MAX_ID_LEN, nor->id);
> 
> Patch does not apply. Are you basing this on some other commits you
> have? This line is different on my tree:
> 
> 	seq_printf(s, "id\t\t%*phn\n", info->id_len, info->id);
> 
> In fact, I do not have a nor->id at all in my tree. BTW, I have applied
> https://lore.kernel.org/r/20220429102018.2361038-2-michael@walle.cc
> 
> I am going to apply the below patch. Please ACK/NACK. I did a quick
> test, the output stays the same before and after this patch.
> 
> -- 8< --
> From c47452194641b5d27c20e557c84a46c85fd7ce37 Mon Sep 17 00:00:00 2001
> From: Michael Walle <michael@walle.cc>
> Date: Thu, 12 May 2022 13:20:27 +0200
> Subject: [PATCH] mtd: spi-nor: debugfs: fix format specifier
> 
> The intention was to print the JEDEC ID in the following format:
>   nn nn nn
> 
> In this case format specifier has to be "%*ph". Fix it.
> 
> Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via 
> debugfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Link: 
> https://lore.kernel.org/r/20220512112027.3771734-1-michael@walle.cc
> ---
>  drivers/mtd/spi-nor/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/debugfs.c 
> b/drivers/mtd/spi-nor/debugfs.c
> index 1949905eefea..eaf84f7a0676 100644
> --- a/drivers/mtd/spi-nor/debugfs.c
> +++ b/drivers/mtd/spi-nor/debugfs.c
> @@ -81,7 +81,7 @@ static int spi_nor_params_show(struct seq_file *s, 
> void *data)
>  	int i;
> 
>  	seq_printf(s, "name\t\t%s\n", info->name);
> -	seq_printf(s, "id\t\t%*phn\n", info->id_len, info->id);
> +	seq_printf(s, "id\t\t%*ph\n", info->id_len, info->id);
>  	string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
>  	seq_printf(s, "size\t\t%s\n", buf);
>  	seq_printf(s, "write size\t%u\n", params->writesize);

Ack. Thanks. My bad, there are some missing changes, which I didn't
sent yet.

-michael
