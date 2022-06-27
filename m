Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B7955E0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiF0JvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiF0JvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D96EC63E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656323475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ODcJ6zydXCy0RZ8g5fZRHZR+hlMipts1TZGkhFsZ1LY=;
        b=cb0sj9Dt1dQGs6CmtLZowD2s6mKiK2Rou0+DYQIjWlFhn7Noq7aMBFIQ/FXZ5Vpvwnb1KC
        3w0bjI4AiahdvQrL0K1/mBMY4k4hmx7dh3XzrzkJwUjqiSbXxp7y43pK6IXqRYoufa31KX
        CcTC3J1Sfy5IGYwOEzlmR/53YC+XIL4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-GEPC4uU3O5eeFy75kyzBfg-1; Mon, 27 Jun 2022 05:51:13 -0400
X-MC-Unique: GEPC4uU3O5eeFy75kyzBfg-1
Received: by mail-qv1-f72.google.com with SMTP id q36-20020a0c9127000000b00461e3828064so8873576qvq.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODcJ6zydXCy0RZ8g5fZRHZR+hlMipts1TZGkhFsZ1LY=;
        b=SWlwwbTXKK+3vjnuaJOIBX39tSCZkdpHYvFqdzfRVsWn7UUozM3GAB30EDrcH3PAGY
         FwqF9AX+9+CW2LwCE9BSGwISH4c0dynY7H7DGFMFGAQN7sLba9jsfGt3w0F0z43ZWlfm
         cRmwDpGyXQt1+tQmSTJg7K+QzRU8Jvpz6FeqkI2qKAmHk8OJH+am4HxMJThxrfFfQovO
         1FRUAD8aqsDsULay2YUv1//gJS3IjIMf1R+p+1X+/hWV4Td4IAN+W8KnS4nJBKYr1Lt8
         +JELCwfgb244WbYPC+vAEdMeQdd60fJ74NIwui9pL8D7FEFu0UM7u9gR1yq3EZikMROL
         62Fg==
X-Gm-Message-State: AJIora8o2UJfJdyFIU9DW2NK+jCxtARRG1VIW8uQmfifpCjD+HTwYZ4q
        DemJZFtk/znkwuHrMOexgQdZv83A7BqczTafqCne0Oy/TWMf1fa1ibRfNt+/y3gofMLx42HH6se
        iCeTVg6Mx0oPNjjQPoAOOMPuchkpwLbQNOL0d629rOeL9PhMpXqh+EBc3Yy49X3bD83Bq0y65Ke
        fff7w=
X-Received: by 2002:a05:622a:1992:b0:319:cb47:b3a4 with SMTP id u18-20020a05622a199200b00319cb47b3a4mr3868115qtc.472.1656323472797;
        Mon, 27 Jun 2022 02:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vstaH0LIoUtcaZsCgkerz4macwKXsk/gMfm6Al+4zrfGHkmD/MM84XZGxlVYeWOoxVFH6+bA==
X-Received: by 2002:a05:622a:1992:b0:319:cb47:b3a4 with SMTP id u18-20020a05622a199200b00319cb47b3a4mr3868086qtc.472.1656323472424;
        Mon, 27 Jun 2022 02:51:12 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id p11-20020a05622a00cb00b00316d7f9ebaesm7262444qtw.3.2022.06.27.02.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:51:11 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] linux/wait: Fix __wait_event_hrtimeout for RT/DL tasks
Date:   Mon, 27 Jun 2022 11:50:51 +0200
Message-Id: <20220627095051.42470-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper on
PREEMPT_RT) are not visible to hrtimer_start_range_ns, thus not
accounted for by hrtimer_start_expires call paths. In particular,
__wait_event_hrtimeout suffers from this problem as we have, for
example:

fs/aio.c::read_events
  wait_event_interruptible_hrtimeout
    __wait_event_hrtimeout
      hrtimer_init_sleeper_on_stack <- this might "mode |= HRTIMER_MODE_HARD"
                                       on RT if task runs at RT/DL priority
        hrtimer_start_range_ns
          WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
          fires since the latter doesn't see the change of mode done by
          init_sleeper

Fix it by making __wait_event_hrtimeout call hrtimer_sleeper_start_expires,
which is aware of the special RT/DL case, instead of hrtimer_start_range_ns.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---
This is a continuation of discussion happened at
https://lore.kernel.org/lkml/YqnygxNWOztakt8+@localhost.localdomain/
"[RT] WARNING at hrtimer_start_range_ns"
---
 include/linux/wait.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 851e07da2583..58cfbf81447c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -544,10 +544,11 @@ do {										\
 										\
 	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
 				      HRTIMER_MODE_REL);			\
-	if ((timeout) != KTIME_MAX)						\
-		hrtimer_start_range_ns(&__t.timer, timeout,			\
-				       current->timer_slack_ns,			\
-				       HRTIMER_MODE_REL);			\
+	if ((timeout) != KTIME_MAX) {						\
+		hrtimer_set_expires_range_ns(&__t.timer, timeout,		\
+					current->timer_slack_ns);		\
+		hrtimer_sleeper_start_expires(&__t, HRTIMER_MODE_REL);		\
+	}									\
 										\
 	__ret = ___wait_event(wq_head, condition, state, 0, 0,			\
 		if (!__t.task) {						\
-- 
2.36.1

