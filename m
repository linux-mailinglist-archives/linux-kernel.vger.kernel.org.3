Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA94A5AA2C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiIAWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiIAWSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F395C9D3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x5so219442qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5xn60rDjdB3Rf7Wir8y+6b2hKXDgCuU2pqQZqimv/ck=;
        b=Os4hTQX+7UasiETS+y9NSvg4ja5hDOYYPQYGOfJ5sv7/j1Yu4A2w2gXnSlW0jOFCDp
         bLTIIkeTRy+1cbbBwSjwl3rHEw4Ocq3dzKdcSC+TunfEtEl+yuu5I44XNzQiXUAY3Ewk
         QEeYCOdMfWSgWfckJw059MAJSVHel1agDUyiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5xn60rDjdB3Rf7Wir8y+6b2hKXDgCuU2pqQZqimv/ck=;
        b=g+vn5cWP5fzsVmqzSQlqg3qIkJ6gOuLuBOGQtYWFBLSGluxbFyzAlJhW5F6jhoUH7R
         TvXTu66rvuH6yjMv8Lc21OIA2i5vxOK+DLIepD8/fkltm2LGzqncIWkSRD++iKtDmS6g
         szxT4UMXt42oF5PjmLA7ZLa2c5s13zWNuIizzMv0nPCVNhAWyz8NE+L7xDcqdqPO4YEa
         AJUFyWQ0rm84CMTR8Qd6KhxLCGijpVdEbyxu+ATDJVeBAiX1ALCxdXVRhvUjCbaqJW75
         X7dWS3xxpDl7OfSBlJkUT9y8CfSYht5+jNak0/MnQfxrrzCD6dv+orseA1V1TYWyvc4W
         RQOw==
X-Gm-Message-State: ACgBeo1tGvsUoujeZ8vuu2CtjxhvEoX7q22PJ50yO1dzf9aHxRiYetc8
        4MVqdBjtPJBmlw4cg0S5vKHgTw==
X-Google-Smtp-Source: AA6agR4diTGOE7swnbaEjFmZk8h1Ql35CL92QOFXkcefETWvplUeM3qM08T8V0Y69YU08rm48PY+vQ==
X-Received: by 2002:ac8:4e45:0:b0:343:5faf:3af6 with SMTP id e5-20020ac84e45000000b003435faf3af6mr26987399qtw.340.1662070686395;
        Thu, 01 Sep 2022 15:18:06 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 13/18] security: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:15 +0000
Message-Id: <20220901221720.1105021-14-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 security/security.c    | 2 +-
 security/selinux/avc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index 14d30fec8a00..b51b4bdb567d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1053,7 +1053,7 @@ void security_inode_free(struct inode *inode)
 	 * The inode will be freed after the RCU grace period too.
 	 */
 	if (inode->i_security)
-		call_rcu((struct rcu_head *)inode->i_security,
+		call_rcu_lazy((struct rcu_head *)inode->i_security,
 				inode_free_by_rcu);
 }
 
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..381f046d820f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -442,7 +442,7 @@ static void avc_node_free(struct rcu_head *rhead)
 static void avc_node_delete(struct selinux_avc *avc, struct avc_node *node)
 {
 	hlist_del_rcu(&node->list);
-	call_rcu(&node->rhead, avc_node_free);
+	call_rcu_lazy(&node->rhead, avc_node_free);
 	atomic_dec(&avc->avc_cache.active_nodes);
 }
 
@@ -458,7 +458,7 @@ static void avc_node_replace(struct selinux_avc *avc,
 			     struct avc_node *new, struct avc_node *old)
 {
 	hlist_replace_rcu(&old->list, &new->list);
-	call_rcu(&old->rhead, avc_node_free);
+	call_rcu_lazy(&old->rhead, avc_node_free);
 	atomic_dec(&avc->avc_cache.active_nodes);
 }
 
-- 
2.37.2.789.g6183377224-goog

