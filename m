Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E379751F387
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiEIEfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiEIE35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:29:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E446B2F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:26:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k14so11037377pga.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 21:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZjP4dNTKy30RT9KsXwzpA3EHoMN585jvCR1XFDuLEc=;
        b=nBNg+tHZflBjGIS0XPj5Tmj27fS8cL8mQm0nI/LyYEthrACAFVmuVfbXjqcD3sQnTO
         kmivvn/pU1dK3Y0JdheVKDRZDi/CCl0csGg4Md5G+jbn4Eq6NxU4T+CmjudaxnMQdVez
         IxSFKuDQmoFDTamIY9S9dXezXOQqnpJKsowXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZjP4dNTKy30RT9KsXwzpA3EHoMN585jvCR1XFDuLEc=;
        b=WTjvBMugFcBkJvwiZM632cvyrlmztLoSnOI8lREBuatbeoXChyAFkqc5IG/eoZSRqF
         MTmuDslo2UDyIKQbBtqpkemNNe4oAibuXD1rFzFRxji1m7koGChIEmBU/yzWfzESpyoc
         +MeI9QEhZyaGAzctynT4di752fuxV8k+SG1ziz/oURVZzjvZT3N3SgQolNKTNtn68bSG
         jz8kb26b199l4bP1gy5IOW2zzqYvSTH3blibQy45pUGFvEcQBsnGnaINCZPxV5PqkFhz
         VxR53CrQbWt4ibVPt0VfAkAjvVoPHwpZpu4OobrWYJWGi4Z0RNJ8pGjCojIRA+rXcXvl
         JceQ==
X-Gm-Message-State: AOAM533RIplrmMv+5u7j20h9iWPxdCemsMHe3IEzH8qAaCoBg5ewCw0c
        NN/wgxjKDlFZ/MR8bQAprxquAg==
X-Google-Smtp-Source: ABdhPJzrANxqU33W/Ssp3fR5eUxPwB81F/Oe0FFkPLJbJUxvMEmAwhD7R/7F6MGgzD3ydHD3eRFfdg==
X-Received: by 2002:a62:7ccc:0:b0:510:4e07:79f3 with SMTP id x195-20020a627ccc000000b005104e0779f3mr13894842pfc.10.1652070363403;
        Sun, 08 May 2022 21:26:03 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:97ce:ca39:c9e7:b20e])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7818a000000b0050dc76281a6sm7472520pfi.128.2022.05.08.21.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 21:26:03 -0700 (PDT)
Date:   Mon, 9 May 2022 12:25:59 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, johnson.wang@mediatek.com,
        mka@chromium.org, jia-wei.chang@mediatek.com,
        andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com
Subject: Re: [PATCH v2 5/5] PM / devfreq: passive: Update frequency when
 start governor
Message-ID: <YniX1w+oI1eOCmCx@google.com>
References: <20220507150145.531864-1-cw00.choi@samsung.com>
 <20220507150145.531864-6-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507150145.531864-6-cw00.choi@samsung.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 08, 2022 at 12:01:45AM +0900, Chanwoo Choi wrote:
> If the parent device changes the their frequency before registering
> the passive device, the passive device cannot receive the notification
> from parent device and then the passive device cannot be able to
> set the proper frequency according to the frequency of parent device.
> 
> So, when start the passive governor, update the frequency
> according to the frequency of parent device.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Link: https://lore.kernel.org/r/20220507150145.531864-6-cw00.choi@samsung.com
> ---
>  drivers/devfreq/governor_passive.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index b34dbe750c0a..74d26c193fdb 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -412,6 +412,23 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  		if (!p_data->this)
>  			p_data->this = devfreq;
>  
> +		/*
> +		 * If the parent device changes the their frequency before
> +		 * registering the passive device, the passive device cannot
> +		 * receive the notification from parent device and then the
> +		 * passive device cannot be able to set the proper frequency
> +		 * according to the frequency of parent device.
> +		 *
> +		 * When start the passive governor, update the frequency
> +		 * according to the frequency of parent device.
> +		 */
> +		mutex_lock(&devfreq->lock);
> +		ret = devfreq_update_target(devfreq, parent->previous_freq);

This crashes when parent is NULL, in the case where parent is cpufreq.
This is the case with the MTK ccifreq driver, which produces the panic
and backtrace below [1].

I made a fix for a previous version of this patch:

    https://github.com/wens/linux/commit/f85c1834dd07388abb57a00200c80f7440823a03

BTW, could you CC me on future revisions? I'm not subscribed to the
linux-pm mailing list.


Regards
ChenYu

[1]

Unable to handle kernel read from unreadable memory at virtual address 0000000000000420
Mem abort info:
ESR = 0x0000000096000005
EC = 0x25: DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
FSC = 0x05: level 1 translation fault
Data abort info:
ISV = 0, ISS = 0x00000005
CM = 0, WnR = 0
[0000000000000420] user address but active_mm is swapper
Internal error: Oops: 96000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc5-next-20220505-09393-g38dc825c1d73 #155 b348fdb8d61a403eef7a9c5857bc02a261fcb213
Hardware name: Google juniper sku16 board (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : devfreq_passive_event_handler (drivers/devfreq/governor_passive.c:426)
lr : devfreq_passive_event_handler (drivers/devfreq/governor_passive.c:426)
sp : ffffffc00808ba80
x29: ffffffc00808ba80 x28: 0000000000000000 x27: ffffffe99bb90458
x26: 0000000000000010 x25: ffffff80c1843848 x24: ffffff80c1843810
x23: ffffffe99babf3f5 x22: ffffffe99c278190 x21: ffffff80c0924d80
x20: ffffff80c1843800 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000065516d0e x16: 00000000fc90660b x15: 0000000000000018
x14: 0000000000000000 x13: ffffffffff000000 x12: 0000000000000038
x11: 0101010101010101 x10: 8000000000000000 x9 : ffffffe99acb8458
x8 : 0065766973000000 x7 : 0000000000000080 x6 : 0000000000000000
x5 : 8000000000000000 x4 : 0000000000000000 x3 : ffffff80c1843810
x2 : ffffff80c0228000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
devfreq_passive_event_handler (drivers/devfreq/governor_passive.c:426)
devfreq_add_device (drivers/devfreq/devfreq.c:932)
devm_devfreq_add_device (drivers/devfreq/devfreq.c:1028)
mtk_ccifreq_probe (drivers/devfreq/mtk-cci-devfreq.c:366)
platform_probe (drivers/base/platform.c:1398)
really_probe (drivers/base/dd.c:542 drivers/base/dd.c:621 drivers/base/dd.c:566)
__driver_probe_device (drivers/base/dd.c:752)
driver_probe_device (drivers/base/dd.c:782)
__driver_attach (drivers/base/dd.c:1143 drivers/base/dd.c:1094)
bus_for_each_dev (drivers/base/bus.c:301)
driver_attach (drivers/base/dd.c:1160)
bus_add_driver (drivers/base/bus.c:619)
driver_register (drivers/base/driver.c:240)
__platform_driver_register (drivers/base/platform.c:866)
mtk_ccifreq_platdrv_init (drivers/devfreq/mtk-cci-devfreq.c:468)
do_one_initcall (init/main.c:1301)
kernel_init_freeable (init/main.c:1375 init/main.c:1392 init/main.c:1411 init/main.c:1618)
kernel_init (init/main.c:1511)
ret_from_fork (arch/arm64/kernel/entry.S:868)
Code: f9000eb4 91004298 aa1803e0 940979d4 (f9421261)
All code
========
   0:	f9000eb4 	str	x20, [x21, #24]
   4:	91004298 	add	x24, x20, #0x10
   8:	aa1803e0 	mov	x0, x24
   c:	940979d4 	bl	0x25e75c
  10:*	f9421261 	ldr	x1, [x19, #1056]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	f9421261 	ldr	x1, [x19, #1056]
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: 0x2992c00000 from 0xffffffc008000000
PHYS_OFFSET: 0x40000000
CPU features: 0x000,00324811,00001086
Memory Limit: none
PANIC in EL3.

> +		if (ret < 0)
> +			dev_warn(&devfreq->dev,
> +			"failed to update devfreq using passive governor\n");
> +		mutex_unlock(&devfreq->lock);
> +
>  		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
>  			ret = devfreq_passive_register_notifier(devfreq);
>  		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
> 
> -- 
> 2.25.1
> 
