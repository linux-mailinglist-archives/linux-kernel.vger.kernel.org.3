Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB93E528473
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiEPMsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbiEPMsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B138BE4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h14so710777wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2emP0o2Jt7FbRySNCidIZURKJdhheIYK6xxEQgSB/+c=;
        b=FF8MBGabC1OTjVtSlzqUERFu9GkOOE8GzlCF6uY+tbZo5HZvGMZ7usLj40S5ouMMtl
         3qmHrikNsc8FaFr/q5ybLQgUXT0d4CLi576CtTz+neYkWmOFC5hEbdyaWa/LgDcSHQtW
         ghHCNWougnmWNi/JVNWGNainF0D4jt09jDnEPy6+SOfpFgtksYepAhrr1L5JdJuVXmpn
         lIs5K87TFVSvisb4KjB299zrYV84tkoJJYmGSe3i3XyI9B5yWHGwPLnl1ZaduJtSLPSS
         tCKjDUk2BBmYnSkjNg9Z//nAaQ1yN3NdHiZFWz0xBKpUc3l5yS6EtMGqw4XFC9FIBpix
         0gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2emP0o2Jt7FbRySNCidIZURKJdhheIYK6xxEQgSB/+c=;
        b=BhxIXqKomeiAbNp387VyEW5BEwF/422I9KiKvascY3B0Pehgy4b00BFTtd+ejRZ6CX
         GOHUQgOp7dpnMqBfN4hZPY2wVKeTKvl9K0rSHiTzGtpYQF7u2yDqNaTr6rAcu0TghNze
         DPqSb4lCplDxoz9prb2NezJVXhvh/+TkB0yQ7Cq/9n6TikVO039maZjKwSA+zPHBHRFm
         qbrjqUdMPCXE4+gVpLWgJpHV8tMEOFhDr3wgkt0Q9x9HOCWemTnhR+mX9J+R7G5mjiuF
         kwqRUbP3IqIYZTnQWQvIa9CbfDW65YfLMIGQdszuNkPJB9jg2F/HtVNx/wF1fOok37lo
         v+RQ==
X-Gm-Message-State: AOAM530MgsYA7b29eE8KK2EkazE9p2sgLDJ4WVeqnJ0NA/ETIuKKEvPs
        Wk8tFxxtooXtlX5IJFC4KD3SRg==
X-Google-Smtp-Source: ABdhPJzGnZylZxNFjLHsyNSQjMM0vFq/pqOBHD613P+R/DQTEbtQIQ4qXWDIluB0FBk/5i0UlafO7w==
X-Received: by 2002:a05:6000:2c2:b0:20c:c6e1:e881 with SMTP id o2-20020a05600002c200b0020cc6e1e881mr13981371wry.333.1652705298776;
        Mon, 16 May 2022 05:48:18 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:b464:e524:6a1d:33d0? ([2a01:e34:ed2f:f020:b464:e524:6a1d:33d0])
        by smtp.googlemail.com with ESMTPSA id z10-20020a7bc7ca000000b003942a244ee7sm9913913wmk.44.2022.05.16.05.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 05:48:18 -0700 (PDT)
Message-ID: <c80f78d9-f846-82af-2151-14423c9bac22@linaro.org>
Date:   Mon, 16 May 2022 14:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] thermal: core: fix memory leak in
 __thermal_cooling_device_register()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20220511020605.3096734-1-yangyingliang@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220511020605.3096734-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 04:06, Yang Yingliang wrote:
> I got memory leak as follows when doing fault injection test:
> 
> unreferenced object 0xffff888010080000 (size 264312):
>    comm "182", pid 102533, jiffies 4296434960 (age 10.100s)
>    hex dump (first 32 bytes):
>      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>      ff ff ff ff ff ff ff ff 40 7f 1f b9 ff ff ff ff  ........@.......
>    backtrace:
>      [<0000000038b2f4fc>] kmalloc_order_trace+0x1d/0x110 mm/slab_common.c:969
>      [<00000000ebcb8da5>] __kmalloc+0x373/0x420 include/linux/slab.h:510
>      [<0000000084137f13>] thermal_cooling_device_setup_sysfs+0x15d/0x2d0 include/linux/slab.h:586
>      [<00000000352b8755>] __thermal_cooling_device_register+0x332/0xa60 drivers/thermal/thermal_core.c:927
>      [<00000000fb9f331b>] devm_thermal_of_cooling_device_register+0x6b/0xf0 drivers/thermal/thermal_core.c:1041
>      [<000000009b8012d2>] max6650_probe.cold+0x557/0x6aa drivers/hwmon/max6650.c:211
>      [<00000000da0b7e04>] i2c_device_probe+0x472/0xac0 drivers/i2c/i2c-core-base.c:561
> 
> If device_register() fails, thermal_cooling_device_destroy_sysfs() need be called
> to free the memory allocated in thermal_cooling_device_setup_sysfs().
> 
> Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/thermal/thermal_core.c | 1 +
>   1 file changed, 1 insertion(+)

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
