Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1654F5BD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiDFLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354322AbiDFLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:02:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C3C528D3C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3JjTLPdPSJ39pHGd48spiEl6+cFumvV5r8fxCWUxCn8=; b=iMWpYPXE1d5UMEh0IGNfqV2tw2
        zwxa7xHlEXejRaAzN8IGTYL6QpUh1jyBQJ2Fz7YuuyPy22PFi3t/uNFdfRDjI6UBsEY9hgxbu8L0T
        Np2bfr3DZJbZ4VhJbgF6s9qfBWz7F12mW9CqsdOk7bOro0UjKZ3UHc3qUacQlg/ukLr8qM72eKSBb
        sPD7f8/zGyC9Ne7uag23Tsb/sm7s3U1Uti0ysQf+Ux6JZCXMRVOX5JBKiNem2JmcPauflWA51+iRW
        UoKoei2rx3gtJvFaTC6luDjg2O0jVMg5cMLz5mpfN43IFaEXynVWeI7lZxNC5OUrl1nRFNzDgWQ0P
        kWruCcKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nc06N-0026Gw-GH; Wed, 06 Apr 2022 07:29:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46E959861A5; Wed,  6 Apr 2022 09:29:13 +0200 (CEST)
Date:   Wed, 6 Apr 2022 09:29:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220406072913.GC34954@worktop.programming.kicks-ass.net>
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
> On Wed, Apr 06, 2022 at 02:46:22AM +0200, Thomas Gleixner wrote:
> > On Tue, Apr 05 2022 at 17:05, Josh Poimboeuf wrote:
> > > On Tue, Apr 05, 2022 at 04:01:15PM +0200, Peter Zijlstra wrote:
> > >
> > > But objtool is complaining about a real problem (albeit with a cryptic
> > > warning).  I don't think we want to paper over that. See patch.
> > >
> > > Also, are in-tree users of trace_printk() even allowed??
> > 
> > See the comment in the header file you are patching:
> > 
> >  * This is intended as a debugging tool for the developer only.
> >  * Please refrain from leaving trace_printks scattered around in
> >  * your code. (Extra memory is used for special buffers that are
> >  * allocated when trace_printk() is used.)
> 
> So what do we do ... send a nastygram?  

Best would be for Steve to send a patch removing them all:


arch/powerpc/kvm/book3s_xics.c:#define XICS_DBG(fmt...) trace_printk(fmt)
drivers/gpu/drm/i915/gt/intel_gtt.h:#define DBG(...) trace_printk(__VA_ARGS__)
drivers/gpu/drm/i915/i915_gem.h:#define GEM_TRACE(...) trace_printk(__VA_ARGS__)
drivers/gpu/drm/i915/i915_gem.h:        trace_printk(__VA_ARGS__);                                      \
drivers/hwtracing/stm/dummy_stm.c:      trace_printk("[%u:%u] [pkt: %x/%x] (%llx)\n", master, channel,
drivers/infiniband/hw/hfi1/trace_dbg.h: trace_printk(fmt, ##__VA_ARGS__)
drivers/tty/n_tty.c:# define n_tty_trace(f, args...)    trace_printk(f, ##args)
drivers/usb/early/xhci-dbc.c:#define    xdbc_trace      trace_printk
fs/ext4/inline.c:       trace_printk("inode %lu\n", dir->i_ino);
fs/ext4/inline.c:               trace_printk("de: off %u rlen %u name %.*s nlen %u ino %u\n",


All except i915 use CPP tokens that don't exist, local developer really
has to take effort to enable it. i915 crud depends on a CONFIG_ symbols
that all{yes,mod}config will happily set for you,
