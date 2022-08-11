Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B8558FA84
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiHKKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiHKKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:11:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C2A5A47B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:11:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD712106F;
        Thu, 11 Aug 2022 03:11:44 -0700 (PDT)
Received: from [10.57.86.55] (unknown [10.57.86.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F195F3F70D;
        Thu, 11 Aug 2022 03:11:42 -0700 (PDT)
Message-ID: <48524c3d-c858-15ec-ac79-9547f3489b7b@arm.com>
Date:   Thu, 11 Aug 2022 11:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] tools headers arm64: Fix compilation failure
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
References: <20220811044341.426796-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220811044341.426796-1-leo.yan@linaro.org>
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

Hi Leo

On 11/08/2022 05:43, Leo Yan wrote:
> When build perf tool on x86_64, it reports failure for finding the
> header <asm/sysreg.h>:
> 

Please could you mention the exact build options used for the perf
build ? (e.g, enable SPE)

>    In file included from util/arm-spe.c:37:
>    util/../../arch/arm64/include/asm/cputype.h:183:10: fatal error: asm/sysreg.h: No such file or directory
>      183 | #include <asm/sysreg.h>
>          |          ^~~~~~~~~~~~~~
>    compilation terminated.
>  > There have no sysreg.h in x86's asm folder, alternatively, this patch
> includes the sysreg.h header in the same folder with cputype.h to fix
> the compilation failure.

Wondering how the "cputype.h" was picked up from arch/arm64/include/ and
why not the sysreg.h ? Ideally, we would like to pickup the kernel
headers as it is without having to manually fixup, things like this.

> 
> Fixes: 37402d5d061b ("tools headers arm64: Sync arm64's cputype.h with the kernel sources")

Also from the above commit,

"That addresses this perf build warning:

       Warning: Kernel ABI header at 
'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 
'arch/arm64/include/asm/cputype.h'
       diff -u tools/arch/arm64/include/asm/cputype.h 
arch/arm64/include/asm/cputype.h
"

Wouldn't we re-introduce the warning back ?

Suzuki
