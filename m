Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714F14974BD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiAWSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiAWSmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:13 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E887C061744
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c3so13491565pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VqjN8AVE4l1jGj4WKwwteMJXfvhHCp8LxE1b5uVHyhI=;
        b=C1SMT8g72QpJmf2bGBlHtrMJyAm02anZRdJPiD2hXPa8KnxyJmdZw8KHlGAX0+WQGc
         BZHWyBl2a5DTg8aenBofL3Pa+LSa4prxrtnLXqzJa+qJVVLWS9YDxbbC4POYvOHztAqw
         IyapelEZ/75WdLGC84xm+UEAL5Cev9xJG06mFRsDSpCKQLMoLxgo8eFVJQqILZ1wkvcj
         /C5aH5KAaWIXgqOmeQebx/JlfxVpZJzkpasVbNS7lD3Xygu7Dq/lNJpvZKtbbQBFVMYy
         bxtmSmEeLKDAfMNUeFJyK+ebz4bFvez0SDfycUa2ySgs5dFSDYB8Y/ANERmbRLt77Z2M
         N4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqjN8AVE4l1jGj4WKwwteMJXfvhHCp8LxE1b5uVHyhI=;
        b=4uq1Ag+v3dGH+lR9nb8OAPfr+lcbzlMUyshvu+9vF26rkhVSBRTc7f7pH+qRT+XD3P
         eW7rTdiOB4GBBcXhHEEI/uvDSm45Q+hyebvc7b154bihpm71AZpHsoBQYoJPkQeyyuVt
         KY0uSobdB7BFSj/C+ti97M0px1cFuwjPQbH05vSINVTqwW2GK1KRmE/KNot/4OpfytK4
         irRutd5RLT4ZC4NLGLOpZLYA0B+lDpQnK3dMjtYPdcmIlGl0QOmcEgIUjyZaaV/PJcQ9
         Co/mZBdqgBO8Q2fGCYL0/iwgzb2uEUNbqfL5OAFeq2dwuQ2CQD+vLdBod5i6+e1OTcqg
         VewA==
X-Gm-Message-State: AOAM530CC+y0P8quG1rNTlmcQziVWkGmkGo7HL0EJqU3wzB985Qt/5mK
        lzahlK0fa3ymtdM9rT+k+N8=
X-Google-Smtp-Source: ABdhPJyR3LEGx3dQjXbO/uCCX9t/QjIgjrhqlzEDELiIFsGeBhAD2N532FLMhxMOd5s6FzXSuCmH2g==
X-Received: by 2002:a17:902:d883:b0:14a:4ba5:6e72 with SMTP id b3-20020a170902d88300b0014a4ba56e72mr12062149plz.27.1642963332593;
        Sun, 23 Jan 2022 10:42:12 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q140sm10315902pgq.7.2022.01.23.10.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:12 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 46/54] soc: replace cpumask_weight with cpumask_weight_lt
Date:   Sun, 23 Jan 2022 10:39:17 -0800
Message-Id: <20220123183925.1052919-47-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qman_test_stash() calls cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_lt because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/soc/fsl/qbman/qman_test_stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index b7e8e5ec884c..28b08568a349 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -561,7 +561,7 @@ int qman_test_stash(void)
 {
 	int err;
 
-	if (cpumask_weight(cpu_online_mask) < 2) {
+	if (cpumask_weight_lt(cpu_online_mask, 2)) {
 		pr_info("%s(): skip - only 1 CPU\n", __func__);
 		return 0;
 	}
-- 
2.30.2

