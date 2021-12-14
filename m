Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD970474CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbhLNUz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhLNUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:55:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A4C06173E;
        Tue, 14 Dec 2021 12:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=evBDxTTQ8+N4iNix5xz5YzD+Ysv8Um0WF6ha9iHDaKY=; b=GC5JOUm2ockglSvsSeGsOK5Nqk
        zpM+zTeX2TrvVWJ+u1CNfc2OdtKhiF2Z0D1OJyerKAP/Gnlx0T9O02wquCgLpLSWWXx2NQcCNtRpc
        oBH0xcP2sf3ZwbF4g0EQj1PR2wNnH1QO4oKBDg6+/TDoR1tYWwDdI0Qf/+dbwPHzvH00jls4DZ+ZE
        L4VI+K60eHsQA3zwx41UPDzOPKUVHAfvuSPjpAG7Vk+WkaeuX6wOWttA/zaJW0asWSkh0Mtg9jKM7
        RlS6marRgp7ANLV6T24e1CFvzFyp4xZ/3XHpPC2bkZjBFvloXS6VUkqiip5hnjMRucpXGnOm1A5Nx
        Cwm0j14w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxEpW-001NMs-In; Tue, 14 Dec 2021 20:55:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BDF9300728;
        Tue, 14 Dec 2021 21:55:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0BD83201E7EE3; Tue, 14 Dec 2021 21:55:20 +0100 (CET)
Message-ID: <20211214204445.665580974@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 14 Dec 2021 21:44:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, posk@posk.io
Subject: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is actually tested code; but still missing the SMP wake-to-idle machinery.
I still need to think about that.

I'll post my test-hack as a reply, but basically it does co-operative and
preemptive UP-like user scheduling.

Patches go on top of tip/master as they rely on the .fixup removal
recently merged in tip/x86/core.

Also, I still need to audit a bunch of mm code, because I'm not sure things are
actually as well behaved as this code supposes they are.

