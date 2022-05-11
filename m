Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ACE523213
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiEKLqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiEKLqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:46:43 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4103CFD0;
        Wed, 11 May 2022 04:46:41 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8B33420CD7A4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
To:     Miaoqian Lin <linmq006@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        "David Daney" <david.daney@cavium.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220511062723.56652-1-linmq006@gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6af08961-0fd9-513f-cb13-0e77529728f2@omp.ru>
Date:   Wed, 11 May 2022 14:46:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220511062723.56652-1-linmq006@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/11/22 9:27 AM, Miaoqian Lin wrote:

> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() in error path to avoid refcount
> leak.
> 
> Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/ata/pata_octeon_cf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 6b5ed3046b44..65688459acf1 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -857,12 +857,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
>  				if (!res_dma) {
>  					of_node_put(dma_node);
> +					put_device(&dma_dev->dev);
>  					return -EINVAL;
>  				}
>  				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
>  									 resource_size(res_dma));
>  				if (!cf_port->dma_base) {
>  					of_node_put(dma_node);
> +					put_device(&dma_dev->dev);
>  					return -EINVAL;
>  				}
>  

   It seems you forgot to call put_device() at the end of the enclosing *if*, where of_node_put()
is also called...

MBR, Sergey
