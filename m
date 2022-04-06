Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D647A4F65F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiDFQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbiDFQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:51:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0841F3A5E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4291B82150
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB58C385A1;
        Wed,  6 Apr 2022 14:14:23 +0000 (UTC)
Date:   Wed, 6 Apr 2022 10:14:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220406101421.3f67cf46@gandalf.local.home>
In-Reply-To: <20220406053251.6dyfxrjmmgdwocfc@treble>
References: <202204041241.Hw855BWm-lkp@intel.com>
        <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
        <20220406000500.5hlaqy5zrdqsg5mg@treble>
        <87czhv11k1.ffs@tglx>
        <20220406053251.6dyfxrjmmgdwocfc@treble>
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

On Tue, 5 Apr 2022 22:32:51 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > See the comment in the header file you are patching:
> > 
> >  * This is intended as a debugging tool for the developer only.
> >  * Please refrain from leaving trace_printks scattered around in
> >  * your code. (Extra memory is used for special buffers that are
> >  * allocated when trace_printk() is used.)  
> 
> So what do we do ... send a nastygram?  

We already do. When anything with a trace_printk() is loaded, the dmesg
will display:

 **********************************************************
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** trace_printk() being used. Allocating extra memory.  **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **
 **                                                      **
 ** If you see this message and you are not debugging    **
 ** the kernel, report this immediately to your vendor!  **
 **                                                      **
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **********************************************************

:-)

-- Steve
