Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DCC4E54A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbiCWO5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiCWO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:57:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E4681658
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:56:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w25so2136811edi.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQBWG3iG2YDpU2sZ3kZwVDKSqvG+EpLXHQB9/8rPRoI=;
        b=HwszbUdruDU5/SuzZsKlZx33qNs/GAmeLgdcObStSYHM5jG/bF9r6I36yjBpqqfKqj
         2UbkB2/REfsU2+16Q18IFj76axNbsn1D4+wXms64mMZ2OoNGF5c33PlRF0Vm53u2aOi+
         B0Fqa+hXmclAE1YftbCKN/ATFVD8cmNIxhTXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQBWG3iG2YDpU2sZ3kZwVDKSqvG+EpLXHQB9/8rPRoI=;
        b=TaQVkKqJkwhwMDi12RrSlJsO+iJcnb35tGmFa0xVZlU69VfNHxczjACsUX7j9DtHUs
         /Oq+mvcoaFyP5oExXo+zE8m9muhKiP3ePwKlw7dbbQ37SS8TZGa/fX5jS0kw92J7McSM
         McTn2AYxr1aSJWWv/LT3Xkd9bxlSub6feRguFYT0c4/7OaAOY97kfqfT1LKRM9F/qGHz
         HjMzG5a9xfofTHF2SgVZ9dUPt3R8lh7yeXYcKIJfssKQ5KJabPZKV9VzGaPJmmYnwThE
         mVUgGfKCShwVX8yBCumwKKRjsQ1tCzQxFTQCP2aDvT6soCDySZ7SNwz3xT4YM31x7dsJ
         JQtw==
X-Gm-Message-State: AOAM530vuhgvVviT9qYtCOG96KueUdcUHJvXmSEg03PiaITwo7uVtqiU
        umSsqYC5XzPMSDl5rtnChHIu+Q==
X-Google-Smtp-Source: ABdhPJz92UoqTDhaDcjRT4yThKBAmsSOGl7es0yyXjpPu0LaL1/NL8DZYCinWC6YhS5CABb3icOewQ==
X-Received: by 2002:a05:6402:13d6:b0:419:2eab:d21 with SMTP id a22-20020a05640213d600b004192eab0d21mr589209edx.78.1648047365532;
        Wed, 23 Mar 2022 07:56:05 -0700 (PDT)
Received: from prevas-ravi.tritech.se ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm77256edu.51.2022.03.23.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:56:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Pribil?= <a.pribil@beck-ipc.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Esben Haabendal <esben@geanix.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-rt-users@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 0/2] RT scheduling policies for workqueues
Date:   Wed, 23 Mar 2022 15:55:58 +0100
Message-Id: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC is motivated by an old problem in the tty layer. Ever since
commit a9c3f68f3cd8 (tty: Fix low_latency BUG), use of UART for
real-time applications has been problematic. Even if both the
application itself and the irq thread are set to SCHED_FIFO, the fact
that the flush_to_ldisc work is scheduled on the generic and global
system_unbound_wq (with all workers running at normal scheduling
priority) means that UART RX can suffer unbounded latency.

This is far from the first time this has come up [1] [2] [3], but so
far no solution acceptable by mainline has been found.

I have been playing around with a solution that would (depending on a
tty.rx_worker module parameter) create a kthread_worker per port,
embed a 'struct kthread_work' alongside the 'struct work_struct' in
struct tty_bufhead, and then choose between the current queue_work()
and kthread_queue_work() based on whether buf->kworker is NULL or
not. That works, but is a bit cumbersome for the application, since it
needs to traverse all of /proc to find the appropriate kthread and set
its priority after opening the tty. It's also not a very pretty
solution.

So, taking a cue from something Linus said in the [2] thread, this is
an attempt at keeping the use of workqueues. A WQ_HIGHPRI, aka nice
-19, workqueue is not enough for RT guarantees. So this extends struct
workqueue_attrs by an 'int policy', allowing userspace via the sysfs
interface to choose, say, SCHED_FIFO 37, for a given workqueue.

This is obviously not for merging as-is, but it is working code that
I've tested would solve the problem we're having (with the few rather
trivial changes in the tty layer, which are not really worth spelling
out here). But before polishing this, I'd like to know if anything
like this has any chance of making it to mainline.



[1] https://lore.kernel.org/linux-rt-users/20180718164958.l3f4ajloobdkp5tz@linutronix.de/T/
[2] https://lore.kernel.org/lkml/20190110101232.9398-1-o.rempel@pengutronix.de/
[3] https://www.spinics.net/lists/linux-serial/msg17782.html


Rasmus Villemoes (2):
  workqueue: allow use of realtime scheduling policies
  workqueue: update sysfs handlers, allow setting RT policies

 include/linux/workqueue.h | 17 +++++++--
 kernel/workqueue.c        | 74 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 11 deletions(-)

-- 
2.31.1

