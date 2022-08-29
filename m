Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771DA5A4E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiH2NqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiH2NqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:46:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E21076758;
        Mon, 29 Aug 2022 06:46:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 129so279478pga.1;
        Mon, 29 Aug 2022 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=w68yDXtvLDmv8QaYlHvGPK5BovUxSuSy6DRLVDA2dBw=;
        b=gDUTk+tYQ1AMcKT0x4n6+UDWPcIJPCouEkXjUlQkPDsRjb/AgNtIASE8LogIja/6ZU
         0QV+/z/1+slxIwUJIqqSVeGzmU0NYRYAfdZgb0TfL0geUjwEnKz2qUSZDA+DiyWif1WZ
         EC1UAgL98COmLpjPBn1oiqOrqQ7MgNPamHZ0Uv2FwdhJ3FYHW290JzdbgX9+D0VI0TEy
         pCZDo7obDJ6TuyEqHjUXE+31oKO1SVh5YrmjJEgRJWIvhSoR10zGp3ymLIX8/buKUL0G
         O/5uhzlAcajfu58cRj4PGcgd2g+GHVySDTMlzI5qmT48X6VUDzSioHqTiSYcKN3CbUe6
         LM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=w68yDXtvLDmv8QaYlHvGPK5BovUxSuSy6DRLVDA2dBw=;
        b=YtyitcW3G1MrgBW4M8SZTgmPyA8y1cfjkBYotvA7Ua8jKssq52W9xnGYcEMGjDkLk8
         wbFC5k4H8lsTinfqD+LyX/ia8/DT9mA0JsSprUqj1wNj4kL8BK3uea4Wews04xGH5vXO
         w0gqCp0wbdQXEfHME0qznTC6i85dZcWZbc+FBRh+ACfJtMDOQFg+/yTt/AGFUFS2iA+u
         wv2S6veGhsbTsAXBdygw9Cwn8I46UxlSYlb9Y6Muc3nvSfXNKESgh5US9NIXTdEqaoxU
         EoW/Dw/fFOy2pry8pIsDbLhAVFU9ZNO61COn7E/JoMhV/QvXv+WXyKzsZzug8+HtgFnQ
         iiSQ==
X-Gm-Message-State: ACgBeo0n+sM5JdKR3K/l1WUZ4sVZAlyg+HiuT2a6C+1sjRFOlLEzvqI2
        E79svfmNcbzquSgIuw47bJo=
X-Google-Smtp-Source: AA6agR70f9Z3tl/5CZjyocOfA46aT/DftP6rJx/Lq9d9rsFY/Ye6z6tW/8kt7qDntaGS9OwGHfD6qw==
X-Received: by 2002:a63:2fc1:0:b0:42a:9680:bd9b with SMTP id v184-20020a632fc1000000b0042a9680bd9bmr14258494pgv.133.1661780768643;
        Mon, 29 Aug 2022 06:46:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 185-20020a6205c2000000b005383988ec0fsm2389071pff.162.2022.08.29.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:46:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:46:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (gpio-fan) Fix array out of bounds access
Message-ID: <20220829134606.GA4065514@roeck-us.net>
References: <20220823181742.5793-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823181742.5793-1-W_Armin@gmx.de>
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

On Tue, Aug 23, 2022 at 08:17:42PM +0200, Armin Wolf wrote:
> When set_fan_speed() is called with speed_index being
> greater than num_speed or less than 0, an array out of bounds
> access occurs. This can be exploited by setting the state of
> the thermal cooling device to arbitrary values, causing for example
> a kernel oops when unavailable memory is accessed this way.
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
> Fix this by checking speed_index and return if it is out of bounds.
> 
> Tested on a Raspberry Pi 3.
> 
> Fixes: d6fe1360f42e ("hwmon: add generic GPIO fan driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/gpio-fan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index befe989ca7b9..1d6facee44e0 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -128,6 +128,9 @@ static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
>  /* Must be called with fan_data->lock held, except during initialization. */
>  static void set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
>  {
> +	if (speed_index >= fan_data->num_speed || speed_index < 0)
> +		return;
> +

This is the wrong place to check the range. The range check should be
in gpio_fan_set_cur_state(), and it should return -EINVAL to the caller
if it fails. Note that the value can never be < 0.

Thanks,
Guenter

>  	if (fan_data->speed_index == speed_index)
>  		return;
