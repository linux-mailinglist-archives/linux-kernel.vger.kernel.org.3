Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD34D4A60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245306AbiCJOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbiCJOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B501C9A3C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:27:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF72061CF0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C99C340EB;
        Thu, 10 Mar 2022 14:27:43 +0000 (UTC)
Date:   Thu, 10 Mar 2022 09:27:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Ingo Molnar <mingo@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: ftrace: no need to acquire text_mutex when
 executed in stop_machine
Message-ID: <20220310092742.4fcc7131@gandalf.local.home>
In-Reply-To: <20220310045454.672097-1-changbin.du@gmail.com>
References: <20220310045454.672097-1-changbin.du@gmail.com>
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

On Thu, 10 Mar 2022 12:54:54 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> It's safe to patch text segment in stop_machine. No race is possible here.
> Besides, there is a false positive for the lock assertion in
> patch_insn_write() since the lock is not held by cpu migration thread.
> 
> So we actually don't need our ftrace_arch_code_modify_prepare/post(). And
> the lock assertion in patch_insn_write() should be removed to avoid
> producing lots of false positive warnings.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Ideally, RISC-V should try to get off of the stop_machine approach, and
move to the breakpoint modification.

-- Steve
