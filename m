Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725834C6429
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiB1H5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiB1H5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:57:33 -0500
Received: from mail.sysgo.com (mail.sysgo.com [IPv6:2a01:4f8:150:204a::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE03868FB5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:56:54 -0800 (PST)
Message-ID: <4d02e8f6-2809-110d-408d-b379f9c9390c@sysgo.com>
Date:   Mon, 28 Feb 2022 08:56:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: signal: nofpsimd: Do not allocate fp/simd context
 when not available
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, elver@google.com, ebiederm@xmission.com,
        seanjc@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220225104008.820289-1-david.engraf@sysgo.com>
 <YhkYbhxA8+IQxVcb@sirena.org.uk>
From:   David Engraf <david.engraf@sysgo.com>
In-Reply-To: <YhkYbhxA8+IQxVcb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.22 18:57, Mark Brown wrote:
> On Fri, Feb 25, 2022 at 11:40:08AM +0100, David Engraf wrote:
>> Commit 6d502b6ba1b2 ("arm64: signal: nofpsimd: Handle fp/simd context for
>> signal frames") introduced saving the fp/simd context for signal handling
>> only when support is available. But setup_sigframe_layout() always
>> reserves memory for fp/simd context. The additional memory is not touched
>> because preserve_fpsimd_context() is not called and thus the magic is
>> invalid.
>>
>> This may lead to an error when parse_user_sigframe() checks the fp/simd
>> area and does not find a valid magic number.
> 
> How did you spot this - do you have a system that can reproduce this?
> It'd be good to have coverage if there's testing but there's no easily
> obtainable userspace that I'm aware of.

I'm using a hypervisor which reports no fp/simd support. The user space 
was a busybox with init and shell. The shell gets a SIGSEGV because 
parse_user_sigframe() returns -EINVAL (bad magic).

user->sigframe in get_sigframe() uses the user stack pointer and the 
area was not zeroed. Thus the magic at fpsimd_offset is invalid.

Best regards
- David
