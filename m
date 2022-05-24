Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270C25331E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiEXTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiEXTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:51:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC39D9F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fFUeIa3PlR6824TWaW8sjCJxadZnZFSVitjO7pF+RXo=; b=pYXr5RXcCs/bj9+ufsnVTxopSQ
        VS5h0VzNjOygCk/qo/47qN7XGFRDNjB0UuRF9lM8k3paTEI+aL9cOWnu5+mvuy0SDvs7iXjknyvQS
        fR3omssEDbqYU6mtdrnwhFaBcuMdmrXVaQlp84QHrxkrwqf8B6Jv80A5/yHaLx5VDbjeuEzOdOTuy
        pu7KXg1O9CHDIackf5BCB1beGxUz8C4H4Co5ikDOCJ/W9fLMgWc6iZy+oMwbvmxAhj5JcnRAujDmV
        YX4NhQ/YaGBixWMvHqplqbMQFU2uY2p8r4KSAuu86NB1nIOxIavv9g7CcARCSMTwnNKcVAnHJ5eDE
        zPWndPJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntaYL-001QNm-MM; Tue, 24 May 2022 19:50:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C36E3002AF;
        Tue, 24 May 2022 21:50:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88742207A452E; Tue, 24 May 2022 21:50:46 +0200 (CEST)
Date:   Tue, 24 May 2022 21:50:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "sv@linux.ibm.com" <sv@linux.ibm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 5/7] objtool: Enable objtool to run only on files
 with ftrace enabled
Message-ID: <Yo03Flwa1s+o6wda@hirez.programming.kicks-ass.net>
References: <cover.1653398233.git.christophe.leroy@csgroup.eu>
 <cf3013dfad89ad5ac7d16d56dced72d7c138a20e.1653398233.git.christophe.leroy@csgroup.eu>
 <Yo0dgyqAOuwU6gHq@hirez.programming.kicks-ass.net>
 <Yo0dpDuK3ilphNAA@hirez.programming.kicks-ass.net>
 <5cb959a2-7e88-5aff-2f8e-be8fdecd002c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cb959a2-7e88-5aff-2f8e-be8fdecd002c@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 06:59:50PM +0000, Christophe Leroy wrote:
> 
> 
> Le 24/05/2022 à 20:02, Peter Zijlstra a écrit :
> > On Tue, May 24, 2022 at 08:01:39PM +0200, Peter Zijlstra wrote:
> >> On Tue, May 24, 2022 at 03:17:45PM +0200, Christophe Leroy wrote:
> >>> From: Sathvika Vasireddy <sv@linux.ibm.com>
> >>>
> >>> This patch makes sure objtool runs only on the object files
> >>> that have ftrace enabled, instead of running on all the object
> >>> files.
> >>>
> >>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >>> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> >>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>> ---
> >>>   scripts/Makefile.build | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> >>> index 2e0c3f9c1459..06ceffd92921 100644
> >>> --- a/scripts/Makefile.build
> >>> +++ b/scripts/Makefile.build
> >>> @@ -258,8 +258,8 @@ else
> >>>   # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
> >>>   # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
> >>>   
> >>> -$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
> >>> -	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
> >>> +$(obj)/%.o: objtool-enabled = $(and $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y),        \
> >>> +        $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),y),y)
> >>
> >> I think this breaks x86, quite a bit of files have ftrace disabled but
> >> very much must run objtool anyway.
> > 
> > Also; since the Changelog gives 0 clue as to what problem it's trying to
> > solve, I can't suggest anything.
> 
> I asked Sathvika on the previous series, see 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220523175548.922671-3-sv@linux.ibm.com/
> 
> He says it is to solve the problem I reported at 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220318105140.43914-4-sv@linux.ibm.com/#2861128

So on x86 we have:

arch/x86/entry/vdso/Makefile:OBJECT_FILES_NON_STANDARD       := y

to kill objtool for the whole of the VDSO. When we run objtool on
vmlinux it isn't a problem, because the VDSO ends up as a data section
through linker scripts.
