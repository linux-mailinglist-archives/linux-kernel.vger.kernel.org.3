Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4E48ECC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiANPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbiANPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:17:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC8DC06173F;
        Fri, 14 Jan 2022 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HIRvcwlSl4Hp1A2rT9yMEOxIWfhwKnmROPnxOG/25YE=; b=MLdEMXb4SCvNvAol4jQBhoZrDw
        ls0LbGXaMsBPr5myQwSrS7mm891UDbP7d0aB9f4apmNBECNtiID+VWfx52VHds1RymMbnwNkWl3UZ
        uXqRMmCE7eCW15t3NcyRYgr40FR9PAbyMpDMKo+4VVqlAo6j3Za51gppGoB6xxlmWLgexYnbKyFOX
        FQssGbBTPx6anq/Gxt2YEa+gHIqTTeO/DpsQLsAiLPvbwHucX3ZFedtzFE04M0xVHMJJmtGuB3QtZ
        0YORWbZUwdCE60GdjX4gvo5ZhMwkhQ84SmqyNXAk5H+iQhQdIYyGA07EH7KLCc24+jKSIgsY3CCIQ
        wGoiQw4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8OK0-005tS8-Ou; Fri, 14 Jan 2022 15:16:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D88AD3002C1;
        Fri, 14 Jan 2022 16:16:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4C2923CDA75B; Fri, 14 Jan 2022 16:16:53 +0100 (CET)
Date:   Fri, 14 Jan 2022 16:16:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YeGT5dvA8KFeW+69@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:09:55PM +0100, Peter Zijlstra wrote:

> > I think the assumption is based on the idea that a process
> > using UMCG will get affined to N CPUs, will have N servers and
> > a number of workers, and they will all happily cooperate and not
> > get any extra threads running.
> > 
> > Of course the pretty picture was not completely true, as the unblocked
> > tasks do consume extra threads in the kernel, though never in the
> > userspace.
> 
> Right, there is some unmanaged time anyway.

Also, since we force wake to the same CPU, and overlapping runtime is
'short', they should all stick to the same CPU, even if we don't pin.
