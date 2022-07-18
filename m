Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F5578E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiGRXws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGRXwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:52:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00C533A08
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M1/SS0P2qiKSfLGyk8FsxEkTVDeHhn+db9rxuTa/gM4=; b=QemNxpjKI01DOUTOnj5s7mrk9I
        enRWE0TEyg9GajCO7JniUUNxp2btXJt/qWm7mTuno0EcpAOlSreROAkuGRZteOknx0FvKmSOadPSW
        UkGjog4TqhV7uienoFmodPh9aYMGNPrlSXxeijbiRfwRnW36zUM1H3w3Nb0B3A3Rg98tzAvuBxKbj
        cB44baZulx01ZsWgkbwup5mSOkJt7OabkYPfDMmvReXwQen2Trp58jjWAbwG/beSofjjS/FeqgR5I
        V7lfilZyccoATyOiqjf/GaU8g36xVbcX+rJ2GN7RQyO/F0wAilgpoiAahGcDyC6Bc5zRPe0z1JFPO
        ve783Dlg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDaXF-004vWA-NP; Mon, 18 Jul 2022 23:52:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 931529802A7; Tue, 19 Jul 2022 01:52:20 +0200 (CEST)
Date:   Tue, 19 Jul 2022 01:52:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtXyNGHKEd9mtkSF@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx>
 <CAHk-=wgzo-we3gbw1jKbL_cO9CybjwLNKReVxhYybOcpqJMESw@mail.gmail.com>
 <YtXUAykqgRCY2AX3@worktop.programming.kicks-ass.net>
 <CAHk-=wiOGOm54vmHJx5t7P3MjWSsda9pLKdSzKziA+TrQcLb_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOGOm54vmHJx5t7P3MjWSsda9pLKdSzKziA+TrQcLb_Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:34:51PM -0700, Linus Torvalds wrote:

> I think the main cause is that the ACPI code builds with
> 
>     ccflags-y                       := -Os -D_LINUX -DBUILDING_ACPICA
> 
> and that '-Os' will disable all function alignment. I think there's a
> few other places that do that too.

Urgh, that's -Ostupid, right?
