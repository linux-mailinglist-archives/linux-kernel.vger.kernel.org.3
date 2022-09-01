Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936755AA2C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiIAWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiIAWS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091E75C35B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:10 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x5so219538qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dpVq45gOBHghNC476XxsHo12GSN2n+TlCs0w1yjI1G8=;
        b=LHvRA8QK5VFw/jrPAKHEmEEsl0L+oZGGdwvCDSEY1J7Zf3XW17vgFCaaiJ5p+DinkX
         JywVDBQDKWVZmOUD+PWJONyE7y3Pj72l2fcvyocgTGJqG/OsejHHXd4qGxJCj3m5m77v
         d3hMh3KrXjEdiRpUQMsxM9gI5WAwTmvMZcliE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dpVq45gOBHghNC476XxsHo12GSN2n+TlCs0w1yjI1G8=;
        b=epLbq9savlHc+5AnexDp/L4NpU/3z5pl1BS2U+RkNXy2Zm16ouTC9WAxcs3MvTXL0C
         mvNT1QsrTR/j5oFEFERpTkkd+7abXITIdxmhXVFym124Bm+Qbt4SzhtMPCy0FHPX5ska
         avRW1q1lWoVLbtoMcZ+IARbPG4qhiYD4UuUyejdu6/8bZRiaSvA1BLqsw6pxqWpHXhu/
         bB5PrJkubxGhWYbcSsTx6zFy33PPYtDuwG3Snwn+SV0PNi3niDpNb9CcCdeni41ngmJ5
         WJYdUSO/7qfi5Zh7ArRUnpCPFwweGWcrCz38QN3Bg2R9aTwXs6xRzMBRmnmyWkR648UW
         bD/w==
X-Gm-Message-State: ACgBeo0pjEWxMltqhhhqQtbyEWGMUX/fl1CA6BCkoiK3b7RQ33RfKJbR
        HYCZkLPMdmdVPhcNlXj4ZnyP2A==
X-Google-Smtp-Source: AA6agR5fwM2qBQofpQTaAhwXy9MXIukc637mu6NfIRAgZbUg8vF1uoX4k76JfSjiT21Y9vviNS6TMg==
X-Received: by 2002:ac8:4e4a:0:b0:343:7e05:d2a8 with SMTP id e10-20020ac84e4a000000b003437e05d2a8mr26201508qtw.67.1662070689060;
        Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 16/18] lib: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:18 +0000
Message-Id: <20220901221720.1105021-17-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move radix-tree and xarray to call_rcu_lazy(). This is required to
prevent callbacks triggering RCU machinery too quickly and too often,
which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/radix-tree.c | 2 +-
 lib/xarray.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 3c78e1e8b2ad..49c821b16acc 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -305,7 +305,7 @@ void radix_tree_node_rcu_free(struct rcu_head *head)
 static inline void
 radix_tree_node_free(struct radix_tree_node *node)
 {
-	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
+	call_rcu_lazy(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
 /*
diff --git a/lib/xarray.c b/lib/xarray.c
index ea9ce1f0b386..230abc8045fe 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -257,7 +257,7 @@ static void xa_node_free(struct xa_node *node)
 {
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
 	node->array = XA_RCU_FREE;
-	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
+	call_rcu_lazy(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
 /*
-- 
2.37.2.789.g6183377224-goog

