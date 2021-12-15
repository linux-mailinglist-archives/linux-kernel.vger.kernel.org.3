Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0B64757A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbhLOLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbhLOLTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:19:01 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7FC061574;
        Wed, 15 Dec 2021 03:19:01 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l7so32810239lja.2;
        Wed, 15 Dec 2021 03:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8R4atPrceTHEd56iw5wcGba7a8UslOFrqwu80FDwnk=;
        b=pU4mwNtFOQpVcKcXNusTjsKTqm6uD1qZxg99Z+ijuyr38/pd7Y7TC8N38LIKzoKST/
         SIyWMHJODG38VFZGw8xu+LJa0MezapU3CFvCoxEuMmQEUPh5PBcl7aN+Z8SyjBNbL0zJ
         pzHkYh+tlKww1gSNc0dz/lXDqDMC6e8LD5P68MWTmIhe4rx7JGqZPJwJaaAFKwzyhBLq
         HOjqTwSoLGe25yn8uNKFB7E84JmumX50rFjOOewPZGrxTpn13SX4bmMRdjxYVCFM1A12
         2txPbMDKzV8+lFniYWDASXRd/1iWnD8UW6gBaHMMenkDTjgGq2yqXwEZeeMhZ7ZmjC7a
         Tb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8R4atPrceTHEd56iw5wcGba7a8UslOFrqwu80FDwnk=;
        b=xacL/YJhIt+2GA16ZtwlFbXAFXiXm7v3nyxOCSqZKigijaZF9cEjdH69EJYPOgA8xt
         atATf5ozuWLBo+Z+o8e142VXE6aGIvlScB7NjPG/OE1i+xEzEHrESrnpu+lyjNC1+xyQ
         HNTYV6sSFydC+ehwVUGBCHakfaHhqcTmN7aTZmJTDPRDLv2xYjc1ItUkd0+mS4guiBoq
         w0EfZl6q3drWHDupjEHXl8Im4S2YOtkNHwjIsgln4R1OZQwzW/bQR1YVkURecYBqHPxn
         fWVBwFTKhLCRVblG0Udgq2/hRAe4kVDl9qZ4L7EChKoBv0z62EFU/KVNmePLFpFI1lL5
         jEEA==
X-Gm-Message-State: AOAM533gcWbFeSI8GRl8DP2+DQW4NrYgmY5P04kG66F204F8LcF3QpNd
        Ect2JgHeUOpwvuEAZKZw5gMITNa3Wl8YPsBn
X-Google-Smtp-Source: ABdhPJyDghtgwy7V7iPYz2zXnf6XnlD7nagpFZgrQ1xC9An9wY7GM0BsoESJaEilsJnIUlT4Be3fxQ==
X-Received: by 2002:a2e:86da:: with SMTP id n26mr9303933ljj.522.1639567139331;
        Wed, 15 Dec 2021 03:18:59 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:18:58 -0800 (PST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: vmw_vmci: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:42 +0100
Message-Id: <20211215111845.2514-6-urezki@gmail.com>
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

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
TO: Jorgen Hansen <jhansen@vmware.com>
TO: Vishnu Dasa <vdasa@vmware.com>
TO: pv-drivers@vmware.com

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 6 ++----
 drivers/misc/vmw_vmci/vmci_event.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index c0b5e339d5a1..6cf3e21c7604 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -687,10 +687,8 @@ int vmci_ctx_remove_notification(u32 context_id, u32 remote_cid)
 	}
 	spin_unlock(&context->lock);
 
-	if (found) {
-		synchronize_rcu();
-		kfree(notifier);
-	}
+	if (found)
+		kvfree_rcu(notifier);
 
 	vmci_ctx_put(context);
 
diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index e3436abf39f4..2100297c94ad 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -209,8 +209,7 @@ int vmci_event_unsubscribe(u32 sub_id)
 	if (!s)
 		return VMCI_ERROR_NOT_FOUND;
 
-	synchronize_rcu();
-	kfree(s);
+	kvfree_rcu(s);
 
 	return VMCI_SUCCESS;
 }
-- 
2.30.2

