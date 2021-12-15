Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0C4757A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhLOLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbhLOLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:19:02 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC3C06173E;
        Wed, 15 Dec 2021 03:19:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z8so32765845ljz.9;
        Wed, 15 Dec 2021 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xT5IjP1JnQkIprU+ASPyKrcT111YK+PQBvjkW+Yhwt0=;
        b=V34l3oWK4R0ILeuEwoveQSgL4EoYgYRNT+KpMZTaDxq9aUYT+5fT8k8nLv5wlnCEIX
         zGDkbPCRPwL/PlrslFfXvGt8XBVzApxwW/qOeAfUDIaKlrL6loGKtrEJcca0asqIdo0q
         fIZMmN8n5d3JjL4dMPYM1S5tci52UiidTXBBwH79VjPh1SOqev/12o6+y1TeC4g41171
         Pnhqk8rfxfiT4Es3vcSJc9n3tQdpIOTlzkCI70j4k4PpM7ehYE7JUOh6Njlpb+0oTCFa
         bTGhNtcGKnP1eFnqoNOasxxiQ2FlAF+TiOLA4e+fo5gw4n9R/kB2YG2qtYWWMUTGbQJB
         vi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xT5IjP1JnQkIprU+ASPyKrcT111YK+PQBvjkW+Yhwt0=;
        b=trh3v5wDCkysOL2fu9dd+EcxPRSGiadTFvEYZnQKiK6Gh1Ge4RkdBf9TkMKmDakcnh
         YMnXxPETteANny0scQAH5bLjMYDqBEStbfwz2QW5s27rkuyLN3kZnr3qw0l6m2fU5mPY
         qlOKA8QvAvgI6OluuJX8abBYbc/govYXGL+EeYiDUJ5KXnGlfZWfHP886eBUgWLd9uA5
         k0uQKiXs20xKiapi+UeGVtydg5MIZswojROAonBJhC+koCSK3mKu0RtoMt+XzSQXSveJ
         pIcJ9Wln4la7BModK8H3Z4EBNlVISPo1E72u1qFJVRDLEIN15FXTGgE1Si30b0Ll80zw
         PbWg==
X-Gm-Message-State: AOAM531uB1vmygr5RhqrO+6wZa9m/vSYBDaw0SNnva3cAsVrjDKCdgsC
        efrOb2EUKJIQv+709vJVKNX5vJs2ebvwyalv
X-Google-Smtp-Source: ABdhPJxnJeL01THWlxPPh5GovIkUlNcPnK3+7W089auFGFZQ/BqDaZCbqiAeg2dtFtUKo3XvCeeCcA==
X-Received: by 2002:a2e:bd13:: with SMTP id n19mr9902919ljq.113.1639567140175;
        Wed, 15 Dec 2021 03:19:00 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:18:59 -0800 (PST)
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
Subject: [PATCH] mlxsw: core: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:43 +0100
Message-Id: <20211215111845.2514-7-urezki@gmail.com>
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

TO: David S. Miller <davem@davemloft.net>
TO: Jakub Kicinski <kuba@kernel.org>
TO: netdev@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 3fd3812b8f31..47c29769759b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2190,8 +2190,7 @@ void mlxsw_core_rx_listener_unregister(struct mlxsw_core *mlxsw_core,
 	if (!rxl_item)
 		return;
 	list_del_rcu(&rxl_item->list);
-	synchronize_rcu();
-	kfree(rxl_item);
+	kvfree_rcu(rxl_item);
 }
 EXPORT_SYMBOL(mlxsw_core_rx_listener_unregister);
 
-- 
2.30.2

