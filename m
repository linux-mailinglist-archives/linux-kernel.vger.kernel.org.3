Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD451981D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbiEDHah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbiEDHac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:30:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CF1EEEF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TVWzpBh6WpuRaNI/PYkDrkLN+i0bqqJHA72BZD9Ef2M=; b=fVUmPKZFYOhNwMmRe19+HqRAl8
        CG2LaRsfvK0xbd0+KgsdvrHBUziIBLn2KrGl/Ah4zj5JYtHzPd9M/udmn3h3RVGn0qwLW/zqnHVkG
        ouuAWgv6N7mbGH7N79+w8+eeFNm7fmexwH2z3Fzvssy6cBwrEc0J2XwY7rC5h5nLXyyk3UGoUTKw+
        2Hd0hnUJ2t77AOr4klH7GhxqcrYQIop/NHKFn/6+A8Snsu4gZNXVqt7yPtbwcT7oLxaT82UnDUow6
        x317mS3A1LJLWa09I2tIBA6FBbxjJ1JMldqN/VCILvmhUuR5GDuagGW3ljE4X9LNtP3u3jU8Hm7U5
        +uANPeEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm9PN-00B10a-US; Wed, 04 May 2022 07:26:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5E1730017D;
        Wed,  4 May 2022 09:26:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDBC22029A1DC; Wed,  4 May 2022 09:26:47 +0200 (CEST)
Date:   Wed, 4 May 2022 09:26:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix SLS checks
Message-ID: <YnIqt4aOooAvlja4@hirez.programming.kicks-ass.net>
References: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
 <20220502181547.fzz2yre2p4akph4s@treble>
 <YnA8Yw19AQV28w54@hirez.programming.kicks-ass.net>
 <20220503211510.ytdv5l4l2zwjdwg7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503211510.ytdv5l4l2zwjdwg7@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 02:15:10PM -0700, Josh Poimboeuf wrote:
> On Mon, May 02, 2022 at 10:17:39PM +0200, Peter Zijlstra wrote:
> > > +++ b/tools/objtool/check.c
> > > @@ -3842,9 +3842,6 @@ static int validate_sls(struct objtool_file *file)
> > >  	for_each_insn(file, insn) {
> > >  		next_insn = next_insn_same_sec(file, insn);
> > >  
> > > -		if (insn->retpoline_safe)
> > > -			continue;
> > > -
> > >  		switch (insn->type) {
> > >  		case INSN_RETURN:
> > >  			if (!next_insn || next_insn->type != INSN_TRAP) {
> > 
> > Yes, agreed. But perhaps with something like this on top?
> 
> Yup, I missed those...  Looks good.  Just one comment:
> 
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -452,6 +452,17 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> >  		return ret;
> >  	i += ret;
> >  
> > +#ifdef CONFIG_SLS
> > +	/*
> > +	 * Ideally this would be unconditional, except in case of
> > +	 * RETPOLINE_LFENCE we don't have sufficient space. Additionally,
> > +	 * -mharden-sls=all should be extended to emit INT3 after
> > +	 * direct jumps too, which will then cover that case.
> > +	 */
> 
> I don't quite follow this 2nd sentence and how it's related here, since
> this function doesn't actually deal with direct jumps.

Ah, my bad. Also, this wrong.

I suppose this wants to be something like:

	if (i < insn->length && op == JMP32_INSN_OPCODE)
		bytes[i++] = INT3_INSN_OPCODE;

So this *can* be a jump, but typically won't be I suppose.

> Speaking of, I guess we'll eventually need to hack this SLS mess into
> jump labels :-/

Urgh... can't we reason that the straight line case is actually expected
to run with the given register state anyway and ignore this?
