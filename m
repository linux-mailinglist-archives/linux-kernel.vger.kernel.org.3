Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBEF4E679E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352205AbiCXRTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350786AbiCXRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:19:46 -0400
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 10:18:14 PDT
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net [178.33.251.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F5DF2D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:18:12 -0700 (PDT)
Received: from player728.ha.ovh.net (unknown [10.111.172.229])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id C46432501C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:12:15 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 4F1F928AEF1BE;
        Thu, 24 Mar 2022 17:12:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R00476d4bff7-adb1-4465-b39a-27e7b6ccfe9d,
                    78FFD8E4238D9337B8F0C8EEA79873C5FE5514E5) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ipmi: use simple i2c probe function
Date:   Thu, 24 Mar 2022 18:11:59 +0100
Message-Id: <20220324171159.544565-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11992804335307884166
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c probe functions here don't use the id information provided in
their second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

This avoids scanning the identifier tables during probes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/char/ipmi/ipmb_dev_int.c | 5 ++---
 drivers/char/ipmi/ipmi_ipmb.c    | 5 ++---
 drivers/char/ipmi/ipmi_ssif.c    | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 49b8f22fdcf0..db40037eb347 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -299,8 +299,7 @@ static int ipmb_slave_cb(struct i2c_client *client,
 	return 0;
 }
 
-static int ipmb_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ipmb_probe(struct i2c_client *client)
 {
 	struct ipmb_dev *ipmb_dev;
 	int ret;
@@ -369,7 +368,7 @@ static struct i2c_driver ipmb_driver = {
 		.name = "ipmb-dev",
 		.acpi_match_table = ACPI_PTR(acpi_ipmb_id),
 	},
-	.probe = ipmb_probe,
+	.probe_new = ipmb_probe,
 	.remove = ipmb_remove,
 	.id_table = ipmb_id,
 };
diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
index ba0c2d2c6bbe..845387d17efb 100644
--- a/drivers/char/ipmi/ipmi_ipmb.c
+++ b/drivers/char/ipmi/ipmi_ipmb.c
@@ -436,8 +436,7 @@ static int ipmi_ipmb_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int ipmi_ipmb_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static int ipmi_ipmb_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct ipmi_ipmb_dev *iidev;
@@ -528,7 +527,7 @@ static struct i2c_driver ipmi_ipmb_driver = {
 		.name = DEVICE_NAME,
 		.of_match_table = of_ipmi_ipmb_match,
 	},
-	.probe		= ipmi_ipmb_probe,
+	.probe_new	= ipmi_ipmb_probe,
 	.remove		= ipmi_ipmb_remove,
 	.id_table	= ipmi_ipmb_id,
 };
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 48aab77abebf..9fa8755bbb6a 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1619,7 +1619,7 @@ static int ssif_check_and_remove(struct i2c_client *client,
 	return 0;
 }
 
-static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int ssif_probe(struct i2c_client *client)
 {
 	unsigned char     msg[3];
 	unsigned char     *resp;
@@ -2037,7 +2037,7 @@ static struct i2c_driver ssif_i2c_driver = {
 	.driver		= {
 		.name			= DEVICE_NAME
 	},
-	.probe		= ssif_probe,
+	.probe_new	= ssif_probe,
 	.remove		= ssif_remove,
 	.alert		= ssif_alert,
 	.id_table	= ssif_id,
-- 
2.27.0

