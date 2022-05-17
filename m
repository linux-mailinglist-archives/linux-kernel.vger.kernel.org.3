Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C271B529E73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiEQJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbiEQJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:46:38 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4D72D1D6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:45:49 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso1053066wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PbU163V9NpaquO6SCuL2TEI60d26RkRN2W+vaRvIf2Q=;
        b=M5AaXstrZzKNEqxjubE0h4I7oP3Lc1dBo2zOqZmvFVoUhzFHGdkruDmgg7usMdo2J4
         AAoUaZ5QzBw9c8N/l8xi7RCa1aBMuREC2x1dBIQ2nVB/cr4dOPRMDKEN2IF6700d4ZzP
         8+hMYI0g9N+R39QOj21DGGb6rW8Z4QrUJVWePh6bP2VXHnIbNsVDkOiNcsDS9GiuxeQD
         bytUmq12CSWcjpm/LPmZ/XzOXTzZyk6weuCk7s4GFHjv1xgrKZ7dYBWmlb1FCRbQY9jY
         3w/NSf8cC4DAQBuqCljdtnHQFSBY0qYx2A1nQWTJ00VdDXtPa4KyBfNA2VUvUnEH74az
         Fy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PbU163V9NpaquO6SCuL2TEI60d26RkRN2W+vaRvIf2Q=;
        b=7ZM4xY8pq0DA9NkkS3Xs11lUYbm+UE6xBfN13GJTku+aAUl9yVgYySD28yt1mpeUOs
         D3syILvzsvw7KmFFfYTk+nsjKL3GLPm8TMxppX+eqqhw9sEtiSIL3x3Y5ylsfv6R1NSk
         gD/4SK9K/eFG1XNV1no1LwUUK3VmxAmc7YBUu5tsUC+DQznDrYW2Iaqr/h3vSstEaH8z
         FYU08muxoAraSz77rRpUlD1McMQYQfarUUYfAxqfn5AfSF1mEvXJI0WU4qxSGWY8ahWU
         1/qe9YDmtKNZo5EoKURj1+gjxEym4wh3OJxEiIz7AF/H5TnsSyUCNRjKzYwYzt2ytciQ
         XKEQ==
X-Gm-Message-State: AOAM533e6I3gVnx4o/BgloI7NsZ1644V9z8/hf2glsJUJ69+mnG2kldb
        D7HZgb8/VoH2UnmrrZGlN3H4u31e9+s=
X-Google-Smtp-Source: ABdhPJyduSrbVAvYxKEvK1sdYPUr1HXYq+Qu5FwsYmEM8CISkPzjSnRc1an8drEgN9+zFIeKi/8dL5vLv7A=
X-Received: from rax.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2a98])
 (user=poprdi job=sendgmr) by 2002:a05:600c:1e17:b0:394:547c:e5a6 with SMTP id
 ay23-20020a05600c1e1700b00394547ce5a6mr20628734wmb.203.1652780747377; Tue, 17
 May 2022 02:45:47 -0700 (PDT)
Date:   Tue, 17 May 2022 09:45:32 +0000
Message-Id: <20220517094532.2729049-1-poprdi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] Bluetooth: Collect kcov coverage from hci_rx_work
From:   Tamas Koczka <poprdi@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     theflow@google.com, Tamas Koczka <poprdi@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate hci_rx_work() with kcov_remote_start() and kcov_remote_stop()
calls, so remote KCOV coverage is collected while processing the rx_q
queue which is the main incoming Bluetooth packet queue.

Coverage is associated with the thread which created the packet skb.

Signed-off-by: Tamas Koczka <poprdi@google.com>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 45c2dd2e1590..703722031b8d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -29,6 +29,7 @@
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
+#include <linux/kcov.h>
 #include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/wait.h>
@@ -3780,7 +3781,9 @@ static void hci_rx_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	while ((skb = skb_dequeue(&hdev->rx_q))) {
+	for (; (skb = skb_dequeue(&hdev->rx_q)); kcov_remote_stop()) {
+		kcov_remote_start_common(skb_get_kcov_handle(skb));
+
 		/* Send copy to monitor */
 		hci_send_to_monitor(hdev, skb);
 
-- 
2.36.0.550.gb090851708-goog

