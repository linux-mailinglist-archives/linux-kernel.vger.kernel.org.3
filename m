Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885ED4B1057
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbiBJO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:26:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiBJO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:26:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A121B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:26:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0C53B8204B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F6CC004E1;
        Thu, 10 Feb 2022 14:26:18 +0000 (UTC)
Date:   Thu, 10 Feb 2022 09:26:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] tracing: uninline trace_trigger_soft_disabled()
Message-ID: <20220210092617.2bb40912@gandalf.local.home>
In-Reply-To: <38191e96ec6d331662ee7278e26edb79cdf95402.1644482771.git.christophe.leroy@csgroup.eu>
References: <38191e96ec6d331662ee7278e26edb79cdf95402.1644482771.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 09:47:52 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> On a ppc32 build with CONFIG_CC_OPTIMISE_FOR_SIZE,
> trace_trigger_soft_disabled() appears more than 50 times in vmlinux.
> 
> That function is rather big for an inlined function, and
> it doesn't benefit much from inlining as its only parameter
> is a pointer to a struct in memory:

The number of parameters is not the reason for it being inlined. It's in a
*very* hot path, and a function call causes a noticeable performance hit.


> 
> 	c003df60 <trace_trigger_soft_disabled>:
> 	c003df60:	94 21 ff f0 	stwu    r1,-16(r1)
> 	c003df64:	7c 08 02 a6 	mflr    r0
> 	c003df68:	90 01 00 14 	stw     r0,20(r1)
> 	c003df6c:	bf c1 00 08 	stmw    r30,8(r1)
> 	c003df70:	83 e3 00 24 	lwz     r31,36(r3)
> 	c003df74:	73 e9 01 00 	andi.   r9,r31,256
> 	c003df78:	41 82 00 10 	beq     c003df88 <trace_trigger_soft_disabled+0x28>
> 	c003df7c:	38 60 00 00 	li      r3,0
> 	c003df80:	39 61 00 10 	addi    r11,r1,16
> 	c003df84:	4b fd 60 ac 	b       c0014030 <_rest32gpr_30_x>
> 	c003df88:	73 e9 00 80 	andi.   r9,r31,128
> 	c003df8c:	7c 7e 1b 78 	mr      r30,r3
> 	c003df90:	41 a2 00 14 	beq     c003dfa4 <trace_trigger_soft_disabled+0x44>
> 	c003df94:	38 c0 00 00 	li      r6,0
> 	c003df98:	38 a0 00 00 	li      r5,0
> 	c003df9c:	38 80 00 00 	li      r4,0
> 	c003dfa0:	48 05 c5 f1 	bl      c009a590 <event_triggers_call>
> 	c003dfa4:	73 e9 00 40 	andi.   r9,r31,64
> 	c003dfa8:	40 82 00 28 	bne     c003dfd0 <trace_trigger_soft_disabled+0x70>
> 	c003dfac:	73 ff 02 00 	andi.   r31,r31,512
> 	c003dfb0:	41 82 ff cc 	beq     c003df7c <trace_trigger_soft_disabled+0x1c>
> 	c003dfb4:	80 01 00 14 	lwz     r0,20(r1)
> 	c003dfb8:	83 e1 00 0c 	lwz     r31,12(r1)
> 	c003dfbc:	7f c3 f3 78 	mr      r3,r30
> 	c003dfc0:	83 c1 00 08 	lwz     r30,8(r1)
> 	c003dfc4:	7c 08 03 a6 	mtlr    r0
> 	c003dfc8:	38 21 00 10 	addi    r1,r1,16
> 	c003dfcc:	48 05 6f 6c 	b       c0094f38 <trace_event_ignore_this_pid>
> 	c003dfd0:	38 60 00 01 	li      r3,1
> 	c003dfd4:	4b ff ff ac 	b       c003df80 <trace_trigger_soft_disabled+0x20>
> 
> It doesn't benefit much from inlining as its only parameter is a
> pointer to a struct in memory so no constant folding is involved.
> 
> Uninline it and move it into kernel/trace/trace_events_trigger.c
> 
> It reduces the size of vmlinux by approximately 10 kbytes.

If you have an issue with the size, perhaps the function can be modified to
condense it. I'm happy to have a size reduction, but I will NACK making it
into a function call.

-- Steve
