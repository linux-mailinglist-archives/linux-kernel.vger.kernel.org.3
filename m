Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0688E525BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377469AbiEMGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244239AbiEMGwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:52:02 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEF12266E14
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:51:59 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 May 2022 15:51:58 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 8CEB22058443;
        Fri, 13 May 2022 15:51:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 13 May 2022 15:51:58 +0900
Received: from [10.212.8.203] (unknown [10.212.8.203])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0B60CB62B7;
        Fri, 13 May 2022 15:51:58 +0900 (JST)
Message-ID: <0b323f86-79e3-f219-58d2-0a48330b92e4@socionext.com>
Date:   Fri, 13 May 2022 15:51:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] ARM: milbeaut: Fix refcount leak in m10v_smp_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Takao Orito <orito.takao@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220512081554.28562-1-linmq006@gmail.com>
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
In-Reply-To: <20220512081554.28562-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the patch!

Acked-by: Sugaya Taichi <sugaya.taichi@socionext.com>


On 2022/05/12 17:15, Miaoqian Lin wrote:
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 9fb29c734f9e ("ARM: milbeaut: Add basic support for Milbeaut m10v SoC")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   arch/arm/mach-milbeaut/platsmp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
> index 3ea880f5fcb7..1f1ff21c7140 100644
> --- a/arch/arm/mach-milbeaut/platsmp.c
> +++ b/arch/arm/mach-milbeaut/platsmp.c
> @@ -53,6 +53,7 @@ static void m10v_smp_init(unsigned int max_cpus)
>   		return;
>   
>   	m10v_smp_base = of_iomap(np, 0);
> +	of_node_put(np);
>   	if (!m10v_smp_base)
>   		return;
>   
> 
