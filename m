Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7F58DA46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiHIO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiHIO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:27:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D39F1158;
        Tue,  9 Aug 2022 07:27:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso17828505pjo.1;
        Tue, 09 Aug 2022 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=myMQ29sXeNGKfu1ttSzZslTbpCbGObPjlnHZzAdiED8=;
        b=cU73e2KlV0JWEPg3mppjZ+VZxAKDCNNYI2zb+JrdlR+JhoMO7kNZcbr/wkCEESST6d
         wZLKZcoyY9af/ed/PeV6JWenH3PW1Uz3Orx62/A+JrcSG69OWN6QX7UdSQXo8hItF7kB
         lQuWyZFRVt1n2MO7LD5GJhTzGcxpQYvTug9MYJ25IZEZW8pAHu3eJ5hSOfYYSGZPfKUb
         kNK68jShgbFFzNcNphd9Uixn/A5P374+GdUhaRiF6q5048BX06FEbY+rOWyoAWk6SIlX
         ppkGYMWcf8knOax+10kvzD3u5JnqzMCIf1WduThj7HEfQ8jEkRerobOooXHzxoKMdgwc
         DT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=myMQ29sXeNGKfu1ttSzZslTbpCbGObPjlnHZzAdiED8=;
        b=3KrkwzvupiJPNjccStjSlU/AU78cqUV0TvwJK2KsJcOoyHRi5/UboPbKVNFfEtUQ1p
         EqOl+lztdSDPy23UPYkO7mVydNWwEPcZQ/7oXLDiRzPnsDJ+8K9wCkcKScpNQ0vCyFf9
         0ZWc9oT8ZAB0a0wj0tGCvaWVAoKqsz9gTjSmCFsKuS8AReYQsJz+My0vjsi4JwgcFYVe
         1BN+vLVEFTiDyOB5EdOh2K3HWTCuu4PQxmfMI+iLFWmQ0E+WNDQq2pm5yF6zSYLY14aN
         VPW+dQlr2g4JerTTv8IzFejpptKTDZ9KjISCMtC8aLxDWqPzXCXauOqubNSjZ8D9t+M7
         Xb7w==
X-Gm-Message-State: ACgBeo3LKJzv51NO2qN5XrrqqQrV/trYDNwDRVbrpABIb7b3oNg3S1CA
        qeZ1MWBjSed4dci1jbMrJq0=
X-Google-Smtp-Source: AA6agR44VQ5PFlBtPXP2ee1qx/ZX0GXCbz5xd/x+6bwqyP8nG8bzxTC1P0Zc7WdKEx9U8kduE03spA==
X-Received: by 2002:a17:90b:17c8:b0:1f5:31c:4d93 with SMTP id me8-20020a17090b17c800b001f5031c4d93mr35537148pjb.53.1660055221613;
        Tue, 09 Aug 2022 07:27:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090a6a4a00b001f021cdd73dsm12650487pjm.10.2022.08.09.07.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:27:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <158a15a8-8a70-abfc-fc69-c99e4a15861e@roeck-us.net>
Date:   Tue, 9 Aug 2022 07:26:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] thermal/of: Fix free after use in
 thermal_of_unregister()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220809085629.509116-1-daniel.lezcano@linaro.org>
 <20220809085629.509116-4-daniel.lezcano@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220809085629.509116-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 01:56, Daniel Lezcano wrote:
> The thermal zone is freed after being unregistered. The release method
> devm_thermal_zone_device_register() calls
>    -> thermal_of_zone_device_unregister()
> 
> This one calls thermal_zone_device_unregister() which frees the
> thermal zone. However, thermal_of_zone_device_unregister() does access
> this freed pointer to free different resources allocated by the
> thermal_of framework which is invalid.
> 
> It results in a kernel panic:
> 
> [    1.915140] thermal_sys: Failed to find thermal zone for tmu id=2
> [    1.921279] qoriq_thermal 1f80000.tmu: Failed to register sensors
> [    1.927395] qoriq_thermal: probe of 1f80000.tmu failed with error -22
> [    1.934189] Unable to handle kernel paging request at virtual address 01adadadadadad88
> [    1.942146] Mem abort info:
> [    1.944948]   ESR = 0x0000000096000004
> [    1.948708]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.954042]   SET = 0, FnV = 0
> [    1.957107]   EA = 0, S1PTW = 0
> [    1.960253]   FSC = 0x04: level 0 translation fault
> [    1.965147] Data abort info:
> [    1.968030]   ISV = 0, ISS = 0x00000004
> [    1.971878]   CM = 0, WnR = 0
> [    1.974852] [01adadadadadad88] address between user and kernel address ranges
> [    1.982016] Internal error: Oops: 96000004 [#1] SMP
> [    1.986907] Modules linked in:
> [    1.989969] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-next-20220808-00080-g1c46f44502e0 #1697
> [    1.999135] Hardware name: Kontron KBox A-230-LS (DT)
> [    2.004199] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.011185] pc : kfree+0x5c/0x3c0
> [    2.014516] lr : devm_thermal_of_zone_release+0x38/0x60
> [    2.019761] sp : ffff80000a22bad0
> [    2.023081] x29: ffff80000a22bad0 x28: 0000000000000000 x27: ffff800009960464
> [    2.030245] x26: ffff800009a16960 x25: 0000000000000006 x24: ffff800009f09a40
> [    2.037407] x23: ffff800009ab9008 x22: ffff800008d0eea8 x21: 01adadadadadad80
> [    2.044569] x20: 6b6b6b6b6b6b6b6b x19: ffff00200232b800 x18: 00000000fffffffb
> [    2.051731] x17: ffff800008d0eea0 x16: ffff800008d07d44 x15: ffff800008d0d154
> [    2.056647] usb 1-1: new high-speed USB device number 2 using xhci-hcd
> [    2.058893] x14: ffff800008d0cddc x13: ffff8000088d1c2c x12: ffff8000088d5034
> [    2.072597] x11: ffff8000088d46d4 x10: 0000000000000000 x9 : ffff800008d0eea8
> [    2.079759] x8 : ffff002000b1a158 x7 : bbbbbbbbbbbbbbbb x6 : ffff80000a0f53b8
> [    2.086921] x5 : ffff80000a22b960 x4 : 0000000000000000 x3 : 0000000000000000
> [    2.094082] x2 : fffffc0000000000 x1 : ffff002000838040 x0 : 01adb1adadadad80
> [    2.101244] Call trace:
> [    2.103692]  kfree+0x5c/0x3c0
> [    2.106666]  devm_thermal_of_zone_release+0x38/0x60
> [    2.111561]  release_nodes+0x64/0xd0
> [    2.115146]  devres_release_all+0xbc/0x350
> [    2.119253]  device_unbind_cleanup+0x20/0x70
> [    2.123536]  really_probe+0x1a0/0x2e4
> [    2.127208]  __driver_probe_device+0x80/0xec
> [    2.131490]  driver_probe_device+0x44/0x130
> [    2.135685]  __driver_attach+0x104/0x1b4
> [    2.139619]  bus_for_each_dev+0x7c/0xe0
> [    2.143465]  driver_attach+0x30/0x40
> [    2.147048]  bus_add_driver+0x160/0x210
> [    2.150894]  driver_register+0x84/0x140
> [    2.154741]  __platform_driver_register+0x34/0x40
> [    2.159461]  qoriq_tmu_init+0x28/0x34
> [    2.163133]  do_one_initcall+0x50/0x250
> [    2.166979]  kernel_init_freeable+0x278/0x31c
> [    2.171349]  kernel_init+0x30/0x140
> [    2.174847]  ret_from_fork+0x10/0x20
> [    2.178433] Code: b25657e2 d34cfc00 d37ae400 8b020015 (f94006a1)
> [    2.184546] ---[ end trace 0000000000000000 ]---
> 
> Store the allocated resource pointers before the thermal zone is free
> and use them to release the resource after unregistering the thermal
> zone.
> 
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Tested-by: Michael Walle <michael@walle.cc>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/thermal/thermal_of.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 3effc729be4b..fd2fb84bf246 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -596,11 +596,15 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
>    */
>   void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>   {
> +	struct thermal_trip *trips = tz->trips;
> +	struct thermal_zone_params *tzp = tz->tzp;
> +	struct thermal_zone_device_ops *ops = tz->ops;
> +
>   	thermal_zone_device_disable(tz);
>   	thermal_zone_device_unregister(tz);
> -	kfree(tz->trips);
> -	kfree(tz->tzp);
> -	kfree(tz->ops);
> +	kfree(trips);
> +	kfree(tzp);
> +	kfree(ops);
>   }
>   EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
>   

