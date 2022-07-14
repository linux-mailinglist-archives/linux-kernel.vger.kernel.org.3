Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24055745DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiGNH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGNH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3D1C1A828
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657783694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=550DnVq2EPGtnDKY2qpgJkb609RpXGjFmRJ5BQ0wADQ=;
        b=P+xLCBecwV1KC1JADtA9/PxknsssNbIW9Q3zNe/2fiRMwD674+3jtzjKbGfTl68MQdo27L
        ycQi9b9kHBK0CnG++k7SxnnEUyh2WMqSaZXC8ej+KBorFhHImfHB19qBBpcD1w28IE49TL
        ifl3mhsZO8/oFoj+lvrGSBfYhzrQzA8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-3Hdg676JOoS_vO6uj_Zvjw-1; Thu, 14 Jul 2022 03:28:13 -0400
X-MC-Unique: 3Hdg676JOoS_vO6uj_Zvjw-1
Received: by mail-wm1-f71.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso285179wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=550DnVq2EPGtnDKY2qpgJkb609RpXGjFmRJ5BQ0wADQ=;
        b=XUs1q8WinLxs0tEkmVvZ+UX+V6FRsNJKFoIaC6OH+/oVhw30jELasewTkAcyh0drHW
         SRxqZqs5gmFHA4pcsW9OHOoq00tX8EtgzF7HEESQvISDpXVICKpbsSgo/PrUzTJRMHlQ
         KAJGD+VPRewD+kbVoSc2gfS3zy2r3we92EsN62lD+ImjMSkxER6jCgK1yHxQ9hRZHIR6
         H7JoDrWsTzqYo/giZoxANnrMV3QaUZjkdhexkvkbqUGkj6yKz/PQdsZd00TSXVTRIjHI
         joGJIH+mkcBNYf1Jo3JexFBuqiYJmXIhFuK78DOZmkhz/6DetlXAf6tuolbXXC7ry0R2
         bOJg==
X-Gm-Message-State: AJIora+uu1vKzDeo33AIRr6chsm1ZM03cj7hqoSzYw/7xiYgielZhIVw
        mh60oCJlK3u3xeclO+EhHo9xjVvY2MDs+CVVu8WUHRwDG4n9aaaInK6JSkoYpCPuUpJWAOUGbe5
        xwmfYcDz3Hv+QKma0G7yehpc0
X-Received: by 2002:a05:6000:184f:b0:21d:a1fb:4581 with SMTP id c15-20020a056000184f00b0021da1fb4581mr7101580wri.651.1657783692019;
        Thu, 14 Jul 2022 00:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sjhAbKxOlxMx3NXmtd/EXEqUwfGIgEpReiSfsIDYPLQEnzkffk8gHoAGkQGXKHLczrIWYK8A==
X-Received: by 2002:a05:6000:184f:b0:21d:a1fb:4581 with SMTP id c15-20020a056000184f00b0021da1fb4581mr7101549wri.651.1657783691723;
        Thu, 14 Jul 2022 00:28:11 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.26])
        by smtp.gmail.com with ESMTPSA id r3-20020adfe683000000b0021004d7d75asm705037wrm.84.2022.07.14.00.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:28:11 -0700 (PDT)
Date:   Thu, 14 Jul 2022 09:28:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>, bordoloih@vmware.com,
        ankitja@vmware.com, Keerthana K <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/07/22 14:31, Srivatsa S. Bhat wrote:
> 
> Hi Juri,
> 
> On 7/13/22 12:50 AM, Juri Lelli wrote:
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
> 
> It looks like this problem goes further back than the above commit
> (which was merged in v5.10).
> 
> Even the oldest LTS kernel (4.9) has code like this:
> 
> if (... && p->dl.dl_boosted && ...)) {
> 	/* code */
> 
> } else if (!dl_prio(p->normal_prio)) {
> 
> 	BUG_ON(!p->dl.dl_boosted || flags != ENQUEUE_REPLENISH);
> 	return;
> } 
> 
> And we have observed crashes in the 4.19 kernel series too (CC'ed
> Ankit Jain and Him Kalyan who have reproduced this issue).
> 
> I believe commit 64be6f1f5f71 ("sched/deadline: Don't replenish from a
> !SCHED_DEADLINE entity") introduced the problem, which dates back to
> v3.18.
> 
> Would you mind updating the Fixes: tag and adding a CC: stable tag as
> well, when you respin the patch, please?

I think you are right. Will do.

Thanks for taking a look!

Best,
Juri

