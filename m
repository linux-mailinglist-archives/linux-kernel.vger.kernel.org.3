Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB55470E8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbiFKBUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFKBUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:20:12 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 18:20:09 PDT
Received: from mx0.chaotikum.eu (mx0.chaotikum.eu [IPv6:2a01:4f8:c2c:ce71::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF62FE5E;
        Fri, 10 Jun 2022 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=chaotikum.eu; s=20200128.mx0; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jof2nISM3ArkpDI9yHxnFylLSJTIlGSe7rzFagU23O8=; b=nGTDfRdNL2WxLsaHrlAoZiSglV
        SmE1ofdhqv0I6YHqNx5B9UsGmDTdCFdJ+POjXdXcacckbTiplJvHWZWRkW6n6ij8GeaBhchGxG08t
        S0nUNcs+clGL36gU/MnRAMsyL22bESMOa1SgotbpiVab2YWhVmMt8tKiATobnSIjkBg4tZGXfv7bY
        FMXnQwkHlfhJuhEYVRcvMRA9Vwb54BrizFPtI9g+Y/E9zTJqfeQt8Ol9lQ8I3uvkVpWcHU3t5jVXj
        m/mCyzWKg1+O2RjXHFnzTfJf9fREFynmKv4aeuT9E7RbILJ0W+ZO51rstMUdp+3/fE7+6qMv8L4s5
        nYvTKk0QJoB0VN9JC2F1vOhR7DZOWNCav4wmnneYnrtCQlP8TrgffFXJ6JuvEsDqlXN5DidE3I7wN
        VBugA7wZZvuPnbHV3abPbxmWU0jL1QuobpdZaBwME01bb4ru/7PF8XiRaVMBdJUJ7JedD9pS7Z6JO
        HR+HyeKzTkFYE0mDQN7YNhGPWx4QtO3moPzUkmMnBhbdPzaT9y45IhJEuD092+FfnhWfdgyNs0NFu
        NbWCQbyrIoLZdRRfwbMVggT6eqaVgS4mx9Vyy9r7n+0AW+2SaAGih8sPrny6XOec1etMoUOBlzJ55
        KKl418RSdHQkWPcdHg4V1MXV5dVjxprjjLSytKCDE=;
X-Spam-Action: add header
X-Spam-Bar: ++++++
X-Spam-Score: 6.7 (++++++)
Received: from [2001:4dd0:4f8e:0:7ddf:a8d0:8763:a125] (port=51080 helo=naboo.chaotikum.eu)
        by mx0.chaotikum.eu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <qsx@chaotikum.eu>)
        id 1nzpY2-0006bX-A2; Sat, 11 Jun 2022 03:04:48 +0200
From:   Thomas Schneider <qsx@chaotikum.eu>
To:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Schneider <qsx@chaotikum.eu>
Subject: [PATCH] HID: nintendo: Set phys property of input device based on HID phys
Date:   Sat, 11 Jun 2022 03:03:59 +0200
Message-Id: <20220611010359.115555-1-qsx@chaotikum.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the MAC address the uniq identifier is set to (cf. commit
1425247383c5 ("HID: nintendo: set controller uniq to MAC")) is certainly
unique, the physical location can be more helpful in user interfaces.  The
underlying hid_device already provides a suitable value, so we can simply
reuse this here.

Signed-off-by: Thomas Schneider <qsx@chaotikum.eu>
---
 drivers/hid/hid-nintendo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 2204de889739..df9cd5d883c0 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -1634,6 +1634,7 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	ctlr->input->id.version = hdev->version;
 	ctlr->input->uniq = ctlr->mac_addr_str;
 	ctlr->input->name = name;
+	ctlr->input->phys = hdev->phys;
 	input_set_drvdata(ctlr->input, ctlr);
 
 	/* set up sticks and buttons */
@@ -1713,6 +1714,7 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	ctlr->imu_input->id.version = hdev->version;
 	ctlr->imu_input->uniq = ctlr->mac_addr_str;
 	ctlr->imu_input->name = imu_name;
+	ctlr->imu_input->phys = hdev->phys;
 	input_set_drvdata(ctlr->imu_input, ctlr);
 
 	/* configure imu axes */
-- 
2.35.1

