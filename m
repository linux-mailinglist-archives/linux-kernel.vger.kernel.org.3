Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DDD5AA800
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiIBGXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:23:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D2B99FF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:23:51 -0700 (PDT)
Date:   Fri, 2 Sep 2022 08:23:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662099829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNXlO5JIHjp6Q9jkavDrFQejyN8sLjCcSCk1NEtTtuM=;
        b=OMPrOq4cuXJfi3PPbr2inQsDbGefNlbzrD4jouWOIgow8vmRqFSG1Qde/Jtd+tU5Zi9HbP
        y5Rl4zWgJJWrLwvNM1o2KoEgrxKoOs4dnhnEyqQ6BwseLzpDdvtslBatTN8FexHTwF1paE
        s3nuKNJYza/SG+GQHTwUGmT2gqRA700qnp+5GNGzUOMLwjA/KOuhe0RxdqvV3pXmqtG0SH
        isTrll9jCcqe5YX72qG/+E+TY/QgT3TR264Lu2tiUvdxSk+tKPGrrOi+meq1I5WOHhk713
        /813tDIEMC5vjBbVcN7W5qzEmI2KTZlSl4uvg3MO+EPzyT9SuNFGYVRrO8VI4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662099829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNXlO5JIHjp6Q9jkavDrFQejyN8sLjCcSCk1NEtTtuM=;
        b=HZtJcpa5vxYATLgUzjtVGzhwNVCLOeNDJ+ONSgS5kxaY8UkTVlSUh1wXMjdIyoPHKWkhdp
        d1pb5xRDehd/PUDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 04/28] mm: move mmap_lock assert function
 definitions
Message-ID: <YxGhcnKyV7KCiWCJ@linutronix.de>
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-5-surenb@google.com>
 <20220901202409.e2fqegqghlijkzey@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901202409.e2fqegqghlijkzey@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-01 16:24:09 [-0400], Kent Overstreet wrote:
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -60,6 +60,18 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
> >  
> >  #endif /* CONFIG_TRACING */
> >  
> > +static inline void mmap_assert_locked(struct mm_struct *mm)
> > +{
> > +	lockdep_assert_held(&mm->mmap_lock);
> > +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> 
> These look redundant to me - maybe there's a reason the VM developers want both,
> but I would drop the VM_BUG_ON() and just keep the lockdep_assert_held(), since
> that's the standard way to write that assertion.

Exactly. rwsem_is_locked() returns true only if the lock is "locked" not
necessary by the caller. lockdep_assert_held() checks that the lock is
locked by the caller - this is the important part.

Sebastian
