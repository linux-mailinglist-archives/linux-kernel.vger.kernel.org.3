Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521C75736BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiGMM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGMM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEBCD74791
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657717093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYC8Yec1GTbUtaYK7RYva4XXz/xl1ExjZYRMzojC8yQ=;
        b=L8Y2U5FFfXvBLvZ0piQufktp3doNmsC2UCEjTpIsr+X915Ip6KGs8+mi3Izz0vWY9oVht7
        URrVz3IpVGvbQtQ2/WlzEztZV87ac4MHWrEh2EpJtVirKnHt31pQNoxKmt4x0isLoa6+lV
        8GQq/UAjqE7Nj4/uRlPsl2vCx7BvVRM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-y1PoGr-KObSmF7vKk7zy-g-1; Wed, 13 Jul 2022 08:58:12 -0400
X-MC-Unique: y1PoGr-KObSmF7vKk7zy-g-1
Received: by mail-wm1-f70.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso5526993wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYC8Yec1GTbUtaYK7RYva4XXz/xl1ExjZYRMzojC8yQ=;
        b=6h4bUoxkuynX6dUN0l7a+80zFpktLh9VLn4Hn4EJypMY0ITqNEgAk2IbmZYiH8Sxik
         qFM6QDU50BC6zXtp0iO/w2ykZ2GYSWtD5jhck4KSzs9RYjr6WsioLDcivn5Z0Mxw/AXv
         oj9E4/OXi7+eQSDGFF3TT0NgYWWj/4BwFGiVIsY40qP8JHkibaxdWvIcLOKszCmVjJKV
         E9rwLDGSkOBumXThu1OmAlKa8I9u/JR5kbaOUe+y4zbzsiG/LaQJU5wxwSY3NUT7B+A3
         iTpSBApy1lVkulKr7jqXg/Tzf/1w/K2OSeQ/HIE+6HaFbPWZ0TuDc6DpkwpaOLQIUjgM
         vJVA==
X-Gm-Message-State: AJIora8O7ghpS8rmvWHGfexT/k2lNq3cTioijkdBKXOCeq1K601pcJQW
        KafMn+H/z6k7QuTyMXJoMJh6lZ42eHCof8H42L8NeYhOEKX+8ihVIALu6poYOVOiIhanTh4TRwB
        GBy7MGz+fK6I2ZpQarrTwmizI
X-Received: by 2002:a1c:7910:0:b0:3a2:e033:cdbc with SMTP id l16-20020a1c7910000000b003a2e033cdbcmr9660887wme.122.1657717091470;
        Wed, 13 Jul 2022 05:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRsnqWu8rRP2FIUsaOp6/GcdlWCvwK0G1/Y1QaiEpMZI2+dk3VkUEbOS2ulOuht+mJNcB7qA==
X-Received: by 2002:a1c:7910:0:b0:3a2:e033:cdbc with SMTP id l16-20020a1c7910000000b003a2e033cdbcmr9660859wme.122.1657717091160;
        Wed, 13 Jul 2022 05:58:11 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.26])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b003a2fdde48d1sm944864wmc.25.2022.07.13.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 05:58:10 -0700 (PDT)
Date:   Wed, 13 Jul 2022 14:58:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <Ys7BYCvlgphAwQ+Y@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <Ys6wgxiZbdjxyh8C@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys6wgxiZbdjxyh8C@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/22 13:46, Peter Zijlstra wrote:
> On Wed, Jul 13, 2022 at 09:50:14AM +0200, Juri Lelli wrote:
> > Tasks the are being deboosted from SCHED_DEADLINE might enter
> > enqueue_task_dl() one last time and hit an erroneous BUG_ON condition:
> > since they are not boosted anymore, the if (is_dl_boosted()) branch is
> > not taken, but the else if (!dl_prio) is and inside this one we
> > BUG_ON(!is_dl_boosted), which is of course false (BUG_ON triggered)
> > otherwise we had entered the if branch above. Long story short, the
> > current condition doesn't make sense and always leads to triggering of a
> > BUG.
> > 
> > Fix this by only checking enqueue flags, properly: ENQUEUE_REPLENISH has
> > to be present, but additional flags are not a problem.
> > 
> > Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/sched/deadline.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 5867e186c39a..0447d46f4718 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1703,7 +1703,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
> >  		 * the throttle.
> >  		 */
> >  		p->dl.dl_throttled = 0;
> > -		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
> > +		BUG_ON(!(flags & ENQUEUE_REPLENISH));
> 
> While there, can we perhaps make it less fatal? 

Yep. On it. Thanks!

Juri

