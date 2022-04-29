Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667325148B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358821AbiD2MEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiD2MEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:04:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A5013D62
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gsyUpztCNYmZ96EpQWYmAz5WX7xwnKSKkquJpktJq7A=; b=Hsx5jjk00lixP/qXUD8gXzHFVk
        WaNixI94vnP836l6T5B5pyGwhaeSy4PRpWlT1p3MckQIimt2kyH2O40kz5CR0ljgiw0p9k0XdnB36
        aQ7sJFumPBjqwJxhUu7edL+OHJjYUXuSCnki4GZ2RGRazYxV6mhaVS30nUd53fH9C1DrI55tWmEqo
        MlNWi2mxN35w5Vao20yAI0pmK8O5JHL2m0c32AxBC8LPmS9a+x+7dh5e/dLE+YENBb7dn4W0a7uRt
        rvAI6nB+k7aGcVr3LM0CoIKlKmAwo3/NBo0v2q5WkV8K6hvhNAc/fXtPE2BPODr9Ra1YQpGJR19yx
        LtSAjSoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkPIk-009bTf-MO; Fri, 29 Apr 2022 12:00:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23149300385;
        Fri, 29 Apr 2022 14:00:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0673920295B20; Fri, 29 Apr 2022 14:00:45 +0200 (CEST)
Date:   Fri, 29 Apr 2022 14:00:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:20:24AM +0200, Peter Zijlstra wrote:
> 
> STACK_FRAME_NON_STANDARD results in inconsistent relocation types
> depending on .c or .S usage:
> 
>   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
>   Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>   0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
>   0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
>   0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
>   0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
>   0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0

So that weird .rodata entry is optprobe_template_func.

It being in .rodata also means it's not validated and there is no ORC
data generated, is that all intentional? The changelog for:

  877b145f0f47 ("x86/kprobes: Move trampoline code into RODATA")

doesn't really say anything useful about any of that :/

I also don't see any kprobe/optprobe hooks in unwind.h, so what happens
if we hit an optprobe?
