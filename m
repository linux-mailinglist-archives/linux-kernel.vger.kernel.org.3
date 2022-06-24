Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55582559401
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiFXHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:17:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570B50B0E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0MjBNXqwwGDkVecLauwz1kkXNtGYgBPvTgjD+2hmJws=; b=R/R4WTDgCM0bGE57KtGi/9cgGQ
        CuMm79deh88rFq9Dbrsa64htpoYUnS5Q0UVypXII1E0iTGOCBFSKQUSo/KcIMzpra0+rAHVAGdEh/
        Dx/Ad7K6FV4AjUQ3rNUk66/+R7Zdt8gNwr7T6Fikm1/KOaw6lNoSWnZSg2gbJIBZBs/wkEHH6lk0u
        usqyjZcKegeaAPbTgcHh+0pdl61wPYIF+M7jCWoED2K6ln7Ql4NRkBxes+T63kg52j9jaalRS4RSV
        TrB3d5uvyha0+rtnKHs7gPfElQxPMuJF1HP6Bf2sTpa1MfK0qmkqQK+lGmltZAJolv+MO7RK90W+0
        sg7vjaPw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4dYh-00C6ID-Od; Fri, 24 Jun 2022 07:16:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70B4F30023F;
        Fri, 24 Jun 2022 09:16:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B54929A7C416; Fri, 24 Jun 2022 09:16:48 +0200 (CEST)
Date:   Fri, 24 Jun 2022 09:16:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <YrVk4ElATQx4lcW0@hirez.programming.kicks-ass.net>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
 <20220622105017.04630f12@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622105017.04630f12@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:50:18AM -0400, Steven Rostedt wrote:
> On Fri, 17 Jun 2022 13:24:53 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Hi,
> > 
> > I recently noticed that __mcount_loc is 64bit wide, containing absolute
> > addresses. Since __mcount_loc is a permanent section (not one we drop
> > after boot), this bloats the kernel memory usage for no real purpose.
> 
> Wait, it's not dropped? Nothing uses it after it is read. It should be
> dropped when init data is dropped.
> 
> From include/asm-generic/vmlinux.lds.h
> 
> /* init and exit section handling */
> #define INIT_DATA                                                       \
>         KEEP(*(SORT(___kentry+*)))                                      \
>         *(.init.data init.data.*)                                       \
>         MEM_DISCARD(init.data*)                                         \
>         KERNEL_CTORS()                                                  \
>         MCOUNT_REC()                                                    \  <<----
>         *(.init.rodata .init.rodata.*)                                  \
>         FTRACE_EVENTS()                                                 \
>         TRACE_SYSCALLS()                                                \
>         KPROBE_BLACKLIST()                                              \
>         ERROR_INJECT_WHITELIST()                                        \
>         MEM_DISCARD(init.rodata)                                        \
> 
> 
> So it should be dropped after boot.

Urgh, clearly I got lost somewhere along the line. In that case it
doesn't matter nearly as much.
