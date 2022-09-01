Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2E5A9E43
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiIARjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiIARhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:37:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0539C52A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dc390f26cso233055697b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=vKtrq3HIq0qVh4puVrk/99Ll6PM2V5XVbSUsmvDjj9I=;
        b=tivdYiD8ZAJK8kY23bdnMjSf6GqsaVRSwINiFtGtPiGjoWq5MFwTdXcs6F+jY7ZJCK
         /S9q6olR7R7v5bTdyGGJAkaj1esNAWRQw+6z/ncs3LyR7k1VQNGfhn+1/vYhCXSOHiL4
         6opl/Yux1TzXEQKGzwy0i4oX47fV8vpc6BEr00D/YdbkLyZ9SHmRwW4kBhG1xNo5Bgh3
         mtUhM/EXxGiBQ9J+E4RQUvuZwU4rl5n4anzWcV73TPe35S1Oe6kIZC4EGb3KKcT8isc0
         o4+RnjpTFgDSTn6r4q7bAZvWDnDcTYKIxFWZmBACSU/yC2EIvY26FAMGgxLd2T0siGu4
         jeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=vKtrq3HIq0qVh4puVrk/99Ll6PM2V5XVbSUsmvDjj9I=;
        b=Fv//1KzKLC1NbToh9QT3EYIm0khX23uqsd+4iIoF13PCpK9skQJJPLL/ewBfIl62C4
         +liRQvnwZyUltFagL4G3SyG5xNH3hia/jsWeZDE1el0hmA1Bop+UX0ZcNXmtt8XYS31b
         4/Awa4f8+z7JwplsKvTQcajH40LcldwPkkwC9Ee+4qagWZcztKvlYq28RPWpeDc04dvQ
         VuaFLR9aY2khk2aTH6fIe2jPP562lSn9qVh+IG5nhYCcm2u3E3cc29phAwMwzozWvrc/
         EZ7SByQHFM5DHgIRemaWFHshVApE0ta0ZsyJpZ6l1p2uaPUGN+3lJehTgBhb0DaQuky5
         X0eQ==
X-Gm-Message-State: ACgBeo2SvblN+kc7j8/ckvjgKlg61REenyRssjuEhE6mHBjVCOWNzJpK
        D0DDdDvkmcqKDTsTdrhbl96dFj1KS2o=
X-Google-Smtp-Source: AA6agR6ETpVykmR2l2EiORnO/7/6aTPnOWA5nUbQjzShI0yNekZbMOoTb0Et/3IYHZBh1H/HSgpOo7WMY1M=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:9a85:0:b0:69b:79d2:7f4e with SMTP id
 s5-20020a259a85000000b0069b79d27f4emr15568357ybo.379.1662053792100; Thu, 01
 Sep 2022 10:36:32 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:15 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-28-surenb@google.com>
Subject: [RFC PATCH RESEND 27/28] powerpc/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Dufour <ldufour@linux.ibm.com>

Set ARCH_SUPPORTS_PER_VMA_LOCK so that the per-VMA lock support can be
compiled on powernv and pseries.
It may be use on the other platforms but I can't test that seriously.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 arch/powerpc/platforms/pseries/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index ae248a161b43..70a46acc70d6 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -16,6 +16,7 @@ config PPC_POWERNV
 	select PPC_DOORBELL
 	select MMU_NOTIFIER
 	select FORCE_SMP
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	default y
 
 config OPAL_PRD
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index fb6499977f99..7d13a2de3475 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -21,6 +21,7 @@ config PPC_PSERIES
 	select HOTPLUG_CPU
 	select FORCE_SMP
 	select SWIOTLB
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	default y
 
 config PARAVIRT_SPINLOCKS
-- 
2.37.2.789.g6183377224-goog

