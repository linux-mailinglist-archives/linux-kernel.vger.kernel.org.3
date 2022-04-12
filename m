Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D124FDE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiDLLaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352894AbiDLLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:25:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557C2C64C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D2RC4bAd0rEJWE1+T1i5AP8ZE6FR3hliXmVOSOJ2LTc=; b=CD0i7wH+RnmCly9CxoPdlqSwSz
        iSO9n/kio46c9MbyVHMBOOAl1ZCPfgdM30zh5PaBe7JRDGEK05h1wwrBZKfIvfJUkWeTX2dsMzpd3
        iEuiSg1pKi/lSWZ/Kp1RAzzPBwqNOwXVRuy1NuuV2FarxrDAXQRdxJjjG7vSSjnW5zWYdCjZsV4In
        b6qChRPRkvUmNJ+dEL8Uc41ZnIPkJlWAME/+HrqFG9Nos+OU9Rw3awQH9cPXtgbQ9KaAO58IrIhb5
        0P/E1rrb23udl7jr2h4QdR6DaP3SzPLrKyZBnVC32NQygiAt05vk+20BeLGikv9jRQzZjyDuu5/CM
        ae6F/arQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neDRt-004I1z-Nc; Tue, 12 Apr 2022 10:08:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56A67300212;
        Tue, 12 Apr 2022 12:08:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 377C02DB89DEA; Tue, 12 Apr 2022 12:08:37 +0200 (CEST)
Date:   Tue, 12 Apr 2022 12:08:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        kim.phillips@amd.com, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 1/2] x86/unwind/orc: recheck address range after stack
 info was updated
Message-ID: <YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:40:03AM +0300, Dmitry Monakhov wrote:
> get_stack_info() detects stack type only by begin address, so we must
> check that address range in question is fully covered by detected stack
> 
> Otherwise following crash is possible:
> -> unwind_next_frame
>    case ORC_TYPE_REGS:
>      if (!deref_stack_regs(state, sp, &state->ip, &state->sp))
>      -> deref_stack_regs
>        -> stack_access_ok  <- here addr is inside stack range, but addr+len-1 is not, but we still exit with success
>      *ip = READ_ONCE_NOCHECK(regs->ip); <- Here we hit stack guard fault
> OOPS LOG:
> <0>[ 1941.845743] BUG: stack guard page was hit at 000000000dd984a2 (stack is 00000000d1caafca..00000000613712f0)


> <4>[ 1941.845751]  get_perf_callchain+0x10d/0x280
> <4>[ 1941.845751]  perf_callchain+0x6e/0x80
> <4>[ 1941.845752]  perf_prepare_sample+0x87/0x540
> <4>[ 1941.845752]  perf_event_output_forward+0x31/0x90
> <4>[ 1941.845753]  __perf_event_overflow+0x5a/0xf0
> <4>[ 1941.845754]  perf_ibs_handle_irq+0x340/0x5b0
> <4>[ 1941.845757]  perf_ibs_nmi_handler+0x34/0x60
> <4>[ 1941.845757]  nmi_handle+0x79/0x190

Urgh, this is another instance of trying to unwind an IP that no longer
matches the stack.

Fixing the unwinder bug is good, but arguable we should also fix this
IBS stuff, see 6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
