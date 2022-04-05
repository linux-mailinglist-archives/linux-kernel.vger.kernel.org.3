Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128AB4F48AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383934AbiDEVqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457744AbiDEQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:38:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C295D4C84
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:36:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649176614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPEm072E8FKkKXf7xYeG5Rr06A0qV3ZtKJkAJTFl2us=;
        b=3XBImYBOM467XP0kbv6mEhGJH9yCiVcCoJfXXYMexLgp+09PEf3G5eRgfXEjGizbfY32li
        q6Aloaa5xst6kaWm5GtIRE09YN/xUipA1gYkJX2Tcv7SfSMwp7jeb/DD3QG5ufx4uJXVW4
        dNI31rW0IipHqyvR9vNIWyCVYK7zn8BdYHwZ9cfH11WncF4vBt471/ztTReir7T14SMBkz
        Wa2d8uX2PERiZFubN+rP7NuDNQOnaeUboGpzC59ZmLWnzUPsFmNayQC1run6FRSg0xInN+
        ++XFDB4T3SZ7bpCgBG8bt7NQixPE6hv1PWoDEgNe/BIBXICNhjN2uKQx/pwIpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649176614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPEm072E8FKkKXf7xYeG5Rr06A0qV3ZtKJkAJTFl2us=;
        b=VA4Z9W9LDNsjaTBzCefRUHmN/VkusECn5JukLM4m3q1lGIhpV/RudqrrPe9DEdIb54jgPm
        Zm1RDhYOsNdYt2Aw==
To:     Alexey Dobriyan <adobriyan@gmail.com>, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH 1/5] x86/alternative: simplify DUMP_BYTES macro
In-Reply-To: <20220311144312.88466-1-adobriyan@gmail.com>
References: <20220311144312.88466-1-adobriyan@gmail.com>
Date:   Tue, 05 Apr 2022 18:36:53 +0200
Message-ID: <87v8vn1o7u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11 2022 at 17:43, Alexey Dobriyan wrote:
> Avoid zero length check with clever whitespace placement in the format
> string.
>
> Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
> ---
>  arch/x86/kernel/alternative.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 5007c3ffe96f..6c9758ee6810 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -66,13 +66,10 @@ do {									\
>  	if (unlikely(debug_alternative)) {				\
>  		int j;							\
>  									\
> -		if (!(len))						\
> -			break;						\
> -									\

How does that clever whitespace placement prevent this being printed in
the len == 0 case, which is a legit case?

>  		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\

This is debug muck. So why does it have to be "optimized"?

Thanks,

        tglx
