Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9705D4EACCD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiC2MDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiC2MD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:03:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A095BD0E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:01:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KSSpX4blyz4xNm;
        Tue, 29 Mar 2022 23:01:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1648555304;
        bh=01mxyWDLRIt5kimROuqbPGIxm1dCV7lRCsI+Du/e0Ss=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L3kBFENcYSTJQ6cWgshgm35f9FNB8Ew3X782WdaRMzj5n1w6uL8J0Z/9Ys116iCFS
         3PKWwyLdvJr7Urq5zfhmzBHcNgBvtBFVrXcYgUJcLmLdW1ydcCQ87VcVAvUsX5BuNm
         WBZuEPhmLtbthCqRlOVX2bbziX37DusGS6BuAtrp4Di10dnmOkWG+QgHwwm8zOu8Yu
         ZN9UUWjSbHiLGVna/Gx2iXrBrD8HB7QI4Y2ePlRHcqGzwi508PLBVR2T5X7UsVNl0c
         nY6Jcm5fJsxWdKA6Re61fRVd9yvLa+Eq0akkxggx2ECh4uGtyOXf5hKVkr8ZbFYdyM
         vfcsSLcgEpWTA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
In-Reply-To: <20220328195920.dqlfra3lcardko6r@treble>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <0b55f122-4760-c1ba-840a-0911cefec2ad@csgroup.eu>
 <20220328195920.dqlfra3lcardko6r@treble>
Date:   Tue, 29 Mar 2022 23:01:38 +1100
Message-ID: <87mth9ezml.fsf@mpe.ellerman.id.au>
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

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> On Sun, Mar 27, 2022 at 09:09:20AM +0000, Christophe Leroy wrote:
>> Second point is the endianess and 32/64 selection, especially when 
>> crossbuilding. There is already some stuff regarding endianess based on 
>> bswap_if_needed() but that's based on constant selection at build time 
>> and I couldn't find an easy way to set it conditionaly based on the 
>> target being built.
>>
>> Regarding 32/64 selection, there is almost nothing, it's based on using 
>> type 'long' which means that at the time being the target and the build 
>> platform must both be 32 bits or 64 bits.
>> 
>> For both cases (endianess and 32/64) I think the solution should 
>> probably be to start with the fileformat of the object file being 
>> reworked by objtool.
>
> Do we really need to detect the endianness/bitness at runtime?  Objtool
> is built with the kernel, why not just build-in the same target
> assumptions as the kernel itself?

I don't think we need runtime detection. But it will need to support
basically most combinations of objtool running as 32-bit/64-bit LE/BE
while the kernel it's analysing is 32-bit/64-bit LE/BE.

>> What are current works in progress on objtool ? Should I wait Josh's 
>> changes before starting looking at all this ? Should I wait for anything 
>> else ?
>
> I'm not making any major changes to the code, just shuffling things
> around to make the interface more modular.  I hope to have something
> soon (this week).  Peter recently added a big feature (Intel IBT) which
> is already in -next.
>
> Contributions are welcome, with the understanding that you'll help
> maintain it ;-)
>
> Some years ago Kamalesh Babulal had a prototype of objtool for ppc64le
> which did the full stack validation.  I'm not sure what ever became of
> that.

From memory he was starting to clean the patches up in late 2019, but I
guess that probably got derailed by COVID. AFAIK he never posted
anything. Maybe someone at IBM has a copy internally (Naveen?).

> FWIW, there have been some objtool patches for arm64 stack validation,
> but the arm64 maintainers have been hesitant to get on board with
> objtool, as it brings a certain maintenance burden.  Especially for the
> full stack validation and ORC unwinder.  But if you only want inline
> static calls and/or mcount then it'd probably be much easier to
> maintain.

I would like to have the stack validation, but I am also worried about
the maintenance burden.

I guess we start with mcount, which looks pretty minimal judging by this
series, and see how we go from there.

cheers
