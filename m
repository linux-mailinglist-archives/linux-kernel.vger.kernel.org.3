Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A555060AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiDSAKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiDSAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D55FB4;
        Mon, 18 Apr 2022 17:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C83FCB81141;
        Tue, 19 Apr 2022 00:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E492C385AF;
        Tue, 19 Apr 2022 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326869;
        bh=a+rWJevxec7dObhHrxLmxlRKyIcRrrEQ/UTfcqpgkMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paP0T0xfRLShG6PxGBY/wCMVWHBIgjBrfN++DLTFgiBVVoNJToVUQLZJYhtuX48Zg
         DfwAjfULfSZZxzVnvPZPNETkY0Fkp/dYhHJXO1jOPIyan0jiaGpXAJaTkqKKuDrwzD
         OhlVEUKbcoFVwVmL0mrs6rlRDxkt6j8Ak5NZ+hqps2Nsj+bEP1VHg8D6JoeiUNGlm0
         WF2YK+TD5UOgKj2YBuQkpVLvmbl5TyqtFg94oEsvzCkAMJP0vhdYnQJbh3ElQmG6eo
         K8uVA/Pm9J3yD9KJ+LAtxPZdtrkvxHvtTMtwq1cDYdPCu/wx6GdhSLwskCAcZ26T27
         gwZ4BCTZx9qmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 245FA5C0848; Mon, 18 Apr 2022 17:07:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/6] scftorture: Fix distribution of short handler delays
Date:   Mon, 18 Apr 2022 17:07:43 -0700
Message-Id: <20220419000746.3949667-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
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

The scftorture test module's scf_handler() function is supposed to provide
three different distributions of short delays (including "no delay") and
one distribution of long delays, if specified by the scftorture.longwait
module parameter.  However, the second of the two non-zero-wait short delays
is disabled due to the first such delay's "goto out" not being enclosed in
the "then" clause with the "udelay()".

This commit therefore adjusts the code to provide the intended set of
delays.

Fixes: e9d338a0b179 ("scftorture: Add smp_call_function() torture test")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index dcb0410950e4..5d113aa59e77 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -267,9 +267,10 @@ static void scf_handler(void *scfc_in)
 	}
 	this_cpu_inc(scf_invoked_count);
 	if (longwait <= 0) {
-		if (!(r & 0xffc0))
+		if (!(r & 0xffc0)) {
 			udelay(r & 0x3f);
-		goto out;
+			goto out;
+		}
 	}
 	if (r & 0xfff)
 		goto out;
-- 
2.31.1.189.g2e36527f23

