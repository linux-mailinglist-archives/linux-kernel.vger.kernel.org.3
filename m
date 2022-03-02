Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9344C9C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbiCBDdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiCBDdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:33:35 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D783C140AF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:32:52 -0800 (PST)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 834F1C0004;
        Wed,  2 Mar 2022 03:32:47 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 01 Mar 2022 19:32:47 -0800
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
In-Reply-To: <Yh7fLRYl8KgMcOe5@google.com>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <Yh7fLRYl8KgMcOe5@google.com>
Message-ID: <f07f50b634e160f543c2a77ec39a2b4f@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-01 19:06, Peter Collingbourne wrote:
> Hi Peter,
> 
> One issue with this call sequence is that:
> 
> On Fri, Feb 11, 2022 at 02:38:03PM +0100, Peter Zijlstra wrote:
>> caller:
>> 	cmpl	$0xdeadbeef, -0x4(%rax)		# 7 bytes
> 
> Because this instruction ends in the constant 0xdeadbeef, it may
> be used as a "gadget" that would effectively allow branching to an
> arbitrary address in %rax if the attacker can arrange to set ZF=1.
> 
>> 	je	1f				# 2 bytes
>> 	ud2					# 2 bytes
>> 1:	call	__x86_indirect_thunk_rax	# 5 bytes
>> 
>> 
>> 	.align 16
>> 	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
>> func:
>> 	endbr					# 4 bytes
>> 	...
>> 	ret
> 
> I think we can avoid this problem with a slight tweak to your
> instruction sequence, at the cost of 2 bytes per function prologue.
> First, change the call sequence like so:
> 
>  	cmpl	$0xdeadbeef, -0x6(%rax)		# 6 bytes
> 	je	1f				# 2 bytes
> 	ud2					# 2 bytes
> 1:	call	__x86_indirect_thunk_rax	# 5 bytes
> 
> The key difference is that we've changed 0x4 to 0x6.
> 
> Then change the function prologue to this:
> 
> 	.align 16
> 	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
> 	.zero 2					# 2 bytes
> func:
> 
> The end result of the above is that the constant embedded in the cmpl
> instruction may only be used to reach the following ud2 instruction,
> which will "harmlessly" terminate execution in the same way as if
> the prologue signature did not match.

FWIIW, this makes sense IMHO. These additional pre-prologue bytes are 
also what might be needed to enable the smaller version of FineIBT that 
I suggested in this thread some time ago.
