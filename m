Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08C44E6CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356257AbiCYDcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbiCYDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:32:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8156F9F3B5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:31:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b8so6416546pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGiTeRG4IQk7h6C89ytVphusb4+2ymibartIH2Voor0=;
        b=jSy5FHrMi1uSu+9XPjkA6dqRLZHrwSVVPGi/LShhirbbhIg051NvEtAfXFZQohs/64
         XIjdKJvuE5u2BblRvrXXkEA1gfUwsaYQvUresbFcxHuNWXxMLwDOT8Ssi7PwdukIYdB4
         28jFf7mVxW74xbdy+ZKfKxYR6FgRn35qxHdOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GGiTeRG4IQk7h6C89ytVphusb4+2ymibartIH2Voor0=;
        b=R1lBTxrQElDmblV7VSdGFhsKHzXl8OrkRK3gHnFJGjl4YUMHgoRBrgWQ46TdSKm6WI
         vgYGYgHZ2kN676WOuAeTyC1Dn3SGfHVWfo/NBm/W9pgTgaFVEVH+YLqoDdGvfHpzN1gI
         U49KODcdSBrG1NdIG5efF78W7vxSwXe66ir813l2m2o0dZbNKQ2qr6GT8cgZ7khAl33x
         +sAmnu9Peq8VuuHxhpgBOsOSfvfOsZfqulO1FwneITDaDc9J/7fLCB7GoJhVkxQ5U0xv
         qmgVW1aHdbPOIdQeAhcbJqusvBxxi62F4YQC5ipCqfh2jU1QeM1fl2kc5LHBDMBWBdbM
         bx1Q==
X-Gm-Message-State: AOAM530pYEdbVwG4RNKxA9eAj1voilDS7Mz0v1EvDDkJ0ZVJiNzCO4hJ
        FcWKHyBAlzSvoI7Ofwj0ACPIAA==
X-Google-Smtp-Source: ABdhPJyQm2KDpZRppICe4Wr5sAd4fXOScBA5SeJDI8r3lTjC/qlbZm17yG255aUtuU6tDztFm5IfAw==
X-Received: by 2002:a17:90b:1809:b0:1c7:28fb:bdd0 with SMTP id lw9-20020a17090b180900b001c728fbbdd0mr10228571pjb.231.1648179060040;
        Thu, 24 Mar 2022 20:31:00 -0700 (PDT)
Received: from localhost (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with UTF8SMTPSA id 21-20020a630115000000b00382a0895661sm3773921pgb.11.2022.03.24.20.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 20:30:59 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout
Date:   Fri, 25 Mar 2022 03:30:51 +0000
Message-Id: <20220325033028.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connecting the same socket twice consecutively in sco_sock_connect()
could lead to a race condition where two sco_conn objects are created
but only one is associated with the socket. If the socket is closed
before the SCO connection is established, the timer associated with the
dangling sco_conn object won't be canceled. As the sock object is being
freed, the use-after-free problem happens when the timer callback
function sco_sock_timeout() accesses the socket. Here's the call trace:

dump_stack+0x107/0x163
? refcount_inc+0x1c/
print_address_description.constprop.0+0x1c/0x47e
? refcount_inc+0x1c/0x7b
kasan_report+0x13a/0x173
? refcount_inc+0x1c/0x7b
check_memory_region+0x132/0x139
refcount_inc+0x1c/0x7b
sco_sock_timeout+0xb2/0x1ba
process_one_work+0x739/0xbd1
? cancel_delayed_work+0x13f/0x13f
? __raw_spin_lock_init+0xf0/0xf0
? to_kthread+0x59/0x85
worker_thread+0x593/0x70e
kthread+0x346/0x35a
? drain_workqueue+0x31a/0x31a
? kthread_bind+0x4b/0x4b
ret_from_fork+0x1f/0x30

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Reviewed-by: Joseph Hwang <josephsih@chromium.org>
---
Tested this commit using a C reproducer on qemu-x86_64 for 8 hours.

 net/bluetooth/sco.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..380c63194736 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -574,19 +574,24 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
-		return -EBADFD;
+	lock_sock(sk);
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		err = -EBADFD;
+		goto done;
+	}
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		return -EINVAL;
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
 
 	hdev = hci_get_route(&sa->sco_bdaddr, &sco_pi(sk)->src, BDADDR_BREDR);
-	if (!hdev)
-		return -EHOSTUNREACH;
+	if (!hdev) {
+		err = -EHOSTUNREACH;
+		goto done;
+	}
 	hci_dev_lock(hdev);
 
-	lock_sock(sk);
-
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 
-- 
2.35.1.1021.g381101b075-goog

