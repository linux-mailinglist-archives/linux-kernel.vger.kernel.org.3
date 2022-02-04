Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDDF4AA44C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378134AbiBDXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378125AbiBDXYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF346DFC1801;
        Fri,  4 Feb 2022 15:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0EE14CE24C4;
        Fri,  4 Feb 2022 23:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCB2C340F8;
        Fri,  4 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=h409ldMmqmMfyS/cakSSPSAQvvvTJuo4yTyqJxPa/So=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AU+5hKZHKnlUjDLvaWr9xDeQL6JY71dY3zhQ8bhk/aowznbMi1Ugjm8NRwQhq/zS3
         PIcgo/GtqXCMKN3xB8vj/JvVvtitUDiy3JaAhtnl7sOOvInzfy+L1Vy40Yx0ExfCFU
         OFvBlQmHa6Po+MRQbTkHjPT3h5CsvrFGdCnrU5XHSbY4mPDreQojVIEaqlOQgZnNR5
         R2p8vNg4/AXk9b/NJSpVsdP5PeTEOloB2P1COs07oYWhPN2nO2nSR2psoLZ3V4WtTo
         6AwizYYZbp/USZCedFoEVeeKWHuHhuMXWGA5z3jdAb4QRmdBKVi9MhFqiDqnS4gWm8
         cnK/jU+0mxgQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD3945C0A6A; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Alison Chaiken <achaiken@aurora.tech>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 08/10] rcu: Update documentation regarding kthread_prio cmdline parameter
Date:   Fri,  4 Feb 2022 15:24:04 -0800
Message-Id: <20220204232406.814-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Inform readers that the priority of RCU no-callback threads will also
be boosted.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9e..8e2e65122b993 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4504,6 +4504,8 @@
 			(the least-favored priority).  Otherwise, when
 			RCU_BOOST is not set, valid values are 0-99 and
 			the default is zero (non-realtime operation).
+			When RCU_NOCB_CPU is set, also adjust the
+			priority of NOCB callback kthreads.
 
 	rcutree.rcu_nocb_gp_stride= [KNL]
 			Set the number of NOCB callback kthreads in
-- 
2.31.1.189.g2e36527f23

