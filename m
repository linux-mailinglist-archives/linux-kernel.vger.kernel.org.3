Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FE5AD5FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiIEPPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiIEPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:15:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674CE53
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGAWEj5ug3pAgXXAvAC/+a50JJGlY/TNhgeeuDwJHhQ=; b=WPdB6pfnNPeZo9LkVir7k8u3SQ
        2RCT33N/PHUDry/162Ycgyf0Qnjp9FmYZkHgHH/qXeE3vk4Wv7oZtP3ckyXBHKYM/DR7C+Wv0kvcn
        KamXC7plCIgCsG+TCS704FPsiCsVkHGIappA+q5BTE5aGZH8bYMeBcY/BAszdb++62ux5HpJA5Gwa
        gDWDjZiuMNHv4J6zX978HQtK7Zwy2aamyMd8Nhd8Xjy9f/Y0tvlKF+VgBXNIIWYXnbbI6etruOJVJ
        wbHKPL7gQAsWgtsT2AuzeCMs7xxpZgm/3vDJvuGEiU9RYWxKuRPZBDM1UdJmc9jbOgA9dx1VwuJJk
        317cwFhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVDoa-009k5C-8K; Mon, 05 Sep 2022 15:15:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEB70300244;
        Mon,  5 Sep 2022 17:15:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B628C2B973C23; Mon,  5 Sep 2022 17:15:07 +0200 (CEST)
Date:   Mon, 5 Sep 2022 17:15:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-ID: <YxYSexFjytTCIJ0i@hirez.programming.kicks-ass.net>
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
> On Sun, Sep 04, 2022 at 11:07:13PM +0900, Masami Hiramatsu wrote:
> > Hi Peter,
> > 
> > I found that the CONFIG_RETHUNK code (path_return) fills the unused bytes
> > with int3 for padding. Unfortunately, this prevents kprobes on the function
> > body after the return code (e.g. branch blocks placed behind the return.)
> 
> Prior to that CONFIG_SLS would already use "ret; int3"

FWIW, there is a compiler option pending to also stick an int3 after
every unconditional jmp.
