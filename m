Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7308F4C9404
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiCATOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiCATOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:14:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3CE4C7B5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3cfe6qkGcSTk1RLLa+OWFN4fepuY3Vm0o//7NItg80k=; b=ZDHeGa6sGg2fhed+n3/g+w7foh
        /0d+DSHa2vtmAZDb8nGYRBXH4MC8O2HeTavX0MEGL+cEaf8APOKP5rVsRE9pjz33xg+DO74KIW6wG
        gA/ubCLBSoSONsAnzav2ktAJ6BpVFXZWHiIShd58iax1wBy+cOGQXpzFARPBADdVIyaO9E5Cx1jVz
        LUxL6qlN/LCKiDSRK09bMpHALfZwVn9cHx23NlyMphmschKDJ+OEiI1N6Q7hR0nPoZG7g47TT4zjz
        FgVlgfuz+/XHwt9oUfTr1wA27/GYB8M2YKZymadyurPXSY13wBKbqTo7PelLeXJHur1wc61TWzblv
        aapZIZ7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP7vS-00ELny-N8; Tue, 01 Mar 2022 19:12:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2409B986271; Tue,  1 Mar 2022 20:12:45 +0100 (CET)
Date:   Tue, 1 Mar 2022 20:12:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, ndesaulniers@google.com,
        rostedt@goodmis.org, samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <20220301191245.GI11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220228150705.aab2d654b973109bab070ffe@kernel.org>
 <20220228232513.GH11184@worktop.programming.kicks-ass.net>
 <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
 <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
 <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:49:09PM +0530, Naveen N. Rao wrote:
> Peter Zijlstra wrote:
> > On Tue, Mar 01, 2022 at 11:49:05AM +0900, Masami Hiramatsu wrote:
> > 
> > > - the 'offset' is NOT limited under the symbol size.
> > >   (e.g. symbol_name = "_text" and @offset points the offset of target symbol from _text)
> > > 
> > > This means we need to call kallsyms_lookup_size_offset() in this case too.
> > 
> > I'm feeling we should error out in that case. Using sym+offset beyond
> > the limits of sym is just daft.
> > 
> > But if you really want/need to retain that, then yes, we need that
> > else branch unconditionally :/
> 
> I think we will need this. perf always specifies an offset from _text.

The _text section symbol should have an adequate size, no?

> Also, I just noticed:

> > +		if (!kallsyms_lookup_size_offset((unsigned long)addr + offset,
> > +						 NULL, &offset))
> > +			return ERR_PTR(-ENOENT);
> > +		addr = (kprobe_opcode_t *)((unsigned long)addr - offset);
> >  	}
> 
> This looks wrong. I think you need to retain offset to calculate the proper
> function entry address so that you can do:
> 	addr = (kprobe_opcode_t *)((unsigned long)(addr + offset) - func_offset);
> 	offset = func_offset;


Right you are, it needs to be:

	addr += offset;
	kallsyms_lookup_size_offset(addr, &size, &offset);
	addr -= offset;

with all the extra unreadable casts on.
