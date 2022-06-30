Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F40561FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiF3QHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiF3QHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:07:23 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5A7D1AF0F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:07:18 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 25UFwEc4007186;
        Thu, 30 Jun 2022 10:58:14 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 25UFwBWR007180;
        Thu, 30 Jun 2022 10:58:11 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 30 Jun 2022 10:58:11 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Sathvika Vasireddy <sv@linux.vnet.ibm.com>,
        Marc Zyngier <maz@kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v3 11/12] powerpc: Remove unreachable() from WARN_ON()
Message-ID: <20220630155811.GK25951@gate.crashing.org>
References: <20220624183238.388144-1-sv@linux.ibm.com> <20220624183238.388144-12-sv@linux.ibm.com> <70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu> <92eae2ef-f9b6-019a-5a8e-728cdd9bbbc0@linux.vnet.ibm.com> <cce19b1c-449a-f306-533a-9edc855049aa@csgroup.eu> <1656572413.pbaqjnrrcl.naveen@linux.ibm.com> <da86c612-186d-364f-cc36-bcf942a97083@csgroup.eu> <1656583960.0nqsj977sr.naveen@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656583960.0nqsj977sr.naveen@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 04:07:47PM +0530, Naveen N. Rao wrote:
> Objtool classifies 'ud2' as INSN_BUG, and 'int3' as INSN_TRAP. In x86 
> BUG(), there is no need for an annotation since objtool assumes that 
> 'ud2' terminates control flow. But, for __WARN_FLAGS(), since 'ud2' is 
> used, an explicit annotate_reachable() is needed. That's _reachable_, to 
> indicate that the control flow can continue with the next instruction.
> 
> On powerpc, we should (eventually) classify all trap variants as 
> INSN_TRAP. Even in the absence of that classification today, objtool 
> assumes that control flow continues with the next instruction. With your 
> work to utilize asm goto for __WARN_FLAGS(), with no extra instructions 
> being generated, I think it is appropriate to just use 
> __builtin_unreachable() and to not use the annotation.
> 
> In any case, we are only hitting this since gcc is generating a 'bl' due 
> to that annotation. We are not yet enabling full objtool validation on 
> powerpc, so I think we can revisit this at that point.

See also <https://gcc.gnu.org/PR99299> that asks for a __builtin_trap()
variant that does not terminate control flow ("that is recoverable").


Segher
