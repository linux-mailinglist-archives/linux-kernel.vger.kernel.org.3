Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6864F839A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241975AbiDGPgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiDGPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:36:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1F1143
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+7hnd+ZdBRHM+2AnpicWtL6AHX9TxhPSfItL+SOmW2g=; b=U3kcEmUSCT4BBBUCoGp3Yw3v+T
        Nqj9vTutdYM3P+is/eNaWWHp6cxtn0aaP8ZpSfioztKetGke5KYUBi4wFbRi4Uqg1nCAdGgplGFi9
        HR+qVTE82S1OhJbNHBvTRlMmYql3SjEPEEB9tmbsNtpfq1nG0QZvWxGP/4+LtllUoXHYdEDGS0dQ/
        9Rb0G8MuLNNqwmbD5e+S3b5VGgxaCK0k2BioBMyYy2Zz5V/oOeahhAOaH/oc3wzL8BkOi3oU65c+y
        X92c1ntcVw5eL0rMG6YhUz5ZvsdMoW10Co2l3lR/xWkk5eIlrGj6k0Y++hRdDSBY43vi5FD2wJR7m
        7nQN7vGw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncU8x-002XTR-Uk; Thu, 07 Apr 2022 15:33:56 +0000
Message-ID: <525a78c1-3867-5129-57a7-b3dca9eff874@infradead.org>
Date:   Thu, 7 Apr 2022 08:33:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] macintosh/via-pmu: Fix build failure when CONFIG_INPUT
 is disabled
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <5edbe76ce68227f71e09af4614cc4c1bd61c7ec8.1649326292.git.fthain@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5edbe76ce68227f71e09af4614cc4c1bd61c7ec8.1649326292.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/22 03:11, Finn Thain wrote:
> drivers/macintosh/via-pmu-event.o: In function `via_pmu_event':
> via-pmu-event.c:(.text+0x44): undefined reference to `input_event'
> via-pmu-event.c:(.text+0x68): undefined reference to `input_event'
> via-pmu-event.c:(.text+0x94): undefined reference to `input_event'
> via-pmu-event.c:(.text+0xb8): undefined reference to `input_event'
> drivers/macintosh/via-pmu-event.o: In function `via_pmu_event_init':
> via-pmu-event.c:(.init.text+0x20): undefined reference to `input_allocate_device'
> via-pmu-event.c:(.init.text+0xc4): undefined reference to `input_register_device'
> via-pmu-event.c:(.init.text+0xd4): undefined reference to `input_free_device'
> make[1]: *** [Makefile:1155: vmlinux] Error 1
> make: *** [Makefile:350: __build_one_by_one] Error 2
> 
> Don't call into the input subsystem unless CONFIG_INPUT is built-in.
> 
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changed since v1:
>  - Adopted IS_ENABLED to avoid an ifdef as suggested by Christophe.
>  - Added the ADB_PMU_EVENT symbol as suggested by Geert, though this
>    adds a new Kconfig symbol for little gain AFAICS.
> ---
>  drivers/macintosh/Kconfig   | 4 ++++
>  drivers/macintosh/Makefile  | 3 ++-
>  drivers/macintosh/via-pmu.c | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 5cdc361da37c..3942db15a2b8 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -67,6 +67,10 @@ config ADB_PMU
>  	  this device; you should do so if your machine is one of those
>  	  mentioned above.
>  
> +config ADB_PMU_EVENT
> +	def_bool y
> +	depends on ADB_PMU && INPUT=y
> +
>  config ADB_PMU_LED
>  	bool "Support for the Power/iBook front LED"
>  	depends on PPC_PMAC && ADB_PMU
> diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
> index 49819b1b6f20..712edcb3e0b0 100644
> --- a/drivers/macintosh/Makefile
> +++ b/drivers/macintosh/Makefile
> @@ -12,7 +12,8 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
>  obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
>  obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
>  
> -obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
> +obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
> +obj-$(CONFIG_ADB_PMU_EVENT)	+= via-pmu-event.o
>  obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
>  obj-$(CONFIG_PMAC_BACKLIGHT)	+= via-pmu-backlight.o
>  obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 399074306a74..495fd35b11de 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -1463,7 +1463,7 @@ pmu_handle_data(unsigned char *data, int len)
>  		pmu_pass_intr(data, len);
>  		/* len == 6 is probably a bad check. But how do I
>  		 * know what PMU versions send what events here? */
> -		if (len == 6) {
> +		if (IS_ENABLED(CONFIG_ADB_PMU_EVENT) && len == 6) {
>  			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
>  			via_pmu_event(PMU_EVT_LID, data[1]&1);
>  		}

-- 
~Randy
