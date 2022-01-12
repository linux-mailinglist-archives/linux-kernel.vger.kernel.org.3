Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14B048C340
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352891AbiALLfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbiALLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:35:10 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BEC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:35:10 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 19so1453346vkl.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fTJTS7bqQi/yIpHQJpi+4PrBqmFnBRpYezv+IVLW9I=;
        b=PJMZnFO3s5Vo9SbANIVxOvoQeetaMi9gbFjbdqqF4JSRyWYh+1M91PRfMqEmTQ78e5
         OnKctDFWn1mpr89a3TweLsKvM3kV9qxcepvL3I4uqq6a/OBFbH2giL/R1IKgJr+g2kto
         4SH+6WRJWSvwhJHBKPSDg0GM+kPh7JIixDJSJZ0K11PSe42JaW31WoEZHELzoqt3y7K0
         yi7geIUn7EcZKWJLr1IWrhGp1aPEne8wzRAo6PNpR6KmGwzepSPADJxidiHep8Td/T5O
         cyxYmUVJcja6dsjLnGSszJGaVbeGdhSB1pTzXp89DpMYx9qfwOlnCh9RWrZs+hA7ddQf
         m4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fTJTS7bqQi/yIpHQJpi+4PrBqmFnBRpYezv+IVLW9I=;
        b=5xZbrjt8W7kzo5SlaleCtvZcK98oO2wL8I43Qw0yGhKrZETspLEhJDB8wR3O0ZQ0OW
         C9ZOBUdctXpLolILntrQDUdGmPRxSqN6CwHztZhZxUk7W9w91NerOLGNUxKMh6mT6Z1F
         XEPO12EOCQhDS8OfaBA0keiAwcfmfvV4FEiaoBCdJ1fsVkcTXVcGWd1A+qtZ1xX/6Btf
         BLPym1+xEjk5T+g1Uytc7q2cUilzLgoEeqlQ8ChIMuIOdnFq+p2LP+pou35msSJcSMnK
         q+VzsBIjdt7lBLOkPLo+ReuWJ4kuEIQblCBDm5aimEhAqAZuf0yuwK6JIbUUi8WI83Zv
         XWvQ==
X-Gm-Message-State: AOAM531HzkefN2oipnXhuTw0i93R/HSEGknpSbNmd5veTcjMsecyWydY
        BBkGH3An4IHwewj0oW61MiUeOHlc80R0vJWNPCM=
X-Google-Smtp-Source: ABdhPJz/bwCv+8MKvrlj91tEjjDwA9AJb+uzqY+ZGTKpvabwgJ2a1V7vqHWmYdL/yvJe0UT5JAPtwNim/8kwef6uymU=
X-Received: by 2002:a05:6122:130e:: with SMTP id e14mr4494396vkp.41.1641987309469;
 Wed, 12 Jan 2022 03:35:09 -0800 (PST)
MIME-Version: 1.0
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
 <CANe_+UipVZRZeWqzXezacPaVb9UeC6a_ZhQp8GkrvftbRktotg@mail.gmail.com>
 <2c66ba2e-1c65-3bdd-b91e-eb8391ec6dbf@quicinc.com> <61212ffd-3505-04d7-5403-932a10d676e7@quicinc.com>
In-Reply-To: <61212ffd-3505-04d7-5403-932a10d676e7@quicinc.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Wed, 12 Jan 2022 11:34:58 +0000
Message-ID: <CANe_+UiX=MDSudBrfpboRoywWNnpyOwOMNETB6rjvm4cadqzTA@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, vbabka@suse.cz,
        rientjes@google.com, mhocko@suse.com,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 08:22, Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Hello Mark,
>
> On 1/10/2022 3:51 PM, Charan Teja Kalla wrote:
> >>> +static int shmem_fadvise_willneed(struct address_space *mapping,
> >>> +                                pgoff_t start, pgoff_t long end)
> >>> +{
> >>> +       XA_STATE(xas, &mapping->i_pages, start);
> >>> +       struct page *page;
> >>> +
> >>> +       rcu_read_lock();
> >>> +       xas_for_each(&xas, page, end) {
> >>> +               if (!xa_is_value(page))
> >>> +                       continue;
> >>> +               xas_pause(&xas);
> >>> +               rcu_read_unlock();
> >>> +
> >>> +               page = shmem_read_mapping_page(mapping, xas.xa_index);
> >>> +               if (!IS_ERR(page))
> >>> +                       put_page(page);
> >>> +
> >>> +               rcu_read_lock();
> >>> +               if (need_resched()) {
> >>> +                       xas_pause(&xas);
> >>> +                       cond_resched_rcu();
> >>> +               }
> >>> +       }
> >>> +       rcu_read_unlock();
> >>> +
> >>> +       return 0;
> >> I have a doubt on referencing xa_index after calling xas_pause().
> >> xas_pause() walks xa_index forward, so will not be the value expected
> >> for the current page.
> > Agree here. I should have the better test case to verify my changes.
> >
> >> Also, not necessary to re-call xas_pause() before cond_resched (it is
> >> a no-op).
> > In the event when CONFIG_DEBUG_ATOMIC_SLEEP is enabled users may still
> > need to call the xas_pause(), as we are dropping the rcu lock. NO?
> >
> > static inline void cond_resched_rcu(void)
> > {
> > #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
> >         rcu_read_unlock();
> >         cond_resched();
> >         rcu_read_lock();
> > #endif
> > }
> >
> >> Would be better to check need_resched() before
> >> rcu_read_lock().
> > Okay, I can directly use cond_resched() if used before rcu_read_lock().
> >
> >> As this loop may call xas_pause() for most iterations, should consider
> >> using xa_for_each() instead (I *think* - still getting up to speed
> >> with XArray).
> > Even the xarray documentation says that: If most entries found during a
> > walk require you to call xas_pause(), the xa_for_each() iterator may be
> > more appropriate.
> >
> > Since every value entry found in the xarray requires me to do the
> > xas_pause(), I do agree that xa_for_each() is the appropriate call here.
> > Will switch to this in the next spin. Waiting for further review
> > comments on this patch.
>
> I also found the below documentation:
> xa_for_each() will spin if it hits a retry entry; if you intend to see
> retry entries, you should use the xas_for_each() iterator instead.
>
> Since retry entries are expected, I should be using the xas_for_each()
> with the corrections you had pointed out. Isn't it?
>

Ah, you've hit a barrier on my Xarray knowledge.
The current shmem code simply does a 'continue' on xas_retry().  Is
this different from Xarray looping internally for xas_retry()?  I
assume not, but cannot give an definite answer (sorry).

Cheers,
Mark
