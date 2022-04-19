Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563BA5060C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiDSAP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiDSAPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4AD62DE;
        Mon, 18 Apr 2022 17:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD9C96130F;
        Tue, 19 Apr 2022 00:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E7EC385B7;
        Tue, 19 Apr 2022 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327154;
        bh=ktl3d0UVrZ+mKyl/NcSpjBwlrHyMaeCpOwxysFPt6PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5YMTSKszHkU+WOs2SMIJk4/qrH06EoGWpI3QwuTCKPznJdasSqe9mebOKeEbjbvA
         ePruW3K8aCBF0A4C+cQRZT/XA0z6dm3KuJxVlTWXnKxqwmFcf3lROzUvWLy7nEUZb2
         k1CYsnhdoYoNPzMqf14STLkH04d/G1acDMEI8J064jpQUNiz3AZf+eTjLD8pp2kX0a
         cxPkmSeNkCdT2t/tOrfaBHOBXXrWXXyjIhG2jFsShi5xAprFiXgwHqom/2LeJVK1P7
         Y2nk3MtpGLR47H+okgZ2xEPHo6PWOkzuWFYrxckurgSA8MJe2AM9dLYaTjJ6RrexnY
         j+PREThy00N7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 493E65C0B86; Mon, 18 Apr 2022 17:12:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/12] rcutorture: Add CONFIG_PREEMPT_DYNAMIC=n to TASKS02 scenario
Date:   Mon, 18 Apr 2022 17:12:27 -0700
Message-Id: <20220419001233.3950188-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CONFIG_PREEMPT_DYNAMIC=y is the default, TASKS02 no longer
builds a pure non-preemptible kernel that uses Tiny RCU.  This commit
therefore fixes this new hole in rcutorture testing by adding
CONFIG_PREEMPT_DYNAMIC=n to the TASKS02 rcutorture scenario.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TASKS02 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
index d333b69bc831..2f9fcffff5ae 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS02
@@ -2,6 +2,7 @@ CONFIG_SMP=n
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TASKS_RCU=y
 CONFIG_FORCE_TASKS_RCU=y
 CONFIG_RCU_EXPERT=y
-- 
2.31.1.189.g2e36527f23

