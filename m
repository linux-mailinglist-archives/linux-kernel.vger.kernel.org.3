Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1D4C5F68
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiB0WVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0WVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85379532CC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646000461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OF8Wv4NGiJ/FjBJDiazDnhCtZMuyqSt8vMjRQPr68q0=;
        b=L5tARpP5B3ZF/mLM9fSqjo159T2pvXExK9R/ctAOTdqSdXWpHOs38AA9FDLot+VT1OuZ0C
        QyKF/GyGHbwIcsHCrRVMNFsfq6+xdNxbsNgLR+wUaHQCC+3ozUdafN5FiBdCePSy8HWSyS
        qyXs5bH9+5nI8//+0mTTXpcRHT7i2hY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-G1c7AnYtNPWHeaMLk6CSNQ-1; Sun, 27 Feb 2022 17:20:59 -0500
X-MC-Unique: G1c7AnYtNPWHeaMLk6CSNQ-1
Received: by mail-qt1-f197.google.com with SMTP id e28-20020ac8415c000000b002c5e43ca6b7so5151965qtm.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 14:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OF8Wv4NGiJ/FjBJDiazDnhCtZMuyqSt8vMjRQPr68q0=;
        b=LjQeIQA/4oJ40z3bydtZOAPDEr8jBPkmqI2dWafSZtXRr6Z1C9txX17bTtlkfGSSlT
         34EomSdy7nWCljeOtwGBADodqPyzrny8Zik287GXeHg5zKIxQlQk5bhca/lqgkeFCpKY
         zv8n9nMAwISbGNQhMQYfdg+qjwBD7ggprTYQ1ExOdATHSgBTJQFA/Da666VTsJqmKOPj
         mVe5z1hr3h86FgzLSueBu0BvhRbDCNWBu/T2sxtewv7WXxqKB5i3lrDicG6rZQvYTf4K
         XSjISDTbtvuhyQ5uqrP+UqVYl0GJpJ2xX/HeRl9jTLgd9H6WHhuV78qcnS46yDX01PDV
         SF1w==
X-Gm-Message-State: AOAM531g8cI0BtF0fP7DLMoYZ4XwXvEF6dpkrTSByVQ90g5dmTRe75Xt
        JoKBaGpTkypf/aMzMt8eomwlR66zQjRdB3wLGVW7CGKZG9zy6ijNxLrjVWWLpLpxQxjS/Rw2ZHg
        RswZKPbMqEaSenIDcvcQqrBav
X-Received: by 2002:a0c:bf48:0:b0:42c:b061:f869 with SMTP id b8-20020a0cbf48000000b0042cb061f869mr12321552qvj.98.1646000459436;
        Sun, 27 Feb 2022 14:20:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDqrZPdRYrh+1bxAEqdJ54BGW5aB5x8XZzKr3/kXpFa+WksVp+U55sYnEEzO8MG+Vf852bCQ==
X-Received: by 2002:a0c:bf48:0:b0:42c:b061:f869 with SMTP id b8-20020a0cbf48000000b0042cb061f869mr12321540qvj.98.1646000459233;
        Sun, 27 Feb 2022 14:20:59 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a14ac00b0060deaee7a21sm4247821qkj.51.2022.02.27.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:20:58 -0800 (PST)
Date:   Sun, 27 Feb 2022 14:20:55 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <20220227222055.uqgcz33dwhl3atpr@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
 <20220227031348.drbmkcmoqur53aay@treble>
 <20220227170003.GE11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220227170003.GE11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 06:00:03PM +0100, Peter Zijlstra wrote:
> > > @@ -3101,6 +3164,17 @@ static int validate_branch(struct objtoo
> > >  
> > >  		if (insn->hint) {
> > >  			state.cfi = *insn->cfi;
> > > +			if (ibt) {
> > > +				struct symbol *sym;
> > > +
> > > +				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
> > > +				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
> > > +				    insn->type != INSN_ENDBR && !insn->noendbr) {
> > > +					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
> > > +						  insn->sec, insn->offset,
> > > +						  sym->name);
> > > +				}
> > 
> > No need to print sym->name here, WARN_FUNC() already does it?
> 
> Almost; perhaps the change to make is to either introduce WARN_SYM or
> make WARN_FUNC also print !STT_FUNC symbols ?

In the case of no function, WARN_FUNC() falls back to printing sec+off.
Is that not good enough?

> > > +static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
> > > +{
> > > +	struct reloc *reloc = insn_reloc(file, insn);
> > > +	struct instruction *target;
> > > +
> > > +	for (;;) {
> > > +		if (!reloc)
> > > +			return;
> > > +
> > > +		target = validate_ibt_reloc(file, reloc);
> > > +		if (target)
> > > +			validate_ibt_target(file, insn, target);
> > > +
> > > +		reloc = find_reloc_by_dest_range(file->elf, insn->sec, reloc->offset + 1,
> > > +						 (insn->offset + insn->len) - (reloc->offset + 1));
> > > +	}
> > 
> > I'm confused about what this loop is trying to do.  Why would an
> > instruction have more than one reloc?  It at least needs a comment.
> 
> Because there are some :/ 'mov' can have an immediate and a
> displacement, both needing a relocation.

<boom> mind blown.  How did I not know this?

-- 
Josh

