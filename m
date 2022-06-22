Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C2556EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376662AbiFVWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359829AbiFVWvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8040918
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:49 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 89so27465367qvc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIRVjLUngtzvaOGGJhPX9zs36OvO+dWcUJ0YzPStXJo=;
        b=RP4Xw5PjLXl1/ttonHyWA6UJqEVlPBaI/VbWuKT2GdpriQ5RbqwHgHOBGOdfOTxTyq
         TDGa++K8gS/R+55d58vj0W+rk6ukDyJmrWWx/adgrlWS5p6iXgZaCXklmrAQ3/o06bKv
         sjXJp95JkuuCiMNbBqArpXD5cBjAQs44IfTfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIRVjLUngtzvaOGGJhPX9zs36OvO+dWcUJ0YzPStXJo=;
        b=XLf+XM5wlKNYBqlGrVhHAZ14E8PnykYXYtZdUgKYCivWTCbWTtr9X3OoTsmEMDZSXw
         6gT4eY5oGQGmMV3/Ii+Q0VQJ4WaQCIK1WkdwX5D7s4bAvyOQk//MAdSgIos/pDcaZzVr
         D3e/oJlMlnnUF87EBIbLFAkXybru1Vn2bTll+b6/PK7XCeKsvQpRTb3IZkb06CJrQERE
         MXvdzH6EPyTxWrwaolNQBvVlWENIGBy+FM4XVX652/e6UKlLDW2B/fPgMFebLUgcsApb
         Pusb7xyGcXDX+T5bgTnkL+nbl2ge9tV8KAkptb+Zoc4BoDmMVIfGY1b6mKVOwE0Xe+ip
         Hqog==
X-Gm-Message-State: AJIora+YxRDxLgVE0bmTcS0Az+dZehRjUiICWIIOBB6gw34oBhfo7l81
        qceFk1F0I1P+UqXxwq89kbZ/uA==
X-Google-Smtp-Source: AGRyM1vaA5Ao94/E0rX5gloX6owI1QnEQU1eoreWEcsbtCYin0ct2kXn34bL0xAor+gWulrg/0CnCA==
X-Received: by 2002:a05:6214:76b:b0:46e:2704:7c42 with SMTP id f11-20020a056214076b00b0046e27047c42mr30212669qvz.90.1655938308765;
        Wed, 22 Jun 2022 15:51:48 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return value
Date:   Wed, 22 Jun 2022 22:51:02 +0000
Message-Id: <20220622225102.2112026-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
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

As per the comments in include/linux/shrinker.h, .count_objects callback
should return the number of freeable items, but if there are no objects
to free, SHRINK_EMPTY should be returned. The only time 0 is returned
should be when we are unable to determine the number of objects, or the
cache should be skipped for another reason.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 711679d10cbb..935788e8d2d7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
-	return count;
+	return count == 0 ? SHRINK_EMPTY : count;
 }
 
 static unsigned long
-- 
2.37.0.rc0.104.g0611611a94-goog

