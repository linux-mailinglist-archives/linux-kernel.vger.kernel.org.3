Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F99572B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiGMCOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGMCOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:14:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67BF4B0CC;
        Tue, 12 Jul 2022 19:14:17 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjLgZ3tNlzVfjb;
        Wed, 13 Jul 2022 10:10:34 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 10:14:08 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 10:14:07 +0800
Subject: Re: [PATCH -next 2/2] spi: microchip-core: switch to use
 devm_spi_alloc_master()
To:     <Conor.Dooley@microchip.com>
CC:     <Daire.McNamara@microchip.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20220712135357.918997-1-yangyingliang@huawei.com>
 <20220712135357.918997-2-yangyingliang@huawei.com>
 <87581e76-ceb7-9efa-d6dd-5ad4fe66111a@microchip.com>
 <687d4652-c231-bfa5-f76f-ac826ab1fe98@microchip.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <35cfbaa3-d21a-f75c-7f89-3624e7b43f33@huawei.com>
Date:   Wed, 13 Jul 2022 10:14:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <687d4652-c231-bfa5-f76f-ac826ab1fe98@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/13 4:50, Conor.Dooley@microchip.com wrote:
> On 12/07/2022 15:03, Conor.Dooley@microchip.com wrote:
>> On 12/07/2022 14:53, Yang Yingliang wrote:
>>> [Some people who received this message don't often get email from yangyingliang@huawei.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> Switch to use devm_spi_alloc_master() to simpify error path.
>> Hey Yang,
>> Thanks for trying to fix my mistakes!
>>
>> Forgive my innocence here, but why is it okay to remove the
>> spi_master_put() in remove() but not the one in the error path of
>> the probe function?
>>
>> If the devm_add_action_or_reset() in devm_spi_register_controller()
>> fails won't the same thing apply to the probe error path?
>>
>> IOW, I think this patch needs a fixes tag too b/c it also fixes a
>> refcount underflow. Please correct me if I am misunderstanding.
> Ahh, I just saw your revert of 59ebbe40fb51 ("spi: simplify
> devm_spi register_controller"). With that, this makes a lot more
> sense.
>
>> One other comment below.
> This comment still applies for this patch. dev_err_probe would be
> nice.
OK.

Thanks,
Yang
>
> Thanks,
> Conor.
