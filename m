Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012F25AA2B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiIAWSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiIAWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AF8543C2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q8so157347qvr.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wacV+wNWevSZZedckm8hHMeO8v0HhmKZhpXkr12CWiU=;
        b=e7rfmVttSIAE2dX9U/UrdKI2/QNY3ZP3fKeyJGley56wIpwe2qS6saz3KZesypfmqe
         hM1riUNN/4tHj4mrt7IXt6dpL2LLv2du/nCXvZZI8MdoBiSD0/AnUB8528he0Bh8pZQV
         vrMkt1S957E51Pelj+JfGSpSAlfQVDY8utxxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wacV+wNWevSZZedckm8hHMeO8v0HhmKZhpXkr12CWiU=;
        b=QHryVwDuDQby4iBBA1Jg0/KHBxd/gRq++7UpJVZaN3xibzy0LJPBId0md/p//8kPbi
         ZMIR7ebkh1IsmshbVVawQetj/xvm45BJr/B927W/hYWyufWzohjpkmJ3eQp6b9Yn0JE4
         cmWlj0RL8NJEYDTaE8yIn2aGJjTqqZp4+L+H4CozKI2kRxIxZ5NjUXDfdSTZWzfKjkc9
         AYBZuW4LIhNyDg/aLf/x+A3N2vnOkW1iPnOZAL46t9S2nnbnz98q47POu58lB42bNeeC
         fM3IzB3AQnm8tz8T1X6XpVdI+NLPxIPRqx8bPeysw3C8paChf0I7spGBiHhDy1MMVg6E
         l+Zg==
X-Gm-Message-State: ACgBeo2olqCcaizUI+k8VYeDCnoVgPefncMtwRG+9IILON1pu9bVpMkv
        lRidM825PRA9jJ9yIy6LOp+vww==
X-Google-Smtp-Source: AA6agR7ebVdicXTu0lYFUslN4hqrp3yrx/UXs4hw278sz5joSWluao70f6a70ft5FQ57ZlDUz+4CoA==
X-Received: by 2002:a05:6214:27c1:b0:473:85c9:3eeb with SMTP id ge1-20020a05621427c100b0047385c93eebmr26877303qvb.53.1662070679524;
        Thu, 01 Sep 2022 15:17:59 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:17:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 03/18] rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
Date:   Thu,  1 Sep 2022 22:17:05 +0000
Message-Id: <20220901221720.1105021-4-joel@joelfernandes.org>
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

The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
may help avoid load/store tearing due to concurrent access, KCSAN
issues, and preserve sanity of people reading the mask in tracing.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ca21ac0f064..5ec97e3f7468 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2106,7 +2106,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	blkd = !!(rnp->qsmask & rdp->grpmask);
+	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
-- 
2.37.2.789.g6183377224-goog

