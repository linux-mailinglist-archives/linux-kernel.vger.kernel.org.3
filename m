Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D7500197
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiDMWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiDMWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:17:07 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166FE238;
        Wed, 13 Apr 2022 15:14:45 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bg9so3033686pgb.9;
        Wed, 13 Apr 2022 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U9y1xoKzi02K/KnzJqfCTRkpP8q7PpqYFALghM4TId8=;
        b=WHgwByVV1RUv7aJq7PxxHS5+DaJFT9PzTJaJhniYsvxQqLFqcPp2hDVz999kDd7vu3
         CjVbSt81zORisRmsW9gXahpb3c3ziXg9hHo663C43uN4/rPCbumAQke/1mm8xCNlo8lu
         3DvNKjJ2G0LK8A9qFz56QGlz47thjGOTnwsl+pbxODQNglbfXk+Y7oHy6b7/G819w1Dv
         wEIY0hgHpj2qc9LpHZANSjabckL/kEeU0IBgg09/UT1Er/307UGc8NliyD6VsBmYQB6S
         G8c2apc5K7csOHOcvKXSnjbmGRC2niOz20Kbq3ku/q1BudhYFOOmEzfCpOPFpI1aN7XX
         8/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U9y1xoKzi02K/KnzJqfCTRkpP8q7PpqYFALghM4TId8=;
        b=hvhvX5ND4bnCX19V3WN9ZioPO6jaJUds7eZol7zDm4+z+YoiwmkqfffpfvKiQtw0tv
         qhQHnqsmI9iVOSEgBcaRp0S7f/IeobwoObrXfWBAL4QU8nsv003cyyXjW1U0TFX6m4YC
         xPDdfufZ8+hyw4O4vOqfeabnrNXOOtZazwZRWUegQgjXm+sd3qj44gxGHeNl3lPXPDyO
         s3uWvKyJQboSUvRLn4gne/vu4oB8KbR8jOYoVr4UO4EZ0mDx12F5MXK6+kb+AQzNwnU7
         DcixhwvXbi08VwDBnyp4njCXkFc7bugQLL7k+RjjnWQsVzuGfvS+S2cmwk+La3GECd18
         HMVA==
X-Gm-Message-State: AOAM530RrukemibUUY0fV1dFTsjU7IaxT0oqBgPBJD8xHr/PVsChZoxR
        whfbXSSHDZRpEZzrl7eRqCE=
X-Google-Smtp-Source: ABdhPJyY1TsLoUDvb6KhWIvp7Qylv1Fv5V+fCqMHoC51LSRiMTMZvWW9nXh99rAA0KINjL5zhr4QqQ==
X-Received: by 2002:a05:6a00:248e:b0:506:1dce:fcba with SMTP id c14-20020a056a00248e00b005061dcefcbamr910301pfv.21.1649888084545;
        Wed, 13 Apr 2022 15:14:44 -0700 (PDT)
Received: from [172.30.1.44] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a68c500b001cb651fffdbsm4086194pjj.8.2022.04.13.15.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 15:14:44 -0700 (PDT)
Message-ID: <8824147c-5512-a7a5-9e89-60b510111500@gmail.com>
Date:   Thu, 14 Apr 2022 07:14:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during
 transitions
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220406014842.2771799-1-briannorris@chromium.org>
 <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 22. 4. 6. 10:48, Brian Norris wrote:
> See the previous patch ("soc: rockchip: power-domain: Manage resource
> conflicts with firmware") for a thorough explanation of the conflicts.
> While ARM Trusted Firmware may be modifying memory controller and
> power-domain states, we need to block the kernel's power-domain driver.
> 
> If the power-domain driver is disabled, there is no resource conflict
> and this becomes a no-op.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>   drivers/devfreq/rk3399_dmc.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index e494d1497d60..daff40702615 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -21,6 +21,7 @@
>   #include <linux/rwsem.h>
>   #include <linux/suspend.h>
>   
> +#include <soc/rockchip/pm_domains.h>
>   #include <soc/rockchip/rk3399_grf.h>
>   #include <soc/rockchip/rockchip_sip.h>
>   
> @@ -93,6 +94,16 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>   
>   	mutex_lock(&dmcfreq->lock);
>   
> +	/*
> +	 * Ensure power-domain transitions don't interfere with ARM Trusted
> +	 * Firmware power-domain idling.
> +	 */
> +	err = rockchip_pmu_block();
> +	if (err) {
> +		dev_err(dev, "Failed to block PMU: %d\n", err);
> +		goto out_unlock;
> +	}
> +
>   	/*
>   	 * Some idle parameters may be based on the DDR controller clock, which
>   	 * is half of the DDR frequency.
> @@ -198,6 +209,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>   	dmcfreq->volt = target_volt;
>   
>   out:
> +	rockchip_pmu_unblock();
> +out_unlock:
>   	mutex_unlock(&dmcfreq->lock);
>   	return err;
>   }

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
