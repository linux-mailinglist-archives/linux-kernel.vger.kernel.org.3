Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE84E26ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347589AbiCUMyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbiCUMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:54:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7827C1697B0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UnPd4xPbpt7XbYWfdR/D82UzgFJRYuCTn0e/4lAJADw=; b=f4dJ6MWDuXuQDLKEpChKiCbuHb
        GiJCAVskTV8MmYMxYEUj5WI8GtOq6/ql2S9OHARzlzSEcoEMTyWxfIU+L6W8A5Ol9i5s5H1aqBpyb
        sUsL9tGFILAlCCbNxzc9USSzaQXvQioZwLqmmRY+u+2M8VDUnmyQVT4Od/Tb34pO5o/ZJKZn7MvYM
        6zcjmDYAkm7HnDVfE2rTI2fj8lirI5SaOrfWg7UUZmRlZQ4hAS8KVI2wP9PUu3NS41ZdgNl3d+GbE
        /E80pIzRTUSHIQfRzJaPO566lOarNZLcrZXlq/rD6SvNV1yIn+9dURkxiV6UmLiZrkiKQME/+Li+0
        jVjzIA2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWHWM-00AZPz-Q9; Mon, 21 Mar 2022 12:52:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F372E3002BE;
        Mon, 21 Mar 2022 13:52:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D00EC2C450553; Mon, 21 Mar 2022 13:52:24 +0100 (CET)
Date:   Mon, 21 Mar 2022 13:52:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/rwsem: Wake readers in a reader-owned rwsem
 if first waiter is a reader
Message-ID: <Yjh1CC1EBBxsD+PK@hirez.programming.kicks-ass.net>
References: <20220318161609.1939957-1-longman@redhat.com>
 <20220318161609.1939957-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318161609.1939957-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 12:16:09PM -0400, Waiman Long wrote:
> In an analysis of a recent vmcore, a reader-owned rwsem was found with
> 385 readers but no writer in the wait queue. That is kind of unusual
> but it may be caused by some race conditions that we have not fully
> understood yet. In such a case, all the readers in the wait queue should
> join the other reader-owners and acquire the read lock.
> 
> In rwsem_down_write_slowpath(), an incoming writer will try to wake
> up the front readers under such circumstance. That is not the case for
> rwsem_down_read_slowpath(), modify the code to do this. This includes the
> original supported case where the wait queue is empty and the incoming
> reader is going to wake up itself.
> 
> With CONFIG_LOCK_EVENT_COUNTS enabled, the newly added rwsem_rlock_rwake
> event counter had 13 hits right after the bootup of a 2-socket system. So
> the condition that a reader-owned rwsem has readers at the front of
> the wait queue does happen pretty frequently. This patch will help to
> speed thing up in such cases.

Urgh.. this so reads like a band-aid.

Anyway; it appears to me the out_nolock case of down_read doesn't
feature a wakeup, can we create a scenario with that?

Anyway, I think I much prefer you sitting down writing the rules for
queueing and wakeup and then varifying them against the code rather than
adding extra wakeups just cause.
