Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD9596489
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiHPVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbiHPVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:21:10 -0400
Received: from qproxy2-pub.mail.unifiedlayer.com (qproxy2-pub.mail.unifiedlayer.com [69.89.16.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53608A7F2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:21:07 -0700 (PDT)
Received: from outbound-ss-820.bluehost.com (outbound-ss-820.bluehost.com [69.89.24.241])
        by qproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id C93B58029D61
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:20:57 +0000 (UTC)
Received: from cmgw10.mail.unifiedlayer.com (unknown [10.0.90.125])
        by progateway2.mail.pro1.eigbox.com (Postfix) with ESMTP id 1E5881004BD9D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:20:33 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id O3zEosB9QCokGO3zEot57R; Tue, 16 Aug 2022 21:20:33 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=c8Nu/Txl c=1 sm=1 tr=0 ts=62fc0a21
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=biHskzXt2R4A:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=bDdBU3oEAAAA:8
 a=HaFmDPmJAAAA:8 a=T7ODj6HJyk-ComGlyZUA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=DN7SgORnOiO7RqxRx1GC:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jeclmRAL0j6fGiaGY2XnGlRAGRDJKW/HlIMVUeS3rEE=; b=HhVw7W/i4xFKumZCdDvb90P6Q0
        3DEFpXvaxfEtjAD+VecstX9GmTv5VKwkJnvmqLwjDUnbXWXl5Uv1QDv15JjcL0ZgWbX3WGHcNXX4e
        Jq9WqN8xMJSCuI7djdqw7Z5dngUlpPfhoTwbzq1tpqvGB4kYBpwpp0osF2oWFqpJ4tXZxjB7+feJ0
        Crus627FKk+yr+hCfjs04Ow/pmAj28GeAXg7OSNFhPgUU4sx9kalCSVgPQnRb/Dp5lrcGZlqAbV0J
        rgU1UksWccuB1g1USlDxZYbC2gogG2ZFoEW0Z9NRNpxzdGCXHU1iAWTmvXoisA408z7M4Iou6bf5E
        xfi2pyfw==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:40324 helo=[10.0.1.48])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1oO3zE-004Id9-5c;
        Tue, 16 Aug 2022 15:20:32 -0600
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
To:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daolu@rivosinc.com,
        jszhang@kernel.org, palmer@dabbelt.com, Conor.Dooley@microchip.com,
        Anup Patel <apatel@ventanamicro.com>
References: <20220816163058.3004536-1-ajones@ventanamicro.com>
From:   Ron Economos <re@w6rz.net>
In-Reply-To: <20220816163058.3004536-1-ajones@ventanamicro.com>
Message-ID: <0edc2f30-5662-392f-77a0-bd93379df724@w6rz.net>
Date:   Tue, 16 Aug 2022 14:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1oO3zE-004Id9-5c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.48]) [73.162.232.9]:40324
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 9:30 AM, Andrew Jones wrote:
> riscv_isa_ext_keys[] is an array of static keys used in the unified
> ISA extension framework. The keys added to this array may be used
> anywhere, including in modules. Ensure the keys remain writable by
> placing them in the data section.
>
> The need to change riscv_isa_ext_keys[]'s section was found when the
> kvm module started failing to load. Commit 8eb060e10185 ("arch/riscv:
> add Zihintpause support") adds a static branch check for a newly
> added isa-ext key to cpu_relax(), which kvm uses.
>
> Fixes: c360cbec3511 ("riscv: introduce unified static key mechanism for ISA extensions")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kernel/cpufeature.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 553d755483ed..3b5583db9d80 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -28,7 +28,7 @@ unsigned long elf_hwcap __read_mostly;
>   /* Host ISA bitmap */
>   static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>   
> -__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> +DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
>   EXPORT_SYMBOL(riscv_isa_ext_keys);
>   
>   /**

Works good on HiFive Unmatched.

Tested-by: Ron Economos <re@w6rz.net>

