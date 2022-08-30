Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867025A5A99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiH3EXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3EXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:23:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C778BF8;
        Mon, 29 Aug 2022 21:23:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so6995425pjc.3;
        Mon, 29 Aug 2022 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=wQtEUVqBvaICfheHsH423T0wNnmLN28SHOOPSyy5UnI=;
        b=jv9znzp5/qfhgDi1KTqGwxs+UqsaYsh4r88www2B4BBwcqVZyX1NV2rAD61PXenZbJ
         HEB4kUsmkKk1BMN2HRMOkNjwFox43kKbpEbrs4Go9Nfa1SUvUy8t5/WxH0ks/4IMIY+1
         ctxQlSBBJFL1ACWJpDYxLOX3O26xXYXya06gpxVeJyXcCUBjwdQCY0XKfbnWzSDSz9tY
         6wUmeZviPdTeZF4rRb0jxW09JxYYxLMdtdXfesOofJf7scj9IWXQd4RDWA35GbRaf4RW
         uxgjiVAXLwOWYx9p3Ip3lo+Rptn30sqzMkjEJ8Z84GK0wAd59JtvmlsmiI08cZtsMtf+
         fvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=wQtEUVqBvaICfheHsH423T0wNnmLN28SHOOPSyy5UnI=;
        b=fz6L6e5q+B9JRIyzfS7oHIYF8WXWJVk5SlR4UaHPk0nOyygK0ZR/j+/uJdjo9ex0MS
         wc1Zb0pcxAWnaVy6qoWYtsblm9/2OofvTdFUqzVw5wP7G8qPW0dI0Vs12By5YFz5yeR2
         AZTtyKCgBxde12MMIuM91BCaNlRq208bJ5fVPRVE7L/upteNASDGllh9GxrnQXJOdTzy
         v5HM/Ob7N2a+RR0P8pU9GH/6zMetqtWx0Ow7+dQXZyZvZLUjXQ/NRGAkSnth2M6hdVKT
         o0FyfozMZx/ggUit1onMei1CipIvGhi7DuV83Rtrq798W6FKdmvM+i2n/wO4/RXwaa2r
         JdUA==
X-Gm-Message-State: ACgBeo2aakjypvUjBvHixaFJhf5guPcLoTbDJ5vYjtIJRRbuqOKI+Abo
        LA1X2BxNx2PuX8jpMpTiGBfD/sqHFq1E9Q==
X-Google-Smtp-Source: AA6agR4LUEFwDWEAt00mNFVfZ53NQBKW3wk3nMWBWk6jo8ymaoFgEYRQmTMbGaG95Q/0+Pnc+l4Psg==
X-Received: by 2002:a17:90b:1a88:b0:1f7:3daa:f2f6 with SMTP id ng8-20020a17090b1a8800b001f73daaf2f6mr22029724pjb.245.1661833424495;
        Mon, 29 Aug 2022 21:23:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gi13-20020a17090b110d00b001fb0fc33d72sm7445482pjb.47.2022.08.29.21.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:23:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 21:23:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (gpio-fan) Fix array out of bounds access
Message-ID: <20220830042341.GA3344665@roeck-us.net>
References: <20220830011101.178843-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830011101.178843-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 03:11:01AM +0200, Armin Wolf wrote:
> The driver does not check if the cooling state passed to
> gpio_fan_set_cur_state() exceeds the maximum cooling state as
> stored in fan_data->num_speeds. Since the cooling state is later
> used as an array index in set_fan_speed(), an array out of bounds
> access can occur.
> This can be exploited by setting the state of the thermal cooling device
> to arbitrary values, causing for example a kernel oops when unavailable
> memory is accessed this way.
> 
> Example kernel oops:
> [  807.987276] Unable to handle kernel paging request at virtual address ffffff80d0588064
> [  807.987369] Mem abort info:
> [  807.987398]   ESR = 0x96000005
> [  807.987428]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  807.987477]   SET = 0, FnV = 0
> [  807.987507]   EA = 0, S1PTW = 0
> [  807.987536]   FSC = 0x05: level 1 translation fault
> [  807.987570] Data abort info:
> [  807.987763]   ISV = 0, ISS = 0x00000005
> [  807.987801]   CM = 0, WnR = 0
> [  807.987832] swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000001165000
> [  807.987872] [ffffff80d0588064] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [  807.987961] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  807.987992] Modules linked in: cmac algif_hash aes_arm64 algif_skcipher af_alg bnep hci_uart btbcm bluetooth ecdh_generic ecc 8021q garp stp llc snd_soc_hdmi_codec brcmfmac vc4 brcmutil cec drm_kms_helper snd_soc_core cfg80211 snd_compress bcm2835_codec(C) snd_pcm_dmaengine syscopyarea bcm2835_isp(C) bcm2835_v4l2(C) sysfillrect v4l2_mem2mem bcm2835_mmal_vchiq(C) raspberrypi_hwmon sysimgblt videobuf2_dma_contig videobuf2_vmalloc fb_sys_fops videobuf2_memops rfkill videobuf2_v4l2 videobuf2_common i2c_bcm2835 snd_bcm2835(C) videodev snd_pcm snd_timer snd mc vc_sm_cma(C) gpio_fan uio_pdrv_genirq uio drm fuse drm_panel_orientation_quirks backlight ip_tables x_tables ipv6
> [  807.988508] CPU: 0 PID: 1321 Comm: bash Tainted: G         C        5.15.56-v8+ #1575
> [  807.988548] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
> [  807.988574] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  807.988608] pc : set_fan_speed.part.5+0x34/0x80 [gpio_fan]
> [  807.988654] lr : gpio_fan_set_cur_state+0x34/0x50 [gpio_fan]
> [  807.988691] sp : ffffffc008cf3bd0
> [  807.988710] x29: ffffffc008cf3bd0 x28: ffffff80019edac0 x27: 0000000000000000
> [  807.988762] x26: 0000000000000000 x25: 0000000000000000 x24: ffffff800747c920
> [  807.988787] x23: 000000000000000a x22: ffffff800369f000 x21: 000000001999997c
> [  807.988854] x20: ffffff800369f2e8 x19: ffffff8002ae8080 x18: 0000000000000000
> [  807.988877] x17: 0000000000000000 x16: 0000000000000000 x15: 000000559e271b70
> [  807.988938] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [  807.988960] x11: 0000000000000000 x10: ffffffc008cf3c20 x9 : ffffffcfb60c741c
> [  807.989018] x8 : 000000000000000a x7 : 00000000ffffffc9 x6 : 0000000000000009
> [  807.989040] x5 : 000000000000002a x4 : 0000000000000000 x3 : ffffff800369f2e8
> [  807.989062] x2 : 000000000000e780 x1 : 0000000000000001 x0 : ffffff80d0588060
> [  807.989084] Call trace:
> [  807.989091]  set_fan_speed.part.5+0x34/0x80 [gpio_fan]
> [  807.989113]  gpio_fan_set_cur_state+0x34/0x50 [gpio_fan]
> [  807.989199]  cur_state_store+0x84/0xd0
> [  807.989221]  dev_attr_store+0x20/0x38
> [  807.989262]  sysfs_kf_write+0x4c/0x60
> [  807.989282]  kernfs_fop_write_iter+0x130/0x1c0
> [  807.989298]  new_sync_write+0x10c/0x190
> [  807.989315]  vfs_write+0x254/0x378
> [  807.989362]  ksys_write+0x70/0xf8
> [  807.989379]  __arm64_sys_write+0x24/0x30
> [  807.989424]  invoke_syscall+0x4c/0x110
> [  807.989442]  el0_svc_common.constprop.3+0xfc/0x120
> [  807.989458]  do_el0_svc+0x2c/0x90
> [  807.989473]  el0_svc+0x24/0x60
> [  807.989544]  el0t_64_sync_handler+0x90/0xb8
> [  807.989558]  el0t_64_sync+0x1a0/0x1a4
> [  807.989579] Code: b9403801 f9402800 7100003f 8b35cc00 (b9400416)
> [  807.989627] ---[ end trace 8ded4c918658445b ]---
> 
> Fix this by checking the cooling state and return an error if it
> exceeds the maximum cooling state.
> 
> Tested on a Raspberry Pi 3.
> 
> Fixes: b5cf88e46bad ("(gpio-fan): Add thermal control hooks")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - move check to gpio_fan_set_cur_state()
> - reword commit message
> ---
>  drivers/hwmon/gpio-fan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index befe989ca7b9..fbf3f5a4ecb6 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -391,6 +391,9 @@ static int gpio_fan_set_cur_state(struct thermal_cooling_device *cdev,
>  	if (!fan_data)
>  		return -EINVAL;
> 
> +	if (state >= fan_data->num_speed)
> +		return -EINVAL;
> +
>  	set_fan_speed(fan_data, state);
>  	return 0;
>  }
