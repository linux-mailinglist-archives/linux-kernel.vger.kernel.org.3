Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5B5711E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiGLFm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLFmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 311EA8C176
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657604573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rr2NpSz95Nba37gHqSCQSn+4s0WDbKuM1o6GXxYrwW4=;
        b=eT6JGwAEKJkp0BxV+Lh5o+HjSZmGE//WldmhYHy7jUYrZXPvhi9UqAwtl1jHzgcYkVKMIF
        Uk+QC/ihaWDtLSBc9E1MKr5skZUVCBcomu8ru6g2MV24ZkRRKDDjlbIo1av6NWPLJ+yRn1
        n0lvK1z0jEoJ+7DkKN5rH+iIle118p0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-qgcWEzD9NfaTPLke5-a5qA-1; Tue, 12 Jul 2022 01:42:47 -0400
X-MC-Unique: qgcWEzD9NfaTPLke5-a5qA-1
Received: by mail-wr1-f70.google.com with SMTP id h29-20020adfaa9d000000b0021d67fc0b4aso1068522wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rr2NpSz95Nba37gHqSCQSn+4s0WDbKuM1o6GXxYrwW4=;
        b=wCqv5ZtqH+wZCqpf5mbAjn0/mb1rhufWAo2AW2YAJHurCYqWKhyAxNRyOgL/fh4mjb
         chAz3DDPc6kGl7b8p9wcJTXl/Tv7GoqTNCVp0AUmLuyTkgL721vzC1iG3CBuRrkCzsEf
         57JtacYs9QO60u0eQtN1eSU9pS9rSJySSTTlb8KO0TZfjuzIpIZQUYNOG8D7tXtPWvjB
         VTU4RssZQt/Cqb+9+KWaQ/7iWHdmamTVulWXp2N2g3x1Hyzpq6gOi2BipyR73qL5+ha7
         g55e3KRlk6LRWyN07dDCA45carhRqh7KoqXsr2P3Oi5KDyGz+cVNcQ8D+tHQ3zJV5yuy
         1KJw==
X-Gm-Message-State: AJIora8QGKcLe/bI83RVpEES9HezgVRtHOUSNDBiZ+qVkMo5c6vplSuL
        pYTPrftrSRZzrV61YTjtafLkh1tkDqbHaGr5xdxKdK5q3ZKk0fncYpY8PQjZtRVQt2iY3aZ52B8
        RUx1w1z9/0c+jsgl5eBSGx4wc
X-Received: by 2002:adf:f64f:0:b0:21d:76c6:d98 with SMTP id x15-20020adff64f000000b0021d76c60d98mr20278232wrp.299.1657604566560;
        Mon, 11 Jul 2022 22:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slcfV//6rP054RoCRMOtQUrM5ceac5x6CadI8120dlpk6sy+CgSTzQQMO268DHEJKmzjWg2g==
X-Received: by 2002:adf:f64f:0:b0:21d:76c6:d98 with SMTP id x15-20020adff64f000000b0021d76c60d98mr20278208wrp.299.1657604566325;
        Mon, 11 Jul 2022 22:42:46 -0700 (PDT)
Received: from localhost.localdomain ([151.29.51.61])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c4c1400b003a1980d55c4sm11423288wmp.47.2022.07.11.22.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 22:42:45 -0700 (PDT)
Date:   Tue, 12 Jul 2022 07:42:43 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] linux/wait: Fix __wait_event_hrtimeout for RT/DL tasks
Message-ID: <Ys0J00yyLlT2Q/vM@localhost.localdomain>
References: <20220627095051.42470-1-juri.lelli@redhat.com>
 <xhsmhtu7weytl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhtu7weytl.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/22 09:41, Valentin Schneider wrote:
> On 27/06/22 11:50, Juri Lelli wrote:
> > Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper on
> > PREEMPT_RT) are not visible to hrtimer_start_range_ns, thus not
> > accounted for by hrtimer_start_expires call paths. In particular,
> > __wait_event_hrtimeout suffers from this problem as we have, for
> > example:
> >
> > fs/aio.c::read_events
> >   wait_event_interruptible_hrtimeout
> >     __wait_event_hrtimeout
> >       hrtimer_init_sleeper_on_stack <- this might "mode |= HRTIMER_MODE_HARD"
> >                                        on RT if task runs at RT/DL priority
> >         hrtimer_start_range_ns
> >           WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
> >           fires since the latter doesn't see the change of mode done by
> >           init_sleeper
> >
> > Fix it by making __wait_event_hrtimeout call hrtimer_sleeper_start_expires,
> > which is aware of the special RT/DL case, instead of hrtimer_start_range_ns.
> >
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Makes sense, that's now aligned with what e.g.
> schedule_hrtimer_range_clock() does.
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks!

Gentle ping to the others about this one.

Best,
Juri

