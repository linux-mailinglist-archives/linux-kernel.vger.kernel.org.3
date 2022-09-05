Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECED5AD5E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiIEPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbiIEPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:10:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B6D38A0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VvD/lV42RUT7H7xICYuQWi8qGi+w14efOaZbwubbG8Q=; b=I98w5q6xNoPCrGZCohLIR5lHwB
        6/nZRN1aLB8Aev3VzHqnXnrRJCBvMP4+ueOvmMBWvIvWc6hrFLnhWmHiW8modyLQb6eddqprlFVfH
        feze/iAc6JnUwD8A+iVvX0/ox/FRAVNTKzRCKwXIaVisQ6X6Qmw71GWHrqAtgZ2MCX8XffjwSVeMG
        HexL40Erhq73T3VfUd+ovZcwquah8ZCZYkghwW9hY5Ox0E8SG8MSrR5CnqQY2l7jR5CWAri+bWKsA
        JX1xkP88ZEJMqu3dcYxd84upTlyjYBxv4otlqZtubMjItas4VXQc9SDJqJc0lVukfZt2dDQNXmJPL
        MwGvdoAQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVDiw-009jst-4i; Mon, 05 Sep 2022 15:09:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A473C300244;
        Mon,  5 Sep 2022 17:09:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C39B2B9707B7; Mon,  5 Sep 2022 17:09:16 +0200 (CEST)
Date:   Mon, 5 Sep 2022 17:09:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-ID: <YxYRHHuTHjzgCuE8@hirez.programming.kicks-ass.net>
References: <20220904230713.a461f8fe85329663226c755f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904230713.a461f8fe85329663226c755f@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 11:07:13PM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> I found that the CONFIG_RETHUNK code (path_return) fills the unused bytes
> with int3 for padding. Unfortunately, this prevents kprobes on the function
> body after the return code (e.g. branch blocks placed behind the return.)

Prior to that CONFIG_SLS would already use "ret; int3"

> This is because kprobes decodes function body to ensure the probed address
> is an instruction boundary, and if it finds the 0xcc (int3), it stops
> decoding and reject probing because the int3 is usually used for a
> software breakpoint and is replacing some other instruction. Without
> recovering the instruction, it can not continue decoding safely.

I can't follow this logic. Decoding the single byte int3 instruction is
trivial. If you want a sanity check, follow the branches you found while
decoding the instruction starting at +0.

> Can we use another instruction for padding instead of INT3? (e.g. NOP or UD2)

No. NOP is not a trap instruction and UD2 is longer than it needs to be.

