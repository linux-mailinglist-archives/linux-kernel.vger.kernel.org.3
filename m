Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052634AE464
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388026AbiBHW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386211AbiBHTnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:53 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFEC0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:52 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i186so376051pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bV0qidYdKe49UwnnplwX5EgJUDf8zdhBMjx8WUJKWzs=;
        b=eGq2LniziG9CjJRR2kTkUUuXbdtcfXwGY3muW0HW5G6quReyWc8n0x/6jxJm4o6G9e
         MigJKTIYPndMz6+XXV4Z/wNFIeXVhetAdOwSuPpcY63ffM8enPP/S6vrfJCJIgumNNpN
         d8LVPIWU9RYH6Fg0TWL/DErpNecQCxtzz4OajZM09Ztmmut3hoI0NYZakKJJZdb32xpj
         p8mPEWS03LuOi7GMBUMX4aGJynBMiraEr1N4gAwhZpWZZ+QJklVcwhzWMbSe81zPoDcY
         RrmOlUBijIBUGcAWoVwwl4qPDYaN9uMWcsiX8+S34/M06LEz3b1dF44r6laiwL3KXNJT
         mzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bV0qidYdKe49UwnnplwX5EgJUDf8zdhBMjx8WUJKWzs=;
        b=u0CPWeFM7CVrKmvbMY0hwqxR/qc+VANSAZmdDHXVDXjXRaDLEMLVC2BULjD+UMutcC
         76yU9ofJw8bVTPpKRPjCXdrn4CXuOMEKVuqRlu/gASV9EOJaxvUqJZoE42j8zhFeJdmO
         VO4vW+a309m5+DojYTOM+3gtkRaBAdwvFKd6Up3piBhQGzh8Zq61UKw2lOzPEDCKZh2S
         y7583Wv19Cm9Ods/6LDq2Ua/XQBzUV9et7v4WdNNdiKdunYAswU3sqQOdcGWiW9aX6wO
         /Z89StcHXuQCk3BYv4ixjnXSec0yUtC7wmyHySk9GfYegWMIzH4p25KaXCVw3Kmz9KUp
         AFKA==
X-Gm-Message-State: AOAM531KI1xQs7T9WIfV/+wGnC1S/gT93xTcJP3hmVaHGqzncpW3tmf/
        jfBPFAYrNxxJRi2xYkceN/g=
X-Google-Smtp-Source: ABdhPJwwj1bI0GWTB5NFt+lgqtppvKAhgRCsL3+JuDgFUYN27r8SV7aTKy49jo1clxPqwm+ioSRXlA==
X-Received: by 2002:a63:6b81:: with SMTP id g123mr4707638pgc.562.1644349432191;
        Tue, 08 Feb 2022 11:43:52 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:51 -0800 (PST)
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 08/12] locking/mutex: Init name properly w/ CONFIG_LOCK_INFO
Date:   Tue,  8 Feb 2022 11:43:20 -0800
Message-Id: <20220208194324.85333-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
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

