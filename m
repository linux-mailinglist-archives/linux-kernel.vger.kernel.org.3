Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B44FE0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354410AbiDLMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355260AbiDLMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:39:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD462A0A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=++CuEWmMFr3JtalWqa+Q+0MtLvDBWWOfSiXyxOg+sfQ=; b=TLrlss4IK1zvwsvPnnO4QFfO+b
        uEx/FCQ6acqIPpWkdk0xR7EyZUBOLJ3NP47L0i+VaJWIcHgu4QC9SS2oo8wd0rFVCnIikMYM942mP
        w9HBffir9f1dVb6ufswELWsQmQHEyJ/rdZ+iz5N/x96voji6iDhpzPpkPednuilVT/QizIyDC4m3e
        lmT9B91bQAz0jWYiggebGhgQMl65v2/cq+xJJB4o3T3QGMxYXxOrS0++ZQL4cA/wEbR50aayPSfy9
        edJ05lTPPRG02m2Ci99ZUTfshEEFtRbOR9CqGxf396YNnb+r4rtRkFmLD02A1J8IkllcCIR7Fd5ap
        xf9QLxMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neFBP-00DImD-7p; Tue, 12 Apr 2022 11:59:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C82D6300250;
        Tue, 12 Apr 2022 13:59:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A63C926670FA9; Tue, 12 Apr 2022 13:59:42 +0200 (CEST)
Date:   Tue, 12 Apr 2022 13:59:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on
 PREEMPT_RT.
Message-ID: <YlVprihb7pLtrRcF@hirez.programming.kicks-ass.net>
References: <20220405102849.GA2708@redhat.com>
 <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
 <20220407121340.GA2762@worktop.programming.kicks-ass.net>
 <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
 <20220408090908.GO2731@worktop.programming.kicks-ass.net>
 <874k332wjp.fsf@email.froward.int.ebiederm.org>
 <YlCVxlTVL1pyBF08@hirez.programming.kicks-ass.net>
 <YlQSe6m2tidxwHt0@hirez.programming.kicks-ass.net>
 <87ee23zqdj.fsf@email.froward.int.ebiederm.org>
 <YlRgaZnJp2YONKhS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlRgaZnJp2YONKhS@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For all who I forgot on the Cc list.. continued here:

  https://lkml.kernel.org/r/20220412114421.691372568@infradead.org

(once it shows up, the web seems congested just now)
