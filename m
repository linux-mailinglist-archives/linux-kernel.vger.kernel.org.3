Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE525AD5DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiIEPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiIEPLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:11:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7745FAFE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vrNNTeR0WYM61xQqsj6BPFaHfkuDQfQ+90zugSRDIbU=; b=sXfyLNrOR/w6zCmf7iY1kMbAuK
        Iulv4QSng3/JDd80Ymtf8jBjJaS1y3ugs9g/26c8o7eEQvfbCyQ3ntqpF5tXf+WsB7oOE7wFYNjYn
        F951eh36O2ThT7Vflt3gMTvFoVg8tyCQQLuZJqFDjdAOjI2HuVMgoVukCZ0k57N0gkyzcSsmIgUZK
        YeQW88GnHSECWdJOzcIgnz4Od8iSr2A2bugAAf2mZjs7aPhnFDXJ6qzTY5gdDl9CxzEgmiu+4GzLQ
        KkQ4x8hHVIa82Q3IibYpuLAn+KjQ7WzJWlBUlEXu22Ltg/6o7+iL8lmJKx1T7T7JFBJ0EJUlXQpLc
        ulmOMN0A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVDk6-009aMY-Ko; Mon, 05 Sep 2022 15:10:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C572A300244;
        Mon,  5 Sep 2022 17:10:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B75D3209EC608; Mon,  5 Sep 2022 17:10:27 +0200 (CEST)
Date:   Mon, 5 Sep 2022 17:10:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-ID: <YxYRYwZ/zYO+u1ij@hirez.programming.kicks-ass.net>
References: <20220904230713.a461f8fe85329663226c755f@kernel.org>
 <20220905105758.176734eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905105758.176734eb@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 10:57:58AM -0400, Steven Rostedt wrote:
> On Sun, 4 Sep 2022 23:07:13 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Can we use another instruction for padding instead of INT3? (e.g. NOP or UD2)
> > 
> > Or, can I expect the instruction length in __return_sites[] are always 5?
> > If so, I can just skip 5 bytes if the address is in __return_sites[].
> 
> Perhaps another option is to have a table of where the padding is placed
> (tagged), and that kprobes could check to see if the int3 is due to this
> padding or not?

I don't see need for that. If you want to be strict you can simply
follow the branches found earlier, if you want to be lazy, you can
decode until you run out of the symbol size.
