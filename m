Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296B4AE11A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385263AbiBHSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385145AbiBHSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:42:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D1BC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:42:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b3so1919534pfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bV0qidYdKe49UwnnplwX5EgJUDf8zdhBMjx8WUJKWzs=;
        b=OHMzOVmuzS8R5vdjMnFQ83YEp0mRe52PlihZ6rxSISxMAiPFQkMYZTgLEk10Xm0usa
         o3hNE+BxWkLxBMsUZ/aRwqhOL9Vg0cn7OW7gLLh52bbdsf6/zJDpCrC7702jkr0M6AnH
         R2O1+OOGo5OSy/hMAiTKCaiqG4dq5JzQE2cvGPL2DtYv4/7J3cT7s1kSorRfmhhphEd9
         S/p2V/Z3OKSuft2IZomKHbhtTtD+NqCMtZPUccAoGl427hbooDuLd85z1FwVeI/tzTgl
         oc3lTysydSvotK2YYva1QthZGhJsxaKHJYKnFj6zv7i+kOCG/g9qnEKR42Qo34BFLF7e
         xvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bV0qidYdKe49UwnnplwX5EgJUDf8zdhBMjx8WUJKWzs=;
        b=LcEXKiBZQmmppD9miRochJe15d//FJ2KPnkAvE412sii/5WpbhaMVjLJqXyOTHY0s1
         Ao3QBvSSsxmFTkxDWCJbH5fPi16iDM+GmAVSqeWClZncHe811o2+hHSiHR2n1UyXTHAY
         +x/oya7gFwCVhUktp7OPdONgUyrsvrGa4FhfkHkjHhxrOMAQHLIQ8lHzmiBW8Nt+B7/1
         U/vTbY2WqM2aEF4ox/HfqL/DJla+oEKTHpvRcLRuAASAIUNiIXfZlkhnQpFeQQr5oRp7
         YusAYOYJZgWVQfOGepBQO+IlSv6ujKkSPrftkj2bTl7YcLlcMlRPKAqJcFoc4PCy/RFU
         EnsA==
X-Gm-Message-State: AOAM5313YyW9FLFpKAlMXnRY0SqMUXzKChZEwJgAo5ONrw5Sm7G0A96w
        3pwOzUj8idd3FrxYS8nrXE8=
X-Google-Smtp-Source: ABdhPJwqqGldEtUv1AKOwY1WV0H+ee56iUVLuA0Ex2r17FXyGt0+fH3AWdP72NQIVFRaVsBpoZp8Yg==
X-Received: by 2002:a63:e643:: with SMTP id p3mr4485222pgj.7.1644345752133;
        Tue, 08 Feb 2022 10:42:32 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id l14sm3517027pjf.1.2022.02.08.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:42:31 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 08/12] locking/mutex: Init name properly w/ CONFIG_LOCK_INFO
Date:   Tue,  8 Feb 2022 10:42:04 -0800
Message-Id: <20220208184208.79303-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex.dep_map.name was set in debug_mutex_init() which is defined
only if CONFIG_DEBUG_MUTEXES is on.  Let's fix it to work with
CONFIG_LOCK_INFO as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/locking/mutex.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 0b2a79c4013b..b7b584ecdfef 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -41,5 +41,12 @@ extern void debug_mutex_init(struct mutex *lock, const char *name,
 # define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
 # define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
 # define debug_mutex_unlock(lock)			do { } while (0)
+
+#ifdef CONFIG_LOCK_INFO
+# define debug_mutex_init(lock, name, key)			\
+		lockdep_set_class_and_name(lock, key, name)
+#else
 # define debug_mutex_init(lock, name, key)		do { } while (0)
+#endif /* !CONFIG_LOCK_INFO */
+
 #endif /* !CONFIG_DEBUG_MUTEXES */
-- 
2.35.0.263.gb82422642f-goog

