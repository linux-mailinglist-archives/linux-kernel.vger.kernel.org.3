Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902EE551191
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiFTHfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiFTHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:35:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E2AE76
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KuxuOwm8WkLtH8CAws9zFjiLjGew//3+cwkg+2fol+M=; b=S2IfV1aNCqbSdQdz7NKG80lxFY
        LRt3jlo2Jxu+InJDxT/6vFse2sekCpU+Nipm+OCIRO+SBS93fqTwpvOvXIp0GbsRnDDOkP/m1ijMK
        r7yyChxkKGB2d/UGDO66+MruyjstTdfYuSox5Fb/MXpXw7DbOPj7b+AP6oVNoVMZSHEsmawaHz0NN
        vsZExcuQHSIXVWSJYcOVjbF/N8xxa+SbzPRTyc+g581E08RRQ8wSz4iUCXQiFg90PiKJUfdvDIsJe
        wJHRN3Kxz2dJZdWHpkD1koOY080YlI+xpcmYM45+pOvEaosjMJtYvaLFbQDtI3FX7VUngOraYd5Af
        +hM2I96g==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3BwP-009Pgj-IY; Mon, 20 Jun 2022 07:35:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3F57300212;
        Mon, 20 Jun 2022 09:35:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 852D029A25D80; Mon, 20 Jun 2022 09:35:20 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:35:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <YrAjOHDrkXQPLv+6@hirez.programming.kicks-ass.net>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
 <20220617201142.yea5ze7od43fat4o@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617201142.yea5ze7od43fat4o@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:11:42PM -0700, Josh Poimboeuf wrote:
> On Fri, Jun 17, 2022 at 01:24:53PM +0200, Peter Zijlstra wrote:
> > 
> > Hi,
> > 
> > I recently noticed that __mcount_loc is 64bit wide, containing absolute
> > addresses. Since __mcount_loc is a permanent section (not one we drop
> > after boot), this bloats the kernel memory usage for no real purpose.
> > 
> > The below patch adds __mcount_loc_32 and objtool support to generate it.
> > This saves, on an x86_64-defconfig + FTRACE, 23975*4 ~= 94K of permanent
> > storage.
> > 
> > XXX hobbled sorttable for now
> > XXX compile tested only
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Nice!
> 
> Some nits:
> 
> - No need for renaming the section, it can still be called
>   '__mcount_loc' regardless?

I wanted to avoid mixing them by accidental build funnies, also, it
having a different name makes it easier to check what's what with a
simple readelf.

> - No need for a new FTRACE_MCOUNT32_USE_OBJTOOL config option or
>   '--mcount32' cmdline option, just change the old ones to be pc32?

Right, so I did that because of the pending --mcount patches for Power.
If Christophe is on board with that, sure, can do.

> - change "32" to "PC32": CC_USING_MCOUNT_LOC_PC32

Right.
