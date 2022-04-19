Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06B35060A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiDSAKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbiDSAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:10:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C822DE5;
        Mon, 18 Apr 2022 17:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E79612E6;
        Tue, 19 Apr 2022 00:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA73C385A9;
        Tue, 19 Apr 2022 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326869;
        bh=FfYldHDuDIR3YtfmA0EGplElFP2BYkBWmQJSnq5n8i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7/K4hgFyaLNLYXJcaPW87HxCBNa+RPhMTmNUBnty2NymEQ2+ZX0/Nk95LqTTvvDg
         R76mrQx+nV6GAb/AKPTQqcVQ2ApcGua8YD/pwk4xarm063SwKITqXfP40iGmRL20gz
         fp4uDizXXo3D9wNEMRV9mte1F7LDPA81PWSpuAfyki4H3Vw68u0fVvWQdatmvjruOf
         0no5cyqmCMocyomfuBz9Ch16u+5s4LrFu9fEnqOnKmrVpYufV/biIhgqdnrU9gAcTu
         a4071kx4CvaPBcNo8jmfY9RZlpcDOx7m5Lw/QbJzAjyQWCCyojguiVR4pvC3J9cgKR
         aVcpUtmEDa/UA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 264B75C0A0D; Mon, 18 Apr 2022 17:07:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, David Vernet <void@manifault.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/6] rcutorture: Avoid corner-case #DE with nsynctypes check
Date:   Mon, 18 Apr 2022 17:07:44 -0700
Message-Id: <20220419000746.3949667-4-paulmck@kernel.org>
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

From: David Vernet <void@manifault.com>

The rcutorture module is used to run torture tests that validate RCU.
rcutorture takes a variety of module parameters that configure the
functionality of the test. Amongst these parameters are the types of
synchronization mechanisms that the rcu_torture_writer and
rcu_torture_fakewriter tasks may use, and the torture_type of the run which
determines what read and sync operations are used by the various writer and
reader tasks that run throughout the test.

When the module is configured to only use sync types for which the
specified torture_type does not implement the necessary operations, we can
end up in a state where nsynctypes is 0. This is not an erroneous state,
but it currently crashes the kernel with a #DE due to nsynctypes being used
with a modulo operator in rcu_torture_fakewriter().

Here is an example of such a #DE:

$ insmod ./rcutorture.ko gp_cond=1 gp_cond_exp=0 gp_exp=0 gp_poll_exp=0
gp_normal=0 gp_poll=0 gp_poll_exp=0 verbose=9999 torture_type=trivial

...

[ 8536.525096] divide error: 0000 [#1] PREEMPT SMP PTI
[ 8536.525101] CPU: 30 PID: 392138 Comm: rcu_torture_fak Kdump: loaded Tainted: G S                5.17.0-rc1-00179-gc8c42c80febd #24
[ 8536.525105] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020
[ 8536.525106] RIP: 0010:rcu_torture_fakewriter+0xf1/0x2d0 [rcutorture]
[ 8536.525121] Code: 00 31 d2 8d 0c f5 00 00 00 00 48 63 c9 48 f7 f1 48 85 d2 0f 84 79 ff ff ff 48 89 e7 e8 78 78 01 00 48 63 0d 29 ca 00 00 31 d2 <48> f7 f1 8b 04 95 00 05 4e a0 83 f8 06 0f 84 ad 00 00 00 7f 1f 83
[ 8536.525124] RSP: 0018:ffffc9000777fef0 EFLAGS: 00010246
[ 8536.525127] RAX: 00000000223d006e RBX: cccccccccccccccd RCX: 0000000000000000
[ 8536.525130] RDX: 0000000000000000 RSI: ffffffff824315b9 RDI: ffffc9000777fef0
[ 8536.525132] RBP: ffffc9000487bb30 R08: 0000000000000002 R09: 000000000002a580
[ 8536.525134] R10: ffffffff82c5f920 R11: 0000000000000000 R12: ffff8881a2c35d00
[ 8536.525136] R13: ffff8881540c8d00 R14: ffffffffa04d39d0 R15: 0000000000000000
[ 8536.525137] FS:  0000000000000000(0000) GS:ffff88903ff80000(0000) knlGS:0000000000000000
[ 8536.525140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8536.525142] CR2: 00007f839f022000 CR3: 0000000002c0a006 CR4: 00000000007706e0
[ 8536.525144] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 8536.525145] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 8536.525147] PKRU: 55555554
[ 8536.525148] Call Trace:
[ 8536.525150]  <TASK>
[ 8536.525153]  kthread+0xe8/0x110
[ 8536.525161]  ? kthread_complete_and_exit+0x20/0x20
[ 8536.525167]  ret_from_fork+0x22/0x30
[ 8536.525174]  </TASK>

The solution is to gracefully handle the case of nsynctypes being 0 in
rcu_torture_fakewriter() by not performing any work. This is already being
done in rcu_torture_writer(), though there is a missing return on that path
which will be fixed in a subsequent patch.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f37b7a01dcd0..d5105fb6c980 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1322,6 +1322,17 @@ rcu_torture_fakewriter(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_fakewriter task started");
 	set_user_nice(current, MAX_NICE);
 
+	if (WARN_ONCE(nsynctypes == 0,
+		      "%s: No update-side primitives.\n", __func__)) {
+		/*
+		 * No updates primitives, so don't try updating.
+		 * The resulting test won't be testing much, hence the
+		 * above WARN_ONCE().
+		 */
+		torture_kthread_stopping("rcu_torture_fakewriter");
+		return 0;
+	}
+
 	do {
 		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
 		if (cur_ops->cb_barrier != NULL &&
-- 
2.31.1.189.g2e36527f23

