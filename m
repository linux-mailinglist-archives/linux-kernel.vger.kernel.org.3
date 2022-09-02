Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6975AAC4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiIBKXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIBKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:23:22 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA78BA5725;
        Fri,  2 Sep 2022 03:23:20 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oU3pT-000KkZ-Ek; Fri, 02 Sep 2022 20:23:16 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Sep 2022 18:23:15 +0800
Date:   Fri, 2 Sep 2022 18:23:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] crypto: crc32c - add missing Kconfig option
 select
Message-ID: <YxHZk7ADgv0Tzl6W@gondor.apana.org.au>
References: <20220825084138.1881954-1-cuigaosheng1@huawei.com>
 <20220825084138.1881954-3-cuigaosheng1@huawei.com>
 <Ywc36LxM2+0eqKu2@gondor.apana.org.au>
 <35ec0aed-ee54-b6ea-1d34-06839b20befb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ec0aed-ee54-b6ea-1d34-06839b20befb@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 08:55:12PM +0800, cuigaosheng wrote:
> Thanks for your reply.
> 
> While I was debugging the kernel code of linux-next, I start the kernel
> with qemu-system-arm with following commands:
> 
>     make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- vexpress_defconfig
>     make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j32
>     qemu-system-arm -M vexpress-a9 -m 1024M -s -nographic -kernel arch/arm/boot/zImage \
>                    -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb -sd /home/rootfs.sd \
>                    -append "root=/dev/mmcblk0 rw console=ttyAMA0"
> 
> But it failed, so I tried to locate the cause of the failure and finally found that
> it failed from this patch(cad439fc040e crypto: api - Do not create test larvals if manager is disabled)，
> logs as follows:
> > EXT4-fs (mmcblk0): Cannot load crc32c driver. VFS: Cannot open root
> > device "mmcblk0" or unknown-block(179,0): error -80 Please append a
> > correct "root=" boot option; here are the available partitions: 1f00
> > 131072 mtdblock0 (driver?) 1f01 32768 mtdblock1 (driver?) b300 32768
> > mmcblk0 driver: mmcblk Kernel panic - not syncing: VFS: Unable to mount
> > root fs on unknown-block(179,0) CPU: 0 PID: 1 Comm: swapper/0 Not
> > tainted 5.15.0-rc1+ #1 Hardware name: ARM-Versatile Express [<8010f334>]
> > (unwind_backtrace) from [<8010b08c>] (show_stack+0x10/0x14) [<8010b08c>]
> > (show_stack) from [<8083f2a4>] (dump_stack_lvl+0x40/0x4c) [<8083f2a4>]
> > (dump_stack_lvl) from [<8083b210>] (panic+0xf8/0x2f4) [<8083b210>]
> > (panic) from [<80b0175c>] (mount_block_root+0x178/0x200) [<80b0175c>]
> > (mount_block_root) from [<80b01bac>] (prepare_namespace+0x150/0x18c)
> > [<80b01bac>] (prepare_namespace) from [<8084384c>]
> > (kernel_init+0x10/0x124) [<8084384c>] (kernel_init) from [<80100130>]
> > (ret_from_fork+0x14/0x24) Exception stack(0x8108bfb0 to 0x8108bff8)
> > bfa0: ???????? ???????? ???????? ???????? bfc0: ???????? ????????
> > ???????? ???????? ???????? ???????? ???????? ???????? bfe0: ????????
> > ???????? ???????? ???????? ???????? ???????? ---[ end Kernel panic - not
> > syncing: VFS: Unable to mount root fs on unknown-block(179,0) ]---
> 
> In the patch, crypto_alloc_test_larval will return NULL if CONFIG_CRYPTO_MANAGER disabled, so
> I checked to see if this change was the cause "EXT4-fs (mmcblk0): Cannot load crc32c driver
> ", the success logs does not have this error.
> 
> When I enabled CONFIG_CRYPTO_MANAGER, kernel can be boot successfully.
> 
> Could that be the reason? I would be very grateful if you could give me some advice.

Can you please provide the whole .config file?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
