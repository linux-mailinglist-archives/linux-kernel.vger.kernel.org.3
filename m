Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C45653F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiGDLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiGDLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:44:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE4F584
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XiB+m1tbZAMLJR0lpeEa1msl+Okwne9w6qdT+sTSXdI=; b=DL5O9fjnqjIlwKjHOj4LvSCbSv
        xg8Lk9q384dEivTYB93x6oCtZQM4qWhzjen7a88iTwvDjLzTKHiXHm1vcPKemPWv6UiFQGKdnlOnj
        gN5S1hAXoYRPwhZkBcrNz9wu+QhAvm4VbhqRB7mfSoiQfSRj+0ftuwUv8nzIRv46TWcLKwqmgJy4Q
        aNAGRWcxIZYAayFoSvey9CQxEvs53pIrOCtTzbaiXIlGVziUUK+3uVUFSwUSfFi+TaQpWABHtiyr1
        +7ucvluEhfmBqShzjEfz8UIXW3c5TlbVuCvdZuIPsFTcpTkd6DGkitpxqGMrAGFliw4dW6VfMRGm1
        eZ+LRikw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8KU1-00H70w-Uh; Mon, 04 Jul 2022 11:43:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE2D830003A;
        Mon,  4 Jul 2022 13:43:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4F632028F029; Mon,  4 Jul 2022 13:43:15 +0200 (CEST)
Date:   Mon, 4 Jul 2022 13:43:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Sathvika Vasireddy <sv@linux.vnet.ibm.com>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "paulus@samba.org" <paulus@samba.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v3 11/12] powerpc: Remove unreachable() from WARN_ON()
Message-ID: <YsLSU6idNME/BtwH@hirez.programming.kicks-ass.net>
References: <20220624183238.388144-1-sv@linux.ibm.com>
 <20220624183238.388144-12-sv@linux.ibm.com>
 <70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu>
 <92eae2ef-f9b6-019a-5a8e-728cdd9bbbc0@linux.vnet.ibm.com>
 <cce19b1c-449a-f306-533a-9edc855049aa@csgroup.eu>
 <1656572413.pbaqjnrrcl.naveen@linux.ibm.com>
 <da86c612-186d-364f-cc36-bcf942a97083@csgroup.eu>
 <1656583960.0nqsj977sr.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656583960.0nqsj977sr.naveen@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 04:07:47PM +0530, Naveen N. Rao wrote:

> Objtool classifies 'ud2' as INSN_BUG, and 'int3' as INSN_TRAP. In x86 BUG(),

Yes, ud2 is the traditional 'kill' instruction and a number of emulators
treat it as such, however it also being the shortest encoding (2 bytes)
for #UD Linux has opted to (ab)use it to implement WARN/BUG.

As such interpretation of 'ud2' needs to assume control flow stops
(compiler will also emit ud2 in a number of cases with that intent).
However, if it's used as WARN we then need to annotate the thing to not
be terminal.

> there is no need for an annotation since objtool assumes that 'ud2'
> terminates control flow. But, for __WARN_FLAGS(), since 'ud2' is used, an
> explicit annotate_reachable() is needed. That's _reachable_, to indicate
> that the control flow can continue with the next instruction.
> 
> On powerpc, we should (eventually) classify all trap variants as INSN_TRAP.

Careful.. INSN_TRAP is mostly used for purposes of speculation stop and
padding. That is, INSN_TRAP does indeed not affect control flow, but the
way objtool treats it might not be quite what you want.

Specifically, straight-line-speculation checks want INT3 after indirect
control transfers (indirect jump and return -- indirect call is
'difficult'); these locations are architecturally not executed and as
such placing a random trap instruction there is 'harmless'. Of course,
were the branch predictor to go wobbly and attempt to execute it, the
fact that it's a trap will stop speculation dead.

Additionally, int3, being a single byte instruction, is also used to
fill dead code space, any #BP trap on it will not have a descriptor and
mostly cause the kernel to go splat.

Per the last usage, validate_reachable_instructions() will ignore it.
I'm not sure you want to always ignore all your (unreachable) trap
instructions.
