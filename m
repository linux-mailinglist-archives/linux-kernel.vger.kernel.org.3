Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0084D2A55
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiCIIHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCIIHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:07:30 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07330167F8D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:06:30 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:806d:fd89:4c52:5c02])
        by baptiste.telenet-ops.be with bizsmtp
        id 486U270095Lieee0186UDl; Wed, 09 Mar 2022 09:06:28 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRrL1-003HA0-MI; Wed, 09 Mar 2022 09:06:27 +0100
Date:   Wed, 9 Mar 2022 09:06:27 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     kernel test robot <lkp@intel.com>
cc:     Farzad Farshchi <farzadfr@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [esmil:visionfive 55/61] nvdla_core_callbacks.c:undefined
 reference to `__udivdi3'
In-Reply-To: <202203090611.3NpTkqvn-lkp@intel.com>
Message-ID: <alpine.DEB.2.22.394.2203090905560.780932@ramsan.of.borg>
References: <202203090611.3NpTkqvn-lkp@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022, kernel test robot wrote:
> tree:   https://github.com/esmil/linux visionfive
> head:   b75fcbba0e03fd9655bc4c8854422d51474664d3
> commit: 6146bd9336a5f9d2bb66d6a394863600b61afeb5 [55/61] nvdla: add NVDLA driver
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203090611.3NpTkqvn-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://github.com/esmil/linux/commit/6146bd9336a5f9d2bb66d6a394863600b61afeb5
>        git remote add esmil https://github.com/esmil/linux
>        git fetch --no-tags esmil visionfive
>        git checkout 6146bd9336a5f9d2bb66d6a394863600b61afeb5
>        # save the config file to linux build tree
>        mkdir build_dir
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>   m68k-linux-ld: drivers/nvdla/nvdla_core_callbacks.o: in function `dla_get_time_us':
>>> nvdla_core_callbacks.c:(.text+0x396): undefined reference to `__udivdi3'
>   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

From 1df1db244324a715b93af89586e4cce720ad2c94 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Mar 2022 09:03:03 +0100
Subject: [PATCH] nvdla: Use div_u64() in dla_get_time_us()

On 32-bit (e.g. m68k allyesconfig):

     m68k-linux-ld: drivers/nvdla/nvdla_core_callbacks.o: in function `dla_get_time_us':
     nvdla_core_callbacks.c:(.text+0x396): undefined reference to `__udivdi3'

dla_get_time_us() does a 64-by-32 division, hence div_u64() must be
used instead of a plain division.

Fixes: 6146bd9336a5f9d2 ("nvdla: add NVDLA driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Feel free to fold into the original.

  drivers/nvdla/nvdla_core_callbacks.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdla/nvdla_core_callbacks.c b/drivers/nvdla/nvdla_core_callbacks.c
index 6d461624adfbda33..e296562d259b7124 100644
--- a/drivers/nvdla/nvdla_core_callbacks.c
+++ b/drivers/nvdla/nvdla_core_callbacks.c
@@ -38,6 +38,7 @@
  #include <linux/interrupt.h>
  #include <linux/irq.h>
  #include <linux/irqdomain.h>
+#include <linux/math64.h>
  #include <linux/module.h>
  #include <linux/of.h>
  #include <linux/of_device.h>
@@ -121,7 +122,7 @@ void *dla_memcpy(void *dest, const void *src, uint64_t len)

  int64_t dla_get_time_us(void)
  {
-	return ktime_get_ns() / NSEC_PER_USEC;
+	return div_u64(ktime_get_ns(), NSEC_PER_USEC);
  }

  void dla_reg_write(void *driver_context, uint32_t addr, uint32_t reg)
-- 
2.25.1

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
