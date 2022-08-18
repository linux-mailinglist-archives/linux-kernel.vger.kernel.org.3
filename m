Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC912598099
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiHRJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHRJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:15:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05766A64;
        Thu, 18 Aug 2022 02:15:40 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7fJY3TlTzXdf3;
        Thu, 18 Aug 2022 17:11:25 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 17:15:38 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 17:15:37 +0800
Subject: Re: [PATCH v3 0/4] ARM: Convert to ARCH_STACKWALK
To:     <linux@armlinux.org.uk>
CC:     <mark.rutland@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>, <will@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>
References: <20220727040022.139387-1-lihuafei1@huawei.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <13e8c9ba-c5ec-a231-5493-3255e1ef9db8@huawei.com>
Date:   Thu, 18 Aug 2022 17:15:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20220727040022.139387-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/27 12:00, Li Huafei wrote:
> This series mainly updates the ARM stack trace code to use the newer and
> simpler arch_stack_walk() interface (see patches 3 and 4). Two issues
> were fixed before that (see patches 1 and 2).
> 
> v3:
>  - According to the discussion with Linus and Russell in v1:
>    - Add a comment about "regs[1]" in patch 2, and remove the
>      unnecessary ternary operator in the initialization of
>      "frame->ex_frame".
>    - Remove the patch "ARM: stacktrace: Allow stack trace saving for
>      non-current tasks", and keep the check for not being able to
>      unwind non-current tasks (including tasks running on other CPUs)
>      when CONFIG_SMP=y in patch 4.
>  - Rebase to linux-5.19-rc8.
> 
> v2: https://lore.kernel.org/lkml/20220713110020.85511-1-lihuafei1@huawei.com/
>  - As suggested by Mark, the commit logs for patch 4 and 5 were
>    refined for easy review.
> 
> v1: https://lore.kernel.org/lkml/20220712021527.109921-1-lihuafei1@huawei.com/
> 
> Li Huafei (4):
>   ARM: stacktrace: Skip frame pointer boundary check for
>     call_with_stack()
>   ARM: stacktrace: Avoid duplicate saving of exception PC value
>   ARM: stacktrace: Make stack walk callback consistent with generic code
>   ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK
> 
>  arch/arm/Kconfig                  |   1 +
>  arch/arm/include/asm/stacktrace.h |   8 +-
>  arch/arm/kernel/perf_callchain.c  |   9 +-
>  arch/arm/kernel/return_address.c  |   9 +-
>  arch/arm/kernel/stacktrace.c      | 191 ++++++++++++++----------------
>  arch/arm/lib/call_with_stack.S    |   2 +
>  6 files changed, 110 insertions(+), 110 deletions(-)
> 


Hi Russell，

Do you have any more comments on this patch set? Can you add this patch
set to your patch tracker? Thanks!

Thanks,
Huafei
