Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A994974AC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbiAWSmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239894AbiAWSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:53 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7737C061748;
        Sun, 23 Jan 2022 10:41:44 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x37so9813297pfh.8;
        Sun, 23 Jan 2022 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Azd/w2Pv4tWIAvkFg87uiwY2Tzr35b3ymris6XNGI+U=;
        b=IPyJfSxowKcB1S3Q1A4DTZa7XdI3e/XLnFC7naVawaaQ+1a+LtUNQ+e7L1/yh1uVnU
         tJKAhbiAtQmE7P3de0oCrhKBgD83mkQONZzr24n6xdYLMwpBMQ4wjv6rDLtRwAinUqWj
         t+lS9kohf4hERa3Dcc5YBZXqRN5C2wf9P7AyvM1DqjJJTmRX/0pwnajQC0iWSf/TaORQ
         Kb9Rr8lYSFcs5alkmVEFbtbaUleUoZ5hcxIjxRshgTwzvy2Tf4ynKKCEExSxgj3kyb5c
         tCb/HyztCPdSBTHTBayp1FVJQdkzrDqOD+6gkbn9ctA5mbUNZqpD9qsgH5p/3gicHVGE
         6Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Azd/w2Pv4tWIAvkFg87uiwY2Tzr35b3ymris6XNGI+U=;
        b=41OZloVqGKlwUBz3536NGGdPlEZRQ932eSMZvCnE3jDwJj4pt/Qw7gTEDL4tccwLe/
         ZaR+pI5rqxH8hucmmAz6ptwvGdtBtXnJXO5YyTw+VJ70wm7swauYLNmYApCN73+S6/IM
         Su+k9i0C2aNRkYsylaa2fTCD1iqIFniTHqGnyDCJWtOC/HzgL1qwTJkq4UIn/CwLqCKP
         VWMTo8kzOGTnYA0xX4xw9YioEH/++N0OOWXC6hBPisL4yY4rEVe6xzHltl1L9ZUm3FSf
         Kg2PHHOaq9B9nMnw8iwN+foRFk9LbO7OzpzQBQDcSnWdYwKoYU6Ws/x6Rerx/W5Si3jV
         hoVw==
X-Gm-Message-State: AOAM530wun6cxDYGzTelbPwf6Eddbu1As3cILFbofHSmFl78C6trGqVQ
        EA7ndON38gxBD7CwMz6b6h8=
X-Google-Smtp-Source: ABdhPJzM40DL0G0MWrnWXQaAocMzZ4JkN5vXEMfehpYSeKlSDkS1lKxTvQEApD4W0wyCbqB+jxF+cA==
X-Received: by 2002:a65:494f:: with SMTP id q15mr9457430pgs.333.1642963304207;
        Sun, 23 Jan 2022 10:41:44 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id z29sm7442507pfk.38.2022.01.23.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:43 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH 37/54] arch/ia64: replace cpumask_weight with cpumask_weight_eq in mm/tlb.c
Date:   Sun, 23 Jan 2022 10:39:08 -0800
Message-Id: <20220123183925.1052919-38-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__flush_tlb_range() code calls cpumask_weight() to compare the
weight of cpumask with a given number. We can do it more efficiently with
cpumask_weight_eq because conditional cpumask_weight may stop traversing
the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/ia64/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 135b5135cace..a5bce13ab047 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -332,7 +332,7 @@ __flush_tlb_range (struct vm_area_struct *vma, unsigned long start,
 
 	preempt_disable();
 #ifdef CONFIG_SMP
-	if (mm != current->active_mm || cpumask_weight(mm_cpumask(mm)) != 1) {
+	if (mm != current->active_mm || !cpumask_weight_eq(mm_cpumask(mm), 1)) {
 		ia64_global_tlb_purge(mm, start, end, nbits);
 		preempt_enable();
 		return;
-- 
2.30.2

