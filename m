Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8D5AF670
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIFU5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiIFU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:57:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81FA00D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:56:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id az27so17249573wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yMM2FY3IJOc8ZIC+YBU+PmCr88InYvCeIt5RFR0M8Pk=;
        b=X+Trjh9rPGbs7UPhbuvHibypqjrCN55jfWvRbMk2FxxXv9XSvr/JCZRxehh4P2rxRd
         enCv/OBAErOTA7xi9ki3iIRmvPIOI8cz0o5C5rq1Z2JsqZD7UNTWLFmoFXoVr1GXKI+J
         AbnYCgmGnf7kyzoqWsUUclps9Y1474jh7R99y/LoGyAwkE2EJbdxwNAEk+y87+GkrTIF
         ihIua75zQcntpzpVXAXrObMGh9GMCdWd3PqKSCRBnvoexrt6knZbXMQpd4aJm4UoGg4E
         kIgGf9+y9hPYHOp83DsKRyoiDVxLtdckdjjt+4TqvyiE1Bq+/x4QL4GnrD41xJZjoV2S
         ZgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yMM2FY3IJOc8ZIC+YBU+PmCr88InYvCeIt5RFR0M8Pk=;
        b=xfr5PLIb6llSMC/9Qp/7+HdqHRgEvmCmbEVCl1Q2RoEpLus7g1UPrqoa9AQTk3S+79
         oQ9OWhepKe58yA/xHvpO8XiUN4N7v5wLP1QLlsKRVpq5KRcyQGGvpRYN+iAJhdQlS9bV
         5IYXB0hqWCRsGIK/XjkzIPWK2OC+lauVAB3lCy+G+wL67bpFFJiy5FaOeKMoEh/MBjMt
         gkKbn9DusIDKTxNPViaiq2g3bt5ExmCwOQQmPfRjulbwhivdzG2PNka6YFWu8xqtd4Yf
         BT/pAchAA1edBGtNXbF4DsNdLpOqB0bQsiqNR9jWiN/VpKwA+suOgw7qV7//Ym/EtKuW
         qGpw==
X-Gm-Message-State: ACgBeo1gpdhrmginhsfGq2zd4rZUOI1QZz02+aOZOYme4iP7PC3V7xQL
        9+ZXhG/ch1TMgfxRTBr2U5DR/A==
X-Google-Smtp-Source: AA6agR6i36nnqPOqjfG5LL42pPJrr20SYSi1MC6hX0LjqRAWLHRtnZIDE+SUfSn3GO/M8GzyX12qSg==
X-Received: by 2002:a5d:4534:0:b0:228:a411:1145 with SMTP id j20-20020a5d4534000000b00228a4111145mr165002wra.222.1662497815748;
        Tue, 06 Sep 2022 13:56:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n24-20020a1c7218000000b003a317ee3036sm15735887wmc.2.2022.09.06.13.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:56:52 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Thomas Haller <thaller@redhat.com>, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] mptcp: account memory allocation in mptcp_nl_cmd_add_addr() to user
Date:   Tue,  6 Sep 2022 22:55:43 +0200
Message-Id: <20220906205545.1623193-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220906205545.1623193-1-matthieu.baerts@tessares.net>
References: <20220906205545.1623193-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=hqQtNGfqEcSdigDLJiA3QmJUymEPTwMdYwGqPXFlNhA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjF7O5vhEtOWQ/pfczdwco8rjLVXWSgmW0J1lYVXuy
 Z/n7UFCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYxezuQAKCRD2t4JPQmmgcyagEA
 COkVtEkFDeK16sX1ShQiSuLqXI8eeLGbzuEd6GSJ2TQS2vOlYP9aw6gYwraBV+mCCzQx6TicRsWC6p
 bMjqzjwROu98J7e4ZG0/eWDeqTUVPE8FG2kNbMhOPIopWDr0mRG4kUP5ixQuDixOXSLXY9/0wVcAcQ
 Y6VJlG6f0dxRSitFjOCUN57qxiA4qC/o/y1D0JN7LDBIAbEty4Q0FKMzux+9kSI2bdF4O2LjCYt/XE
 oClVp6vFG5VdbSFZVrDamFsRdXOS66w8VYYchqogE6MRzEYUvAAy1gBA5dHJWaZKXq4aHtXY6dbZJ8
 eY32rg159zmUy3dPquMmnMRJckEXBpABx4QYeqEcj80b2Ihvq15nxxS8C+lyZ3AJI/O8ielu8wmR45
 X0kq/DXWmwPH8fq7TGVKvJVSh2LGHRxqWskmSOGsraHhR2CE5Sf/BKBTF0cfDIYgsB1waN2fw4aaDG
 Ue2Ea/UDJ3N2LoLG7jQ2dw44+vHuJGaW9RGtxVmjE09ECrF+3Wzq/0BoCx/YxDNw/n42/E6G2FrBtQ
 NtsRmjkKjir8JSZNnqiJ6VgX+X/P2QWhtMDkUcog49bmeexNm0kUXFqn/8L55EucUvgQXzNPCYIjIZ
 fuG5TolplUBupmQg6iH5BuSPRn+LnBOwvdcJIXbQqKDJp2uMw7Z2NtzTLG9A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Haller <thaller@redhat.com>

Now that non-root users can configure MPTCP endpoints, account
the memory allocation to the user.

Signed-off-by: Thomas Haller <thaller@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index afc98adf2746..9813ed0fde9b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1327,7 +1327,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "can't allocate addr");
 		return -ENOMEM;
-- 
2.37.2

