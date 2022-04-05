Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090554F4F01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452504AbiDFAWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573627AbiDET0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:26:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF532A724
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:24:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649186643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBpB8VyxqrML+VkIgBACu3iDqkhROgmwY7tjmIL4eEE=;
        b=0YmWQ54GkWT2NyXGn63FPu1pDnwVGzslkscg3ZFExIQ8m2BaT52W5VRmmFm6Jo912toFTf
        X1OEXx87VodFjGDyTmiHx1DvSOdlVcAl0GGIWPAms8941lMbULhzTHxmbCQWN3DGQdigxs
        L3IxfFvVyj6LTuVtR5vn3kGGlEHVaygjtThf/A/4IfIOlggVPigp5uIhEZa2RFY+Dgss61
        91M9Z4H4Kvx/vT1d52k3eagql13WZLcdzVzp9NYWbQhR6ow7ALfiUtrK2EKh2Ak6zkEJc+
        /hWejh+vKveLC+yyzAFKE8HiAKM8qZ4FM/NAThEbUejeXneaQ2VJ52nKQzjT4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649186643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBpB8VyxqrML+VkIgBACu3iDqkhROgmwY7tjmIL4eEE=;
        b=WclwfULHFh8wlhXABkAJLoc04RlSlmfsy2db9G/uVbLQm27G9toMbYtAdwMQ+WHfCWRaX6
        WWuYxxTGDwCY/yDQ==
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/alternative: record .altinstructions section
 entity size
In-Reply-To: <Yi4ybwog/H4gk5Ts@localhost.localdomain>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-3-adobriyan@gmail.com>
 <20220312211740.GG28057@worktop.programming.kicks-ass.net>
 <Yi4ybwog/H4gk5Ts@localhost.localdomain>
Date:   Tue, 05 Apr 2022 21:24:02 +0200
Message-ID: <87o81f1gh9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13 2022 at 21:05, Alexey Dobriyan wrote:
> On Sat, Mar 12, 2022 at 10:17:40PM +0100, Peter Zijlstra wrote:
>> On Fri, Mar 11, 2022 at 05:43:10PM +0300, Alexey Dobriyan wrote:
>> > +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof=
_struct_alt_instr) "\n"\
>> > +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof=
_struct_alt_instr) "\n"\
>> > +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof=
_struct_alt_instr) "\n"\
>>=20
>> > +	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr
>> > +	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr
>>=20
>> Aside of adding entsize, you're also adding the M(ergable) bit. Also,
>> those lines are on the unwieldy side of things.
>
> binutils doc says
>
> 	https://sourceware.org/binutils/docs/as/Section.html
>
> 	If flags contains the M symbol then the type argument must be specified =
as well as an extra argument=E2=80=94entsize=E2=80=94like this:
>
> 	.section name , "flags"M, @type, entsize
>
> 	Sections with the M flag but not S flag must contain fixed size constant=
s,
> 	each entsize octets long. Sections with both M and S must contain zero
> 	terminated strings where each character is entsize bytes long. The linker
> 	may remove duplicates within sections with the same name, same entity si=
ze
> 	and same flags. entsize must be an absolute expression. For sections with
> 	both M and S, a string which is a suffix of a larger string is considered
> 	a duplicate. Thus "def" will be merged with "abcdef"; A reference to the
> 	first "def" will be changed to a reference to "abcdef"+3.
>
> "a"M doesn't work, but "aM" does.
>
> I don't know if merging is the issue, it is not like alt replacements hav=
e names.

That does not matter. M merges any duplications in sections with the
same [section] name, entity size and flags.

     .pushsection .bar "aM" @progbits, 4
     .byte 0x01, 0x02, 0x03, 0x04
     .popsection

     .pushsection .bar "aM" @progbits, 4
     .byte 0x01, 0x02, 0x03, 0x04
     .popsection

Will create a section .bar with lenght 4 and the content:
     0x1,0x2,0x3,0x4

What saves you here is the fact that the altinstruction entries are
guaranteed to be unique, but that wants a big fat comment.

Thanks,

        tglx
