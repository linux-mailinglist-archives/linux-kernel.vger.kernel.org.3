Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892024720B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhLMFrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhLMFrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639374464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jqZjVXuB02/na70pVy+Ypnpg6sqRgLlH0wP5jPX/dC4=;
        b=a3md97SHMjJAs2uNVzNUN4cc5kReWkrXl70+P8IrbNNQJkQGkOrfao/xCGmnVsVXP1igz3
        qTpizI5IKrykQo+rmmyYsRy/vSiOp/uC3UiJWr7GX9fTqUSbaGSdYuEB4wttH38Ovyw+Qd
        FV2rroUwvZpndj97Nh2MGmKixsccX6s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-420-wUZuEHsPOeCNs4mCaMXKJA-1; Mon, 13 Dec 2021 00:47:41 -0500
X-MC-Unique: wUZuEHsPOeCNs4mCaMXKJA-1
Received: by mail-pg1-f197.google.com with SMTP id r9-20020a63d909000000b003312e182b9cso8510633pgg.16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 21:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jqZjVXuB02/na70pVy+Ypnpg6sqRgLlH0wP5jPX/dC4=;
        b=wHtDJHiTcU9KqGI5nCQxo1delgLohlbdhwPsDvGJ8FKZg0+ZJfZ+KPNcL3P5KfoQHQ
         vlVRojvKjoxB+WC2u5OhCfFMLwz7loz4l9rIwmgG/rejwQInDfxuPLMnBl7FdLZqIGnE
         TvfLMbKCFT+WQlevu6x95DkZTpd/JPGczX+TynoUc92Z/iuYzd9o7sTPgUzcG9FyvnWN
         3U4Hclq274mu816YkInmmOXEuWVgqBqaKyDl9JNhUKj2gXxwCq7F4wJEDLc6JcEeBSA3
         khsIUWuCez4K1kEWqec9aLAgRGfC22epBprNwG7NSxme8HFK8mnMX5TGyJ23tLgExFDy
         JT+Q==
X-Gm-Message-State: AOAM531gWa8LrY8v/xrPO3/PWh33zpbsLAhRxo4gvjhYpJRas/sjMQdv
        kJiBdz2SaeiM2KMC0wy6MW4ZAJKbCmWHXok+YOyRnQYmYTzfkIcBnm66mkj4EI9/Ja6Lh4bBbFd
        njEpgy+HU7MT0zkqVSHxSFdCG
X-Received: by 2002:a17:90b:97:: with SMTP id bb23mr42812688pjb.201.1639374459078;
        Sun, 12 Dec 2021 21:47:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBg/xhnjq3sQ6/B8LuYiHaj91tFcJorpVXkfe/StyvJF3p6PRgEewvHIK4YYtjSSeoz8Es7A==
X-Received: by 2002:a17:90b:97:: with SMTP id bb23mr42812666pjb.201.1639374458729;
        Sun, 12 Dec 2021 21:47:38 -0800 (PST)
Received: from localhost.localdomain.com ([103.59.74.139])
        by smtp.gmail.com with ESMTPSA id fs21sm4621888pjb.1.2021.12.12.21.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 21:47:38 -0800 (PST)
From:   Suresh Kumar <surkumar@redhat.com>
X-Google-Original-From: Suresh Kumar <suresh2514@gmail.com>
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Suresh Kumar <suresh2514@gmail.com>
Subject: [PATCH] net: bonding: debug: avoid printing debug logs when bond is not notifying peers
Date:   Mon, 13 Dec 2021 11:17:09 +0530
Message-Id: <20211213054709.158550-1-suresh2514@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently "bond_should_notify_peers: slave ..." messages are printed whenever
"bond_should_notify_peers" function is called.

+++
Dec 12 12:33:26 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:26 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:26 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:26 node1 kernel: bond0: (slave enp0s25): Received LACPDU on port 1
Dec 12 12:33:26 node1 kernel: bond0: (slave enp0s25): Rx Machine: Port=1, Last State=6, Curr State=6
Dec 12 12:33:26 node1 kernel: bond0: (slave enp0s25): partner sync=1
Dec 12 12:33:26 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:26 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:26 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
...
Dec 12 12:33:30 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:30 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:30 node1 kernel: bond0: (slave enp4s3): Received LACPDU on port 2
Dec 12 12:33:30 node1 kernel: bond0: (slave enp4s3): Rx Machine: Port=2, Last State=6, Curr State=6
Dec 12 12:33:30 node1 kernel: bond0: (slave enp4s3): partner sync=1
Dec 12 12:33:30 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:30 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
Dec 12 12:33:30 node1 kernel: bond0: bond_should_notify_peers: slave enp0s25
+++

This is confusing and can also clutter up debug logs.
Print logs only when the peer notification happens.

Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
---
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ff8da720a33a..0ac964359fbf 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1096,9 +1096,6 @@ static bool bond_should_notify_peers(struct bonding *bond)
 	slave = rcu_dereference(bond->curr_active_slave);
 	rcu_read_unlock();
 
-	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
-		   slave ? slave->dev->name : "NULL");
-
 	if (!slave || !bond->send_peer_notif ||
 	    bond->send_peer_notif %
 	    max(1, bond->params.peer_notif_delay) != 0 ||
@@ -1106,6 +1103,9 @@ static bool bond_should_notify_peers(struct bonding *bond)
 	    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
 		return false;
 
+	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
+		   slave ? slave->dev->name : "NULL");
+
 	return true;
 }
 
-- 
2.27.0

