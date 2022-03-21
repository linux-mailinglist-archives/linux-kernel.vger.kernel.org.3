Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42BB4E2707
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347631AbiCUM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347625AbiCUM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:57:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812BEDF3A;
        Mon, 21 Mar 2022 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YFlhHXWTNkKh8CB15QpQ7sYR5pmzwsAj6etOr2SZi1A=; b=JlvVlVELnIp48NMJI+ARrQuFjv
        Zi1AvQ4ZxQxzjdm7/LVcyoxoYY+I0Vtf1W/ysTpTfqiKLHoOeL72srIfSZkrIyc2in+1oP5ati8sY
        2hGzP3UMMn5ewty3VJB65a0R0jXJYD0rhTBAXl352vEUMVVQFWARKl7/LJUkKQix21vtHY6ao0m0X
        2y4ykvY7mUZetTCaQzNcv199ONxsl3v8Wh1xH3s/JncQRsjN707up3lbJO+k/aZ9lr74FH2KVsxxD
        TLNsmTYU+BX+s1Kc3sZ+B+jjDyyfWV6YZ/fClDC4w2fxvOQPOhb8d8jCNN00xmyfzjHMClPg0MeDb
        +MRqQATQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWHZd-00AZWq-VL; Mon, 21 Mar 2022 12:55:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7116E3001CD;
        Mon, 21 Mar 2022 13:55:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30D192025BC86; Mon, 21 Mar 2022 13:55:49 +0100 (CET)
Date:   Mon, 21 Mar 2022 13:55:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321140327.777f9554@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:03:27PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the tip tree, today's linux-next build (x864 allmodconfig)
> produced these new warnings:
>=20
> vmlinux.o: warning: objtool: arch_rethook_prepare()+0x55: relocation to !=
ENDBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: arch_rethook_trampoline_callback()+0x3e: rel=
ocation to !ENDBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: unwind_next_frame()+0x93e: relocation to !EN=
DBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: unwind_next_frame()+0x5f2: relocation to !EN=
DBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: unwind_next_frame()+0x4a7: relocation to !EN=
DBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x81: relocation t=
o !ENDBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x90: relocation t=
o !ENDBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x8c: relocatio=
n to !ENDBR: arch_rethook_trampoline+0x0
> vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x9b: relocatio=
n to !ENDBR: arch_rethook_trampoline+0x0

Hurmph, lemme go figure out where that code comes from, I've not seen
those.

> [ Note I was already getting these:
> arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_2block_xor_avx5=
12vl() falls through to next function chacha_8block_xor_avx512vl()
> arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_4block_xor_avx5=
12vl() falls through to next function chacha_8block_xor_avx512vl()
> arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx(=
) falls through to next function poly1305_blocks_x86_64()
> arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_emit_avx() =
falls through to next function poly1305_emit_x86_64()
> arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx2=
() falls through to next function poly1305_blocks_x86_64()

Yes, those are somewhere on the todo list, lemme bump them.
