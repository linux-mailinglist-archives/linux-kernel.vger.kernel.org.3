Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1559A721
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351942AbiHSUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351625AbiHSUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8AFBE4CA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id y4so4203200qvp.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E7Xq/XCIcO6OqJQYLMUxDOI6zGFTDKoXgxMJiXC3P5I=;
        b=PnhSY8rM7rduW9739YQGmVnMq/JGCCmIPkz6MaFXLYg5jNAb1UrdPTDggg3S+dNGgJ
         2Y7P7W5dgjp2YYRCd8rcBCIO8TU/aSkgyDY1qZlMu1yk3Y+QY+oYAUm9E8JWOIN6jBd7
         9cLfbbI/yGRKAc3Y15XmddVSxaTj8LHTLbh0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E7Xq/XCIcO6OqJQYLMUxDOI6zGFTDKoXgxMJiXC3P5I=;
        b=rdalrlzheEVF66ukQfTC8a0gO4KbIzIdpDwwif00XW6c2ESZCPYhoE38WWqchwkZHk
         hOSXdSrEZY2k43Z9uLV2KuxsmuG1c2bGY3Yp0JMwdxaw+EFoGHoID1GNNGXr0nKk8W2P
         j414UtpiVuGiqF1TFDnirMl0t4Jf6GB8Me2dVos43RbJ1L+cHGrbB46rPVOsil7cWS7z
         9CetYGw7xNfywod57VM8XwkwuyOaiXUJ61aUZpHyz1NfDqv+Yh4DAzT9G3Rv8RrSfqQr
         7UHGkt1pQr+E9KkWPEpF3vuehnno6F197vfsP2Dswo0A7JR483pcb6D7DOL1eTf7e4Bs
         5hfg==
X-Gm-Message-State: ACgBeo2Ha2D6G7BQ0cI+UO6gcGxdmOn05FOSLWCrhbP6HqCR+U0Xrjy6
        tYGvMdjyuNHf3mXfea9hh1Sb5l8Zw3W+CQ==
X-Google-Smtp-Source: AA6agR5kzA0uvHG4tfTkS5Y71k+SYHXpzSvkUg40aguVGCWBXSgV6NPjLlhGB6DaqBmALd9Ti9wdHg==
X-Received: by 2002:a05:6214:2aa2:b0:477:47ad:c2bf with SMTP id js2-20020a0562142aa200b0047747adc2bfmr8105366qvb.125.1660942152066;
        Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 11/14] lib: Move call_rcu() to call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:54 +0000
Message-Id: <20220819204857.3066329-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
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
index b3afafe46fff..1526dc9e1d93 100644
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
2.37.2.609.g9ff673ca1a-goog

