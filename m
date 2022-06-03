Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0453CC32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245440AbiFCPUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbiFCPUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC353506DA;
        Fri,  3 Jun 2022 08:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FC161889;
        Fri,  3 Jun 2022 15:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15397C385A9;
        Fri,  3 Jun 2022 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654269633;
        bh=JRwtXeAAKkEjKJCXj/qjul5ZdfRH3VbHm2x/qf+JZLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F1FGdibcZgL16P5fANhB0tQPDR7Z6NyWv5G3ifuh3zaeQUfKb3VFxrTDf/PPM+Hxi
         UJ5V6/yfQHsnTqe9W/CYoYQhrFoJsRXKGrD2S3TYaLeY++OaMYH8uZ4djdOtdPB3uq
         DBqEwMXlqWdkOOKicILUVr9oEhrwlUFnE3JbP+tmSuFgMEy1rkyOxdZ19CLTjDjRMR
         1nzbsVwDmbxx19cnCW77uWlo0zpzBNNcjJQfYKeQXdNymF2i6bM/4wDRiWh9JZbuaA
         3fjcMxeQYLcq1GhpcY6lShQhCbdOFAFjmuWwz1B26lv02vN+qfbGvYun05z0+eVPDQ
         Wv2W9NQ57ebTw==
Date:   Fri, 3 Jun 2022 16:29:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: adi-axi-adc: Fix refcount leak in
 adi_axi_adc_attach_client
Message-ID: <20220603162934.7e6b0783@jic23-huawei>
In-Reply-To: <20220524074517.45268-1-linmq006@gmail.com>
References: <20220524074517.45268-1-linmq006@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 11:45:17 +0400
Miaoqian Lin <linmq006@gmail.com> wrote:

> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Looks 'obviously correct to me' so applied to the fixes togreg branch of iio.git
and marked for stable.

Great if anyone more familiar with this driver than me has a chance
to take a quick look though.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/adi-axi-adc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index a73e3c2d212f..a9e655e69eaa 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -322,16 +322,19 @@ static struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
>  
>  		if (!try_module_get(cl->dev->driver->owner)) {
>  			mutex_unlock(&registered_clients_lock);
> +			of_node_put(cln);
>  			return ERR_PTR(-ENODEV);
>  		}
>  
>  		get_device(cl->dev);
>  		cl->info = info;
>  		mutex_unlock(&registered_clients_lock);
> +		of_node_put(cln);
>  		return cl;
>  	}
>  
>  	mutex_unlock(&registered_clients_lock);
> +	of_node_put(cln);
>  
>  	return ERR_PTR(-EPROBE_DEFER);
>  }

