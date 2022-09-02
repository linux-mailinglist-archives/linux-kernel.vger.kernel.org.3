Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C2D5AAA53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiIBInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiIBIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:42:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7646DAFADC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kyUq76Ekypnho/k0EISFYQkD5KK5rKzGsuomfL+eaXc=; b=lC/XLdh8VjG1swl38+yATsXvz3
        r6gwmqc2fYBtTbRW1eo85+4AMiO6E6/2aJ6THbpInNUlmeMKt3GhkNVy2uLq0QMz+pkw6c62y+5zs
        4Jgtt20xoA/PrrpZqKIkEr/sTdS1C/DfXr7RioekxoS3gM/c+KxYShn+KBf+CYQVBYyTz6sOSYPKr
        zA/fuz/3o7pf4KQyujptDcXRVlo///hpm7j+x9IpOZfxbdNB6r8/SbI8eOgz/vAODNX2wKEvUhZ/s
        /6tGqbWCZ32XiTaSegBK5VgHc2thAUjL+TvtDwt6McfUTx0ctUU/rJPbw8FyC7SF6HP1XJNbNZHox
        W7X7E9Nw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU2Fo-008cnp-OP; Fri, 02 Sep 2022 08:42:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC8003002C7;
        Fri,  2 Sep 2022 10:42:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C62CB2B8A3BCB; Fri,  2 Sep 2022 10:42:17 +0200 (CEST)
Date:   Fri, 2 Sep 2022 10:42:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 08/16] objtool: Fix SEGFAULT
Message-ID: <YxHB6VzfXYozAPEA@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-9-sv@linux.ibm.com>
 <YxEGD0TVWtXTjcGR@hirez.programming.kicks-ass.net>
 <66a3976b-48c1-f8c4-aee0-d04c2c11f5af@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66a3976b-48c1-f8c4-aee0-d04c2c11f5af@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:06:28AM +0000, Christophe Leroy wrote:
> 
> 
> Le 01/09/2022 à 21:20, Peter Zijlstra a écrit :
> > On Mon, Aug 29, 2022 at 11:22:15AM +0530, Sathvika Vasireddy wrote:
> >> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>
> >> find_insn() will return NULL in case of failure. Check insn in order
> >> to avoid a kernel Oops for NULL pointer dereference.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   tools/objtool/check.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> >> index 91678252a9b6..ed2fdfeb1d9c 100644
> >> --- a/tools/objtool/check.c
> >> +++ b/tools/objtool/check.c
> >> @@ -205,7 +205,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
> >>   		return false;
> >>   
> >>   	insn = find_insn(file, func->sec, func->offset);
> >> -	if (!insn->func)
> >> +	if (!insn || !insn->func)
> >>   		return false;
> > 
> > I suppose this is ok, but how can the lookup for func->sec, func->offset
> > *not* find an instruction ?!
> 
> That happened to me at the begining when the port to powerpc was not 
> fully functionnal.
> 
> I guess that could also happen with a corrupted object file so better 
> safe than sorry.

Fair enough.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
