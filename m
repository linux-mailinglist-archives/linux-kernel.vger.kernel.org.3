Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4C57C6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiGUIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGUIrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:47:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB230183B8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IQRODSRykcmujBn6DwtbnO28xSyBIAV2+1gWNhFuYxA=; b=IOEZANBvQCQqKPuQj1PHBtqTca
        1DCfpP7JrvzYR3aDdGOHgncB/t/K1OHplnqD9hIdY4zHhKoahNaTjLMEpxlhwDN3RqKiGkfAA3hG5
        NGUTOCDlQyGm2LfC1KPSOrfeQxsGfV7+kXzYWK5oki8KL7xgtrlkbhIvHPLeN+C2lgqRLAYFsBO5G
        1/kfwFJzX5IzzWXKyC3P2ya1Jh7Ra/LaFjKwMbD2Jq5TpeHJj6PwZSntEw2BQ/lM6t3JevNWiSFrS
        phvSF9UhBpXXG8Zb7TptcJRzqFwHWNxlRbRCR44m9zTBmtxsKsoKiY9i8VzzLPp+XAfxIzCSZFuOe
        r1K+XZTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oERpv-00FDog-S8; Thu, 21 Jul 2022 08:47:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC15C30017D;
        Thu, 21 Jul 2022 10:47:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A40A8203C1CB7; Thu, 21 Jul 2022 10:47:09 +0200 (CEST)
Date:   Thu, 21 Jul 2022 10:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] lkdtm: Keep the rodata test from causing retbleed
 WARNINGS
Message-ID: <YtkSjUBIsy5WbrZT@hirez.programming.kicks-ass.net>
References: <20220720155507.4f904a58@gandalf.local.home>
 <202207201311.775CB068@keescook>
 <20220720225615.lrt7xnxv3trmiyc7@treble>
 <20220720225809.wtnlgvof6wi4owkq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720225809.wtnlgvof6wi4owkq@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 03:58:09PM -0700, Josh Poimboeuf wrote:
> Actually Peter said he grabbed it and is planning to push it to -tip
> tomorrow.

Robots were happy, all pushed now.
