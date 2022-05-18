Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289352B973
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiERMEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiERMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:04:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7783632C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:04:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3BV63YQ6z4xbP;
        Wed, 18 May 2022 22:03:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652875438;
        bh=tCWgxXr7XXOx2XHZ9VRkQnDGXiWz2tzxEYsme/eLKqE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bgEw3lhpumxzhiCa0NmLobkT9jCCBKGXzAYGvAAKp4y6+qKbEoTuUzgD3lmp9ZpQP
         X19kR3JPHCXNMK0FkYN276FM5ipkoO1DkQKOZOCHCpu4aJfGi+WuSiMSatT7/e6XtJ
         HHvd0uonUT9wLssaLa3oG2bW0M+HhUcdY1/6+AmCT5HcK5LTLFR5lJqn7+ChNlo+2v
         BKS5BkFqVQ35v9urZsHSR0W/eVnDf3aLOMDn1x+BXUXqpgbWiFHfVYR4qQBrZB5VlK
         +/asA2hBbKnUQu0jFO0kubBmsXwfG8aeJX2vd/Ub5EAa8jJ5QMJ6Z16WnstFzAKjKT
         EtWcZCuakOCpQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 19/25] powerpc/ftrace: Minimise number of #ifdefs
In-Reply-To: <87leuznl5h.fsf@mpe.ellerman.id.au>
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
 <18ce6708d6f8c71d87436f9c6019f04df4125128.1652074503.git.christophe.leroy@csgroup.eu>
 <1652866821.cdcfe8bs78.naveen@linux.ibm.com>
 <87leuznl5h.fsf@mpe.ellerman.id.au>
Date:   Wed, 18 May 2022 22:03:55 +1000
Message-ID: <87ilq3nj2s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> Christophe Leroy wrote:
>>> A lot of #ifdefs can be replaced by IS_ENABLED()
>>> 
>>> Do so.
>>> 
>>> This requires to have kernel_toc_addr() defined at all time
>>> as well as PPC_INST_LD_TOC and PPC_INST_STD_LR.
>>> 
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>> v2: Moved the setup of pop outside of the big if()/else() in __ftrace_make_nop()
>>> ---
>>>  arch/powerpc/include/asm/code-patching.h |   2 -
>>>  arch/powerpc/include/asm/module.h        |   2 -
>>>  arch/powerpc/include/asm/sections.h      |  24 +--
>>>  arch/powerpc/kernel/trace/ftrace.c       | 182 +++++++++++------------
>>>  4 files changed, 103 insertions(+), 107 deletions(-)
>>> 
>>
>> <snip>
>>
>>> @@ -710,6 +707,9 @@ void arch_ftrace_update_code(int command)
>>> 
>>>  #ifdef CONFIG_PPC64
>>>  #define PACATOC offsetof(struct paca_struct, kernel_toc)
>>> +#else
>>> +#define PACATOC 0
>>> +#endif
>>
>> This conflicts with my fix for the ftrace init tramp:
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220516071422.463738-1-naveen.n.rao@linux.vnet.ibm.com/
>>
>> It probably makes sense to retain #ifdef CONFIG_PPC64, so that we can 
>> get rid of the PACATOC. Here is an incremental diff:
>
> Where is the incremental diff meant to apply?
>
> It doesn't apply on top of patch 19, or at the end of the series.

I think I worked out what you meant.

Can you check what's in next-test:

  https://github.com/linuxppc/linux/commits/next-test

cheers
