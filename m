Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D644757A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbhLOLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbhLOLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:19:00 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44380C061574;
        Wed, 15 Dec 2021 03:18:59 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id m12so32790697ljj.6;
        Wed, 15 Dec 2021 03:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXBBA6tooNUJe0qcFXJZUGQ+vzEcA/gvh+yxjKcwpWY=;
        b=pFAJRY08zh4uBk2yxFcOF5CRP5Xaooyqwvpkmq2oEvGAQ29n7VwOVwMZ5YcYsRtnjE
         TMWBfGOrijArZzJlMRZvq59nWMFouDYH2FJf6e8QPgc20vUl57S/RRbBOVRc9YectayT
         F2eCI8I/9mnHUmreR8KoSMZq3aVMOOvYOLqDkwfKPUib3W1BRd09Q4NlPJYTDXWhOMbn
         G3b/ALm9DCYnoIb+KaP3vIwidiQQviOunF7lPv7roa/cOYoydJdnOqD6pTL14WXmV2SO
         eyGz/EIHJeNKSIUIVwATPPo560Dw6J4xxFMkkPmFsjZx9utlFKT8M0AQTmJhngBqii9S
         g9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXBBA6tooNUJe0qcFXJZUGQ+vzEcA/gvh+yxjKcwpWY=;
        b=Tf/8Z6B5azX79OKO+2xPA2rlT9/qj7miKW7fR7x0ST6PS8Dxa9gN8SQ8JR6UqShy3t
         34DU6XhYz+QQNyLk79w9WOFHyJFkxOU9Rc1aClQ/yRYmnlzgcOygzzg2fn6DFR9VotC8
         8kJxeijN54U96ZXuMjhX786hesD/gqGqha0288I/MO0CQvRbBS+VWG9mzkyoYnQh9bGE
         DWDdnNw85nutGTJZD9fgGUjHf3iZqWJCwN8qPXdZb69tXE4ePeRNpNry0ZKZVdk53ZcN
         yM8vVT/8LqtjIZ7dGJzgyQOYdVM3QIdb+PUF42PAqiVGO7J0mBSkKKRrcSBGMNMBUTA0
         wX5Q==
X-Gm-Message-State: AOAM533AYl6lhSLDQlJ4nfPqJqGrNE+cQ/5wf1CLFjmhea9go58iE8D3
        HD7HUI/XUHtbwHyqtb/yTQzOrQpLPPd0y+ck
X-Google-Smtp-Source: ABdhPJyjG0DF4H4NoX1YAecwDQnw1hcE7326b6kvl7XCGvbMqGBBUdTOiGM1KVJ4k4cFtCxeDGNOcQ==
X-Received: by 2002:a05:651c:1689:: with SMTP id bd9mr9870481ljb.192.1639567137573;
        Wed, 15 Dec 2021 03:18:57 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:18:57 -0800 (PST)
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
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: [PATCH] fs: nfs: sysfs: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:40 +0100
Message-Id: <20211215111845.2514-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215111845.2514-1-urezki@gmail.com>
References: <20211215111845.2514-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

TO: Trond Myklebust <trond.myklebust@hammerspace.com>
TO: linux-nfs@vger.kernel.org
Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
---
 fs/nfs/sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 8cb70755e3c9..ff88d5d58e1e 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -113,10 +113,9 @@ static ssize_t nfs_netns_identifier_store(struct kobject *kobj,
 	if (!p)
 		return -ENOMEM;
 	old = rcu_dereference_protected(xchg(&c->identifier, (char __rcu *)p), 1);
-	if (old) {
-		synchronize_rcu();
-		kfree(old);
-	}
+	if (old)
+		kvfree_rcu(old);
+
 	return count;
 }
 
-- 
2.30.2

