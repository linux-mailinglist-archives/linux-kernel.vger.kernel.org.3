Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB1A4F5C24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiDFLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiDFLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:21:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15391F9776
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gjSzDmZ8ZEg6oAu+s89H1vKfdedj6enk18MsmjGy26Q=; b=agYQaaN/zk2oC1MVsKr1tZ2MAM
        AseKQ0ZZhsNn8lAM3BekArNNGu2ygdCGP4GIljuR9lGgCIjjCNsei4BVw7EWUZ9INnXF7xnq1cdBq
        o0RVBKJU3YljkJc6VTeSLNpegbHCB3kpkXlxQOspr5BkynUDjo50kwb9KmgNsGkmd/lZO0oMbrezO
        UW+K3FMNOTKbJ+ViRXHjkh+PRaxd9ICOlepteYeNxPCpYih3yPIPDdyxBocnCYjGAtnY95Wx1AxNc
        7d/r6SJxL6JRVRB7CEJH8EAbvEVspBxl3Iu/plH+hP+duLbiSWeer1+HhyrfOhK0fyhPAtCXUN9gh
        p5B+01zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nc0KB-0026ZM-Gg; Wed, 06 Apr 2022 07:43:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DFD79861A5; Wed,  6 Apr 2022 09:43:31 +0200 (CEST)
Date:   Wed, 6 Apr 2022 09:43:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220406074330.GD34954@worktop.programming.kicks-ass.net>
References: <202204041241.Hw855BWm-lkp@intel.com>
 <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
 <20220406000500.5hlaqy5zrdqsg5mg@treble>
 <87czhv11k1.ffs@tglx>
 <20220406053251.6dyfxrjmmgdwocfc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406053251.6dyfxrjmmgdwocfc@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:32:51PM -0700, Josh Poimboeuf wrote:
> More broadly, this issue could theoretically happen in some other places
> throughout the kernel tree, since _THIS_IP_ is fundamentally unreliable
> as currently written.
> 
> So we could look at making _THIS_IP_ more predictable.
> 
> Inline asm would work better ("lea 0(%rip), %[rip]"), but then you need
> an arch-dependent implementation...

Well, there's a ton of _THIS_IP_ instances all around, and it would be
unfortunate to have them grow into actual code :/
