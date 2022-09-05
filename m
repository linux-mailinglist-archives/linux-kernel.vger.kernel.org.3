Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6085AD6E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiIEPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiIEPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:52:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923845D11E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jX+1wDdolT+cB5BzVJqFbVISJb28cjQt6PL6hAv6HA8=; b=L8pZyX2VaVt1MEb7hb+m5WLNDr
        r09CBMjgPa3XXov1irmiB1AaBAnNfZNErD8mg49AHwTJIp9woIDvLVItdmyVfV/y6Ig+iSgF+KzFQ
        q1vcAcPiafsB1aoj429XhbGdT0dgHWNIx2Q4wspTzkSRxfq/NN2+WfNCMmSuOP9gZyHX66wTYG6fE
        H+IRPT9Z8jujxd8Vbvam/JcKx9Z3uHG7o/SJgPsGbjS+uTFoPiPS3gvJPUGVPi/9yGxBiebb7sVsB
        gDFfm+un3Zbmx0CDoa8knA80eKeLPFmSEBYUuz55SNlVJAw5hs38/NuKKKnSwpGHpWrOCqXnw4Rvc
        7GV/zN+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVEOl-009bp4-VY; Mon, 05 Sep 2022 15:52:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6525F300244;
        Mon,  5 Sep 2022 17:52:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19165209EC608; Mon,  5 Sep 2022 17:52:29 +0200 (CEST)
Date:   Mon, 5 Sep 2022 17:52:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-ID: <YxYbPTmN1TCp4En5@hirez.programming.kicks-ass.net>
References: <20220904230713.a461f8fe85329663226c755f@kernel.org>
 <YxYRHHuTHjzgCuE8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYRHHuTHjzgCuE8@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:09:16PM +0200, Peter Zijlstra wrote:

> > This is because kprobes decodes function body to ensure the probed address
> > is an instruction boundary, and if it finds the 0xcc (int3), it stops
> > decoding and reject probing because the int3 is usually used for a
> > software breakpoint and is replacing some other instruction. Without
> > recovering the instruction, it can not continue decoding safely.
> 
> I can't follow this logic. Decoding the single byte int3 instruction is
> trivial. If you want a sanity check, follow the branches you found while
> decoding the instruction starting at +0.

Specifically, kprobe is the only one scribbling random [*] instructions
with int3 in kernel text, so if kprobes doesn't know about the int3, it
must be padding.

[*] there's also static_call, jump_label and ftrace that use
text_poke_bp() to scribble instructions but those are well known
locations.
