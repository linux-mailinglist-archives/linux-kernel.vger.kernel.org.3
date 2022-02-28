Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E634C782F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiB1Smg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbiB1SmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEB58BC3A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646073421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Nw+YzuEzgs3gu2at3y5Ba3Dv+XkvEq+c0bsLbBK/qk=;
        b=EFP+XEL+pSb8Eq4DlI6KXzbkaaiiHqppzsJlIJI6Gg3x3rxbpQOYxfDRDh7oI+6NIZPvM8
        D/7txjamniqDXa4ISl1aU9w83Dks8Fvsa+vJvH7sbWqQXX8s/80rgs4M4j9G8qehfwPnko
        OVRRt+fSq2TZOfp5PAHUFBSjz3zbbd0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-yClh6WywNkS7B4zlv5M-KQ-1; Mon, 28 Feb 2022 13:37:00 -0500
X-MC-Unique: yClh6WywNkS7B4zlv5M-KQ-1
Received: by mail-qk1-f199.google.com with SMTP id c19-20020a05620a11b300b00648cdeae21aso11929837qkk.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Nw+YzuEzgs3gu2at3y5Ba3Dv+XkvEq+c0bsLbBK/qk=;
        b=0RkrYDeoL8L1wwKXfd1J2/Q4N1M/4qgTqC+NJZH/hqUGE5LBlrLO/SNgIPSSNzmw9u
         dzYduvOW+QPTPwhFVGHr0LVsiVAZGqOXwAG65wVO4rwOuohnpm2qp6YnuWOaJIvGNw0X
         8oLeVv5pOOLS3HGOicbzxonv2kRHliMeOIE+rzwNqDunNYzUKipiqS2josC27Jqy6Xdc
         DrKYsoYTpoIqljVe1Bd7pYs9M05FynStzfWVc8sqeLCZ2JPwpyzwwH6V/ff9Auisgb3d
         4KP9R4dGiys+qiukO0272tq1C0uwZ96ziYNQySylnmCH6rve76v1jWLb5kW59MtfkE94
         wB4A==
X-Gm-Message-State: AOAM5339aQAj2sBTTaIRlkQTQc860DWKrpjthZpN+4nM4jb8/mDNtesz
        3oElh2AYSWcTvzNrsJ4Bmx4SdJyfptF0EJ+SpQf/UdD5xGndadmGqhnoTrwhsqtV3A/nVcE9B2Y
        q1AFdeifE5F/d2vg+/XFkMKXY
X-Received: by 2002:a05:6214:3004:b0:434:ec44:a4aa with SMTP id ke4-20020a056214300400b00434ec44a4aamr579434qvb.82.1646073420032;
        Mon, 28 Feb 2022 10:37:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypuXmACvJKkGTqqA7ckL8GgJgVLOX14Uko4cCuqnq4ygGwUrBeVheyZdTCTnqnxdeqCkR0bg==
X-Received: by 2002:a05:6214:3004:b0:434:ec44:a4aa with SMTP id ke4-20020a056214300400b00434ec44a4aamr579411qvb.82.1646073419737;
        Mon, 28 Feb 2022 10:36:59 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id g202-20020a379dd3000000b0064932a7b992sm5444536qke.98.2022.02.28.10.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:36:59 -0800 (PST)
Date:   Mon, 28 Feb 2022 10:36:55 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <20220228183655.gcacvddofbaaiqhz@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
 <20220227031348.drbmkcmoqur53aay@treble>
 <20220227170003.GE11184@worktop.programming.kicks-ass.net>
 <20220227222055.uqgcz33dwhl3atpr@treble>
 <YhyaS4tN9NpCJcmk@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhyaS4tN9NpCJcmk@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:47:55AM +0100, Peter Zijlstra wrote:
> On Sun, Feb 27, 2022 at 02:20:55PM -0800, Josh Poimboeuf wrote:
> > On Sun, Feb 27, 2022 at 06:00:03PM +0100, Peter Zijlstra wrote:
> > > > > @@ -3101,6 +3164,17 @@ static int validate_branch(struct objtoo
> > > > >  
> > > > >  		if (insn->hint) {
> > > > >  			state.cfi = *insn->cfi;
> > > > > +			if (ibt) {
> > > > > +				struct symbol *sym;
> > > > > +
> > > > > +				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
> > > > > +				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
> > > > > +				    insn->type != INSN_ENDBR && !insn->noendbr) {
> > > > > +					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
> > > > > +						  insn->sec, insn->offset,
> > > > > +						  sym->name);
> > > > > +				}
> > > > 
> > > > No need to print sym->name here, WARN_FUNC() already does it?
> > > 
> > > Almost; perhaps the change to make is to either introduce WARN_SYM or
> > > make WARN_FUNC also print !STT_FUNC symbols ?
> > 
> > In the case of no function, WARN_FUNC() falls back to printing sec+off.
> > Is that not good enough?
> 
> I got really tired of doing the manual symbol lookup... I don't suppose
> it matters too much now that I've more or less completed the triage, but
> it was useful.

Maybe it would be reasonable to change WARN_FUNC to do that?  i.e. fall
back from func+off to sym+off to sec+off.

-- 
Josh

