Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C5356501D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiGDI4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiGDI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:56:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1108BCB8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ct5yyx7bFf2ATEGBZpShUScjmwYbIXK3FHgjkgQQkmU=; b=Aq780jjp9JTcDozxNQu3yn6uej
        E4chxcCKShPuqD7Ect2s1yMWsh0DA3rRm4J52DeohzcHJQgn3ksBmD7N/garMqqE59DUrZdzooWBH
        HdC7tF8KIyhHM+i9YfsAfxYuTE4pOLjAVe0Zf41GsPhXMtGDz0UM+nUWNEK+by1ae/Qv7v4ouyFGe
        sAPZzMSH56Ch0b+umleNqldR5EroIqyuslolVjqZBOO8xeHLx9tq+LzBSWz0yqD/b2HpJYNL3wizJ
        xYQGvQvc2ncMUmB1ILtSKZEtrMtIDffdTiTV8uzkS8F5Y5fCaNXa8dybfFDb5jcvx3MlwbcRaeLri
        /rtBeS8A==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hse-00H7Kw-TG; Mon, 04 Jul 2022 08:56:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 093FC3001AE;
        Mon,  4 Jul 2022 10:56:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E72AD201850A7; Mon,  4 Jul 2022 10:56:30 +0200 (CEST)
Date:   Mon, 4 Jul 2022 10:56:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/core: Introduce nr_running percpu for each
 cookie
Message-ID: <YsKrPm0lov9yIQpk@hirez.programming.kicks-ass.net>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-3-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656403045-100840-3-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:57:24PM +0800, Cruz Zhao wrote:
> Introduce a percpu count to struct sched_core_cookie, which indicates how
> many tasks with this cookie in the runqueue of this cpu.

*why* ?!?

Changelog should always motivate why a change is done. The patch itself
mostly shows what it does, it doesn't explain why.
