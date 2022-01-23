Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336664974BE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiAWSnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbiAWSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:19 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB6C061778
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e8so13482292plh.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JZIbGsK4fO2MmYeZQFtgL2Ya3fsLijV0bZeyyLWVcBo=;
        b=aUu0ISOJcNHam1D3Deq4AyVkQoVeIW2t7/+xoxukqRlijxKAKMOj78cgt43a/ei4O1
         0qBwFjn+P6QLJr2+wKvS0EcKSrQg6mt4PFWodNwqKDPeWfCi7wYI9gfBVe+HOIF5Zemp
         NPKMnKGkp9WLy3q9OJBIgUBz1KG4/Z7f9evOvF/91Tn1lI8xKoTxnDJN/Z2rWXDXZUem
         IxaPj5p1F0DqYX3yqlJtl6mqNMsfUy+eDzlRKccIkzih5UbyroeukBtDgkxOfC53IOj/
         EBud2UhpLrJCkoFjjwbO78ukwiewlbuiEN7ns5yFjwfeHMFIpRAS9HSkDzA9klQeap9d
         TqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZIbGsK4fO2MmYeZQFtgL2Ya3fsLijV0bZeyyLWVcBo=;
        b=2iOlMzA3a7PG/P3ub2yI/178aETmYaKxUAPGqiLdVIFNkc9dptabWW5GwQueP74lcb
         1z4y+bvpDEnHGvAdgpkIZhKFcW3nHQNaHoVn97qeQi4GN5AN3KLe/raNdW+f0FHf3LlS
         41hFeZlZD4zzngnCJ6cvnSFwTZlVJtWSkKto1PyVRh4Pocb5yGElPbymBbFbrFB3KqpD
         neWNej56RNXmFtYRaWjr8KFxPSJmRH/Us7uJFeyjhDf0qInlb+UfgGiT2dkA8S5IR8Jr
         tEaklXD3DQTQgwQnl1hlG4nQzyD8NIYjXB6GllkJLbFtsDUsXIoEEtKVrGLJLSKzaNwC
         HzVA==
X-Gm-Message-State: AOAM530NWWBLAxfJFNnySgVmUA0M2aLvLPZhYM1uIZGaZCqEjO2yIDPu
        nGpwYvn56BJYcsfT5I4wqT4=
X-Google-Smtp-Source: ABdhPJxZyVaSdm8qfd0Lxd4g15OkNroNLz6HGWoPVFx+Xofe/zxCaNgOOfWpiOJzDf8cAIJOPuRTJw==
X-Received: by 2002:a17:902:f243:b0:14b:1f32:e923 with SMTP id j3-20020a170902f24300b0014b1f32e923mr6194383plc.121.1642963338768;
        Sun, 23 Jan 2022 10:42:18 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id s2sm170778pgq.38.2022.01.23.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:18 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 48/54] kernel/time: replace cpumask_weight with cpumask_weight_eq where appropriate
Date:   Sun, 23 Jan 2022 10:39:19 -0800
Message-Id: <20220123183925.1052919-49-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick_cleanup_dead_cpu() calls cpumask_weight() to compare the weight
of cpumask with a given number. We can do it more efficiently with
cpumask_weight_eq() because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf338d20..32d6629a55b2 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -648,7 +648,7 @@ void tick_cleanup_dead_cpu(int cpu)
 	 */
 	list_for_each_entry_safe(dev, tmp, &clockevent_devices, list) {
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
-		    cpumask_weight(dev->cpumask) == 1 &&
+		    cpumask_weight_eq(dev->cpumask, 1) &&
 		    !tick_is_broadcast_device(dev)) {
 			BUG_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
-- 
2.30.2

