Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001B52528C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354637AbiELQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350699AbiELQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:29:35 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 09:29:33 PDT
Received: from 10.mo552.mail-out.ovh.net (10.mo552.mail-out.ovh.net [87.98.187.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897091BA8C2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:29:33 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.228])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 92B1024EA4;
        Thu, 12 May 2022 16:14:18 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 12 May
 2022 18:14:17 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-101G0047b61092e-eff4-4052-83bb-9054023d8a3d,
                    72056902518AC1F5BD4797AAAB6E76FEAFBFF81B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <cc8cf48b-8acf-c281-a3b2-5acd49e38dfd@kaod.org>
Date:   Thu, 12 May 2022 18:14:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] powerpc/xive: Fix refcount leak in xive_spapr_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Child <nick.child@ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ammar Faizi <ammarfaizi2@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20220512090535.33397-1-linmq006@gmail.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220512090535.33397-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 89c32f8e-8e1a-4e55-a27b-1b57f752691f
X-Ovh-Tracer-Id: 3628212452218538799
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrgeejgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeigedvffekgeeftedutddttdevudeihfegudffkeeitdekkeetkefhffelveelleenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 11:05, Miaoqian Lin wrote:
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   arch/powerpc/sysdev/xive/spapr.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index 29456c255f9f..503f544d28e2 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -830,12 +830,12 @@ bool __init xive_spapr_init(void)
>   	/* Resource 1 is the OS ring TIMA */
>   	if (of_address_to_resource(np, 1, &r)) {
>   		pr_err("Failed to get thread mgmnt area resource\n");
> -		return false;
> +		goto err_put;
>   	}
>   	tima = ioremap(r.start, resource_size(&r));
>   	if (!tima) {
>   		pr_err("Failed to map thread mgmnt area\n");
> -		return false;
> +		goto err_put;
>   	}
>   
>   	if (!xive_get_max_prio(&max_prio))
> @@ -871,6 +871,7 @@ bool __init xive_spapr_init(void)
>   	if (!xive_core_init(np, &xive_spapr_ops, tima, TM_QW1_OS, max_prio))
>   		goto err_mem_free;
>   
> +	of_node_put(np);
>   	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
>   	return true;
>   
> @@ -878,6 +879,8 @@ bool __init xive_spapr_init(void)
>   	xive_irq_bitmap_remove_all();
>   err_unmap:
>   	iounmap(tima);
> +err_put:
> +	of_node_put(np);
>   	return false;
>   }
>   

