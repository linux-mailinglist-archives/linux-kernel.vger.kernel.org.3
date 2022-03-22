Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663904E42CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiCVPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiCVPV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:21:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA5888EB;
        Tue, 22 Mar 2022 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=82Iai9rshD4beiVR/j7WhNo1cfOZSCSdMFJeraPEq2g=; b=da9HiTmJD+ymSvajQWByZu8GUx
        86F+53OJsDWx617vaeyp46vNQgmSe2zo/Sq4RUl7edRnmisEdLfMi9Fxe16tctKyR4cwAanPhD3A1
        xAZOQlanU7pMAM0exWcHANDTxu8n+y7fY7ANgHdUMygeoY24iGq+N6L1kOaobHsNc0fiRVqhxo7nd
        rdtoe9T1KKM7U0SPgdV3OJd6AUp3Ig11ie4bJD2+1m+cn5LU369xSYtC17R4oCUs7IH/RYxT48lEl
        RJglRD24J5uIWzLAshq5sqSsahGx5+n0RLHLR5C4WIc7kOgV8C3RfRiJhTLmm3gIeAnm7Y5c4bnQb
        YKxs6KRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgI3-00BhxY-9w; Tue, 22 Mar 2022 15:19:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1372430007E;
        Tue, 22 Mar 2022 16:19:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D436D31AA29F5; Tue, 22 Mar 2022 16:19:16 +0100 (CET)
Date:   Tue, 22 Mar 2022 16:19:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <Yjno9GS9Q0JEnZyc@hirez.programming.kicks-ass.net>
References: <20220321121209.3b95e406@gandalf.local.home>
 <20220321121549.1c8588c5@gandalf.local.home>
 <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
 <20220321124551.3d73660b@gandalf.local.home>
 <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
 <20220321125419.0a20415c@gandalf.local.home>
 <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
 <20220322091242.1ad0206b@gandalf.local.home>
 <Yjneyn8o06svJkY4@hirez.programming.kicks-ass.net>
 <20220322110438.25c2a760@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322110438.25c2a760@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:04:38AM -0400, Steven Rostedt wrote:
> On Tue, 22 Mar 2022 15:35:54 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > I suggested inhibiting tail-call to notrace, you said no. You now seem to
> > agree that solves it.
> 
> I said inhibiting tail-calls was a solution, but only inhibiting it to
> notrace would probably have a significant performance impact.
> 
> I thought you were talking about adding notrace to tail calls, not the
> other way around. Maybe that is our confusion in this conversation.

Yeah, I meant inhibiting the compiler from doing tail-calls.
