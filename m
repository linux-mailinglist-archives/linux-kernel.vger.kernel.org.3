Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC959D02E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiHWEot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiHWEon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:44:43 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18BC52DED
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:44:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a19-20020aa780d3000000b0052bccd363f8so5488913pfn.22
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=oAES/CRzxT/8dcoOMmdV0cByj8R02dL73KkeFTknRA4=;
        b=h5S3F1umhD/slt6d+GYuUsnRCqXadhS7WTydLOxjb87Sl6XLjWzvH9PY/pv/15CgZZ
         YIF0pzztMXX3brkyVekY5fBjAr1Q/qaNtYRyW+Np6P9k1C31ZElLKDErvAhOgKNJwTNA
         BO3drL/CuFssDScJpvQr4kx2Fi1GHVVbyphYDLK8X9lO5TW+2Bbm9O5jGt0swPUbCNmC
         oEAkzS3EscyQyrPdluMhWRa8Vdqa0tYzflpauj5PJDBEqH1DctJhbNVqzr4VUppamI6X
         joazzWiCZL9xeLnJxFLkIQgNfiOdh9p+QV5+WzbZhW/X8JtlgMQH2P9O2OqqTNamXQM8
         lQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=oAES/CRzxT/8dcoOMmdV0cByj8R02dL73KkeFTknRA4=;
        b=wcOB19i8uB85eHf66XNJ3tbPv737DNsYn4Sed8ye0twnJZOVAuYjMwnZ1UmWQqio/U
         DuhluTLGZ0WvhNjvbihQirn4ZB+sJjAzNnsNra7ZHxvidQilQmRSfdPeO1x5452Y5JWS
         VnVLl+mCqqziyx1+q+xBDOn9Al4n2RxOyrdenjLFO7wZs0X2SIdRKRVPqwYc/aJxUJQb
         3acI5GDtk7dhhRv3JkWAkSTJ8BiV+zSrvcZzzeXbDD2aRbmWf0A4SBPadfyl9q5f3GWx
         ljjQEui79y0UthO7s+0hjJAbfSRtwbWAqe/uGZTdn2JTcycpKFUBk6bm5s66jXmhglRY
         eKxg==
X-Gm-Message-State: ACgBeo0/LJJHfzHptoac4an2g7fJhEqrRrr7bTBismUuXwpi+hdgsMAg
        xB8cqaeigvKolO93eA2uCvnESBhMoHDB
X-Google-Smtp-Source: AA6agR7kNeuE7NwOAsEre+MOLXlMtAyvEaMKjInRrNGhrnXofgV4brRKgcPFAjG5rVMLS+4j0s/9/suMIuLn
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:4a4b:b0:1fb:18e2:ffbc with SMTP id
 lb11-20020a17090b4a4b00b001fb18e2ffbcmr1565234pjb.96.1661229881508; Mon, 22
 Aug 2022 21:44:41 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:44:34 -0700
In-Reply-To: <20220823044434.3402413-1-jiangzp@google.com>
Message-Id: <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
Mime-Version: 1.0
References: <20220823044434.3402413-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v2 1/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

When disconnecting all devices, hci_conn_failed is used to cleanup
hci_conn object when the hci_conn object cannot be aborted.
The function hci_conn_failed requires the caller holds hdev->lock.

Fixes: 9b3628d79b46f ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v2:
- Update commit message

Changes in v1:
- Hold hdev->lock for hci_conn_failed

 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 74a0cd5d0b37f..e08c0503027d8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5034,9 +5034,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		/* Cleanup hci_conn object if it cannot be cancelled as it
 		 * likelly means the controller and host stack are out of sync.
 		 */
-		if (err)
+		if (err) {
+			hci_dev_lock(hdev);
 			hci_conn_failed(conn, err);
-
+			hci_dev_unlock(hdev);
+		}
 		return err;
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
-- 
2.37.1.595.g718a3a8f04-goog

