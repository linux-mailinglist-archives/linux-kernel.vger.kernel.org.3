Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C558DC95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245177AbiHIQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiHIQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:56:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD1637D;
        Tue,  9 Aug 2022 09:56:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j15so15003955wrr.2;
        Tue, 09 Aug 2022 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=trF1Dnl/B4bmI0Jk6roxYxlXVoEJE4owCmdIB31PL+E=;
        b=O2mS2dqkqbMKlXPy/EAZEuhFeIOCzGJo8weuij0/bAzS9ZFRzhDDZcnR7jwZuTQAq+
         mdpFDpLmj+2ttPS/4TBVQJQANNgkZnkaJt5aOjPZgYHdIpHu/wSylhB6FeCHezO2iL9o
         3y0nJBpYOvhIRu8gGVhXISfXVj5tJMa8bTTMokNm/lkj+GHaH5/+YCuZiifOl+J4Wroe
         +pWN/dD1G7H1tYDn0MzWXqNhPr+JmO2pGf7eoXjZnJI7C7cqp35tdK6CbI10BQ/+NMud
         iQbvnszrhe8T0p6piiWg9PVOYmafDS6btza5ejCAp/oy+MCyGRN7u9gMOzcy2dHtHEYU
         qo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=trF1Dnl/B4bmI0Jk6roxYxlXVoEJE4owCmdIB31PL+E=;
        b=qdWOFOgrK2RnXnWDk1u+9EtQzKoadbOmgklfwldAh7FIYLrvZUHiFZbIOfh08YIURJ
         LaMyn3G69LiuFoKBo09JwvKdyBRkVDMYETe7sPLseoXj/RXV+e5UnzXRhPtZM12J4yW3
         YosyanmvRQkeZSvDOATwwUk3b3px1kNl0ZfxRLnh8QFSMwpVU5Zgz9tfJBnKnmM7HE8C
         /d1WO4A+7zIorUX8sPbCedbcZVXCAmm7e5ecWzUJe0O2Cb8f0R/+D6A85R09bbHrtF7B
         m0Ij6EVJYKrZGsfjPI84VK8EIT2XenHDrSXUuHU9ARHOXDq0A9ptnVHIOpnr2bEo+/6j
         HwNg==
X-Gm-Message-State: ACgBeo2vmF0Z+HHt30cZa/GPauHK3EPvqElZ33HSDOTatC5o9bf17ix+
        V0Q9KYtQNxiLaB0MfWChID4O6b458YBPyA==
X-Google-Smtp-Source: AA6agR5Nz1sE/9VlQRDfDjrl3cMmnbOu/eagJ74tZByUddQH/G/DtvACPP2g2RkLT2uf5hDzoe1kTg==
X-Received: by 2002:adf:de0f:0:b0:21e:ead4:23f5 with SMTP id b15-20020adfde0f000000b0021eead423f5mr14622172wrm.641.1660064186432;
        Tue, 09 Aug 2022 09:56:26 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b003a2e1883a27sm26346290wms.18.2022.08.09.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:56:26 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH] fs/xfs: Use atomic64_try_cmpxchg in xlog_grant_{add,sub}_space
Date:   Tue,  9 Aug 2022 18:56:15 +0200
Message-Id: <20220809165615.9694-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use `!atomic64_try_cmpxchg(ptr, &old, new)` instead of
`atomic64_cmpxchg(ptr, old, new) != old` in xlog_grant_{add,sub}_space.
This has two benefits:

- The x86 cmpxchg instruction returns success in the ZF flag, so this
  change saves a compare after cmpxchg, as well as a related move
  instruction in the front of cmpxchg.

- atomic64_try_cmpxchg implicitly assigns the *ptr value to &old when
  cmpxchg fails, enabling further code simplifications.

This patch has no functional change.

Cc: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 fs/xfs/xfs_log.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 4b1c0a9c6368..92e39873d09e 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -148,7 +148,7 @@ xlog_grant_sub_space(
 	int			bytes)
 {
 	int64_t	head_val = atomic64_read(head);
-	int64_t new, old;
+	int64_t new;
 
 	do {
 		int	cycle, space;
@@ -161,10 +161,9 @@ xlog_grant_sub_space(
 			cycle--;
 		}
 
-		old = head_val;
 		new = xlog_assign_grant_head_val(cycle, space);
-		head_val = atomic64_cmpxchg(head, old, new);
-	} while (head_val != old);
+
+	} while (!atomic64_try_cmpxchg(head, &head_val, new));
 }
 
 static void
@@ -174,7 +173,7 @@ xlog_grant_add_space(
 	int			bytes)
 {
 	int64_t	head_val = atomic64_read(head);
-	int64_t new, old;
+	int64_t new;
 
 	do {
 		int		tmp;
@@ -190,10 +189,9 @@ xlog_grant_add_space(
 			cycle++;
 		}
 
-		old = head_val;
 		new = xlog_assign_grant_head_val(cycle, space);
-		head_val = atomic64_cmpxchg(head, old, new);
-	} while (head_val != old);
+
+	} while (!atomic64_try_cmpxchg(head, &head_val, new));
 }
 
 STATIC void
-- 
2.37.1

