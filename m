Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2AF579157
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiGSDbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiGSDbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:31:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913CE2DA9C;
        Mon, 18 Jul 2022 20:31:05 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ln46Y3LPFz1M7yS;
        Tue, 19 Jul 2022 11:28:21 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 11:31:03 +0800
Message-ID: <00e710db-3fcd-1fb7-3d19-b5761e241adc@huawei.com>
Date:   Tue, 19 Jul 2022 11:31:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] crypto: hisilicon/hpre - don't use GFP_KERNEL to alloc
 mem during softirq
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <davem@davemloft.net>,
        <xuzaibo@huawei.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>
References: <20220719021042.250882-1-shaozhengchao@huawei.com>
 <YtYT+JeYj7vlz9Xp@gondor.apana.org.au>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <YtYT+JeYj7vlz9Xp@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/19 10:16, Herbert Xu wrote:
> On Tue, Jul 19, 2022 at 10:10:42AM +0800, Zhengchao Shao wrote:
>>
>> @@ -252,7 +252,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
>>   	if (unlikely(shift < 0))
>>   		return -EINVAL;
>>   
>> -	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, GFP_KERNEL);
>> +	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, flags);
> 
> How about just using GFP_ATOMIC unconditinoally?
> 
> Cheers,

Hi Herbert:
	Thank you for your reply. I think differentiate the application 
scenarios of GFP flags, which can be more suitable to allocate memory.

Zhengchao Shao
