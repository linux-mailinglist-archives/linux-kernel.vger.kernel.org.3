Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD64BC1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiBRVXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:23:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiBRVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:23:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A736B52
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lf/JXSVhn5YTizBcJSiljp0yPpO62XfH/FJ//KnGRpk=; b=mq5vkEFOQ18UKbADeYWoTyCOgh
        QpQELX3fQSuH/1dep6fxY9Zna0GMV6dBexo4vfTVa9QhiWfud9t/Jymc/+usoWpQ5HPAEsSKpMyfx
        CxVAtki8FXVIXUE6dIAQo/QZnosyfwI1IlHqHaE8vi+55wSdX0CCGdFtBShfQR+FABa+YT5gBgiCx
        BwLYgSdqLXnepOxP9pYbLDaOTMtlfqdFxJhlLVxZoldrIVTRfdiq0RZfMzsPgLeOhciHuwV9Ngex2
        moWxhsq+jQgcr7QNTHay8lumwH4xvlPSjBdehpj6f00E62j/9ASBO2i9UUuHAuoXalNYoT5+tTuUI
        qHygkxXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLAiE-00GxJF-Lf; Fri, 18 Feb 2022 21:22:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39DB8300478;
        Fri, 18 Feb 2022 22:22:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B5EA2BCB5D56; Fri, 18 Feb 2022 22:22:46 +0100 (CET)
Date:   Fri, 18 Feb 2022 22:22:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 02/29] x86/module: Fix the paravirt vs alternative order
Message-ID: <YhAOJg7A8iko6it7@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.691941184@infradead.org>
 <20220218202820.7tvwxytkyqtngiks@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218202820.7tvwxytkyqtngiks@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:28:20PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 18, 2022 at 05:49:04PM +0100, Peter Zijlstra wrote:
> > Ever since commit 4e6292114c741 ("x86/paravirt: Add new features for
> > paravirt patching") there is an ordering dependency between patching
> > paravirt ops and patching alternatives, the module loader still
> > violates this.
> > 
> > Fixes: 4e6292114c741 ("x86/paravirt: Add new features for paravirt patching")
> > Cc: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Probably a good idea to put the 'para' and 'alt' clauses next to each
> other and add a comment that the ordering is necessary.

Can't, retpolines must be in between, but I'll add a comment to check
alternative.c for ordering constraints.
