Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07C55D61E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiF0Vok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiF0Voj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:44:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22E6825F4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:44:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F276A1758;
        Mon, 27 Jun 2022 14:44:37 -0700 (PDT)
Received: from [10.57.85.164] (unknown [10.57.85.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCFD33F792;
        Mon, 27 Jun 2022 14:44:35 -0700 (PDT)
Message-ID: <6b330119-fbf2-1c34-7ad3-0ae789658d22@arm.com>
Date:   Mon, 27 Jun 2022 22:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v5] coresight: etm4x: avoid build failure with unrolled
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
References: <17600de3-b295-ebdf-b9fa-323d2bc3cb93@arm.com>
 <20220623174131.3818333-1-ndesaulniers@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220623174131.3818333-1-ndesaulniers@google.com>
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

Hi Nick,

Thanks for the rework.

On 23/06/2022 18:41, Nick Desaulniers wrote:
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
> drivers/hwtracing/coresight/coresight-etm4x-core.c:702:4: note: while in
> macro instantiation
> etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> ^
> drivers/hwtracing/coresight/coresight-etm4x.h:403:4: note: expanded from
> macro 'etm4x_relaxed_read32'
> read_etm4x_sysreg_offset((offset), false)))
> ^
> drivers/hwtracing/coresight/coresight-etm4x.h:383:12: note: expanded
> from macro 'read_etm4x_sysreg_offset'
> __val = read_etm4x_sysreg_const_offset((offset));       \
>          ^
> drivers/hwtracing/coresight/coresight-etm4x.h:149:2: note: expanded from
> macro 'read_etm4x_sysreg_const_offset'
> READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
> ^
> drivers/hwtracing/coresight/coresight-etm4x.h:144:2: note: expanded from
> macro 'READ_ETM4x_REG'
> read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
> ^
> arch/arm64/include/asm/sysreg.h:1108:15: note: expanded from macro
> 'read_sysreg_s'
> asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
>               ^
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
> Regardless of which compiler or compiler options determine whether a
> loop can or can't be unrolled, which determines whether
> __builtin_constant_p evaluates to true when passed an expression using a
> loop induction variable, it is NEVER safe to allow the preprocessor to
> construct inline asm like:
>    asm volatile (".inst (0x160 + (i * 4))" : "=r"(__val));
>                                   ^ expected constant expression
> 
> Replace unsafe uses of calls to etm4x_relaxed_read32 with
> csdev_access_relaxed_read32 when the parameter is an expression that
> would be invalid inline asm so that it does not depend on the ability of
> the compiler to optimize __builtin_constant_p of the expression to true.
> Only when the second parameter of etm4x_relaxed_read32 expands to an
> expression dependent on a loop induction variable do we need to fix
> this.
> 
> For such cases where the induction variable is used in an expression,
> perform the following function call replacements:
> * etm4x_relaxed_write32 -> csdev_access_relaxed_write32
> * etm4x_relaxed_write64 -> csdev_access_relaxed_write64
> * etm4x_relaxed_read32 -> csdev_access_relaxed_read32
> * etm4x_read32 -> csdev_access_read32
> * etm4x_read64 -> csdev_access_read64
> 
> This is not a bug in clang; it's a potentially unsafe use of the macro
> arguments in read_etm4x_sysreg_offset dependent on __builtin_constant_p.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1310
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Suggested-by: Tao Zhang <quic_taozha@quicinc.com>
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
