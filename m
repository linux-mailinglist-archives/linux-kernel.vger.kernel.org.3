Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06405ADBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiIEXIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIEXIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:08:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C9696FD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:08:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c20so6895355qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hk/srkBtxVkS+zUVkai21MOd0Ml2smnzuFrvLhiDgCY=;
        b=IEfScbVqtsTPgpyexhCh2rcgdcvGqGXJm4/pS4rm+XxbUBiy6QXx8PMESOdBrCMG6V
         WSRjzyNudWEjWQZbObdPjHo6oUVbEUNM9nJ9gC6lVvirLHMi6Qd9EvJvZepVa5DNTRME
         9lIxHLN+Z/XE9pKuKKwRdUEwH6ge0ieNiwPkvWhOzCeX6JG3Hmb5XNzR2fsmxTdAnvyO
         p+dcUc2NRxW6J3OO17Zlb0J99JfHswcEdFFtinWuPsXUSX6ZCQOuqYbowmgas0V0Y5Gr
         iOWgWXSa6hvShxI+VZgv/n4z3NVTJ8PqvakqH71AxwYYL1gMbqsMGV396Mitad/2xD1F
         7NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hk/srkBtxVkS+zUVkai21MOd0Ml2smnzuFrvLhiDgCY=;
        b=1uZmIuRsD8NFR93x5KAaeXYxSl8uk9bAmoucWVn4u8ZKf5CJ12jsF/8rDxPP0RqXtc
         MSA5VbQbErkWYsQdezqY21KggCoqll+aawgQclIx2lf8xs+lVVgJpmPz5sTb7FkVuoQ8
         HzxBRApVuNs+D5z4QI4dd6UNGms0KHiy4/4O972Z3sVSqb8X8a45uih6Cr+pY/+BGEbV
         TVEU3xEUvhMjULKQUuvaBZkTtSy0FLdGNMyffL9qr9aJQOD2Es+Eliim00exSYhw/kiF
         JGgSKQpSXlPlyLnlz8dixNYfHX0BjkZaWJVLt4a7SBkCchjp40oIhJjST0gBmTmTbZDJ
         QBYQ==
X-Gm-Message-State: ACgBeo0kK7plAmarE+52WJWWBAgdrnlF0Irs8T4EMqAkcFjxyPko1jd/
        yaKa/V1RwV2jpYqMTBecHg2O6JQuT+E=
X-Google-Smtp-Source: AA6agR6HM9+H1spruQ9WCbZ6vf7t8Yub5iwBItNOFc0oOxdMD6wVF7v4LKmGEEYHZmOXkqPuGS8lkQ==
X-Received: by 2002:a05:622a:58e:b0:343:79d8:2e76 with SMTP id c14-20020a05622a058e00b0034379d82e76mr41753624qtb.404.1662419303767;
        Mon, 05 Sep 2022 16:08:23 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:dde1:6b3e:62e9:1461])
        by smtp.gmail.com with ESMTPSA id t12-20020ac8760c000000b003434d1a7a14sm7763916qtq.62.2022.09.05.16.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 16:08:23 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 1/5] smp: don't declare nr_cpu_ids if NR_CPUS == 1
Date:   Mon,  5 Sep 2022 16:08:16 -0700
Message-Id: <20220905230820.3295223-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905230820.3295223-1-yury.norov@gmail.com>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMP and NR_CPUS are independent options, hence nr_cpu_ids may be
declared even if NR_CPUS == 1, which is useless.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 650810a6f29b..e971c9626a1b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1088,9 +1088,11 @@ static int __init maxcpus(char *str)
 
 early_param("maxcpus", maxcpus);
 
+#if (NR_CPUS > 1)
 /* Setup number of possible processor ids */
 unsigned int nr_cpu_ids __read_mostly = NR_CPUS;
 EXPORT_SYMBOL(nr_cpu_ids);
+#endif
 
 /* An arch may set nr_cpu_ids earlier if needed, so this would be redundant */
 void __init setup_nr_cpu_ids(void)
-- 
2.34.1

