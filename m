Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DADC4DE60B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbiCSE6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiCSE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:58:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4380B2A4BE5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hwFaJqqqG8uUr3fjXxsVA+nII57NXxwdDsoh1j9zLU8=; b=sYgGKh6dBxUGoBFst+uzjWVsdR
        CWber+AaE0Aplg5JPGEO5RntoT2dKhTmnJB9P2b5bM6lXdGMvJUEzdysWS6C2WGsp0fCh63xzUeHR
        BvDAAip4j88WlrNdp4esF957+lg0RBPyE1Mq5ZUD4PZ+hhJZcpAexGfaIdJdIIJ/P7sstIEGoMdlu
        HgU40NOG2iYAw4sy3MLAsXKY7hldYnyCHO7n5zxOVpYLjEJmA9ATeJCfrmMhTXqNoyqI2YBdxdOw1
        8DZvDueoeelxBJQjKfvgOmb0YBbXYzMTgG8f3RDVxZcAxYu4PxfPItPY0NgklL7yVaYW2I4GODk2b
        8s0DuVtA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVR8f-008ZOw-PS; Sat, 19 Mar 2022 04:56:30 +0000
Message-ID: <f5cebabc-18f9-7e64-ac34-2c7802104aa1@infradead.org>
Date:   Fri, 18 Mar 2022 21:56:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] macintosh/via-pmu: Fix build failure when CONFIG_INPUT is
 disabled
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cb1828050f8c9ef801b2bdf79eccd6c52afed26b.1647663509.git.fthain@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cb1828050f8c9ef801b2bdf79eccd6c52afed26b.1647663509.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/22 21:18, Finn Thain wrote:
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
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Hi Finn,
It builds without those reported errors, but I do see these warnings
since the robot-supplied .config file has:
# CONFIG_PROC_FS is not set


  CC      drivers/macintosh/via-pmu.o
../drivers/macintosh/via-pmu.c:897:12: warning: 'pmu_battery_proc_show' defined but not used [-Wunused-function]
  897 | static int pmu_battery_proc_show(struct seq_file *m, void *v)
      |            ^~~~~~~~~~~~~~~~~~~~~
../drivers/macintosh/via-pmu.c:871:12: warning: 'pmu_irqstats_proc_show' defined but not used [-Wunused-function]
  871 | static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
      |            ^~~~~~~~~~~~~~~~~~~~~~
../drivers/macintosh/via-pmu.c:860:12: warning: 'pmu_info_proc_show' defined but not used [-Wunused-function]
  860 | static int pmu_info_proc_show(struct seq_file *m, void *v)
      |            ^~~~~~~~~~~~~~~~~~

> ---
>  drivers/macintosh/Makefile  | 5 ++++-
>  drivers/macintosh/via-pmu.c | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
> index 49819b1b6f20..eaf28b1c272f 100644
> --- a/drivers/macintosh/Makefile
> +++ b/drivers/macintosh/Makefile
> @@ -12,7 +12,10 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
>  obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
>  obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
>  
> -obj-$(CONFIG_ADB_PMU)		+= via-pmu.o via-pmu-event.o
> +obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
> +ifeq ($(CONFIG_INPUT), y)
> +obj-$(CONFIG_ADB_PMU)		+= via-pmu-event.o
> +endif
>  obj-$(CONFIG_ADB_PMU_LED)	+= via-pmu-led.o
>  obj-$(CONFIG_PMAC_BACKLIGHT)	+= via-pmu-backlight.o
>  obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 4b98bc26a94b..55afa6dfa263 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -1457,12 +1457,14 @@ pmu_handle_data(unsigned char *data, int len)
>  		if (pmu_battery_count)
>  			query_battery_state();
>  		pmu_pass_intr(data, len);
> +#ifdef CONFIG_INPUT
>  		/* len == 6 is probably a bad check. But how do I
>  		 * know what PMU versions send what events here? */
>  		if (len == 6) {
>  			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
>  			via_pmu_event(PMU_EVT_LID, data[1]&1);
>  		}
> +#endif
>  		break;
>  
>  	default:

thanks.
-- 
~Randy
