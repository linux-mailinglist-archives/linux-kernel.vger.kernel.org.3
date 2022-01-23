Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C364974BB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiAWSnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbiAWSmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CDDC06173B;
        Sun, 23 Jan 2022 10:42:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so14270046pja.2;
        Sun, 23 Jan 2022 10:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GndtSn11kZKp8gPiAnYtAF0D1ExNO7oxGiuzzMjH66E=;
        b=BCY8BFgQYJuoXKOVV9p7rADrcLbaR8XwOD2oDh49UsHvgwjsHzRqmVsA58kTvbMC52
         8JK4BMrp4oZfp3fXguYb/3lGTDBa79/2a2dIP0EYqWSBlrHq6Q1+lWRisPqcd8kiwU0n
         NPAE97Kv0/tSwl1szc7CNNNEDeP3vnAGePfb1sRIXNHsvVq//ZdFKZvSrgBsOfnP584S
         XvRmz/4ORGJRhEHl2lHJCyNgfxlXqpkwXextNWwwAIASqn5NxAhQPNubJtagwZsHxm8g
         v/3WdP4q4IDpdGmg4yIOJm3LL/ymjzOiEu9TOP39Q8wNTbN+vnWyGAj8b/VaQE3Hwxm5
         JWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GndtSn11kZKp8gPiAnYtAF0D1ExNO7oxGiuzzMjH66E=;
        b=PAH95OcIOJauGinXVTdq3le7/k+ZaeU8AHRhsVmPawHQVJu3i1+K6VUZbi/hzXvqYM
         ZNpPYRN+ELCzqX7vNJ17I8G1NX3uODS8f0S713Q2wZMO5D9Jq+wWARwStJE0eL6XWOWO
         JnLb8wrynFEJlxdVBd/Khve57orDBpSR1ClrlSd2zACrUVdLwOXghoXCySLNMVLJ65oa
         Ye0LnD9vNHNs7GsIGKYWtlAHIcxKPxWD7RQkV2yKUSAAvOxIjviI+ABcSFST81W7DkhU
         dPddtS43vAA0MJV4m+lG2G7s/NREEnWpOsvPTlUPEiC/QRpDZpl7iuNzzDOIvYp5Y/6I
         VZig==
X-Gm-Message-State: AOAM533Ey+Ojucb3IXUvOW0kP3ZyH+g5WRSmz8DLOVIooKVfIomYhhRk
        7KwiTv5vXH3cs8aeenStDLk=
X-Google-Smtp-Source: ABdhPJw+B3WUB7yJ66uYnzJyrxSdBb4KzZWDTZMEioY+/QPO87Cj291gr3eP/fRZPxVluYuKiQlMrA==
X-Received: by 2002:a17:90a:7101:: with SMTP id h1mr9564886pjk.93.1642963329571;
        Sun, 23 Jan 2022 10:42:09 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c8sm14352243pfl.122.2022.01.23.10.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:09 -0800 (PST)
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
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 45/54] scsi: replace cpumask_weight with cpumask_weight_gt
Date:   Sun, 23 Jan 2022 10:39:16 -0800
Message-Id: <20220123183925.1052919-46-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpfc_cpuhp_get_eq() calls cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_gt because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a56f01f659f8..325e9004dacd 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12643,7 +12643,7 @@ lpfc_cpuhp_get_eq(struct lpfc_hba *phba, unsigned int cpu,
 		 * gone offline yet, we need >1.
 		 */
 		cpumask_and(tmp, maskp, cpu_online_mask);
-		if (cpumask_weight(tmp) > 1)
+		if (cpumask_weight_gt(tmp, 1))
 			continue;
 
 		/* Now that we have an irq to shutdown, get the eq
-- 
2.30.2

