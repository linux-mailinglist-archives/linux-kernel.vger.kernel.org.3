Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0F5A1138
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiHYMzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbiHYMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:55:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF3D39B85;
        Thu, 25 Aug 2022 05:55:16 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MD2sp0KvQzlWQ2;
        Thu, 25 Aug 2022 20:51:58 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 20:55:13 +0800
Subject: Re: [PATCH -next 2/2] crypto: crc32c - add missing Kconfig option
 select
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220825084138.1881954-1-cuigaosheng1@huawei.com>
 <20220825084138.1881954-3-cuigaosheng1@huawei.com>
 <Ywc36LxM2+0eqKu2@gondor.apana.org.au>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <35ec0aed-ee54-b6ea-1d34-06839b20befb@huawei.com>
Date:   Thu, 25 Aug 2022 20:55:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Ywc36LxM2+0eqKu2@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

While I was debugging the kernel code of linux-next, I start the kernel
with qemu-system-arm with following commands:

     make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- vexpress_defconfig
     make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j32
     qemu-system-arm -M vexpress-a9 -m 1024M -s -nographic -kernel arch/arm/boot/zImage \
                    -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb -sd /home/rootfs.sd \
                    -append "root=/dev/mmcblk0 rw console=ttyAMA0"

But it failed, so I tried to locate the cause of the failure and finally found that
it failed from this patch(cad439fc040e crypto: api - Do not create test larvals if manager is disabled)，
logs as follows:
> EXT4-fs (mmcblk0): Cannot load crc32c driver. VFS: Cannot open root 
> device "mmcblk0" or unknown-block(179,0): error -80 Please append a 
> correct "root=" boot option; here are the available partitions: 1f00 
> 131072 mtdblock0 (driver?) 1f01 32768 mtdblock1 (driver?) b300 32768 
> mmcblk0 driver: mmcblk Kernel panic - not syncing: VFS: Unable to 
> mount root fs on unknown-block(179,0) CPU: 0 PID: 1 Comm: swapper/0 
> Not tainted 5.15.0-rc1+ #1 Hardware name: ARM-Versatile Express 
> [<8010f334>] (unwind_backtrace) from [<8010b08c>] 
> (show_stack+0x10/0x14) [<8010b08c>] (show_stack) from [<8083f2a4>] 
> (dump_stack_lvl+0x40/0x4c) [<8083f2a4>] (dump_stack_lvl) from 
> [<8083b210>] (panic+0xf8/0x2f4) [<8083b210>] (panic) from [<80b0175c>] 
> (mount_block_root+0x178/0x200) [<80b0175c>] (mount_block_root) from 
> [<80b01bac>] (prepare_namespace+0x150/0x18c) [<80b01bac>] 
> (prepare_namespace) from [<8084384c>] (kernel_init+0x10/0x124) 
> [<8084384c>] (kernel_init) from [<80100130>] (ret_from_fork+0x14/0x24) 
> Exception stack(0x8108bfb0 to 0x8108bff8) bfa0: ???????? ???????? 
> ???????? ???????? bfc0: ???????? ???????? ???????? ???????? ???????? 
> ???????? ???????? ???????? bfe0: ???????? ???????? ???????? ???????? 
> ???????? ???????? ---[ end Kernel panic - not syncing: VFS: Unable to 
> mount root fs on unknown-block(179,0) ]---

In the patch, crypto_alloc_test_larval will return NULL if CONFIG_CRYPTO_MANAGER disabled, so
I checked to see if this change was the cause "EXT4-fs (mmcblk0): Cannot load crc32c driver
", the success logs does not have this error.

When I enabled CONFIG_CRYPTO_MANAGER, kernel can be boot successfully.

Could that be the reason? I would be very grateful if you could give me some advice.

Thanks very much!

在 2022/8/25 16:50, Herbert Xu 写道:
> On Thu, Aug 25, 2022 at 04:41:38PM +0800, Gaosheng Cui wrote:
>> The CRYPTO_CRC32C is using functions provided by CRYPTO_MANAGER,
>> otherwise the following error will occur:
>>
>>      EXT4-fs (mmcblk0): Cannot load crc32c driver.
>>
>> So select CRYPTO_MANAGER when enable CRYPTO_CRC32C.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   crypto/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/crypto/Kconfig b/crypto/Kconfig
>> index b1ccf873779d..7f124604323b 100644
>> --- a/crypto/Kconfig
>> +++ b/crypto/Kconfig
>> @@ -641,6 +641,7 @@ config CRYPTO_CRC32C
>>   	tristate "CRC32c CRC algorithm"
>>   	select CRYPTO_HASH
>>   	select CRC32
>> +	select CRYPTO_MANAGER
>>   	help
>>   	  Castagnoli, et al Cyclic Redundancy-Check Algorithm.  Used
>>   	  by iSCSI for header and data digests and by others.
> Why exactly does it need CRYPTO_MANAGER?
>
> Cheers,
