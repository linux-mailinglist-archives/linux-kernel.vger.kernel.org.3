Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5251E592
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383677AbiEGI3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383686AbiEGI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:29:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8881EF
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:25:29 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KwL7m0MYszfbPL;
        Sat,  7 May 2022 16:24:20 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 16:25:26 +0800
Message-ID: <62762CF6.3010004@hisilicon.com>
Date:   Sat, 7 May 2022 16:25:26 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Peng Wu <wupeng58@huawei.com>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <wangxiongfeng2@huawei.com>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH] ARM: hisi: Add missing of_node_put after of_find_compatible_node
References: <20220428104306.21682-1-wupeng58@huawei.com>
In-Reply-To: <20220428104306.21682-1-wupeng58@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 2022/4/28 18:43, Peng Wu wrote:
> of_find_compatible_node  will increment the refcount of the returned
> device_node. Calling of_node_put() to avoid the refcount leak
> 
> Signed-off-by: Peng Wu <wupeng58@huawei.com>

Thanks!
Applied to the hisilicon armv7 SoC tree.

Best Regards,
Wei

> ---
>  arch/arm/mach-hisi/platsmp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
> index a56cc64deeb8..9ce93e0b6cdc 100644
> --- a/arch/arm/mach-hisi/platsmp.c
> +++ b/arch/arm/mach-hisi/platsmp.c
> @@ -67,14 +67,17 @@ static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
>  		}
>  		ctrl_base = of_iomap(np, 0);
>  		if (!ctrl_base) {
> +			of_node_put(np);
>  			pr_err("failed to map address\n");
>  			return;
>  		}
>  		if (of_property_read_u32(np, "smp-offset", &offset) < 0) {
> +			of_node_put(np);
>  			pr_err("failed to find smp-offset property\n");
>  			return;
>  		}
>  		ctrl_base += offset;
> +		of_node_put(np);
>  	}
>  }
>  
> @@ -160,6 +163,7 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	if (WARN_ON(!node))
>  		return -1;
>  	ctrl_base = of_iomap(node, 0);
> +	of_node_put(node);
>  
>  	/* set the secondary core boot from DDR */
>  	remap_reg_value = readl_relaxed(ctrl_base + REG_SC_CTRL);
> 

