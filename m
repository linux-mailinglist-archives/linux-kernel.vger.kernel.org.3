Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5E51999D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346249AbiEDIYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiEDIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:24:27 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF022B1C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:20:52 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b81so273442vkf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZeM2sK6VsFpvnvIUwVCoNa4r1ezlmI7cS8ZgepmC84=;
        b=hSNZbMrTMFievu5D9MtMUJMwIDI8+/jQVZxuuo+3f9e8nR41TGIc9FzDpRb0hjzBGP
         j/wAcoRO8SZrWabKfZaBkxYlA+SBRBfWlcNA/+0IS22029aOTvGHT2fbzcWKT6JmCxLp
         bshEvOmNiHDkAvBrvx+BeBhcD5dIg0n4uHm1gkBk46Ecb28i63c/bTiohrKuudKH69n2
         OlV8xGhL61ydC5BDlhXlY4a14uQQsX0E0LQk3kLnRPEifpJ/8e0AOmXR/8bfTOS58bJx
         9feiiopTnMypFzKGpnqI2UQ7dy/RjbRnMqqhrD3FPhV5xWa0NKIOfymwWeYYDhGQrAFY
         QMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZeM2sK6VsFpvnvIUwVCoNa4r1ezlmI7cS8ZgepmC84=;
        b=36RH/RSSfAw4bQwCI+V8mhd9Pae+/F0vy4E/pI1w3UgoZ5AJ4aFFDIdpNjoxlQe1MB
         JEUA76Aj4iGk5QK3WLV3AhSjJaoSSM/ig5K/uOz9yt700LIUMOfVKIpHgsudr6bHi2r/
         l4NWNA3k5HfT47ofvOOqBXix0K1ST8kteb9fZ6I2IsjNUcaOnkJ1OiBpwxbb+vm7lw5d
         YHggfx5gbC9Q+6hau786lUOpgFxcYuj5h7leDkjP7eOPd2pHlYmlvcpxqRV+LqQpRVYG
         XOmbcmvIkoOxd13v2gjrNk90Ou7DVHWQi0ZjzxCpHkmTvedpxT83BlzAWP4aeA9gFgOb
         b7Pg==
X-Gm-Message-State: AOAM532Fio5MzWLCpKSDQ19JbQnbroDIEHVzoiSWpTYAkXI4lzV1EY4R
        cHzgFIKVwZ4Y1tpEl/NLxn+0PHR8b9xzMQ9aPNM=
X-Google-Smtp-Source: ABdhPJxvA9Fb4Ot25FQ7DBPpMBdU2Pgp5GXz/X+0YUQRxuVvUiMLwiagK2c2Wbwd9yqwWpMY4qmw+LrtMOiu2XatiOE=
X-Received: by 2002:a1f:a146:0:b0:34e:1514:c124 with SMTP id
 k67-20020a1fa146000000b0034e1514c124mr5732956vke.33.1651652450400; Wed, 04
 May 2022 01:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz> <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
In-Reply-To: <YnF0RyBaBSC1mdKo@casper.infradead.org>
From:   Michel Lespinasse <walken.cr@gmail.com>
Date:   Wed, 4 May 2022 01:20:39 -0700
Message-ID: <CAL36u31s_4TYPRtAzbGUpQVw2ButNv3vtKLhBkfJAhFSfcNDSg@mail.gmail.com>
Subject: Re: Memory allocation on speculative fastpaths
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Liam Howlett <liam.howlett@oracle.com>, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>, David <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(for context, this came up during a discussion of speculative page
faults implementation details)

On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> Johannes (I think it was?) made the point to me that if we have another
> task very slowly freeing memory, a task in this path can take advantage
> of that other task's hard work and never go into reclaim.  So the
> approach we should take is:
>
> p4d_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> pud_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> pmd_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
>
> if (failure) {
>   rcu_read_unlock();
>   do_reclaim();
>   return FAULT_FLAG_RETRY;
> }

I don't think this works. The problem with allocating page tables is
not just that it may break an rcu-locked code section; you also need
the code inserting the new page tables into the mm's page table tree
to synchronize with any munmap() that may be concurrently running. RCU
isn't sufficient here, and we would need a proper lock when wiring new
page tables (current code relies on mmap lock for this).

> ... but all this is now moot since the approach we agreed to yesterday
> is:
>
> rcu_read_lock();
> vma = vma_lookup();
> if (down_read_trylock(&vma->sem)) {
>         rcu_read_unlock();
> } else {
>         rcu_read_unlock();
>         mmap_read_lock(mm);
>         vma = vma_lookup();
>         down_read(&vma->sem);
> }
>
> ... and we then execute the page table allocation under the protection of
> the vma->sem.
>
> At least, that's what I think we agreed to yesterday.

I don't remember discussing any of this yesterday. As I remember it,
the discussion was about having one large RCU section vs several small
ones linked by sequence count checks to verify the validity of the vma
at the start of each RCU section.
