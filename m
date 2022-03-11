Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B744E4D642B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbiCKO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbiCKO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:58:02 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3211B3735
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:56:58 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KFTY43pHCz9sS8;
        Fri, 11 Mar 2022 15:56:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vtr32IuOipKO; Fri, 11 Mar 2022 15:56:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KFTY42whNz9sS7;
        Fri, 11 Mar 2022 15:56:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B5D88B78D;
        Fri, 11 Mar 2022 15:56:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ob3X9aOzhGZu; Fri, 11 Mar 2022 15:56:56 +0100 (CET)
Received: from [192.168.202.87] (unknown [192.168.202.87])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 773B58B763;
        Fri, 11 Mar 2022 15:56:55 +0100 (CET)
Message-ID: <c0b8cb0e-cd96-d660-db87-51ded45435c2@csgroup.eu>
Date:   Fri, 11 Mar 2022 15:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] powerpc/32: Add support for out-of-line static calls
Content-Language: fr-FR
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <97f252fcd63e145f54fbf85124c75fb01e96e1bb.1630415517.git.christophe.leroy@csgroup.eu>
 <YS419Exj6PpESVc/@hirez.programming.kicks-ass.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <YS419Exj6PpESVc/@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Le 31/08/2021 à 16:00, Peter Zijlstra a écrit :
> On Tue, Aug 31, 2021 at 01:12:26PM +0000, Christophe Leroy wrote:
> 
> Yes, this should work nicely!
> 
> Since you have the two nop's at the end, you could frob in an
> optimization for __static_call_return0 without too much issue.
> 
> Replace the two nops with (excuse my ppc asm):
> 
> 	li r3, 0
> 	blr
> 
> and augment arch_static_call_transform() with something like:
> 
> 	if (func == &__static_call_return0)
> 		err = patch_branch(tramp, tramp+24, 0);

I just discovered that we likely have an issue with the implementation 
of that RET0 static call.

Looking at System.map I have:

	c0004fc0 t __static_call_return0
	c0011518 t __static_call_return0
	c00d8160 t __static_call_return0


So when we do:

	if (func == &__static_call_return0)

It is unlikely that we'll get the expected one.


I see __static_call_return0 is defined as 'static inline' in 
include/linux/static_call.h

Any reason for not having it as a single global symbol instead ?

Thanks
Christophe
