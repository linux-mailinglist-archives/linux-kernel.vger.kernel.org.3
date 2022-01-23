Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF739497494
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiAWSlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiAWSlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:04 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B0C061762
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:04 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 128so13765689pfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QPKVddXMwyPUGJHCiBL7SqymTrzOfaCYlNdg2PQJoYo=;
        b=Iuh+2DtxuSEMkkUDpbhNS7s4A4Ryp5/2axsi17WCpZOdLQexzRWGG94IclzD4noeoE
         m7xu9iXKYySVHL8p04V+gv0xr+CPfTI6cdzYMcx9GRpoKbAgk3QFV7SaqeijUQUhL/f0
         z/rGeX05aH+UT1FOD/rswO/+tOuwXagALyijgDkxJpRjDrcl6VxZXY8Mh3x3IQWLEAM1
         TeLWq5rkQRmlZOkzw/Xut+RSfu10I5+m/ascmhUvfod6cLzfSCuIO+uY5F9RrHD9j8XF
         x7e2zB/H0SmJXM4XoVwvO6XSbNtXaLUff0UBYfTH1/hqb/lF8+SDeujHTLbfILlN8FMz
         y5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPKVddXMwyPUGJHCiBL7SqymTrzOfaCYlNdg2PQJoYo=;
        b=mwDeq1xJTaSeaNVVtFOIU2NGVB6miFU9Y2SGTTCPzRBC4/Cj9uYbCULIkvivL9rd9t
         RSfrdZzCTGWSNLDYFhOUo6mkE/i8dbhav2q1wBClz+uTu9mFwcRaqKXFa4yhDJhF9jgn
         z1BalPF1Xe5didGsR015YeW7C5mKsLQD4+FJr9RcXj6rbnAl97M4ORqHRS+qnBptRx09
         AkaYegliJ76p900eia+u+yZBUviYmLpDoEhydec2nRh8xWpNInX12rz3AmDP3bdgbVpC
         kjEhMFHibUD4YtFfSgnaoVOprd41eZ/fVKhrA9ISbhY+phqCBwADWQ0N9oihB9lQLwNl
         hseg==
X-Gm-Message-State: AOAM530mNNbZf/yr6q7cqP56R8XCiSDFDVvQDUQt04AguZGJ5spw/A7v
        vlccIqnkN+TbcQ+69VlMDPA=
X-Google-Smtp-Source: ABdhPJx9AGtXz/yHsvgR0AHxLbrVhd0CcN+ep2bKkeqRhK1BogRrK4KUaLaPLfv0O2CgN/UDdfoMAw==
X-Received: by 2002:a62:4c3:0:b0:4c2:7817:7360 with SMTP id 186-20020a6204c3000000b004c278177360mr11430170pfe.24.1642963263649;
        Sun, 23 Jan 2022 10:41:03 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id ns21sm4951068pjb.43.2022.01.23.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:03 -0800 (PST)
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
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 24/54] time: replace cpumask_weight with cpumask_empty in clocksource.c
Date:   Sun, 23 Jan 2022 10:38:55 -0800
Message-Id: <20220123183925.1052919-25-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clocksource_verify_percpu() calls cpumask_weight() to check if any bit of
a given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 1cf73807b450..a2fecb4d8c0e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -337,7 +337,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpus_read_lock();
 	preempt_disable();
 	clocksource_verify_choose_cpus();
-	if (cpumask_weight(&cpus_chosen) == 0) {
+	if (cpumask_empty(&cpus_chosen)) {
 		preempt_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
-- 
2.30.2

