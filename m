Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BBC4DE449
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiCRWtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbiCRWtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:49:49 -0400
X-Greylist: delayed 828 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 15:48:30 PDT
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F917268C38;
        Fri, 18 Mar 2022 15:48:30 -0700 (PDT)
Received: from [IPv6:::1] ([IPv6:2601:646:8600:40c1:8f0c:2533:51ff:d719])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 22IMltGC1012727
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 18 Mar 2022 15:47:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 22IMltGC1012727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022030301; t=1647643676;
        bh=eQmUnf4BQ6Am5omHpUeOWcJu4ubjTaOa1UmiRCl9H4A=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=FjhPFIrk+8dUdZPRs95FCMKlxROzpjTBqlqt1yqa4v1OWFiKnD4uXULa4YjMf/1Yd
         jIcsOz4fu2fiJJzZuEyv5DAiWz+fnYMetgYZRq9ZJBSJzYLJvsJZMLvq++A3TcYmTL
         a4QWVdrWQFloz4VuA1nDVPOS2H8iN5Y3RBgI8NxOJ7kjK2uFKvpm2WQPWYWETmVBt2
         A33qv13r63/moq+OBS04JKvyzYsEifUhTMnxbCBeHz2uqpBeW2bZdd2GdUvdSDWv0R
         PjEQvAANiuXAZhr7Rjy9FGqM9EM1cLqeJ3I98K6cvo/7NFARUVLXlGpBDk97GJLP0S
         YvF6UXcUsoc5w==
Date:   Fri, 18 Mar 2022 15:47:49 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Segher Boessenkool'" <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH v5] x86: use builtins to read eflags
User-Agent: K-9 Mail for Android
In-Reply-To: <ad0d80fdfb404df6a98c68e759fca199@AcuMS.aculab.com>
References: <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com> <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org> <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com> <20220318220901.GS614@gate.crashing.org> <ad0d80fdfb404df6a98c68e759fca199@AcuMS.aculab.com>
Message-ID: <93EDA96C-0EAD-4C40-ABEA-28C8BF76A9F9@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 18, 2022 3:36:48 PM PDT, David Laight <David=2ELaight@ACULAB=2ECOM=
> wrote:
>From: Segher Boessenkool
>> Sent: 18 March 2022 22:09
>=2E=2E=2E
>> It generally is a very good idea to
>> have a redzone though, without it you pay much more than necessary for
>> frame setup and teardown in leaf functions (similar to some of what the
>> misnamed "shrink-wrapping" optimisation does, but the two are mostly
>> independent, the benefits add up)=2E
>
>Are there really leaf functions that need to spill data to stack
>where the cost of setting up a stack frame is significant?
>
>I'd have thought that was relatively rare=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
>Registration No: 1397386 (Wales)
>
>

Yes=2E
