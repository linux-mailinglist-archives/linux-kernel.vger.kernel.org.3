Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA105AA2C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiIAWTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiIAWSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B1D647E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:10 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j17so205626qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uvMol3uyneGva4YyiwYlT7IjMY9wNfnMaY4BpajVnC0=;
        b=vB0TPhC+ETNKaorpvy0zXtEQMbIqrE0wkU/h5SP9iHJyWzeG/Kp/jpHxx6dt746Npa
         QOHvSTUY4nY6DTxMILIli4C/sMT/xiS5q23jK7GsK9NDcZWBJDyMJp2HL8fP0VFkqEZF
         VvTw7as9Jv9mHmLJUawLZKjNlgVaU2bZ1YoPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uvMol3uyneGva4YyiwYlT7IjMY9wNfnMaY4BpajVnC0=;
        b=iG2wZMNrnhD7EMdR7MZEro8OvjVkmNYmNaQOcaCOQUI8KLIXmoTdOunFjpzbmsbKpK
         3BoepUc5n91lG+IGn4lie3ccOteBtbna4LRIQWf/Qxm492+29aeUTxcthv8X7CX7LKL2
         pa5DkPNQV/XFjylqZUFyG3NZSqAoHi7Wbh3P9Nx2kFHdRKY70IiqDNWrJizwy4VVBf++
         lVy8ZdJwY2+NCXb1VjpLJhj/UyYl9riHkgZwaTxdijhzYo1Qu8nywoTVelTtV5+h/Otj
         H1eJYWkU6f8YgHGyCyStQiUUSmW8+XQ8/UFZbT8F1Z/d9HKXufOWGyZQKl7X5nziK2G6
         n+MA==
X-Gm-Message-State: ACgBeo08PKGRAlRBoPuTN2X5AmcrWjpSwzYvaHUFQX+v8075JSHcn+IW
        OuutqkdD8roeEEm3fNlMBYAIaA==
X-Google-Smtp-Source: AA6agR7IUlccHMDPHEeKk4mHGnWwUpV/eTK+kjnIV8R3LGYG/QjIQq6jZqPANDerA0E/GIkXT0vkdA==
X-Received: by 2002:ac8:58c8:0:b0:344:87c2:c495 with SMTP id u8-20020ac858c8000000b0034487c2c495mr25705752qta.631.1662070689867;
        Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 17/18] i915: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:19 +0000
Message-Id: <20220901221720.1105021-18-joel@joelfernandes.org>
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
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index ccec4055fde3..21d6f66fb394 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -343,7 +343,7 @@ static void __i915_gem_free_objects(struct drm_i915_private *i915,
 		__i915_gem_free_object(obj);
 
 		/* But keep the pointer alive for RCU-protected lookups */
-		call_rcu(&obj->rcu, __i915_gem_free_object_rcu);
+		call_rcu_lazy(&obj->rcu, __i915_gem_free_object_rcu);
 		cond_resched();
 	}
 }
-- 
2.37.2.789.g6183377224-goog

