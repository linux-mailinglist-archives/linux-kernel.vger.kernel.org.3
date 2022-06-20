Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1355272A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbiFTWwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbiFTWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420A21D0C7;
        Mon, 20 Jun 2022 15:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5EA5B8164A;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A46C341D0;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=BewmV1Of2+80WZJs41h1/PSorrSzk6m6v4xd9AT62Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqGfTKqYzFq22PjaGdv7SKkEE8e/Fd6NiHadEYaBnZaPiH2ANMpniwY9KatJUKUAL
         90IcTusLegeRZFBrIRiAuj63/iF816HE1xXdXfDne/piGyyglHQ6xl8ZLdbpYAyYhI
         6MDQwu78WIOl7px9meqER1D3TlIwJl/xLk+dRA5bdib2Xt/ERXV9UNIexRaYz0anmG
         G70fiUe3Z8YiqEqEhTZju+BKTS89YG9s2lrHYnZAYu+GZqUJUyXRH8NS0Q0Puj7y//
         wzcqoPOaoVrVIyDj6WRs6EjCLx1SQR6tRaMUk1mCgLVoxE3DBbndoHizHyJazPhlym
         RB6Dw0NmcCpgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F0EB5C0BCC; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 07/12] rcutorture: Verify that polled GP API sees synchronous grace periods
Date:   Mon, 20 Jun 2022 15:51:23 -0700
Message-Id: <20220620225128.3842050-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
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

This commit causes rcu_torture_writer() to use WARN_ON_ONCE() to check
that the cookie returned by the current RCU flavor's ->get_gp_state()
function (get_state_synchronize_rcu() for vanilla RCU) causes that
flavor's ->poll_gp_state function (poll_state_synchronize_rcu() for
vanilla RCU) to unconditionally return true.

Note that a pair calls to synchronous grace-period-wait functions are
used.  This is necessary to account for partially overlapping normal and
expedited grace periods aligning in just the wrong way with polled API
invocations, which can cause those polled API invocations to ignore one or
the other of those partially overlapping grace periods.  It is unlikely
that this sort of ignored grace period will be a problem in production,
but rcutorture can make it happen quite within a few tens of seconds.

This commit is in preparation for polled expedited grace periods.

[ paulmck: Apply feedback from Frederic Weisbecker. ]

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4ceec9f4169c7..d2edc763bb92a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1269,7 +1269,12 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_EXP_SYNC:
 				rcu_torture_writer_state = RTWS_EXP_SYNC;
+				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+					cookie = cur_ops->get_gp_state();
 				cur_ops->exp_sync();
+				cur_ops->exp_sync();
+				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+					WARN_ON_ONCE(!cur_ops->poll_gp_state(cookie));
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_COND_GET:
@@ -1291,7 +1296,12 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_SYNC:
 				rcu_torture_writer_state = RTWS_SYNC;
+				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+					cookie = cur_ops->get_gp_state();
 				cur_ops->sync();
+				cur_ops->sync();
+				if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+					WARN_ON_ONCE(!cur_ops->poll_gp_state(cookie));
 				rcu_torture_pipe_update(old_rp);
 				break;
 			default:
-- 
2.31.1.189.g2e36527f23

