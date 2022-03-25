Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE34E7E11
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiCYUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiCYUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC817E1D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E68F861D61
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0282C004DD;
        Fri, 25 Mar 2022 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648241191;
        bh=LQFKt10LSmaGE3MEo4zcNZRff2M+N1aNeUHBztWpOKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQR4hHILpnUkhfu7+xcMiRIk0v6yjyvIksOfM5LPSTaUIq8cNLk0oV//EXe/qB4TA
         wb6Xx6B86gAcULNcU2IBwbfuhjAyTB7Mqxmu/jC1WIUVC69FLplcSGiCgEkUrF5sHC
         Vz/3RusidENiid01E61425EVB8K4qKlLLgEfFkyQ=
Date:   Fri, 25 Mar 2022 13:46:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 1/4] stacktrace: add interface based on shadow call
 stack
Message-Id: <20220325134629.99699c921bb8c8db413e8e35@linux-foundation.org>
In-Reply-To: <21e3e20ea58e242e3c82c19abbfe65b579e0e4b8.1648049113.git.andreyknvl@google.com>
References: <cover.1648049113.git.andreyknvl@google.com>
        <21e3e20ea58e242e3c82c19abbfe65b579e0e4b8.1648049113.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 16:32:52 +0100 andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a new interface stack_trace_save_shadow() for collecting stack traces
> by copying frames from the Shadow Call Stack.
> 
> Collecting stack traces this way is significantly faster: boot time
> of a defconfig build with KASAN enabled gets descreased by ~30%.
> 
> The few patches following this one add an implementation of
> stack_trace_save_shadow() for arm64.
> 
> The implementation of the added interface is not meant to use
> stack_trace_consume_fn to avoid making a function call for each
> collected frame to further improve performance.
> 
> ...
>
> @@ -108,4 +111,16 @@ static inline int stack_trace_save_tsk_reliable(struct task_struct *tsk,
>  }
>  #endif
>  
> +#if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_SHADOW_STACKTRACE)
> +int stack_trace_save_shadow(unsigned long *store, unsigned int size,
> +			    unsigned int skipnr);
> +#else
> +static inline int stack_trace_save_shadow(unsigned long *store,
> +					  unsigned int size,
> +					  unsigned int skipnr)
> +{
> +	return -ENOSYS;
> +}
> +#endif

checkpatch sayeth "WARNING: ENOSYS means 'invalid syscall nr' and
nothing else".

checkpatch also picked up a typo in a changelog.  Useful thing to run,
is checkpatch.


