Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDBF4B2F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353615AbiBKVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:05:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBKVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:05:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B742D2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=djDzuW0cps2g7Kw8gzqN7GELDrjwVHlIZPy10UxJRYI=; b=i5yDxCAwbRqf/kSNqOJ4w3Mb4m
        zb4rrO/PBj9ceJFio1tJmUpAbdI3K2pKriEmbNS0J6aTZ6l8yJUfnwUo3bMchFF4j1TxHQzWgexDm
        +zi2taLh7aKe6OKERTeuNkNGOnDR41OOtuFo9zo3adt1ZX4X5ibbv9vyvbnau6B/afpbg5wolvSvq
        3tI1eFyH5nXIwqmrP85XGG80Jw+YGffPrWrt7U4z61Q42w+HtJiUixk70usmWS9TfyX+k+8Fe4gUu
        LCV3N3T/a1hIg4smJQLMyf4fwVGGP9+rvRi56XAH41l0sU3K4e5W0fS+2DLNpdhNf0gWEL87uJlrz
        hhVmaLSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nId67-00Ajgv-53; Fri, 11 Feb 2022 21:04:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9C1530022C;
        Fri, 11 Feb 2022 22:04:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3E11264E6612; Fri, 11 Feb 2022 22:04:48 +0100 (CET)
Date:   Fri, 11 Feb 2022 22:04:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <YgbPcAHgC1FLRXdR@hirez.programming.kicks-ass.net>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley>
 <87fsopcvnj.fsf@jogness.linutronix.de>
 <20220211155727.49ab86f5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211155727.49ab86f5@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:57:27PM -0500, Steven Rostedt wrote:
> On Fri, 11 Feb 2022 15:48:08 +0106
> John Ogness <john.ogness@linutronix.de> wrote:
> 
> > It is because (as in the example above), taking this "lock" does not
> > provide synchronization to data. It is only synchronizing between
> > CPUs. It was Steven's suggestion to call the thing a cpu_sync object and
> > nobody in the RT Track seemed to disagree.
> 
> I love causing trouble ;-)
> 
> Actually, it wasn't just my suggestion. IIRC, I believe Peter Zijlstra was
> against calling it a lock (Peter, you can use lore to see the context here).

All I remember is that it was in a room and I was late, I can't even
remember what City we were all in at the time. Was this Lisbon?

Anyway, as Steve said, it isn't really a strict exclusion thing, it only
avoids the most egregious inter-cpu interleaving. I'm down with
goldi-locks, something has to have that name :-)
