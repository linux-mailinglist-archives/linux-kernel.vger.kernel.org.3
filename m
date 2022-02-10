Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C9A4B17DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbiBJV6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:58:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiBJV6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:58:20 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA4EB37
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:58:19 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JvrGW3Gdmz1s767;
        Thu, 10 Feb 2022 22:58:11 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JvrGW04bKz1qqkB;
        Thu, 10 Feb 2022 22:58:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id P0Gm9oQZh0uW; Thu, 10 Feb 2022 22:58:09 +0100 (CET)
X-Auth-Info: K9Vgp8IFWJ4Z7781WVGKiz1IyIbMo3h9rBlVSRIGtFnKqw4w1utxrA8f7q6T64u9
Received: from igel.home (ppp-46-244-163-189.dynamic.mnet-online.de [46.244.163.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 10 Feb 2022 22:58:09 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 33DC02C3B35; Thu, 10 Feb 2022 22:58:09 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 5/6] RISC-V: Do no continue isa string parsing
 without correct XLEN
References: <20220210214018.55739-1-atishp@rivosinc.com>
        <20220210214018.55739-6-atishp@rivosinc.com>
X-Yow:  I don't believe there really IS a GAS SHORTAGE..  I think it's all
 just a BIG HOAX on the part of the plastic sign salesmen--
 ..  to sell more numbers!!
Date:   Thu, 10 Feb 2022 22:58:09 +0100
In-Reply-To: <20220210214018.55739-6-atishp@rivosinc.com> (Atish Patra's
        message of "Thu, 10 Feb 2022 13:40:17 -0800")
Message-ID: <877da2xu32.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10 2022, Atish Patra wrote:

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 469b9739faf7..cca579bae8a0 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -84,6 +84,7 @@ void __init riscv_fill_hwcap(void)
>  	for_each_of_cpu_node(node) {
>  		unsigned long this_hwcap = 0;
>  		uint64_t this_isa = 0;
> +		char *temp;
>  
>  		if (riscv_of_processor_hartid(node) < 0)
>  			continue;
> @@ -93,6 +94,7 @@ void __init riscv_fill_hwcap(void)
>  			continue;
>  		}
>  
> +		temp = (char *)isa;

There should be no need for this cast.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
