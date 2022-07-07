Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D148656AA6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiGGSXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiGGSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:23:15 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B05A2EC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:23:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k14so23972182qtm.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=feedback-id:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X9++tSx2Q3dj3EHyHS7CfMESdH5gB/pHrn+gp7alMx8=;
        b=S76hnCfbZLLhsSMFlS7ANwjphG7JK3MWk31F3dawY39musHG348HfcivgF3JYcY+3S
         g+4BLwc+Z7gkqHVJbyF3S98/D/OIA2CpGaTJnWtDIXt1L/aF5AqEgeh2fyswPVnaZOLe
         zUI9ICqEZmOYh7uuqi7WsUT/fHChUWekg24wI9JB68aF+/V60mPpa5bjRmGAh6WvYBT6
         RxKgk9esNU6ooySEyU1PPRVNQTLRtZkwwJx70YwHkRLXemIwmeicp3izuMIkvZB7Lorq
         wSxQ1IHt0WLt7tNkbRZSc6izM/uD3DlDiCB/v1vCQH70Rbzvse2BRSEZNqwd6SbtkqLY
         hGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:feedback-id:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X9++tSx2Q3dj3EHyHS7CfMESdH5gB/pHrn+gp7alMx8=;
        b=LnbtzoWddlXspe3YH5iQbUKp1N6WBArM8lUgeCCej/BUeGrFYoz2EQ/lx6lL6t/aFE
         8IJTWIdPF97rgfr93U9RLz7sQR6GGhWQmFs5ZeiGIS7avvVVO5Fdjaswz14wEabKroIt
         McT8wh0tAhmLDuWuE6saQ0Q+jvF8P2NF32atfnwxLlHPSOP46UEI5vCOGeh0D4prVqwA
         mz/O4eF5rgd6jZjI0dtsRqJFkNtXNFcjUGjJnKWv0cieElSVYCrYqeJX0qtNaHpxGIw2
         5i6YErmr7hccpctdkcF9Hq5rKPuWMwl8sNyjzfYCDLqYp1LtdTJCZj56NggiSMTfLoCx
         WkZg==
X-Gm-Message-State: AJIora+MrEW/XGC97APgF0fNhHAP+5+WgOvdqJu3xWW5IwGsWZOUar6k
        vhkHQai9fcQ7uFiBrGciDXRokBS6NFM=
X-Google-Smtp-Source: AGRyM1vXnAuklTIZkLgGDtsx8EUI/3UNljPEcljnMc0WDF9aRi/cs08AsfrDjVMQNsV2RIHUGLgA7w==
X-Received: by 2002:a05:6214:2525:b0:473:10e:a109 with SMTP id gg5-20020a056214252500b00473010ea109mr15914143qvb.42.1657218193151;
        Thu, 07 Jul 2022 11:23:13 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g6-20020ac842c6000000b00317ccc66971sm26441441qtm.52.2022.07.07.11.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:23:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1ADDE27C0054;
        Thu,  7 Jul 2022 14:23:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Jul 2022 14:23:12 -0400
X-ME-Sender: <xms:jyTHYuLVOYbgOft9Vo2f6sMKoGfGNBl1V2KSpS2fobAUQzG2aNeK5A>
    <xme:jyTHYmI5F41EyDDCz_DgFvSy5mZlxiNmRSrT66AA4ed_d2X-wHWgGboNQrPckYo69
    pmxp99dcsThnE_q_g>
X-ME-Received: <xmr:jyTHYuvSKcq9pjS5Tc0mGEfiN93jRNU4U8n4A0RhTZCKySmKssVyYncFd2d0gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeihedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jyTHYjZc1SbwHqBeNy3T_zask3AoGkiNCJSBSDIyTof1el_XE8Ulog>
    <xmx:jyTHYlaLvEs6WP0Q9NtxJ4jk2ioN2rf-DpCNo2SxI382IRR45f88Ng>
    <xmx:jyTHYvAzpSw9NT4lA4GDcUOR1YIxydLlVZa1Q3XVXtse8amzqd8Ctg>
    <xmx:jyTHYjNMb5ISBLsO9NaBwFRPsccnawrIUYrUp69ZL6QNu-sPWj7ftA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Jul 2022 14:23:11 -0400 (EDT)
Date:   Thu, 7 Jul 2022 11:22:15 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH v3] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Message-ID: <YsckV+iWLxPC+eH5@boqun-archlinux>
References: <20220706135916.980580-1-longman@redhat.com>
 <f3051cbb-313c-ba88-66c9-3f8f8d88d806@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3051cbb-313c-ba88-66c9-3f8f8d88d806@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:03:10AM -0400, Waiman Long wrote:
> On 7/6/22 09:59, Waiman Long wrote:
> > Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
> > stealing") allows unlimited number of lock stealing's for non-RT
> > tasks. That can lead to lock starvation of non-RT top waiter tasks if
> > there is a constant incoming stream of non-RT lockers. This can cause
> > rcu_preempt self-detected stall or even task lockup in PREEMPT_RT kernel.
> > For example,
> > 
> > [77107.424943] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
> > 
> > Avoiding this problem and ensuring forward progress by limiting the
> > number of times that a lock can be stolen from each waiter. This patch
> > sets a threshold of 32. That number is arbitrary and can be changed
> > if needed.
> > 
> > Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >   kernel/locking/rtmutex.c        | 9 ++++++---
> >   kernel/locking/rtmutex_common.h | 8 ++++++++
> >   2 files changed, 14 insertions(+), 3 deletions(-)
> > 
> >   [v3: Increase threshold to 32 and add rcu_preempt self-detected stall]
> 
> Note that I decided to increase the threshold to 32 from 10 to reduce the
> potential performance impact of this change, if any. We also found out that
> this patch can fix some of the rcu_preempt self-detected stall problems that
> we saw with the PREEMPT_RT kernel. So I added that information in the patch
> description.
> 

Have you considered (and tested) whether we can set the threshold
directly proportional to nr_cpu_ids? Because IIUC, the favorable case
for lock stealing is that every CPU gets a chance to steal once. If one
CPU can steal twice, 1) either there is a context switch between two
tasks, which costs similarly as waking up the waiter, or 2) a task drops
and re-graps a lock, which means the task wants to yield to other
waiters of the lock.

Regards,
Boqun

> Cheers,
> Longman
> 
