Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFDA55C50F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiF0WIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiF0WH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:07:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE8D1EAE3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hd5cTStikKtz0tlIXNTx5Krap4rwRL5aZNJ2LQhABak=; b=nLEdo93IKdL9y1s/O/X3cU2L6h
        NxK6olojRPEtMre+dz8dkg5Q3gGv/xgeio7ua4m82gBPxgfVD/+P59L77mC/rIaIL6oPdY/S7EovR
        /eV0WHKTOJWNnBYLr5qUTGsBa3IyavO00wDBkbpc7YST5hKbVavz4DqSNTBhh8zQ/Es3M+M0Rebfi
        Q8DnxZzd/xwKNNH9wyEnIIAbMerRU1bOxvhiLs5boGQNUB8beLBfUzjqz9kBd6HKBkSD6Gbf6vXP0
        LagFG+d6EVdDmqopVHMCsTeGJ0AtpoMLmy70Ud0Sc4FKGgRTCGfDl8Z5DLfHGmpnaB+GZAlUwGSfk
        d685gLPg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5wsL-00Di3i-4C; Mon, 27 Jun 2022 22:06:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73EA53001F3;
        Tue, 28 Jun 2022 00:06:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4C6C207F0D5E; Tue, 28 Jun 2022 00:06:29 +0200 (CEST)
Date:   Tue, 28 Jun 2022 00:06:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <Yrop5Wzc72GIREVv@hirez.programming.kicks-ass.net>
References: <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
 <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
 <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
 <YrnxHBoi6sO0vqV0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrnxHBoi6sO0vqV0@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 06:04:12PM +0000, Wedson Almeida Filho wrote:

>   let new_thread = task::new_paused(|| pr_info!("Hello world\n"))?;

I'm still having a really hard time with this Rust stuff, the above
looks like a syntax error and random characters to me :/
