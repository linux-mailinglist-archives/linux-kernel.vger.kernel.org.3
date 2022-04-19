Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46205060D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbiDSATF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiDSASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A6B140C2;
        Mon, 18 Apr 2022 17:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB1C6134F;
        Tue, 19 Apr 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825FAC385CA;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=9dPljee+XkU+dCj4G8HwoefiT/Vy/6UWKYfyp8TPR/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLa1QAQKxrZRB3HBBloOH1AFmDiXh/9s5oy1HP+svg/y3ShCrWyFaggU0qr9H1s6z
         EsC0GmFzTaX5UFOWbjB52ZMp8QfbOZisuDFXLHEG6QGVu6duM16g0RAYIG8aERef69
         nrn1t45CTRGJbvxYP5Fb8Vfq9C9OESnzabBFRirbmziC7FAnK6BjN/F1LM+MWODoz4
         fvoqTRCgXhiobvx3YGcvYYPQSnc8l0zjh+x09Z3Dm46bJ/kmxUSzpR0jbwkAFiCcg3
         rIjOxQOsc1QRoWwbfMjZzT/FruHMbqWWzWhbHd1wt76zNlhCGWZLzTGSEDRxA9jJ2z
         JQnGKe2O0bYow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D65F35C1355; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/12] rcutorture: Make torture.sh refscale and rcuscale specify Tasks Trace RCU
Date:   Mon, 18 Apr 2022 17:15:24 -0700
Message-Id: <20220419001525.3950505-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the Tasks RCU flavors are selected by their users rather than
by the rcutorture scenarios, torture.sh fails when attempting to run
NOPREEMPT scenarios for refscale and rcuscale.  This commit therefore
makes torture.sh specify CONFIG_TASKS_TRACE_RCU=y to avoid such failure.

Why not also CONFIG_TASKS_RCU?  Because tracing selects this one.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index c5b3dedc6dc4..f9c1437b9a19 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -364,7 +364,7 @@ fi
 for prim in $primlist
 do
 	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
 done
 
 if test "$do_rcuscale" = yes
@@ -376,7 +376,7 @@ fi
 for prim in $primlist
 do
 	torture_bootargs="rcuscale.scale_type="$prim" rcuscale.nwriters=$HALF_ALLOTED_CPUS rcuscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "rcuscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5 --kconfig "CONFIG_TASKS_TRACE_RCU=y CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
 done
 
 if test "$do_kvfree" = "yes"
-- 
2.31.1.189.g2e36527f23

