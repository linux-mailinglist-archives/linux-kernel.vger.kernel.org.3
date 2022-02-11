Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836F94B2EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiBKU66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:58:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353750AbiBKU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:58:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8EDBC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66BDCB82CF4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC4FC340ED;
        Fri, 11 Feb 2022 20:57:28 +0000 (UTC)
Date:   Fri, 11 Feb 2022 15:57:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <20220211155727.49ab86f5@gandalf.local.home>
In-Reply-To: <87fsopcvnj.fsf@jogness.linutronix.de>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
        <20220207194323.273637-2-john.ogness@linutronix.de>
        <YgZaMkUU5Ve2GV9D@alley>
        <87fsopcvnj.fsf@jogness.linutronix.de>
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

On Fri, 11 Feb 2022 15:48:08 +0106
John Ogness <john.ogness@linutronix.de> wrote:

> It is because (as in the example above), taking this "lock" does not
> provide synchronization to data. It is only synchronizing between
> CPUs. It was Steven's suggestion to call the thing a cpu_sync object and
> nobody in the RT Track seemed to disagree.

I love causing trouble ;-)

Actually, it wasn't just my suggestion. IIRC, I believe Peter Zijlstra was
against calling it a lock (Peter, you can use lore to see the context here).

And besides calling it "goldie locks" I suggested calling it something that
has to do with "synchronization" instead of true exclusiveness. And name it
something to do with keeping one CPU from stepping on another CPU. And the
entire group agreed to not call it a lock, but instead a CPU
synchronization object.

Linux Plumbers RT MC summary:
 https://lpc.events/event/11/page/104-accepted-microconferences#summary-rt

Printk topic video:
 https://youtu.be/5jkvV4A2kT8?list=PLVsQ_xZBEyN3wA8Ej4BUjudXFbXuxhnfc&t=9217

Printk topic slides:
 https://linuxplumbersconf.org/event/11/contributions/1060/attachments/829/1600/lpc2021_rtmc_ogness.pdf

(This is why I pushed all the MCs to provide summaries!)

-- Steve
