Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F05A7DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiHaMmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiHaMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:41:48 -0400
X-Greylist: delayed 506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 05:41:46 PDT
Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7388D3E79
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1661949200;
        bh=f7Ge6BqQzFFLnUBF1++YxLIJ1YH3OB0XRMTv5fP9cQc=;
        h=Date:Subject:To:From:From;
        b=K/crxDlTJz3YFxF6FIuw3JGVV3vC+U9Zbe1OvhOv5CHoSBijoQdVdl7TaLToBCs9p
         07/S1aeUmXD6D2K6n6fNMnku8/d9U1KGhsRX0tVSejJO/ldL5kRrGYz31xswBHh059
         RvEQgiawNT00NQ+bcpVwzwrV0dfQ7CLTqNsaJzGg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp11.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 36AE9400D4;
        Wed, 31 Aug 2022 08:33:19 -0400 (EDT)
Message-ID: <0a0e568e-e3fc-56da-8370-e4796b480fe3@mev.co.uk>
Date:   Wed, 31 Aug 2022 13:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] comedi: sysfs: convert sysfs snprintf to sysfs_emit
Content-Language: en-GB
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        zhangxuezhi1@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20220831121456.210835-1-zhangxuezhi3@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220831121456.210835-1-zhangxuezhi3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 0165e51f-50d6-4f1b-89cf-afbcf9ee0dca-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 13:14, Xuezhi Zhang wrote:
> From: zhangxuezhi1 <zhangxuezhi1@coolpad.com>
> 
> Fix up all sysfs show entries to use sysfs_emit
> 
> Signed-off-by: zhangxuezhi1 <zhangxuezhi1@coolpad.com>

The patch looks fine apart from the Signed-off-by line.  Please use a 
proper name for the Signed-off-by line.  Generally, a romanized version 
of the forename(s) (given name(s)) followed by the surname (family name) 
is preferred, for example: Xuezhi Zhang.

Could you please post a "PATCH v2" with a proper Signed-off-by line? 
Thanks.

> ---
>   drivers/comedi/comedi_fops.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 55a0cae04b8d..e2114bcf815a 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t max_read_buffer_kb_store(struct device *csdev,
> @@ -452,7 +452,7 @@ static ssize_t read_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t read_buffer_kb_store(struct device *csdev,
> @@ -509,7 +509,7 @@ static ssize_t max_write_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t max_write_buffer_kb_store(struct device *csdev,
> @@ -565,7 +565,7 @@ static ssize_t write_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t write_buffer_kb_store(struct device *csdev,

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
