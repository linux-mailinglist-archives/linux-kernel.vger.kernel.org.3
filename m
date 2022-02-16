Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AB64B86FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiBPLq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:46:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiBPLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:46:24 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8176BBE15;
        Wed, 16 Feb 2022 03:46:11 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nKIl4-00076X-4g; Wed, 16 Feb 2022 12:46:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 5/6] RISC-V: Do no continue isa string parsing without correct XLEN
Date:   Wed, 16 Feb 2022 12:46:05 +0100
Message-ID: <3202369.D2aLoNIhS8@diego>
In-Reply-To: <20220216002911.1219593-6-atishp@rivosinc.com>
References: <20220216002911.1219593-1-atishp@rivosinc.com> <20220216002911.1219593-6-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Februar 2022, 01:29:10 CET schrieb Atish Patra:
> The isa string should begin with either rv64 or rv32. Otherwise, it is
> an incorrect isa string. Currently, the string parsing continues even if
> it doesnot begin with current XLEN.
> 
> Fix this by checking if it found "rv64" or "rv32" in the beginning.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 59c70c104256..cb9c9e0aab31 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -84,6 +84,7 @@ void __init riscv_fill_hwcap(void)
>  	for_each_of_cpu_node(node) {
>  		unsigned long this_hwcap = 0;
>  		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
> +		const char *temp;
>  
>  		if (riscv_of_processor_hartid(node) < 0)
>  			continue;
> @@ -93,6 +94,7 @@ void __init riscv_fill_hwcap(void)
>  			continue;
>  		}
>  
> +		temp = isa;
>  #if IS_ENABLED(CONFIG_32BIT)
>  		if (!strncmp(isa, "rv32", 4))
>  			isa += 4;
> @@ -100,6 +102,9 @@ void __init riscv_fill_hwcap(void)
>  		if (!strncmp(isa, "rv64", 4))
>  			isa += 4;
>  #endif
> +		/* The riscv,isa DT property must start with rv64 or rv32 */
> +		if (temp == isa)
> +			continue;

hmm, should (and can) this create some warning about the ignored
malformed ISA string?

Otherwise
Tested-by: Heiko Stuebner <heiko@sntech.de>

>  		bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
>  		for (; *isa; ++isa) {
>  			const char *ext = isa++;
> 




