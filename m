Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23005A9FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiIATT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiIATTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:19:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07FFCC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=degmQsdmDYi+b3tN8qVEdHxJOY/qjnlNSPHaWQEAiVY=; b=FGrf9IAJiAVOym9p1GhlvSefrj
        EMAcQXYDwUSKtr3BnhOlXDOKlieUHY8Rf5w4GBxy6pUtJXDBSk4Xn7ZMN/AP7n6rX6/XldRwjmvwE
        DoBmFfceTOkmSAbOQYn1Rsv5p2QUjxlvaz5RqsL+Pbb3P8Gqja+Tg/y12zx1409yfsmVj7aMRdPr6
        hMZ+0cUQPpBKNz/Nn4xWgwWRa+Xp6Rz+T+I0qHhX5jq07S4kdDuhqiz2wa/7Yndts8BYg1YWPr4J0
        0WCaY/2kKQ+8ds+R95hPgbalGQXcoAUKZexjYQAULb0jkNLjv1G4R4oVwhwr2nj59cO47RKIXVby3
        gU20bt+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTpiv-006IOv-Qp; Thu, 01 Sep 2022 19:19:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 438AD30010B;
        Thu,  1 Sep 2022 21:19:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 350C22B8D5A25; Thu,  1 Sep 2022 21:19:32 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:19:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 07/16] powerpc: Skip objtool from running on VDSO files
Message-ID: <YxEFxJk+2fog+oRx@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-8-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-8-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:14AM +0530, Sathvika Vasireddy wrote:
> Do not run objtool on VDSO files, by using
> OBJECT_FILES_NON_STANDARD
> 
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>  arch/powerpc/kernel/vdso/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
> index 096b0bf1335f..a49a0d6a1c53 100644
> --- a/arch/powerpc/kernel/vdso/Makefile
> +++ b/arch/powerpc/kernel/vdso/Makefile
> @@ -102,3 +102,5 @@ quiet_cmd_vdso64ld_and_check = VDSO64L $@
>        cmd_vdso64ld_and_check = $(VDSOCC) $(c_flags) $(CC64FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
>  quiet_cmd_vdso64as = VDSO64A $@
>        cmd_vdso64as = $(VDSOCC) $(a_flags) $(CC64FLAGS) $(AS64FLAGS) -c -o $@ $<
> +
> +OBJECT_FILES_NON_STANDARD := y

Just to clarify; your linker script will place the VDSO in .rodata or a
similar !.text section, right?
