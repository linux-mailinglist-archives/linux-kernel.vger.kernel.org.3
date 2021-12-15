Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFE34757A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhLOLTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhLOLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:19:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21458C06173F;
        Wed, 15 Dec 2021 03:19:00 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u22so32744972lju.7;
        Wed, 15 Dec 2021 03:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mv8LCg5hfv3NsHhjpVbivA950W+vq5Ul9i+K+7LTn0=;
        b=BrPPIpSGRWtkZNSg87q8xBysJpiUgbg7Ac6Tr1kTnf1x1yGZuDZ1JNy79YtLu/4nL2
         N4DX8KW+gi+8BsDPwAB5S9eggLfw1ppjE+ZFj2FiGPUxhnw+A7YFF9DCgs9Oh0EGAZ0V
         2Gmsz2jF2aAHYFXNaegLwDSp17D26UYDb/NF13aM3D3oeOUXVDs6+X52TT6N5AAlqj63
         TK0x4cyAxW3QfVnvrhOdhcpKVlEIBArWkEb4aFV7pAPEYcYn+cfkAoKuGQvvJQ8r0wKT
         rU9elBmekfTdQNHNG75Y7t3Ug5OtuKWVLpIGFQOdNzGRyN3IIDbzdSygiZMLc0G27cY1
         imyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mv8LCg5hfv3NsHhjpVbivA950W+vq5Ul9i+K+7LTn0=;
        b=DiVicyRUNW7rYhg7ImL7+mcqWB2KqmacS8jO481TTPpb4lkigRdM3/usXMQkuALgc3
         Vbu6KhfdMTWXSSzj3LnLu58BzvR9RihcdT3BMYMqMGb5OiOjpBE66vHMG6WS4t4XSR5g
         Hu2ryOsm7Ql2XVDqj4zNmewl+qzxukyUGQSsUqkibtJCT6RZ/R6rMZ9y07jZ6/d8P8fF
         iP5O9Iw+rEjCuSTLN+6GxjR4U7BeZ9YlqR8j2fRn+5SYjZlqunKW1VAcposSzB3VvekD
         nXXqr83f/r2C4htBnbOqOdzi/ZMX+X3AyrlmG0kxTLPJiIODfUFZjZLaS8kDUXbsW3VL
         eXFg==
X-Gm-Message-State: AOAM533/dcV5oWmbDoMDOz8LCZTeu6zrocMboivkmpCJi8WoV0fbcGd5
        6TltgWVyStnIdy8gbjv84Zx88oOOh9EFqY5A
X-Google-Smtp-Source: ABdhPJzvXafSpGSGwSSTdm4oUN+syVOr4D4PnsuF+o4JmHKmW5e+MDe6WWNew7txvtqQZ/vSZOZVyw==
X-Received: by 2002:a2e:bf1e:: with SMTP id c30mr9804668ljr.408.1639567138426;
        Wed, 15 Dec 2021 03:18:58 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.18.57
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH] mfd: dln2: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:41 +0100
Message-Id: <20211215111845.2514-5-urezki@gmail.com>
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

TO: Lee Jones <lee.jones@linaro.org>
TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/mfd/dln2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 852129ea0766..365e3e77cac4 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -179,10 +179,8 @@ void dln2_unregister_event_cb(struct platform_device *pdev, u16 id)
 
 	spin_unlock_irqrestore(&dln2->event_cb_lock, flags);
 
-	if (found) {
-		synchronize_rcu();
-		kfree(i);
-	}
+	if (found)
+		kvfree_rcu(i);
 }
 EXPORT_SYMBOL(dln2_unregister_event_cb);
 
-- 
2.30.2

