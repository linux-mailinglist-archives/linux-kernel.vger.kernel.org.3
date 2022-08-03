Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB2589324
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiHCUZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiHCUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:24:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD589402DC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:24:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z7-20020a25ba47000000b00677405b2d2dso7081336ybj.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=e8+BGqQecoK41rQp8eMnlTuoC90aodRWA08z3InPywM=;
        b=NS2BEQEsOTnQcMqoV3YcJcS+hpOyHmOhc2HjEH1OQIR9pxGiv4vE3GLUv9zdTi6FRH
         ePHs3re4GUcTVR9Nk2Xj2/7M+7LDFgeIk8X2E3g0PG+3XrWmZwNuURapOKOivwB+Rj2F
         Uvp6FL9159m0qjmZg54yfShVwoARnBNYh8rWkltzB86bs29UVbCkhn1SnFDgTFfl4R6Z
         Qo5jbMluBrAA8zoFBbrf/bmNXTxdt5/unLqNbYl/G9UxvrPte548Glb0CuPgEvNM5TjQ
         8cVciqHa+aDxIea/kkXAm3Z/oDHdSkEycsfP/XCrYSddU4Vi0VAPPLTy0Nq0RDAShDEb
         jZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=e8+BGqQecoK41rQp8eMnlTuoC90aodRWA08z3InPywM=;
        b=Y3CYlRj9dK2WCEwzWneDKXwypxCu3v7fg9nrQbIgRmnrf6rYb0O2F8oJtrdsiU5MFU
         svcLfRBjH9NMeNtUfSWBIIwO4a/XfxV+ijQIQYTLQbB750RqFZTpcDR1GQAqxds+pnfp
         g63xKN5oi1cTNxGxUKQ3LzS2IHtdGnn/anUyj+iZS4Xy7YAQbeWKwiIHVSVAIipIiWGC
         WvrDLidg9d1yx3iZcq9vL2aJ3tVrh2dPapt7Evpmpwwq9NQhlRdhkE9lotDJulmW8h76
         bgrtcUaIUXsnclJm+r2N+Y/gUxfREAMSUOG1Wr7G8D93Y8TkqzjPg3e46sMuDjDpw1Ge
         kBeQ==
X-Gm-Message-State: ACgBeo3ROsU1zNZY2LlJjiGgyl/G0GfhoV7Sr7amWlXxQ0h+dGytcp2/
        uoy83unnEaULFSjFD00m8sZfibcmykFUAQ==
X-Google-Smtp-Source: AA6agR5oed7M2ZPhh2pVDRZ4G75naZJIM4bHGbCvOAyfYG+HLPdBKLHsBw1x0pYBJ6W5RKvPjSUJa2AQtU7EJQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:6eae:dfce:5d69:e05f])
 (user=mmandlik job=sendgmr) by 2002:a0d:d40d:0:b0:322:d4c0:c6f6 with SMTP id
 w13-20020a0dd40d000000b00322d4c0c6f6mr25825644ywd.428.1659558298100; Wed, 03
 Aug 2022 13:24:58 -0700 (PDT)
Date:   Wed,  3 Aug 2022 13:24:51 -0700
In-Reply-To: <20220803132319.1.I5acde3b5af78dbd2ea078d5eb4158d23b496ac87@changeid>
Message-Id: <20220803132319.2.I27d3502a0851c75c0c31fb7fea9b09644d54d81d@changeid>
Mime-Version: 1.0
References: <20220803132319.1.I5acde3b5af78dbd2ea078d5eb4158d23b496ac87@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 2/2] Bluetooth: hci_sync: Cancel AdvMonitor interleave scan
 when suspend
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cancel interleaved scanning for advertisement monitor when suspend.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

 net/bluetooth/hci_sync.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index cb0c219ebe1c..33d2221b2bc4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1721,6 +1721,9 @@ static bool is_interleave_scanning(struct hci_dev *hdev)
 
 static void cancel_interleave_scan(struct hci_dev *hdev)
 {
+	if (!is_interleave_scanning(hdev))
+		return;
+
 	bt_dev_dbg(hdev, "cancelling interleave scan");
 
 	cancel_delayed_work_sync(&hdev->interleave_scan);
@@ -5288,6 +5291,9 @@ int hci_suspend_sync(struct hci_dev *hdev)
 	/* Pause other advertisements */
 	hci_pause_advertising_sync(hdev);
 
+	/* Cancel interleaved scan */
+	cancel_interleave_scan(hdev);
+
 	/* Suspend monitor filters */
 	hci_suspend_monitor_sync(hdev);
 
-- 
2.37.1.455.g008518b4e5-goog

