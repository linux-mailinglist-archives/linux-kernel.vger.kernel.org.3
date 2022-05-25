Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E43534039
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbiEYPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245075AbiEYPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:17:30 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A5B0A6D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:17:29 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 520803F804
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653491847;
        bh=fsgCZw/xRNXiy6OJN4APf5lDTp10s7xR3Y+a1NWVZTo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YG2hOYBYE8xF+Kx3G7I/L6ia2jHSrp/S9L3ARxwAwppFtMahOy+LzYoD6dCv8BZwH
         Hlp4OLMPhv649Z0GEh1FD6ZxiVZOadlANrimdZNR4QFQII4l4WE7+r1lc0PJIkjfl+
         SHGHXucrc6SIXUpwjNa3v/FpBjlpMSB/QgyTXievUOyTatZom+5NLEM4txbo5LGZrV
         0s8C0oBmI9YAZ/nkZkX5+zd3DSVC9/SaH8E1xMfSH6o8qENJj4pZ6+QlFnzmklCPzj
         gykjwE/60YAG55qA4TIPoPeEhj22XJ44D1+KmTrHQAJ09TmAn0uxWwROViLbINL8BT
         yRehaVa8+oF8Q==
Received: by mail-ej1-f71.google.com with SMTP id ks1-20020a170906f84100b006fee53b22c2so4676077ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fsgCZw/xRNXiy6OJN4APf5lDTp10s7xR3Y+a1NWVZTo=;
        b=Xnr5A6rWT+gG2Dh3UzyS5jPPaY0TFdE9+UfQAHgqAymH9RaLr/tjeYmbalaFIyiMQl
         Lwl7eYugiu5LIFgE9o4VGMQP16tt93v9Bnm9tE2P9jcbnmZZ8kfzvtOLxqGkeTuC9We0
         WrAt6EAbbA5iF5Wgi5Yj9L7YJVejKfIF8a7hh4o4JdZsDQEYB6OWy5kjEEDgsVkSUHqW
         Gm2KA6UqVNktmRiiOvIzPTlcNxqbyR74uXV/CM13wq28y9niZkSu2V8GKr2L0DsKAm5Q
         WUIsIAf416rpzPDbrQYz8YlGvM3GcOwZ4EHtOiQanFNF27ialmzsxW7tZ+9jwRbz2d4o
         ygIw==
X-Gm-Message-State: AOAM5308tBPM5d1hUmnMz9vuXDiF9SGFSjX2NDf1HUzUXV4hBFWW4WFR
        b3d9ls2CH01oLMeaRelMcaQYlm3Ful9EEb2gPdqTRxtI9g0HNxLXaU7FdDwT3xl7cX9aCxBaUa0
        +iJbgfaWhTf61ufODmf0A1OVfyONjCoYC8v/z7Sz+uQ==
X-Received: by 2002:a17:906:5d10:b0:6f4:e263:b574 with SMTP id g16-20020a1709065d1000b006f4e263b574mr30507996ejt.435.1653491839756;
        Wed, 25 May 2022 08:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGEBbYA4ZthguX/6ezk6GsjZqOLHUOp5YalEv0cGTth685wa7GG2o5INcUqyTuzNjzdCdFVA==
X-Received: by 2002:a17:906:5d10:b0:6f4:e263:b574 with SMTP id g16-20020a1709065d1000b006f4e263b574mr30507981ejt.435.1653491839485;
        Wed, 25 May 2022 08:17:19 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id y16-20020a056402271000b0042b6a84b230sm4559765edd.90.2022.05.25.08.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 08:17:18 -0700 (PDT)
Message-ID: <09b050e3-b8e2-fc58-c4cf-e1c81c5eac84@canonical.com>
Date:   Wed, 25 May 2022 17:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/5] riscv: cpu_ops_sbi: Support for 64bit hartid
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-2-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220525151106.2176147-2-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 17:11, Sunil V L wrote:
> The hartid can be a 64bit value on RV64 platforms. This patch modifies
> the hartid variable type to unsigned long so that it can hold 64bit
> value on RV64 platforms.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   arch/riscv/kernel/cpu_ops_sbi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index 4f5a6f84e2a4..efa0f0816634 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -65,7 +65,7 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
>   static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
>   {
>   	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
> -	int hartid = cpuid_to_hartid_map(cpuid);
> +	unsigned long hartid = cpuid_to_hartid_map(cpuid);
>   	unsigned long hsm_data;
>   	struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
>   
> @@ -107,7 +107,7 @@ static void sbi_cpu_stop(void)
>   static int sbi_cpu_is_stopped(unsigned int cpuid)
>   {
>   	int rc;
> -	int hartid = cpuid_to_hartid_map(cpuid);
> +	unsigned long hartid = cpuid_to_hartid_map(cpuid);
>   
>   	rc = sbi_hsm_hart_get_status(hartid);
>   

