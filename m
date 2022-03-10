Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855DC4D4A73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbiCJOmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiCJOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0744AD5DCC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UoLoMSr1L4PiQxwJzNXgnjqeiV5XbOR73wyZICR4kL0=; b=Lr6akouqn7YW5NjwJwQCt55gBL
        N+eHZT6DyUTmjU4aB51d1uEGSHkNUg9PzFLOI4KCujoYfFQzLMvBz8sQPSosVZ8VhYRB2/D2uT6iy
        Fuht3Bb+ZAfmzGY9OYhTKoPRPn36QAmgwW+AF7vW7sQ5lSaW2aGbKxkOXBrnR7YWcFJvejamAMKcX
        0jlcPDsDI1T0yUkEtzsdJtdHckBXXD/2MgWIEiTxI0fJEDIADbqMhMRMSGhO4Q/LzBqN3lgBFClWK
        Pf0YVSTcexMJGfP/U5CQ7isfsCM/e9VRnTbpn5dDj1ftuxvOLgxjo27gQebFtmM4ve1QJ7lcR9ZuG
        NiAhAIMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSJlo-000biS-0H; Thu, 10 Mar 2022 14:28:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 089FC3000E6;
        Thu, 10 Mar 2022 15:27:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D03752B52E237; Thu, 10 Mar 2022 15:27:58 +0100 (CET)
Date:   Thu, 10 Mar 2022 15:27:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@intel.com" <alyssa.milburn@intel.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
Message-ID: <YioK7llYzEUrAw/r@hirez.programming.kicks-ass.net>
References: <20220308153011.021123062@infradead.org>
 <20220308200614.gyhp657bdq3rxapl@treble>
 <20220309065718.e4k2el2mlqn23yh2@treble>
 <bdb04de758ea4f89a8731ee6b98794fa@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb04de758ea4f89a8731ee6b98794fa@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 01:37:50PM +0000, David Laight wrote:
> I'm wondering what actually happens to loadable modules?

They work just fine..

> Especially those built 'out of tree',
> potentially with a different compiler,
> and maybe containing binary 'blobs'.

-EDONTCARE, you're on your own and get to keep whatever pieces.
In fact, the more pieces I can get you, the better I feel about it.

> The requirement to run programs on old distributions means
> that things get compiled with quite old versions of gcc.
> For instance RHEL7 is gcc 4.8.5.

Min GCC is 5.1. If you want Kernel IBT you get to use GCC-9 (or 8 with
backports) but I'd recommend using GCC-10 or later since before that the
IBT code-gen is pretty stupid.

If you build modules using another compiler than the main kernel, you
again get to keep the pieces.
