Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48764757A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbhLOLTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbhLOLTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:19:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D64C06173E;
        Wed, 15 Dec 2021 03:19:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so42558835lfv.4;
        Wed, 15 Dec 2021 03:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/jLQjejN2VfR5T/xeA4fzGNyg1b3us8WnkzpdD0XGQ=;
        b=gGKaat8yo/0W8Tjp3XG6PFBmspGD+tbqkJvA4viw9U2nfdEoNclDAHLFfHcxIIuJtE
         abaY8jBpo9vqe0tfiosMNyfVvKTWwOFIE19DaDmfU8KkhTfD5gMfJ6fl/KhTxZJm8N7y
         b9RU+WZR4L1NLFsiwAVUjQOZOL2Adr0108Ta2lEIUa2eMSJafrBXNSGQlfw0j3GM97SG
         QeJLGG+di3ZTW/DS2a/lEdqLwg+CIepipQctHNrfkskiLEPwhw/mZA/36CppvBRjOeOV
         mZ59S2whDAms0L8j0Iqp78YG0icPWe2loWoD/sudwXUi3ZcGYuaHINKexPLnXBfALHP8
         uXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/jLQjejN2VfR5T/xeA4fzGNyg1b3us8WnkzpdD0XGQ=;
        b=zsSCUU5OcoZRNOt8Iu7Q0tFTvpaY4+efqeJJ/tu7Cq1eV6kssaq2rjcFmQzsKjaMpo
         VgXV/9WPCOgoSpc+F5CHWw6n0RmlHX4OUe5KGOp62hmvZXaU7VttmpuoDXxQ0LkG7o8u
         I0xhlHBRbGlydkZNfBomsuc69XA2c+cuPcrBZOQ3GopMNZxnlLUX8YoY17ocd0b5yp5e
         vytfWdEhelzL1+Rdiy5T8QKHoTIxFNJ+pwQNeEdeAlXwjhX9wH9FQXatiPDBN9hewvPB
         8hdCM2kh1X+YsLIPMVq5EKWcWHue1hB/ZKYmLC0fMvg39Vr/dPylhttLppJk06hSZVth
         nR7g==
X-Gm-Message-State: AOAM5327hJ/+2ArpNU0rEl0LzDS4gIKIz5i095orV39pBqcSM4/tNUsI
        53N3wTA7A5mKlvJZggHi2RCEcme4rbYRBch3
X-Google-Smtp-Source: ABdhPJxZ9nsFQpG6k9CX3mAY2mTc3bLpL5l93/9TYo3Y/en64cPwugDYDlt1Izg0U7wr9USTRq24NA==
X-Received: by 2002:a19:c350:: with SMTP id t77mr9461676lff.152.1639567142108;
        Wed, 15 Dec 2021 03:19:02 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:19:01 -0800 (PST)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH] scsi: core: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:45 +0100
Message-Id: <20211215111845.2514-9-urezki@gmail.com>
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

TO: James E.J. Bottomley <jejb@linux.ibm.com>
TO: Martin K. Petersen <martin.petersen@oracle.com>
TO: linux-scsi@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 3 +--
 drivers/scsi/device_handler/scsi_dh_rdac.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 37d06f993b76..308246ce346a 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1238,8 +1238,7 @@ static void alua_bus_detach(struct scsi_device *sdev)
 		kref_put(&pg->kref, release_port_group);
 	}
 	sdev->handler_data = NULL;
-	synchronize_rcu();
-	kfree(h);
+	kvfree_rcu(h);
 }
 
 static struct scsi_device_handler alua_dh = {
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 66652ab409cc..dc687021ff3a 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -782,8 +782,7 @@ static void rdac_bus_detach( struct scsi_device *sdev )
 	}
 	spin_unlock(&list_lock);
 	sdev->handler_data = NULL;
-	synchronize_rcu();
-	kfree(h);
+	kvfree_rcu(h);
 }
 
 static struct scsi_device_handler rdac_dh = {
-- 
2.30.2

