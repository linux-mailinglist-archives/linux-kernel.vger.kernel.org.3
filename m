Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0F4B7B46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiBOXit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:38:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiBOXir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:38:47 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877C9A4FB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:38:36 -0800 (PST)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 3EEEF240004;
        Tue, 15 Feb 2022 23:38:33 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 15 Feb 2022 15:38:33 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, hjl.tools@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
In-Reply-To: <202202151503.91E9B76B@keescook>
References: <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
 <20220214222550.GB23216@worktop.programming.kicks-ass.net>
 <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
 <202202151129.1A5C5FE42@keescook>
 <20220215210550.GD23216@worktop.programming.kicks-ass.net>
 <202202151503.91E9B76B@keescook>
Message-ID: <4553dfb68285a686737969e117bf48cc@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Mostly so that we can deduce the address of the trap from the 
>> retpoline
>> site, also the above has a fairly high chance of using jcc.d32 which 
>> is
>> actually larger than jcc.d8+ud2.
> 
> Ah, yeah, that's an interesting point.
> 
> Still, I worry about finding ways to convinces Clang to emit precisely
> cmp/je/trap/call, but I guess we'll catch it immediately if it doesn't.
> :P

This can probably be done more easily/precisely if implemented directly
in the compiler's arch-specific backend. At least for x86 it wasn't a
hassle to emit a defined sequence of instructions in the past. The price
is that it will require a pass specific to each supported architecture,
but I guess this isn't that bad.

Perhaps this is discussion for a different mailing list, idk... but
just pointing that it is not a huge wall.
