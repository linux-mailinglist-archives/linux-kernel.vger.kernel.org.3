Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78450B3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiDVJRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445917AbiDVJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:15:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62AC51E73
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:12:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kl7wf0njlz4xXS;
        Fri, 22 Apr 2022 19:12:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1650618771;
        bh=TAQU4yACc/OpJ4CrlRCjZa4rq8YrRjfIqrgtYmrgmq8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Kluun7t1yUg109zhUX0NKdQDXUS57TjUMNfWa33hSC3kQoiszVF4V4VbMEt6kNQLS
         VMSD8Lv9ktUSJAoTylgu1kmx2DeejrCGR5Ov1ws0dHU/ggozuXn6xPUTp1BLvcogCN
         tSEj8ybnDEIRnhoQCSlCQ+utsfavEI6puFSK/x4C0xCJPfiYDwFLT4xvZ59M3SJpSv
         GI2foayEyAw1DN+7qMxZjjQPpwQ5PmVI99eUbiubs9X65wSHK4NXtTieLOjEaw5pss
         3lBgp0arVWxkjvR0IgWdhTMoPS6SUrCH4wmY/kfyFBJcoGKQcbwsHqXEysY4k9oBDH
         Z2Je52wsOeogA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 06/22] powerpc/ftrace: Inline ftrace_modify_code()
In-Reply-To: <1650261933.e8kr43zvw0.naveen@linux.ibm.com>
References: <cover.1648131740.git.christophe.leroy@csgroup.eu>
 <3b651381f4c53988ede62f4a1505e7e8ccab56b4.1648131740.git.christophe.leroy@csgroup.eu>
 <1650261933.e8kr43zvw0.naveen@linux.ibm.com>
Date:   Fri, 22 Apr 2022 19:12:44 +1000
Message-ID: <87wnfh8os3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Christophe Leroy wrote:
>> Inlining ftrace_modify_code(), it increases a bit the
>> size of ftrace code but brings 5% improvment on ftrace
>> activation.
>> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>  arch/powerpc/kernel/trace/ftrace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
>> index 41c45b9c7f39..98e82fa4980f 100644
>> --- a/arch/powerpc/kernel/trace/ftrace.c
>> +++ b/arch/powerpc/kernel/trace/ftrace.c
>> @@ -53,7 +53,7 @@ ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
>>  	return op;
>>  }
>> 
>> -static int
>> +static inline int
>>  ftrace_modify_code(unsigned long ip, ppc_inst_t old, ppc_inst_t new)
>>  {
>>  	ppc_inst_t replaced;
>
> I thought gcc was free to inline functions without the need for 
> 'inline'.

Yes it is.

> On the flip side, don't we need __always_inline if we want to force 
> inlining?

Yes. Since ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly").

cheers
