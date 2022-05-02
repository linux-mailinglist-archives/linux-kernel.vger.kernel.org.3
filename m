Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182FC5177C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384806AbiEBUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiEBUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 297F2BCA7
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651522191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DT4jtv2VjyjNNAsU5PjSvC9JMsUE39bfx5W3QGdwNjo=;
        b=fgs8io2xKj5UxlMR1SAQbuvvZMlxYcN9gMTqQTmNqlNhzDG/G0FZu4x6291DHdxu6yJUym
        +K5mWL8mzNSZLzMzM88E/VUiwB4eD8AWUtHB1fRMG5UV3P9UbrO9KaMl/7MTKaCawk3OpK
        fdCNiq41O54ekMB+jgSWFGFmMegAq70=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-PNi6AysJO52jE1GaYLdfsw-1; Mon, 02 May 2022 16:09:50 -0400
X-MC-Unique: PNi6AysJO52jE1GaYLdfsw-1
Received: by mail-qv1-f71.google.com with SMTP id bu6-20020ad455e6000000b004563a74e3f9so11822712qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DT4jtv2VjyjNNAsU5PjSvC9JMsUE39bfx5W3QGdwNjo=;
        b=ThPlJMfCbtm6QNY2nQpUuiJlFF+uc+93SCIm3zZCinfL99dtQbw7XU0I/HqQtXFVZv
         sRBclAXSz0qFI2a+9Hx37H5jM2xe2UBLs19sjJgg9TISC3mu0rgkCIFav0s3+mV3j6rP
         FfDZ1zD3QW0taNrLWv63aHluV7qJNtCTAlSjRG7GH9qiY/bCubskyTt448LP/w9x3MAu
         MOx2z0b2uz7J8vxaXMpbaDLt17vKmAwWcFtxz+8ca5E0BMOb1zXJJbqWZYn/+eRyLj7p
         MUBDSkl+jBgvxY/irJVb6pFO4YTu6puYfzHV7wjqyiLSbVJLrHpRrjxvV3A4wAp3k5Yy
         KgJQ==
X-Gm-Message-State: AOAM531npQzSXMF39kWVlbIj6F5CuTRxFqu+N0IHtVZo7nrC+6IrdpCg
        W9AjRiRcnkqfLwjpLVl73rZR8CCR6ffAiDlMp/8pdAPCKLFYFjlRf3dbAjRfJ+YkH4GAk6+56Zk
        eUduoQE+PzIeh+4oCTI/FzhVo
X-Received: by 2002:a05:622a:6101:b0:2f1:df05:b084 with SMTP id hg1-20020a05622a610100b002f1df05b084mr11951331qtb.580.1651522189415;
        Mon, 02 May 2022 13:09:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl4Vn3lCQlp+9DiE+LQHvGYhHFaiQsuwbHf0aZyfS38QaDYVcJDy0y+G3OPVqpCrkw4UtI1Q==
X-Received: by 2002:a05:622a:6101:b0:2f1:df05:b084 with SMTP id hg1-20020a05622a610100b002f1df05b084mr11951315qtb.580.1651522189169;
        Mon, 02 May 2022 13:09:49 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id z13-20020ac875cd000000b002f39b99f6a1sm4661442qtq.59.2022.05.02.13.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:09:48 -0700 (PDT)
Date:   Mon, 2 May 2022 13:09:46 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix SLS checks
Message-ID: <20220502200946.ji7jqoitz65sz7yx@treble>
References: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
 <20220502181547.fzz2yre2p4akph4s@treble>
 <YnA4sS0hA6VwFKPd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnA4sS0hA6VwFKPd@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 10:01:53PM +0200, Peter Zijlstra wrote:
> On Mon, May 02, 2022 at 11:15:47AM -0700, Josh Poimboeuf wrote:
> > On Sat, Apr 30, 2022 at 12:50:02PM +0200, Peter Zijlstra wrote:
> > > 
> > > Fix the SLS validation; not having a next instruction is also a fail
> > > when the next instruction should be INSN_TRAP.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  tools/objtool/check.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index 3f6785415894..3354101ffe34 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -3380,7 +3380,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> > >  
> > >  		case INSN_RETURN:
> > >  			if (sls && !insn->retpoline_safe &&
> > > -			    next_insn && next_insn->type != INSN_TRAP) {
> > > +			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
> > >  				WARN_FUNC("missing int3 after ret",
> > >  					  insn->sec, insn->offset);
> > >  			}
> > > @@ -3428,7 +3428,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> > >  
> > >  		case INSN_JUMP_DYNAMIC:
> > >  			if (sls && !insn->retpoline_safe &&
> > > -			    next_insn && next_insn->type != INSN_TRAP) {
> > > +			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
> > >  				WARN_FUNC("missing int3 after indirect jump",
> > >  					  insn->sec, insn->offset);
> > >  			}
> > 
> > My SLS rewrite in tip/objtool/core already fixed this, FWIW.  But this
> > could be good for -urgent.
> 
> Urgh, I should've looked at that indeed. This didn't find any new sites
> though; so I don't think this needs to go through urgent.

Well to be fair, it was easy to miss since I snuck it in with rewrite.

-- 
Josh

