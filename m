Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA10459A49C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350102AbiHSRxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352000AbiHSRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D847B99
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2096A61825
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6027EC433D6;
        Fri, 19 Aug 2022 17:28:00 +0000 (UTC)
Date:   Fri, 19 Aug 2022 13:28:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <jpoimboe@kernel.org>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/unwind/orc: unwind ftrace trampolines with
 correct orc
Message-ID: <20220819132812.391619d2@gandalf.local.home>
In-Reply-To: <20220819084334.244016-1-chenzhongjin@huawei.com>
References: <20220819084334.244016-1-chenzhongjin@huawei.com>
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

On Fri, 19 Aug 2022 16:43:34 +0800
Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> When meeting ftrace trampolines in orc unwinding, unwinder uses address
> of ftrace_{regs_}call address to find the orc, which gets next frame at
> sp+176.
> 
> If there is an irq hitting at sub $0xa8,%rsp, the next frame should be
> sp+8 instead of 176. It makes unwinder skip correct frame and throw
> warnings such as "wrong direction" or "can't access registers", etc,
> depending on the content of the wrong frame address.
> 
> By adding the base address ftrace_{regs_}caller with the offset
> *ip - ops->trampoline*,
> we can get the correct address to find orc.
> 
> Also change "caller" to "tramp_addr" to make variable name conform to
> its content.
> 
> Fixes: 6be7fa3c74d1 ("ftrace, orc, x86: Handle ftrace dynamically allocated trampolines")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Would someone from the tip tree care to pull this in?

-- Steve
