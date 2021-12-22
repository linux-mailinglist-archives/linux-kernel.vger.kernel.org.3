Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509DE47D025
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhLVKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhLVKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:41:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45EDC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QvsghOhufKmtYPZfMbHxSSOQWfgpeOnRvHYaOiH8qrw=; b=bi6N93EfAgDOH7ITE9dusnmxfU
        Ia4NRairg69KHvsKbOPZGlN0K3NKMCF1EFbOYIYYayDyaFhaddWkjO54+wsXZQI1azh7dF8fHoYmW
        XXbxjewaKsRBnyiOuAxGGKeVNrB0PFxHVYKVZEEUPwcY6Lt+px/we5et7OhkVH7olS+dCVBEO0LRT
        cdsJo27hmXWLN3aPNMf+1KOaX8wzj9chrdk9Kdd9ysydRxExXhcsp1baVN22YCUN5onB8MIM0z9AK
        x89P3DwrGo0jPRIvSMdweSgyfdOPqxdoxt4WGZIvgheP0sX6zPzISCyEfMNrqpFwnNMsOVBh0nOOB
        nuambugA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzz3L-003IDe-80; Wed, 22 Dec 2021 10:40:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49D6E30041D;
        Wed, 22 Dec 2021 11:40:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 041A3200A044E; Wed, 22 Dec 2021 11:40:57 +0100 (CET)
Date:   Wed, 22 Dec 2021 11:40:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedule: SCHED_RR: Give a fresh time-slice to the task
 after after it suspends or relinquishes
Message-ID: <YcMAuSFQazD4lBTC@hirez.programming.kicks-ass.net>
References: <20211222091526.8511-1-zhaoxiu.zeng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222091526.8511-1-zhaoxiu.zeng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 05:15:26PM +0800, zhaoxiu.zeng wrote:
> Assuming the sched_rr_timeslice is 100ms, there are several tasks with the
> same priority t1, t2, t3, ..., and t1 sleeps every 80ms, the scheduling
> timing may be:
>     t1  t2   t3        t1  t2   t3        t1  t2   t3        t1  t2   t3
>     80, 100, 100, ..., 20, 100, 100, ..., 60, 100, 100, ..., 40, 100, 100
> 
> After applying this patch, the scheduling timing may be:
>     t1  t2   t3        t1  t2   t3        t1  t2   t3        t1  t2   t3
>     80, 100, 100, ..., 80, 100, 100, ..., 80, 100, 100, ..., 80, 100, 100
> 

Is this what POSIX mandates or why are you sending this to me ?
