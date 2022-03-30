Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D915A4EBFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbiC3La5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiC3Laz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF8F7165BB5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648639748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaxx7Mi+hRPrFxRT4XMjZarJbz28r/Aqr9FeS7C1aeM=;
        b=YKYIOkTIPgrVFhJuYNvYTgcxEaB1HIuX3+HQYG44koqxgaLLknByzEhYgj5SYOrNjebn7F
        SbuQpB4pXmSY39t6vzlxUt2FKQyMHkx7J996fVoNMmY8IkXQWyZqespOiGXkW47rn5yZ7h
        9CzuSjjRQzf1dq92foFPfAE8r/aYU5w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-2unNIxjbNDmMENj0GdHeYQ-1; Wed, 30 Mar 2022 07:29:07 -0400
X-MC-Unique: 2unNIxjbNDmMENj0GdHeYQ-1
Received: by mail-wm1-f72.google.com with SMTP id c62-20020a1c3541000000b003815245c642so987466wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yaxx7Mi+hRPrFxRT4XMjZarJbz28r/Aqr9FeS7C1aeM=;
        b=030jjSgHEG0dIIDwA1fcsrSyeE+ng8DVxmoNt8u8P6/vhnaJPcfeh8G/zmdAoyYNY5
         AtjGMYcLfdVtshscJGwMLU59rVeKGP0p9vvBfXSh755YGl+XdHImqvhJ/Oj+luKBizpQ
         iqDQwAGrEp9zeGsbJnizUVU/ztgocijAvRWXz8SuwrMFFw7gVilzVlgCqWxlXvI4T99m
         c3IrtGtFrk+XrU7CpjfznKxGfUREC8rnVco3xZNKUurR2m5BfxxP91P52vq5wXPZU8kZ
         A/c2ugSAEf8ch/JFRD3an3hrgtvtyeLk6xOI28lKRNzNOlPtBcUgYgIE9srCZV5KErom
         rh7A==
X-Gm-Message-State: AOAM532rEtd59Oer7da8o0akD2xcHedFTAA6Xx0eMyy4Go8lZ1g+U+03
        Nyt4e7PbaWTIof58e6sLmlWN+RlbG7luNQieySQZgsfPCneY6oMg2vIoFCrLvDXUM/3dMnIubGB
        czR7ejp83h5qqPAlPuqqZQzbX
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr4110598wmc.130.1648639746485;
        Wed, 30 Mar 2022 04:29:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3tJfjg2ltNgBDJTjAI6UNvach4o9T1u3xP9F0MW35LlWoSLgV4PaG9kYJkXDGXk8iOPzXyQ==
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr4110575wmc.130.1648639746177;
        Wed, 30 Mar 2022 04:29:06 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1c1a:5300:ea85:f79:5235:c7fc? ([2a0c:5a80:1c1a:5300:ea85:f79:5235:c7fc])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm5273322wmb.3.2022.03.30.04.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:29:05 -0700 (PDT)
Message-ID: <7d115ec39714b906e31398373855c28391229ff9.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Date:   Wed, 30 Mar 2022 13:29:04 +0200
In-Reply-To: <20220303114550.GE4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220303114550.GE4363@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Thu, 2022-03-03 at 11:45 +0000, Mel Gorman wrote:
> On Tue, Feb 08, 2022 at 11:07:48AM +0100, Nicolas Saenz Julienne wrote:
> > This series replaces mm/page_alloc's per-cpu page lists drain mechanism with
> > one that allows accessing the lists remotely. Currently, only a local CPU is
> > permitted to change its per-cpu lists, and it's expected to do so, on-demand,
> > whenever a process demands it by means of queueing a drain task on the local
> > CPU. This causes problems for NOHZ_FULL CPUs and real-time systems that can't
> > take any sort of interruption and to some lesser extent inconveniences idle and
> > virtualised systems.
> > 
> 
> I know this has been sitting here for a long while. Last few weeks have
> not been fun.
> 
> > Note that this is not the first attempt at fixing this per-cpu page lists:
> >  - The first attempt[1] tried to conditionally change the pagesets locking
> >    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
> >    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
> >    for NOHZ_FULL setups, which isn't ideal.
> >  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
> >    performance degradation was too big.
> > 
> 
> For unrelated reasons I looked at using llist to avoid locks entirely. It
> turns out it's not possible and needs a lock. We know "local_locks to
> per-cpu spinlocks" took a large penalty so I considered alternatives on
> how a lock could be used.  I found it's possible to both remote drain
> the lists and avoid the disable/enable of IRQs entirely as long as a
> preempting IRQ is willing to take the zone lock instead (should be very
> rare). The IRQ part is a bit hairy though as softirqs are also a problem
> and preempt-rt needs different rules and the llist has to sort PCP
> refills which might be a loss in total. However, the remote draining may
> still be interesting. The full series is at
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2
> 
> It's still waiting on tests to complete and not all the changelogs are
> complete which is why it's not posted.
> 
> This is a comparison of vanilla vs "local_locks to per-cpu spinlocks"
> versus the git series up to "mm/page_alloc: Remotely drain per-cpu lists"
> for the page faulting microbench I originally complained about.  The test
> machine is a 2-socket CascadeLake machine.
> 
> pft timings
>                                  5.17.0-rc5             5.17.0-rc5             5.17.0-rc5
>                                     vanilla    mm-remotedrain-v2r1       mm-pcpdrain-v1r1
> Amean     elapsed-1        32.54 (   0.00%)       33.08 *  -1.66%*       32.82 *  -0.86%*
> Amean     elapsed-4         8.66 (   0.00%)        9.24 *  -6.72%*        8.69 *  -0.38%*
> Amean     elapsed-7         5.02 (   0.00%)        5.43 *  -8.16%*        5.05 *  -0.55%*
> Amean     elapsed-12        3.07 (   0.00%)        3.38 * -10.00%*        3.09 *  -0.72%*
> Amean     elapsed-21        2.36 (   0.00%)        2.38 *  -0.89%*        2.19 *   7.39%*
> Amean     elapsed-30        1.75 (   0.00%)        1.87 *  -6.50%*        1.62 *   7.59%*
> Amean     elapsed-48        1.71 (   0.00%)        2.00 * -17.32%*        1.71 (  -0.08%)
> Amean     elapsed-79        1.56 (   0.00%)        1.62 *  -3.84%*        1.56 (  -0.02%)
> Amean     elapsed-80        1.57 (   0.00%)        1.65 *  -5.31%*        1.57 (  -0.04%)
> 
> Note the local_lock conversion took 1 1-17% penalty while the git tree
> takes a negligile penalty while still allowing remote drains. It might
> have some potential while being less complex than the RCU approach.

I've been made aware of a problem with the spin_trylock() approach. It doesn't
work for UP since in that context spin_lock() is a NOOP (well, it only disables
preemption). So nothing prevents a race with an IRQ.

It's kinda funny, breakages generally happen the other way around.

Regards,

-- 
Nicolás Sáenz

