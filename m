Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AD57D06B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiGUP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:58:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1997B1FE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZXkGwoOX1JrZvD+fPeKunMd6GdYNliqLEsor5vQnwI=; b=m58CK47P6Lhrl+v6zZzvdcI5F0
        pzf9OgeEKSamZC9gocSb9L7p1EiOxGztXgGEYmww8GD9lPA4RwHKGJ0DQXUkccYyqkMbeEXttAHJ6
        z8txTcOe+umZJuNDpxp8PRQh7OMTqyKsZteBzW/0JzAySiUsXomGSQqCa7uCPDULgvS4wX5xfrftN
        SHwZ+OwrAt1sWGz0OIRFHmiTBYF0AYtEAbFZdW5GvdhO8GsUBwq7lYSmt8IwpoumHMlTX381zEZV1
        tQuUAGSL6BFMv2fsROnfECOG7GiOUlinLuFPUKiVwRBIL6RN0oeypxmeJhCPMkahQsAkR6EViWBbT
        LuFnlH1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEYZ3-00FTGW-NN; Thu, 21 Jul 2022 15:58:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50049980BD2; Thu, 21 Jul 2022 17:58:13 +0200 (CEST)
Date:   Thu, 21 Jul 2022 17:58:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <Ytl3leUTGSOaMFDS@worktop.programming.kicks-ass.net>
References: <20220720155507.4f904a58@gandalf.local.home>
 <202207201311.775CB068@keescook>
 <20220720225615.lrt7xnxv3trmiyc7@treble>
 <20220720225809.wtnlgvof6wi4owkq@treble>
 <YtkSjUBIsy5WbrZT@hirez.programming.kicks-ass.net>
 <20220721095151.7eaabfcb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721095151.7eaabfcb@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 09:51:51AM -0400, Steven Rostedt wrote:
> On Thu, 21 Jul 2022 10:47:09 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Jul 20, 2022 at 03:58:09PM -0700, Josh Poimboeuf wrote:
> > > Actually Peter said he grabbed it and is planning to push it to -tip
> > > tomorrow.  
> > 
> > Robots were happy, all pushed now.
> 
> What tree is this against. I tried to add it to v5.19-rc7 but it fails to
> apply.

I can cleanly merge tip/x86/urgent into v5.19-rc7 (ff merge)
