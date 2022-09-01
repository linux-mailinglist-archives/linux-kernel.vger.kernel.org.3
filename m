Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B05A9FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiIATVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIATVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:21:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3987822B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+roK5D09xrSmOTu3P9Sq1+swSxQSmI55Rozlj/752hc=; b=SA4u3MTjdtlR0YA+gRA5r1ludD
        tFMeaLbxOMYjCyzsUlZvpXhnZc4YYAS+moqdo47PM5WidLL4S5706TPZjOCTaAc+q0My20kmvYY39
        AMHI8bcNaChVJ5vhxGmFOFvqu6WTutPz1gb+a+AZOf/OiqM7bJWaG+eBEaXMe507tvVwSU3kQ+9PR
        UMudahAcskOEDdsg+B4RhmOmTrxVayyUw1n1EAYDo6BDXX0lei+V2/CqeRPZoI4yBMiLxwpYjFhf0
        KsMI/65uOfgkVeJvu1gDAwCq4qvSd0X2PqPYYDcI3sNhxfcYiczEpAcYSNIUXRitYrpiKF2sqHlgc
        9DL1ZnHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTpk8-008TE7-39; Thu, 01 Sep 2022 19:20:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5DC130010B;
        Thu,  1 Sep 2022 21:20:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A69332B8BD272; Thu,  1 Sep 2022 21:20:47 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:20:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 08/16] objtool: Fix SEGFAULT
Message-ID: <YxEGD0TVWtXTjcGR@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-9-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-9-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:15AM +0530, Sathvika Vasireddy wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> find_insn() will return NULL in case of failure. Check insn in order
> to avoid a kernel Oops for NULL pointer dereference.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  tools/objtool/check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 91678252a9b6..ed2fdfeb1d9c 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -205,7 +205,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		return false;
>  
>  	insn = find_insn(file, func->sec, func->offset);
> -	if (!insn->func)
> +	if (!insn || !insn->func)
>  		return false;

I suppose this is ok, but how can the lookup for func->sec, func->offset
*not* find an instruction ?!
