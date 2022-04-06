Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89B64F5865
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355057AbiDFJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444720AbiDFI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:56:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667F9593A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A5BF3CE1FE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12E6C385A1;
        Wed,  6 Apr 2022 01:20:34 +0000 (UTC)
Date:   Tue, 5 Apr 2022 21:20:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220405212032.3d858b31@gandalf.local.home>
In-Reply-To: <87czhv11k1.ffs@tglx>
References: <202204041241.Hw855BWm-lkp@intel.com>
        <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
        <20220406000500.5hlaqy5zrdqsg5mg@treble>
        <87czhv11k1.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Apr 2022 02:46:22 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> This covers the trace_printk() case which uses do_trace_printk(), but
> the same problem exists in trace_puts() and ftrace_vprintk()...., no?

Hmm, I'm not even sure why ftrace_vprintk() is there. It seems redundant.

Arnaldo,

Was there a reason for it. The commit that added it isn't very descriptive.

commit 9011262a37cb438f0fa9394b5e83840db8f9680a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Jan 23 12:06:23 2009 -0200

    ftrace: add ftrace_vprintk
    
    Impact: new helper function
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>


-- Steve
