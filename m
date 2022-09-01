Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985335A92A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiIAJDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiIAJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:03:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E549B7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rdb+EyHW3HnzLV+Rqaxl+0TKszH0hWfP4sKGnf9nyhI=; b=dYE7BVV+93/gLZkkBQtpXAqgFX
        z+frs7g7FFujHtiHM50UDOv2ESdw3eDxrYcmnWbbBtwyUcvGIFRMLB4CDk/AVwIw8bMfpwOq6l1vq
        zYDjgL8vd5EGxoSZ4n1dqoBr8wYcxOOQ9LMJnM4y5thxw92HjXt+SOhFaxdc4m1nCf3+Y2qt2s1bS
        ig+pXih8wDPikJR7NaHm/JP1Ur3u//q0L3o08qdRfrkftskCUBh4jrDues/Z4W849UCdZjW2Z+eHx
        AAWh8MznvtRy2+2i7wSIn9t8jQEV7DdgGlymXT48X+W2fA62BQl9b9VpomJ07TRdNcIvXs5q9QJd1
        jlnTP45g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTg5U-008Mko-BV; Thu, 01 Sep 2022 09:02:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 443F5300244;
        Thu,  1 Sep 2022 11:02:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F8F82B1A6BC1; Thu,  1 Sep 2022 11:02:10 +0200 (CEST)
Date:   Thu, 1 Sep 2022 11:02:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix the bug that sched_core_find() may
 return throttled task
Message-ID: <YxB1Eu9wTPel8LWu@hirez.programming.kicks-ass.net>
References: <1661928558-108473-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661928558-108473-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:49:18PM +0800, Cruz Zhao wrote:
> When a cfs_rq is throttled, the cookie'd task in this cfs_rq wouldn't
> dequeue from the core tree, and sched_core_find() may return this task,
> which will result that the throttled task running on the cpu.
> 
> To resolve this problem, we pick the first cookie matched task and
> unthrottled task.

You mean: first that that both matches the cookie and is not throttled.

Except I think you can have the same problem with the RT crud.
