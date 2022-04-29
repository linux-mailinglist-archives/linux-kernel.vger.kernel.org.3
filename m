Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77575514069
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354108AbiD2CA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiD2CAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:00:25 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337E9BF524
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:57:07 -0700 (PDT)
X-QQ-mid: bizesmtp62t1651197407tc0g5311
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 29 Apr 2022 09:56:41 +0800 (CST)
X-QQ-SSF: 01400000000000E0M000000A0000000
X-QQ-FEAT: RUa2qNdlQy9gFLfsF33WW446EZUtx6dfowP/F7KcjhQyvOoiWiQcE9hUBCHLR
        UUYdI/rq8v4KImt3IGVHMav3cWM0Obywaj/NMo+3zg+4SwnZDaAiD9oCKAkGfK5Vz5UK9fC
        Naf6gMWSjsA+hNHccfugoAO2CN/RIJY9RShv0GGZ62CGXUlKqOG5RTHObLgKhDv6NLZb8uX
        lJTtnsvxR8hJpzuBKfIkej/cFQ7MuaKYO/lUQfNCGBUBHCjXA1r1UUh9Xp+wsVjPvWhQJMN
        lIY20AMiC0IymSGJRZzDMLa0OJOUev9IzNuyOTx75L/wDL3Nexc0ih7IgpkPGQJPGQpo1bD
        vnBD7xq3dAQuEmwuLcBvZpZd/0tLg==
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     krzysztof.kozlowski@linaro.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] NFC: Add error mapping for Directed Advertising DISCOVERY_TEAR_DOWN
Date:   Fri, 29 Apr 2022 09:56:40 +0800
Message-Id: <20220429015640.32537-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DISCOVERY_TEAR_DOWN occurs. Since the operation is analogous
to conventional connection creation map this to the usual ENOLINK
error.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 net/nfc/nci/lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/nci/lib.c b/net/nfc/nci/lib.c
index 473323f8067b..873854c5d180 100644
--- a/net/nfc/nci/lib.c
+++ b/net/nfc/nci/lib.c
@@ -57,6 +57,9 @@ int nci_to_errno(__u8 code)
 	case NCI_STATUS_NFCEE_INTERFACE_ACTIVATION_FAILED:
 		return -ECONNREFUSED;
 
+	case  NCI_STATUS_DISCOVERY_TEAR_DOWN:
+		return -ENOLINK;
+
 	case NCI_STATUS_RF_TRANSMISSION_ERROR:
 	case NCI_STATUS_NFCEE_TRANSMISSION_ERROR:
 		return -ECOMM;
-- 
2.20.1



