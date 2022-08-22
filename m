Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756E259C2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiHVPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbiHVPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:24:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1146365C1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43q/Y6PCIr12PsYQrhIey7J5JJCN8rOQIc8ZlyWJoi0=; b=F629MzDPAA4PSM+EgfdfU46okF
        vr3fGAtS/Fkoj3bk++3k/7giS57gkwNyOfRJh3ki22dcEscg+oYh7XJCgaV7N54Bmjm1glq05oU7t
        yPF8ukcMf2jDR06labHuUhjEZanfckIWPWoqYX0/P5pGRLnXepWojVzFWyeVDczGMhR0s4vxFhgkh
        VxRKgBSutAr1UHdcBB2RM9XnMaFk+4/WwTZ9d31Pv00/Gbnw0GaGEesRr78SaVsyXuC9DfFegsXih
        uK2nfx7Ynv1nYuJGS4D9nOd5NHB5hsFUKC16yC45mUyb9R6YrQepwA3+ToXiTWynBYFd1LGdSBTO/
        KrZLFP7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ9Em-00EOl9-Rf; Mon, 22 Aug 2022 15:21:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 188A79804A3; Mon, 22 Aug 2022 17:21:11 +0200 (CEST)
Date:   Mon, 22 Aug 2022 17:21:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <YwOe54h8SO11JAKw@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
 <afb376c7-7f91-2b1c-9bef-ff4d49f066ed@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb376c7-7f91-2b1c-9bef-ff4d49f066ed@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:59:13AM -0400, Liang, Kan wrote:

> > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > +		pr_warn_once("hybrid PMU and virt are incompatible\n");
> > +		return false;
> > +	}
> 
> I would expect that KVM exposes the enhanced CPUID to the guest. The
> guest vCPU should knows its specific CPU type. The KVM should bind the
> vCPU to the same type of CPUs.
> 
> Before KVM provides such support, I guess it may be OK to have the
> warning. Maybe more specifically, only architecture events work.

Well, as is I randomly get #GPs when I boot a guest kernel.

The QEMU thing is passing in Core CPUID to all vCPUs (because per luck
it starts on a biggie), but if the vCPU lands on a small then the
PERF_GLOBAL_CTRL write will #GP because biggie has more bits set than
small knows how to deal with:

0001000f000000ff vs 000000070000003f, or something like that.

So I'm thinking we should entirely kill the thing by default and allow
KVM to set some magical bit when it knows the CPUID and affinity crud is
just right to have it maybe work. But that's for some virt person to
sort out...
