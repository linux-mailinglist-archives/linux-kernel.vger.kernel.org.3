Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A805B179C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIHItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiIHIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:48:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E360F11366F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yivMFvAuYoQCsKYoHw1xYjWDVKneaxLVfmyklrKww1g=; b=OX2vq17UWM1iOL8Bxve2zMEf83
        yGbzOh9EOzIX3CLj3HAmrUCVlcDL4bZzICCRhFb7YvdPLE41NVwRcbMS4rzY6GadtBLjCY2cZfN1D
        bxywaHKv0kIbXXIL4z+cfkHHESL8TrWX6YGxju44unxlc4wNvyIT9Kg1x8/dEIBwin0ne8mp0E5SR
        DkFIWw8LNtdC4hHc66wWMfhBEhRc4wdFHNerj5ZWU1sAW07nsBNHaWkJI2XGzZwKCPqCEYL41iEfV
        gHJ0aVWV4MQwVnlfX8z89NALg19UFqtXHq1JiZo9Zer+VUshMYI5pi/AO4rhlQRqFPA5ATkkpz0qm
        AEzxCqCA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWDCW-00AfCa-53; Thu, 08 Sep 2022 08:47:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F66A300074;
        Thu,  8 Sep 2022 10:47:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4544C2B6563A7; Thu,  8 Sep 2022 10:47:55 +0200 (CEST)
Date:   Thu, 8 Sep 2022 10:47:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking: Detect includes rwlock.h outside of spinlock.h
Message-ID: <YxmsO8q2/eR0MPJk@hirez.programming.kicks-ass.net>
References: <YweemHxJx7O8rjBx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YweemHxJx7O8rjBx@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:08:56PM +0200, Sebastian Andrzej Siewior wrote:
> From: Michael S. Tsirkin <mst@redhat.com>
> 
> The check for __LINUX_SPINLOCK_H within rwlock.h (and other files)
> detects the direct include of the header file if it is at the very
> beginning of the include section.
> If it is listed later then chances are high that spinlock.h was already
> included (including rwlock.h) and the additional listing of rwlock.h
> will not cause any failure.
> 
> On PREEMPT_RT this additional rwlock.h will lead to compile failures
> since it uses a different rwlock implementation.
> 
> Add __LINUX_INSIDE_SPINLOCK_H to spinlock.h and check for this instead
> of __LINUX_SPINLOCK_H to detect wrong includes. This will help detect
> direct includes of rwlock.h with without PREEMPT_RT enabled.
> 
> [ bigeasy: add remaining __LINUX_SPINLOCK_H user and rewrite
>   commit description. ]
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!
