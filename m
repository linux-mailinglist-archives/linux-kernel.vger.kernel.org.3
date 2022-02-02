Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266BB4A6EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiBBKkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiBBKkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:40:08 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D7CC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:40:08 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s185so38892611oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 02:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vF/oZ6LB0YKplLBoyHRWWtR7m3qveEBq0KdCXmv2Tdc=;
        b=cwMRuj5+IcZmU9qUjtbaZdG/uvBiBGLAkTVFnE6KLC3iBhyxAAgB+EAfy0KnIGxs8j
         5Oy+3Yg5/yX/fg2Vas1sJoaMIRVXdjY6FHdPyL0Y1Dl+krI78ZcerDMIg8dHg+TigiDs
         7/v7wNh7ZOcmjRqw2utbYkWosXiX7v1ZSvszqC4HWf3o46XTixtL4yNoos+pdNub7ECT
         wG91GFKoR7W6JvnnlLF0ACuQU3ZdjzpNQhSVu8aB8Zw1BMcMKvq4NO6KIWMcq6Ue99eS
         poiR8MoZXnHiS3MR7KvFvRp0ua0G20VYcQgeFfeYKps6jiPIa91xKqYQ8E+Eeu7pukSG
         2qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vF/oZ6LB0YKplLBoyHRWWtR7m3qveEBq0KdCXmv2Tdc=;
        b=IVXljkpWzGBQqmGYr+vEtZvBMK26wWzK2Lkk0VREqieT3FbYZeSsehwm3s4X9OYSnu
         UMGyo6E+d7N9GFRUCSiUOTV1hKBC3fbScKKBRZyHj/AK9zOh4gesXk2eDeDYh2jJfaTj
         Z503bRxxtTC3/hlXu1kbh3wP20kjnXYmW5lxYDNZNckr6+LzCuBJ5a5akza3OdluGCgq
         4wAxexfsxmf97M547VVd9lExYdQFwVTulWIDdhev7gcZNvNzyw+bWp4/TI2R91MuQr26
         jVc7hlRVaO3wvuT70QEmc4zi5ktd0egoCajH0566FVxOREWEjy6/mkTJN0cAHmkV6Z/p
         FclA==
X-Gm-Message-State: AOAM5330fy25OoiTZixIxaXzY+0bMqougNpnQcPMM1pAbN+uJlRyITK8
        lulUzlnzHZyjhlpydMZeYHDx1g==
X-Google-Smtp-Source: ABdhPJyF95jbDN/hf/M9NTL0kYDs4xzfY1R92JIb1GZnM6R7QKzcg90NmSHgWR3Nsn9K1aAJYHFTYA==
X-Received: by 2002:a05:6808:1154:: with SMTP id u20mr4000312oiu.169.1643798407473;
        Wed, 02 Feb 2022 02:40:07 -0800 (PST)
Received: from [192.168.11.51] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id 100sm10162293oth.75.2022.02.02.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 02:40:06 -0800 (PST)
Message-ID: <fb4d3615-23e3-f001-be85-eb80ab57f9e9@kali.org>
Date:   Wed, 2 Feb 2022 04:40:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] irqchip/gic-v3-its: Skip HP notifier when no ITS is
 registered
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20220202103454.2480465-1-maz@kernel.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220202103454.2480465-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/22 4:34 AM, Marc Zyngier wrote:
> We have some systems out there that have both LPI support and an
> ITS, but that don't expose the ITS in their firmware tables
> (either because it is broken or because they run under a hypervisor
> that hides it...).
>
> Is such a configuration, we still register the HP notifier to free
> the allocated tables if needed, resulting in a warning as there is
> no memory to free (nothing was allocated the first place).
>
> Fix it by keying the HP notifier on the presence of at least one
> sucessfully probed ITS.
>
> Fixes: d23bc2bc1d63 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9e93ff2b6375..cd772973114a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5517,6 +5517,9 @@ int __init its_lpi_memreserve_init(void)
>   	if (!efi_enabled(EFI_CONFIG_TABLES))
>   		return 0;
>   
> +	if (list_empty(&its_nodes))
> +		return 0;
> +
>   	gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
>   	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>   				  "irqchip/arm/gicv3/memreserve:online",

Tested on the Lenovo Yoga C630

Tested-by: Steev Klimaszewski <steev@kali.org>

