Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE783519CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348062AbiEDKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiEDKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC1220ED
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4E361AC0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C3EC385A4;
        Wed,  4 May 2022 10:26:43 +0000 (UTC)
Date:   Wed, 4 May 2022 11:26:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 4/7] arm64: add copy_{to, from}_user to machine
 check safe
Message-ID: <YnJU4NIrJmHLawgk@arm.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-5-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420030418.3189040-5-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:04:15AM +0000, Tong Tiangen wrote:
> Add copy_{to, from}_user() to machine check safe.
> 
> If copy fail due to hardware memory error, only the relevant processes are
> affected, so killing the user process and isolate the user page with
> hardware memory errors is a more reasonable choice than kernel panic.

Just to make sure I understand - we can only recover if the fault is in
a user page. That is, for a copy_from_user(), we can only handle the
faults in the source address, not the destination.

> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 34e317907524..480cc5ac0a8d 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -25,7 +25,7 @@
>  	.endm
>  
>  	.macro strb1 reg, ptr, val
> -	strb \reg, [\ptr], \val
> +	USER_MC(9998f, strb \reg, [\ptr], \val)
>  	.endm

So if I got the above correctly, why do we need an exception table entry
for the store to the kernel address?

-- 
Catalin
