Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304655770F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiFWJrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiFWJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:47:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D915249C87
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:47:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D30812FC;
        Thu, 23 Jun 2022 02:47:00 -0700 (PDT)
Received: from [10.57.84.86] (unknown [10.57.84.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77A373F93E;
        Thu, 23 Jun 2022 02:46:47 -0700 (PDT)
Message-ID: <17600de3-b295-ebdf-b9fa-323d2bc3cb93@arm.com>
Date:   Thu, 23 Jun 2022 10:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4] coresight: etm4x: avoid build failure with unrolled
 loops
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220614220229.1640085-1-ndesaulniers@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220614220229.1640085-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick

Thanks for resending the patch. Unfortunately, this one still doesn't
address my comments in the v3 [0].


On 14/06/2022 23:02, Nick Desaulniers wrote:
> When the following configs are enabled:
> * CORESIGHT
> * CORESIGHT_SOURCE_ETM4X
> * UBSAN
> * UBSAN_TRAP
> 
> Clang fails assemble the kernel with the error:
> <instantiation>:1:7: error: expected constant expression in '.inst' directive
> .inst (0xd5200000|((((2) << 19) | ((1) << 16) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 7) & 0x7)) << 12) | ((((((((((0x160 + (i * 4))))) >> 2))) & 0xf)) << 8) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 4) & 0x7)) << 5)))|(.L__reg_num_x8))
>        ^
> drivers/hwtracing/coresight/coresight-etm4x-core.c:702:4: note: while in macro instantiation
>                          etm4x_relaxed_read32(csa, TRCCNTVRn(i));
>                          ^
> drivers/hwtracing/coresight/coresight-etm4x.h:403:4: note: expanded from macro 'etm4x_relaxed_read32'
>                   read_etm4x_sysreg_offset((offset), false)))
>                   ^
> drivers/hwtracing/coresight/coresight-etm4x.h:383:12: note: expanded from macro 'read_etm4x_sysreg_offset'
>                          __val = read_etm4x_sysreg_const_offset((offset));       \
>                                  ^
> drivers/hwtracing/coresight/coresight-etm4x.h:149:2: note: expanded from macro 'read_etm4x_sysreg_const_offset'
>          READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
>          ^
> drivers/hwtracing/coresight/coresight-etm4x.h:144:2: note: expanded from macro 'READ_ETM4x_REG'
>          read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
>          ^
> arch/arm64/include/asm/sysreg.h:1108:15: note: expanded from macro 'read_sysreg_s'
>          asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
>                       ^
> arch/arm64/include/asm/sysreg.h:1074:2: note: expanded from macro '__mrs_s'
> "       mrs_s " v ", " __stringify(r) "\n"                      \
>   ^
> 
> Consider the definitions of TRCSSCSRn and TRCCNTVRn:
> drivers/hwtracing/coresight/coresight-etm4x.h:56
>   #define TRCCNTVRn(n)      (0x160 + (n * 4))
> drivers/hwtracing/coresight/coresight-etm4x.h:81
>   #define TRCSSCSRn(n)      (0x2A0 + (n * 4))
> 
> Where the macro parameter is expanded to i; a loop induction variable
> from etm4_disable_hw.
> 
> When any compiler can determine that loops may be unrolled, then the
> __builtin_constant_p check in read_etm4x_sysreg_offset() defined in
> drivers/hwtracing/coresight/coresight-etm4x.h may evaluate to true. This
> can lead to the expression `(0x160 + (i * 4))` being passed to
> read_etm4x_sysreg_const_offset. Via the trace above, this is passed
> through READ_ETM4x_REG, read_sysreg_s, and finally to __mrs_s where it
> is string-ified and used directly in inline asm.
> 
> Regardless of compiler or compiler options determine whether a loop can
> or can't be unrolled, which determines whether __builtin_constant_p
> evaluates to true when passed an expression using a loop induction
> variable, it is NEVER safe to allow the preprocessor to construction
> inline asm like:
>    asm volatile (".inst (0x160 + (i * 4))" : "=r"(__val));
>                                   ^ expected constant expression
> 
> Replace unsafe uses of calls to etm4x_relaxed_read32 with
> csdev_access_read32 when the parameter is an expression that would be
> invalid inline asm so that it does not depend on the ability of the
> compiler to optimize __builtin_constant_p of the expression to true.
> Only when the second parameter of etm4x_relaxed_read32 expands to an
> expression dependent on a loop induction variable do we need to fix
> this.
> 
> This is not a bug in clang; it's a potentially unsafe use of the macro
> arguments in read_etm4x_sysreg_offset dependent on __builtin_constant_p.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1310
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Suggested-by: Tao Zhang <quic_taozha@quicinc.com>
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> V1 (Arnd):
> https://lore.kernel.org/lkml/20210225094324.3542511-1-arnd@kernel.org/
> 
> V2 (Arnd):
> https://lore.kernel.org/lkml/20210429145752.3218324-1-arnd@kernel.org/
> 
> V3 (Tao):
> https://lore.kernel.org/lkml/1632652550-26048-1-git-send-email-quic_taozha@quicinc.com/


Even with this patch applied, we have many more instances left
to convert. Please could you update the patch to convert all of these ?

$ grep "(i)"  coresight-etm4x* | grep -v csdev_
coresight-etm4x-core.c: * Check if TRCSSPCICRn(i) is implemented for a 
given instance.
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
config->seq_ctrl[i], TRCSEQEVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
config->cntrldvr[i], TRCCNTRLDVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
config->cntr_ctrl[i], TRCCNTCTLRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
config->cntr_val[i], TRCCNTVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
config->res_ctrl[i], TRCRSCTLRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
config->ss_ctrl[i], TRCSSCCRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
config->ss_status[i], TRCSSCSRn(i));
coresight-etm4x-core.c:                 etm4x_relaxed_write32(csa, 
config->ss_pe_cmp[i], TRCSSPCICRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
config->addr_val[i], TRCACVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
config->addr_acc[i], TRCACATRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
config->ctxid_pid[i], TRCCIDCVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
config->vmid_val[i], TRCVMIDCVRn(i));
coresight-etm4x-core.c:         state->trcseqevr[i] = etm4x_read32(csa, 
TRCSEQEVRn(i));
coresight-etm4x-core.c:         state->trccntrldvr[i] = 
etm4x_read32(csa, TRCCNTRLDVRn(i));
coresight-etm4x-core.c:         state->trccntctlr[i] = etm4x_read32(csa, 
TRCCNTCTLRn(i));
coresight-etm4x-core.c:         state->trccntvr[i] = etm4x_read32(csa, 
TRCCNTVRn(i));
coresight-etm4x-core.c:         state->trcrsctlr[i] = etm4x_read32(csa, 
TRCRSCTLRn(i));
coresight-etm4x-core.c:         state->trcssccr[i] = etm4x_read32(csa, 
TRCSSCCRn(i));
coresight-etm4x-core.c:         state->trcsscsr[i] = etm4x_read32(csa, 
TRCSSCSRn(i));
coresight-etm4x-core.c:                 state->trcsspcicr[i] = 
etm4x_read32(csa, TRCSSPCICRn(i));
coresight-etm4x-core.c:         state->trcacvr[i] = etm4x_read64(csa, 
TRCACVRn(i));
coresight-etm4x-core.c:         state->trcacatr[i] = etm4x_read64(csa, 
TRCACATRn(i));
coresight-etm4x-core.c:         state->trccidcvr[i] = etm4x_read64(csa, 
TRCCIDCVRn(i));
coresight-etm4x-core.c:         state->trcvmidcvr[i] = etm4x_read64(csa, 
TRCVMIDCVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
state->trcseqevr[i], TRCSEQEVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
state->trccntrldvr[i], TRCCNTRLDVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
state->trccntctlr[i], TRCCNTCTLRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
state->trccntvr[i], TRCCNTVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
state->trcrsctlr[i], TRCRSCTLRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
state->trcssccr[i], TRCSSCCRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write32(csa, 
state->trcsscsr[i], TRCSSCSRn(i));
coresight-etm4x-core.c:                 etm4x_relaxed_write32(csa, 
state->trcsspcicr[i], TRCSSPCICRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
state->trcacvr[i], TRCACVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
state->trcacatr[i], TRCACATRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
state->trccidcvr[i], TRCCIDCVRn(i));
coresight-etm4x-core.c:         etm4x_relaxed_write64(csa, 
state->trcvmidcvr[i], TRCVMIDCVRn(i));

[0] 
https://lore.kernel.org/lkml/48162555-2a67-60bc-ea4b-8720e7b98a22@arm.com/


Kind regards
Suzuki

> 
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 87299e99dabb..7c6bd85e36d4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -836,13 +836,13 @@ static void etm4_disable_hw(void *info)
>   	/* read the status of the single shot comparators */
>   	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
>   		config->ss_status[i] =
> -			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +			csdev_access_read32(csa, TRCSSCSRn(i));
>   	}
>   
>   	/* read back the current counter values */
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		config->cntr_val[i] =
> -			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> +			csdev_access_read32(csa, TRCCNTVRn(i));
>   	}
>   
>   	coresight_disclaim_device_unlocked(csdev);
> @@ -1177,7 +1177,7 @@ static void etm4_init_arch_data(void *info)
>   	drvdata->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
>   	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
>   		drvdata->config.ss_status[i] =
> -			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +			csdev_access_read32(csa, TRCSSCSRn(i));
>   	}
>   	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
>   	drvdata->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);

