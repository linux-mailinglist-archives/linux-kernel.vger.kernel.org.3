Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB48493697
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiASIwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345165AbiASIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:52:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60693C061574;
        Wed, 19 Jan 2022 00:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vSg8ZrRKcNP4N0aIzqMy7pQZL/CJuOTJI8hGONUUDtQ=; b=V2TycFG+Wm8QFoNbKGqJZugqjM
        1Z/iKER8MIhlqK0jrMVRqhoXQHdIiYhoAgTwKhWIAQ/VImr3fd8MSKzo24gMVfvHBHb4pFlboJ4IT
        Ud8iG6yGODjvdbjhY+hZ50qMyXzpvNcgj30IajhEKZmecCs2ooWezk2wWjmPJeRXRfSLBq8DnesB1
        IN7r/3u57hdbSAdELOnYmSWwma5Dh8Njjd08USCJwcJLRybsOnrEHTCDxeLsw1NpvushX5trcICSO
        D+q/ihq2/VFGbfekiz76rEK0Scb/gSBdDLttwQKzcz7fCZ6//kQLVkwXJDhQCpDiguasLFPW7VMRG
        nXvQlkdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nA6hB-0020SX-V1; Wed, 19 Jan 2022 08:51:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B880300140;
        Wed, 19 Jan 2022 09:51:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D1F829A40F04; Wed, 19 Jan 2022 09:51:57 +0100 (CET)
Date:   Wed, 19 Jan 2022 09:51:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YefRLYwKy0AeHyhz@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net>
 <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:19:21AM -0800, Peter Oskolkov wrote:

> ================ worker timeouts
> 
> Timeouts now are easy to explain: mutex::lock() and condvar::wait() have
> timeouts, so workers waiting on these primitives naturally wait with timeouts;
> if sys_umcg_wait() supports worker timeouts, this is it, all is simple; if
> it does not, the userspace now has to implement the whole timeout machinery,
> in order to wake these sleeping workers when their timeouts expire.

I still have absolutely no idea what you're on about here. Please reply
to the email on that subject:

  https://lkml.kernel.org/r/Ya34S2JCQg+81h4t@hirez.programming.kicks-ass.net

What would you have the timeout actually do? Talk about the state
transitions.
