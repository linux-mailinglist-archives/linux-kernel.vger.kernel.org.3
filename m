Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E405455A982
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiFYLiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiFYLiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:38:05 -0400
Received: from 10.mo552.mail-out.ovh.net (10.mo552.mail-out.ovh.net [87.98.187.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A311C1E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 04:38:01 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.118])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 2B89624A8F;
        Sat, 25 Jun 2022 11:29:37 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Sat, 25 Jun
 2022 13:29:36 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-107S001e52cdebf-f225-43ef-b594-73954c12a390,
                    4F3A6162F3CBF85AFED954EB26FB80209C915413) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d48bcb6b-41f7-8243-6094-cf80beffe68a@kaod.org>
Date:   Sat, 25 Jun 2022 13:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] powerpc/xive: Fix some incorrect memory allocation
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
References: <2ebb28e9de76d35b75c137f9944c2dfd893d34fa.1656150559.git.christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <2ebb28e9de76d35b75c137f9944c2dfd893d34fa.1656150559.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 8095d44e-4afb-4333-bd47-84e426c9d3f6
X-Ovh-Tracer-Id: 17411197634755070825
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeguddggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeifeehtdevfeeuhfelheekkeefieeivdfhgeevueeijeetjeekueeggedujeeiieenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdpoffvtefjohhsthepmhhoheehvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe,

On 6/25/22 11:49, Christophe JAILLET wrote:
> 'xibm->count' really looks like a number of bits (see how it is used in
> __xive_irq_bitmap_alloc()), so use the bitmap API to allocate and free this
> bitmap.
> 
> This improves semantic and potentially avoids some over memory allocation.

This is correct and
  
> Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I don't cross compile, so this patch is NOT compile-tested.


Nathan provided a fix for it already :

  http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220623182509.3985625-1-nathanl@linux.ibm.com/

Thanks,

C.

> ---
>   arch/powerpc/sysdev/xive/spapr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index 7d5128676e83..fdbebb14b7de 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -57,7 +57,7 @@ static int __init xive_irq_bitmap_add(int base, int count)
>   	spin_lock_init(&xibm->lock);
>   	xibm->base = base;
>   	xibm->count = count;
> -	xibm->bitmap = kzalloc(xibm->count, GFP_KERNEL);
> +	xibm->bitmap = bitmap_zalloc(xibm->count, GFP_KERNEL);
>   	if (!xibm->bitmap) {
>   		kfree(xibm);
>   		return -ENOMEM;
> @@ -75,7 +75,7 @@ static void xive_irq_bitmap_remove_all(void)
>   
>   	list_for_each_entry_safe(xibm, tmp, &xive_irq_bitmaps, list) {
>   		list_del(&xibm->list);
> -		kfree(xibm->bitmap);
> +		bitmap_free(xibm->bitmap);
>   		kfree(xibm);
>   	}
>   }

