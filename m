Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9A147BC36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhLUIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhLUIwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:52:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB0EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0e1OB1zArcZGMKI1kg4r9MA6pBPZI77APRi350VUYQw=; b=gzgVhIyXtix23kMucDSXTkqSKs
        S7jr58aM2xs4N6DSNXEg84Umnb2VaE/a9C82iWszQvnZ787IkFkafMPs3A15A/cR7ishCTfEUo0wO
        RXoy14txEUJtbH1uwPbCyMBVc4ayyP/OEeWbsusvN8B81kgUjI44079ad2fYgyDk8iMn5+KA/jQrn
        7CrJ7J9WST/K0LNh/PD40Kz5U0U1hcMKBo0GGX2i19IJlEoxMkephKY9hbk2puHF0gLyFAwMGIWr5
        gM5QM0Xw+j/7/VIJcZJp3u/qAr3Co+MWXfXA9T5WuXADM5IjxaW6nyLYxoaJfZSBLH0J0LqTM5DlZ
        JdZXCR8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzaso-002JYC-KL; Tue, 21 Dec 2021 08:52:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED82B3002BE;
        Tue, 21 Dec 2021 09:52:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0759301579C3; Tue, 21 Dec 2021 09:52:28 +0100 (CET)
Date:   Tue, 21 Dec 2021 09:52:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     xuhaifeng <xuhaifeng@oppo.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: optimize __cond_resched_lock()
Message-ID: <YcGVzClid/7q3DuB@hirez.programming.kicks-ass.net>
References: <20211221072316.42-1-xuhaifeng@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221072316.42-1-xuhaifeng@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:23:16PM +0800, xuhaifeng wrote:
> if the kernel is preemptible(CONFIG_PREEMPTION=y), schedule()may be
> called twice, once via spin_unlock, once via preempt_schedule_common.
> 
> we can add one conditional, check TIF_NEED_RESCHED flag again,
> to avoid this.

You can also make it more similar to __cond_resched() instead of making
it more different.
