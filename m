Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B58A4757A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbhLOLTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbhLOLTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:19:03 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C6EC06173F;
        Wed, 15 Dec 2021 03:19:02 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l7so32810390lja.2;
        Wed, 15 Dec 2021 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+iHO/SIeyGqNyQAEiJgdx7jAWs0ko1xH4TyQey/PuM=;
        b=qB193CP6wWLHcjEQZXm5STxeoKgeaTkm/g3xMIKpLqsLe/iNxMNVJP27KxDAb1jK1C
         jkAoJS9yir8YwYdzllryf27OezSLCqH2dcWWXuErTHz5cLvEcUQKlWmhgMprgU0bx8Ux
         tyhf1wpn9KyQC8mzJvajfbG+uWs41tAz9lJgFe8RhKXzMm5hri9QM9JGVpdVQ7wUTU/G
         9PEdxbP/mrYNrHYFY07CYuj02fu6BffqGJU5PT+xXX6FoY93eQxEGAcJIkSXaK9B7Ux0
         4HH8k0Nzx0HezuyEpsW2ui2qM1Iq/UewPRrxS9tNqObAyJmaZ8H8m3ENpF8WRRspwcZi
         J8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+iHO/SIeyGqNyQAEiJgdx7jAWs0ko1xH4TyQey/PuM=;
        b=2n6m6RvNnObp0uUP+FTMTIniMLqcwgeb1YWPuhsfJDjS6SJrAG9/L/9j8vFNEZqSZd
         r3tkClaS6Qaz1y1ulJKekIyomzyFUM3gn08wnjuTASUjWmJ/SNvMCjUnFNMQ7eOSoUjx
         5YqRQEGz7pxLB90HyDBpK9Q8537jC2ZToGX+TwVrdizbJvHsQXeLgUEcut6Buxpe1w9f
         ZhdZfMSc5QGbeBuPZVSD4k06NsPzO7/5bI1PjfcgXa9idO7sbjhSLyYPvIPrONGSsIgN
         ESkjd+9LhUVND6vc0WtB3iarzBzmn6TWpOZHHeXDO4COF4ZGg3isn9E/bWbnGtjTL5UV
         NPXg==
X-Gm-Message-State: AOAM5315qYinz3CVXyxWp9100XBfNAAfsxIpv7n1C5X47bn6v9rbhUyf
        YhGgbS1ci+VD0bcif001qGeLYYT/wADGgDpd
X-Google-Smtp-Source: ABdhPJzMT2JnUXhil69q/L9rLP+kO1nBtTqzWyX/s4NjqWrgk0PQP7eMgCUb2MRivdv5QTva/NQKBQ==
X-Received: by 2002:a05:651c:2119:: with SMTP id a25mr9712582ljq.131.1639567141054;
        Wed, 15 Dec 2021 03:19:01 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:19:00 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: [PATCH] RDMA/hfi1: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:44 +0100
Message-Id: <20211215111845.2514-8-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215111845.2514-1-urezki@gmail.com>
References: <20211215111845.2514-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

TO: linux-rdma@vger.kernel.org
TO: Jason Gunthorpe <jgg@nvidia.com>
TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index f07d328689d3..7264a35e8f4c 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1292,8 +1292,7 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
 	sdma_map_free(rcu_access_pointer(dd->sdma_map));
 	RCU_INIT_POINTER(dd->sdma_map, NULL);
 	spin_unlock_irq(&dd->sde_map_lock);
-	synchronize_rcu();
-	kfree(dd->per_sdma);
+	kvfree_rcu(dd->per_sdma);
 	dd->per_sdma = NULL;
 
 	if (dd->sdma_rht) {
-- 
2.30.2

