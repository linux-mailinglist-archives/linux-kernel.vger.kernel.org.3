Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D844587934
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiHBIm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiHBImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FE091834B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659429743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4OpWRpLrMYsL2KSFpwdyO4aF9mwz1xUB24NEFQPJIA0=;
        b=Q+s+fqJPSFlzMrkrlSYdS05L+iEEBs4gKqs4JsYuSBlfZWu38h97c6QbI2Pf1q490JBQ4t
        Z70XJh6HuHLRGThIttO7bbtCwbw4/FI/Igkq0BGcKEPEoid1fhftECcKpjKWo8RJpzD3MX
        klabLJuXQ90xv24DA5o25ZyaS7vE0h0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-345E7Fa6MOuxg8G5ZMY-gA-1; Tue, 02 Aug 2022 04:42:22 -0400
X-MC-Unique: 345E7Fa6MOuxg8G5ZMY-gA-1
Received: by mail-wm1-f72.google.com with SMTP id c189-20020a1c35c6000000b003a4bfb16d86so2833722wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4OpWRpLrMYsL2KSFpwdyO4aF9mwz1xUB24NEFQPJIA0=;
        b=P6IyEsuoA28d8p37ZHELbbMCL7/+A3CJwpwjoXmozgaa/iBW/fbaO95ozrUGf+GVdm
         fPfUI/RYgFtnDn6j3v4e/DyjbHdXSLP9C2ldmpGyRGE7rcyEE6Pg5/USH2rYQjdfS1U5
         ebdAKsJWCI9xfegcgGtBhn17TtGZ9M7oBAutbKEcRzOAj5PhMNY7ohHh3T0F0TUiiN75
         ip3S6l4PIl6qmlE2dgu285ygI009qmv+DIhywSUFaYngG/f3IQbsso2hQlzQpo1QAKKm
         uOCv2ONYLOzY+/kqYXfTncZbvfZ+ZHBysWbRe24Bfp5fUWjBLgTRO1UlSxM7TZ7ekUT1
         CcsQ==
X-Gm-Message-State: ACgBeo0BK5ql4e2xtKroCvQYWzYsU7ii2KinArE0OM8qniqmnd6u+Y29
        PnyIb7b32T+EVpQKnijurZXr0VaFapJssfwkexAhE31R364RgLf3Pjx9jELVWO6tBdZ7y6SfMZq
        MXrBB61kPniYR/q8eRBVFHc3/t3hRv8Jw6dJUCx/hklB2fuKvg+vTMVA3qYVZJq770p+L2Iab5g
        P8
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr12739886wri.0.1659429740561;
        Tue, 02 Aug 2022 01:42:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZT/ezv8pPGE/YiUn43hbl6B4IHxF8QvzdUybP5iii4Pf6qdVOgMEyx7XOkycwno9a8TZ+4w==
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr12739867wri.0.1659429740295;
        Tue, 02 Aug 2022 01:42:20 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003a31169a7f4sm24825800wmg.12.2022.08.02.01.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 01:42:19 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH v3 0/3] workqueue: destroy_worker() vs isolated CPUs
Date:   Tue,  2 Aug 2022 09:41:43 +0100
Message-Id: <20220802084146.3922640-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Using a work struct from within the workqueue code itself is a bit scary, but
it seems to be holding up (at the very least on the locking side of things).

Note that this affects all kworkers (not just percpu ones) for the sake of
consistency and to prevent adding extra corner cases. kthread_set_per_cpu(p, -1)
is a no-op for unbound kworkers, and IIUC the affinity change is not required
since unbound workers have to be affined to a subset of wq_unbound_cpumask, but
it shouldn't be harmful either.

3/3 (not for merging!) is a simple and stupid stresser that forces extra pcpu
kworkers to be spawned on a specific CPU - I can then quickly test this on QEMU
by making sure said CPU is isolated on the cmdline.

Thanks to Tejun & Lai for the discussion thus far.

Revisions
=========

RFCv2 -> RFCv3
++++++++++++++

o Rebase onto v5.19
o Add new patch (1/3) around accessing wq_unbound_cpumask

o Prevent WORKER_DIE workers for kfree()'ing themselves before the idle reaper
  gets to handle them (Tejun)

  Bit of an aside on that: I've been struggling to convince myself this can
  happen due to spurious wakeups and would like some help here.

  Idle workers are TASK_UNINTERRUPTIBLE, so they can't be woken up by
  signals. That state is set *under* pool->lock, and all wakeups (before this
  patch) are also done while holding pool->lock.
  
  wake_up_worker() is done under pool->lock AND only wakes a worker on the
  pool->idle_list. Thus the to-be-woken worker *cannot* have WORKER_DIE, though
  it could gain it *after* being woken but *before* it runs, e.g.:
                          
  LOCK pool->lock
  wake_up_worker(pool)
      wake_up_process(p)
  UNLOCK pool->lock
                          idle_reaper_fn()
                            LOCK pool->lock
                            destroy_worker(worker, list);
			    UNLOCK pool->lock
			                            worker_thread()
						      goto woke_up;
                                                      LOCK pool->lock
						      READ worker->flags & WORKER_DIE
                                                          UNLOCK pool->lock
                                                          ...
						          kfree(worker);
                            reap_worker(worker);
			        // Uh-oh
			  
  ... But IMO that's not a spurious wakeup, that's a concurrency issue. I don't
  see any spurious/unexpected worker wakeup happening once a worker is off the
  pool->idle_list.
  

RFCv1 -> RFCv2
++++++++++++++

o Change the pool->timer into a delayed_work to have a sleepable context for
  unbinding kworkers

Cheers,
Valentin

Valentin Schneider (3):
  workqueue: Hold wq_pool_mutex while affining tasks to
    wq_unbound_cpumask
  workqueue: Unbind workers before sending them to exit()
  DEBUG-DO-NOT-MERGE: workqueue: kworker spawner

 kernel/Makefile             |   2 +-
 kernel/workqueue.c          | 169 +++++++++++++++++++++++++++++-------
 kernel/workqueue_internal.h |   1 +
 kernel/wqstress.c           |  69 +++++++++++++++
 4 files changed, 207 insertions(+), 34 deletions(-)
 create mode 100644 kernel/wqstress.c

--
2.31.1

