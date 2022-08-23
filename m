Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185759CFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiHWERL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHWERF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:17:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A321481ED
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:17:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c21-20020a17090ae11500b001fab6a5be8aso5653896pjz.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=26b2SOokG7fUG+DR/RGU1Ptb+ITmg2OiN31lztTaJ0E=;
        b=RJz+cZRp9RlbTvMhLM9LReOUXebomYIs9CcF6h6IFOZaYCUOoTQBII8VN6eEAOf3P+
         7n5Wj/DxmfjjFgfddOSWzeofOMTJ1hGWW6f02lUK2kW24cyObFMT46SscoNum2XKXJnn
         i/omxNVgV3/XWCFXwez4bSclwyBUJ/VrOmtQtpwVJvA7Qr5A6CbcNtgOj8M/PYzKVN1M
         Gv5Y7G80j24Z+ny3YYK6dxHG5hB0eTDI+wIBcGAL+8baV/94g7NBu8uzUiYeJuhqIdtb
         pHXzv6olzUgzW189/hVvcq3Sa7dwjyqr/oQRWCZCS3qcuItQcCx9W4+6is7/qKsm7ZQE
         huDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=26b2SOokG7fUG+DR/RGU1Ptb+ITmg2OiN31lztTaJ0E=;
        b=51aMjq3rwM872CsKyayTjUTnzfWBMzXqdJ3iZiuFuM8MSmQTBdJbyzZz3Soed7KBBK
         IXI4IMl3TUWlxqR0GaUSlmFACmROmyvLNpoZIlLsuxXlo0yk19ZijQstxQV+alycMg0m
         N7OkS7+nvpRf1FM3ph6FrXumG63qo7pgAwFlabFcalAVqqNmwrGE8AZPjsCzg4fW2LaT
         wK0iB2f47j395MfoUE797nUyPKI1T6/Z5y1xrJ90uevlUXrysCkrXD9L2F5lc3uEBNVW
         +0A8a2YyRWEG5W8Ss47PXfDhRogEUoS1HO5/V9i/BJxfWEA+5B7Movtfou1Cg8YyYfrM
         qDSg==
X-Gm-Message-State: ACgBeo0EchQCBev8NbGOtWqsc1Qit94kCAHCWR+vLjkZZ02A/b5Lna8K
        Cwp8NxhwLiQTILeQijPNSC95LNikln4Q
X-Google-Smtp-Source: AA6agR6SuxOe1INxl6FNeYlVERbtxVeLmulxIqfR3pAMrZa4KeHxSeakcSVnNCSJYrIwMio31SHqTBeAixMd
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr119787pje.0.1661228224252; Mon, 22 Aug
 2022 21:17:04 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:16:56 -0700
In-Reply-To: <20220823041656.3398118-1-jiangzp@google.com>
Message-Id: <20220822211644.kernel.v1.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
Mime-Version: 1.0
References: <20220823041656.3398118-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v1 1/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When disconnecting all devices, hci_conn_failed is used to cleanup
hci_conn object when the hci_conn object cannot be aborted.
The function hci_conn_failed requires the caller holds hdev->lock.

Fixes: 9b3628d79b46f ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")

series-to: chromeos-bluetooth-upstreaming@chromium.org
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

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

