Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC8565441
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiGDMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiGDMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:02:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4458D11824
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oRxEExQGS51+M6WTe0WINDdntAU5Zr4k/poXigFL9/0=; b=nTR50XltwL+mBbqsdP+QoMm9wn
        VSHAFb183oqYta6DoOt5wmkBwjWtV5zR6H5s22nxpHuzDdV5GFM28RKggvvuLDa5EQvKY+ebG8xuw
        GgFONDiYmlLpq3uK0rv4DYfSfbHOteYsj9ptpSQNOPVHX0bWb3O89/GjQi180IuY6xkZDw2uj8Gx6
        wpG+oeboK7Xy/7UI3LSH6ZahL9DwKWjoxoO7xIa1SncyjZBwMZOMPOg+xZiwbFwV1xLAJCDRZ6wLx
        ziomw1HwDOEJaP50X4tmRMZSxhgqdhj0qYtyNg33R3i9yzHOuFfNC2OUgZD9gmAgI32Wfu7dblN5j
        /Xp9AdlQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Klv-00HEd0-PZ; Mon, 04 Jul 2022 12:01:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17333300252;
        Mon,  4 Jul 2022 14:01:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F15FA2028F029; Mon,  4 Jul 2022 14:01:46 +0200 (CEST)
Date:   Mon, 4 Jul 2022 14:01:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Sathvika Vasireddy <sv@linux.vnet.ibm.com>,
        Marc Zyngier <maz@kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v3 11/12] powerpc: Remove unreachable() from WARN_ON()
Message-ID: <YsLWqkanM0lxcvP8@hirez.programming.kicks-ass.net>
References: <20220624183238.388144-1-sv@linux.ibm.com>
 <20220624183238.388144-12-sv@linux.ibm.com>
 <70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu>
 <92eae2ef-f9b6-019a-5a8e-728cdd9bbbc0@linux.vnet.ibm.com>
 <cce19b1c-449a-f306-533a-9edc855049aa@csgroup.eu>
 <1656572413.pbaqjnrrcl.naveen@linux.ibm.com>
 <da86c612-186d-364f-cc36-bcf942a97083@csgroup.eu>
 <1656583960.0nqsj977sr.naveen@linux.ibm.com>
 <20220630155811.GK25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630155811.GK25951@gate.crashing.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:58:11AM -0500, Segher Boessenkool wrote:
> On Thu, Jun 30, 2022 at 04:07:47PM +0530, Naveen N. Rao wrote:
> > Objtool classifies 'ud2' as INSN_BUG, and 'int3' as INSN_TRAP. In x86 
> > BUG(), there is no need for an annotation since objtool assumes that 
> > 'ud2' terminates control flow. But, for __WARN_FLAGS(), since 'ud2' is 
> > used, an explicit annotate_reachable() is needed. That's _reachable_, to 
> > indicate that the control flow can continue with the next instruction.
> > 
> > On powerpc, we should (eventually) classify all trap variants as 
> > INSN_TRAP. Even in the absence of that classification today, objtool 
> > assumes that control flow continues with the next instruction. With your 
> > work to utilize asm goto for __WARN_FLAGS(), with no extra instructions 
> > being generated, I think it is appropriate to just use 
> > __builtin_unreachable() and to not use the annotation.
> > 
> > In any case, we are only hitting this since gcc is generating a 'bl' due 
> > to that annotation. We are not yet enabling full objtool validation on 
> > powerpc, so I think we can revisit this at that point.
> 
> See also <https://gcc.gnu.org/PR99299> that asks for a __builtin_trap()
> variant that does not terminate control flow ("that is recoverable").

Re comment 9 there, x86 must assume ud2 will abort. If the compiler were
to emit ud2 for non-abort purposes then it needs to somehow annotate
this so that both objtool and the kernel can determine this.

That said; the whole annotate_reachable() thing in our WARN is
superfluous, we should read __bug_table instead. That said, we still
need _ASM_REACHABLE to handle a few noreturn cases, so there is no real
pressing reason to go clean that up. (if only the compiler would tell us
about noreturn)

ARM has an immediate in their break instruction and varies the desired
behaviour depending on the immediate.

