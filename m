Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D74D0B60
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiCGWs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiCGWs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:48:27 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9BE65C5;
        Mon,  7 Mar 2022 14:47:32 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id r127so2341776qke.13;
        Mon, 07 Mar 2022 14:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFLTHg2yYVsdS4i22ClDHYq1QkQXsi11dNBuiLatLKs=;
        b=tEq94OtCcvP51G2x7TJslIZ3Y/Tii+R4W+Bm090QcwKIxI+iJdh/RhEXpJ/VuPeiJZ
         2dVOEYU6Dxo60OIeHyMPZqSJVs59CJXhYgiX1T0M4zT0xV7kOOTciYRntMrcz0vF/iIJ
         D1K75QNIXZoWah4j6nXemAGu/uFHEKTfrPpN+ttyS4LxE/KnCWgrXYt4Z/BqL+IITCGF
         UawIRqGehfaHMtxH1MvDWML3pO52WoA/DVneIp9dIPZlJ1qzMHw6Z55SmAe1KqKy+Enb
         v7w4kE5xq+hdFvrwq6PpjBvpUYZdGCFgSzpnYjOTg3ISCuVkxuQGVasoi2APNFYBh3IX
         R4xQ==
X-Gm-Message-State: AOAM532yWfBli9e3VEwoQYr7fzmY/RVtpbRya6lb9VWqYlkHvLOVHdqt
        gPl2KKHyBG7srpQmovQD8/6kb1QxGcLLYw==
X-Google-Smtp-Source: ABdhPJwg594A12Dc+bKwCI0BvF81VI0sfQ7VCWC76vubWBsvlNUyhMqC349X6ueWQG/w8+rW+A7OGA==
X-Received: by 2002:a05:620a:4007:b0:67d:14e0:126e with SMTP id h7-20020a05620a400700b0067d14e0126emr902800qko.496.1646693251311;
        Mon, 07 Mar 2022 14:47:31 -0800 (PST)
Received: from localhost (fwdproxy-ash-020.fbsv.net. [2a03:2880:20ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id f83-20020a379c56000000b0067b2dd2c860sm1996528qke.54.2022.03.07.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:47:31 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        rostedt@goodmis.org, kernel-team@fb.com
Subject: [PATCH 1/2] rcutorture: Avoid corner-case #DE with nsynctypes check
Date:   Mon,  7 Mar 2022 14:46:55 -0800
Message-Id: <20220307224655.2626262-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/rcu/rcutorture.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 57faf4cb9cd2..7fdff1bfed79 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1371,6 +1371,17 @@ rcu_torture_fakewriter(void *arg)
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
2.30.2

