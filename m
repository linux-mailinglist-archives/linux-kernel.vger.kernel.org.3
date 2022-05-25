Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D6E533A62
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiEYKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:04:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBBA666BD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qVx2eszcHGVRUFr1EptNxO6lq1rDLY3MrUUGJsgKPsQ=; b=EN3N9JYRknKNENGt0RjkAqysC9
        i6uqZiWPWdq4qElg7zZVQc0aDfNAdOBS4hUsIHy5OOrrq49uYy0rF4QnHR2HujYiXLAGk0H3p0Xf4
        Z/lY9q23Y2DAHQ4FU3ySR3H8Xw+OsQoqs9oCic33V0kaKFIqORUZFersNURdjnnfCatBImkFDM5uw
        VqUQtIC7VzKos5eXgXw86nzSUDFPTPkVI1q8T2UxPBS6CcNgczCy9piE/l9k7+Lrgo8xk2t3NXkxK
        lQIVn3qBkK+RWor7fdFMH95VtApTPbWn+2OkZaKPqDfJsGg5Wq0LQSxcSzcvIhkvd7JIzaaOHI9zk
        lyDIV3eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntnru-001ZrW-DX; Wed, 25 May 2022 10:03:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34FFC3001DD;
        Wed, 25 May 2022 12:03:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D6B720767285; Wed, 25 May 2022 12:03:52 +0200 (CEST)
Date:   Wed, 25 May 2022 12:03:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Message-ID: <Yo3/CHaBb/0ULNML@hirez.programming.kicks-ass.net>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524185324.28395-4-bp@alien8.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:53:24PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Warn when done and taint the kernel.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index c717db6b6856..f7ded2facaa0 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -501,6 +501,8 @@ static int microcode_reload_late(void)
>  		microcode_check();
>  
>  	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
> +	pr_err("However, late loading is dangerous and it taints the kernel.\n"
> +	       "You should switch to early loading, if possible.\n");

Should we not warn *before* attempting the ucode update? Should the
whole thing come unstuck, you at least have some clue.
