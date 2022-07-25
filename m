Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1C57FC73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiGYJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73AC813E8A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658741566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=X+Qwfg78s0YoOWpe3U1EomLxQZyMo0G7UJxLf2W9JB0=;
        b=RZbGN4bpulFMJoFTqg/HHQ5RSsgDunKb6L/9z1+ZNLNuegJo0mL94KUMaapcDZ2JtPPWc7
        PRZeuNW+ysCTP36W4W3N06RB8l4wGBHNamgA/Gn3F5XUr+aRaUJ/RMLgN2JRmkiMUgWEux
        e+VdtpPOTYmtRouuyvMBHLOkT4CcqGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-LhP_01y2OcyjE5dOFKfm_Q-1; Mon, 25 Jul 2022 05:32:45 -0400
X-MC-Unique: LhP_01y2OcyjE5dOFKfm_Q-1
Received: by mail-wr1-f70.google.com with SMTP id t13-20020adfe10d000000b0021bae3def1eso1464752wrz.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=X+Qwfg78s0YoOWpe3U1EomLxQZyMo0G7UJxLf2W9JB0=;
        b=izhLx+XK8Op4nYtFR6XprcQS/OTYRdFXofzk1A9sUKC86s2tCFDiFuxNfbrww3gCd0
         KrkQsDxO5zJCp8RdevQMSYfFAjP9FOLvg6BDJ1AFEABPHiOBVh1yz6v2X+iVFy8DrW1R
         oNn9HNwkeJKm5A4SQrKHAKWYr78/xIfNC7zB7vnzen+QAlstLE9R1rpScA2BXtqmC4F+
         nWt/ZS33qETOgxT49uG1f06SHOrKFJiOjorxcpRx0byniKDcr/An1TDQkh1b4XA9U01M
         8G85BEEQ6gC2c56rL4VMVTQcgp8dXh/2H0Wtg/LGYBEl5p/ZnOHC+iI22E7AeXkAABG5
         zP0w==
X-Gm-Message-State: AJIora/7qszit5+50qbaVL+yLXKVD8+Iom1uvSgLLhYz+USfj4qO0vxs
        ILhwuoJlVdXPwMVLHwSDbASRpH5DMHiWpcnsfFv1JIjDOSufzM62479xGbAUURJ+BkTPBYb5IIU
        IMJ/GnIhmDoChCnGbCArWE+Qc
X-Received: by 2002:a1c:4b09:0:b0:3a2:ff2a:e543 with SMTP id y9-20020a1c4b09000000b003a2ff2ae543mr19757335wma.93.1658741563999;
        Mon, 25 Jul 2022 02:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1smz1eC735IW/Qs7rsRDlfDdzyagDi7+UjtzBGs7XsKSv4Wdo/7577e93nUiK2g9hCoo7Q8sw==
X-Received: by 2002:a1c:4b09:0:b0:3a2:ff2a:e543 with SMTP id y9-20020a1c4b09000000b003a2ff2ae543mr19757316wma.93.1658741563712;
        Mon, 25 Jul 2022 02:32:43 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c22c900b003a3270735besm13754847wmg.28.2022.07.25.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 02:32:43 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@infradead.org>,
        Chris Mason <clm@fb.com>, Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        George Spelvin <linux@sciencehorizons.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Len Brown <lenb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [Question] timers: trigger_dyntick_cpu() vs TIMER_DEFERRABLE
Date:   Mon, 25 Jul 2022 10:32:42 +0100
Message-ID: <xhsmhedy9fsg5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been incidentally staring at some NOHZ bits related to the timer
wheels, and trigger_dyntick_cpu() confuses me:

  static void
  trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
  {
          [...]
          /*
           * TODO: This wants some optimizing similar to the code below, but we
           * will do that when we switch from push to pull for deferrable timers.
           */
          if ((timer->flags & TIMER_DEFERRABLE)) {
                  if (tick_nohz_full_cpu(base->cpu))
                          wake_up_nohz_cpu(base->cpu);
                  return;
          }
          [...]
  }

From what I grok out of get_nohz_timer_target(), under
timers_migration_enabled we should migrate the timer to an non-idle CPU
(or at the very least a non-isolated CPU) *before* enqueuing the
timer. Without timers_migration_enabled (or if TIMER_PINNED), I don't see
anything that could migrate the timer elsewhere, so:

Why bother kicking a NOHZ CPU for a deferrable timer if it is the next
expiring one? Per the definition:

 * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
 * system is busy, but will not cause a CPU to come out of idle just
 * to service it; instead, the timer will be serviced when the CPU
 * eventually wakes up with a subsequent non-deferrable timer.

I tried to find some discussion over this in LKML, but found nothing.
v3 of the patch did *not* kick a CPU for a deferrable timer, but v4 (the
one that ended up merged) did (see below). Patch in question is:

  a683f390b93f ("timers: Forward the wheel clock whenever possible")

Thanks

====
v3
====
@@ -520,23 +522,27 @@ static void internal_add_timer(struct ti
        __internal_add_timer(base, timer);

        /*
-	 * Check whether the other CPU is in dynticks mode and needs
-	 * to be triggered to reevaluate the timer wheel.  We are
-	 * protected against the other CPU fiddling with the timer by
-	 * holding the timer base lock. This also makes sure that a
-	 * CPU on the way to stop its tick can not evaluate the timer
-	 * wheel.
-	 *
-	 * Spare the IPI for deferrable timers on idle targets though.
-	 * The next busy ticks will take care of it. Except full dynticks
-	 * require special care against races with idle_cpu(), lets deal
-	 * with that later.
-	 */
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active) {
-		if (!(timer->flags & TIMER_DEFERRABLE) ||
-		    tick_nohz_full_cpu(base->cpu))
-			wake_up_nohz_cpu(base->cpu);
-	}
+	 * We might have to IPI the remote CPU if the base is idle and the
+	 * timer is not deferrable. If the other cpu is on the way to idle
+	 * then it can't set base->is_idle as we hold base lock.
+	 */
+	if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->is_idle ||
+	    (timer->flags & TIMER_DEFERRABLE))
+		return;
+
+	/* Check whether this is the new first expiring timer */
+	if (time_after_eq(timer->expires, base->next_expiry))
+		return;
+	base->next_expiry = timer->expires;
+
+	/*
+	 * Check whether the other CPU is in dynticks mode and needs to be
+	 * triggered to reevaluate the timer wheel.  We are protected against
+	 * the other CPU fiddling with the timer by holding the timer base
+	 * lock.
+	 */
+	if (tick_nohz_full_cpu(base->cpu))
+		wake_up_nohz_cpu(base->cpu);
 }
====
v4
====
@@ -519,24 +521,37 @@ static void internal_add_timer(struct ti
 {
        __internal_add_timer(base, timer);

+	if (!IS_ENABLED(CONFIG_NO_HZ_COMMON) || !base->nohz_active)
+		return;
+
        /*
-	 * Check whether the other CPU is in dynticks mode and needs
-	 * to be triggered to reevaluate the timer wheel.  We are
-	 * protected against the other CPU fiddling with the timer by
-	 * holding the timer base lock. This also makes sure that a
-	 * CPU on the way to stop its tick can not evaluate the timer
-	 * wheel.
-	 *
-	 * Spare the IPI for deferrable timers on idle targets though.
-	 * The next busy ticks will take care of it. Except full dynticks
-	 * require special care against races with idle_cpu(), lets deal
-	 * with that later.
-	 */
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active) {
-		if (!(timer->flags & TIMER_DEFERRABLE) ||
-		    tick_nohz_full_cpu(base->cpu))
+	 * This wants some optimizing similar to the below, but we do that
+	 * when we switch from push to pull for deferrable timers.
+	 */
+	if (timer->flags & TIMER_DEFERRABLE) {
+		if (tick_nohz_full_cpu(base->cpu))
                        wake_up_nohz_cpu(base->cpu);
+		return;
        }
+
+	/*
+	 * We might have to IPI the remote CPU if the base is idle and the
+	 * timer is not deferrable. If the other cpu is on the way to idle
+	 * then it can't set base->is_idle as we hold base lock.
+	 */
+	if (!base->is_idle)
+		return;
+
+	/* Check whether this is the new first expiring timer */
+	if (time_after_eq(timer->expires, base->next_expiry))
+		return;
+
+	/*
+	 * Set the next expiry time and kick the cpu so it can reevaluate the
+	 * wheel
+	 */
+	base->next_expiry = timer->expires;
+	wake_up_nohz_cpu(base->cpu);
 }

