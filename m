Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501A046FC29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhLJIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:00:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54456 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhLJIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:00:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E880CCE29D8;
        Fri, 10 Dec 2021 07:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE679C00446;
        Fri, 10 Dec 2021 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639123022;
        bh=fbV6jnRImt77kPNxzcy/mg18kVek5MEGJZ+W4KsRu9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tl0LYYMywy/PxftZX5ppzTy6dXCK1W1TI2sjpt2DU5fqNTFhizS/+sxNcd5sld3PN
         PYR8KUJzv8aoqodKHNuT/eHcZK8b2c9eZYmqjaOHdQ9OFQ7Kp9StoOXgpu2NSoztXM
         gDjvf4PFnCEVsUsqR+5Wui+zH80zh7ibGkQgp0882mVPm4vyA1mGuj8rqnXCulY9zq
         tMlTn8llli1xbW0gcsWV7LkiwKDqolpHSKRwrC0qF1tmCJkMxNRCNprVfj6elTnTlT
         NswyfxGG8duix6w+9W160l0f9Ye0FWQ4C5obSBLbr8ohaTtjvac23E8eD/4QqzIFke
         owRt0rQ8fzZIQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvam4-000BVZ-Rm; Fri, 10 Dec 2021 08:57:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Robert Schlabbach <robert_s@gmx.net>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v3 2/4] media: si2157: Add optional firmware download
Date:   Fri, 10 Dec 2021 08:56:57 +0100
Message-Id: <68cd904138504a94c5e592b50547e0a22cd33d4d.1639120421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639120421.git.mchehab+huawei@kernel.org>
References: <cover.1639120421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Schlabbach <robert_s@gmx.net>

The Si2157 (A30) is functional with the ROM firmware 3.0.5, but can also
be patched at runtime, e.g. to firmware 3.1.3. However, although a
firmware filename for its firmware patch exists, that has only been used
for the Si2177 (A30) so far (which indeed takes the binary identical
firmware patch).

Add support for downloading firmware patches into the Si2157 (A30), but
make it optional, so that initialization can succeed with and without a
firmware patch being available. Keep the use of request_firmware() for
this purpose rather than firmware_request_nowarn(), so that the warning
in the log makes users aware that it is possible to provide a firmware
for this tuner.

The firmware patch is probably also optional for other (if not all)
tuners supported by the driver, but since I do not have the others
available to test, they are kept mandatory for now to avoid regressions.

Signed-off-by: Robert Schlabbach <robert_s@gmx.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1639120421.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 481a5db7fb69..ed28672c060d 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -130,6 +130,7 @@ static int si2157_init(struct dvb_frontend *fe)
 	struct i2c_client *client = fe->tuner_priv;
 	struct si2157_dev *dev = i2c_get_clientdata(client);
 	unsigned int chip_id, xtal_trim;
+	unsigned int fw_required;
 	struct si2157_cmd cmd;
 	const char *fw_name;
 	int ret;
@@ -198,6 +199,10 @@ static int si2157_init(struct dvb_frontend *fe)
 	#define SI2146_A10 ('A' << 24 | 46 << 16 | '1' << 8 | '0' << 0)
 	#define SI2141_A10 ('A' << 24 | 41 << 16 | '1' << 8 | '0' << 0)
 
+	/* assume firmware is required, unless verified not to be */
+	/* only the SI2157_A30 has been verified not to yet */
+	fw_required = true;
+
 	switch (chip_id) {
 	case SI2158_A20:
 	case SI2148_A20:
@@ -206,10 +211,13 @@ static int si2157_init(struct dvb_frontend *fe)
 	case SI2141_A10:
 		fw_name = SI2141_A10_FIRMWARE;
 		break;
-	case SI2177_A30:
-		fw_name = SI2157_A30_FIRMWARE;
-		break;
 	case SI2157_A30:
+		fw_name = SI2157_A30_FIRMWARE;
+		fw_required = false;
+		break;
+	case SI2177_A30:
+		fw_name = SI2157_A30_FIRMWARE;
+		break;
 	case SI2147_A30:
 	case SI2146_A10:
 		fw_name = NULL;
@@ -230,6 +238,9 @@ static int si2157_init(struct dvb_frontend *fe)
 
 	ret = si2157_load_firmware(fe, fw_name);
 	if (ret) {
+		if (!fw_required)
+			goto skip_fw_download;
+
 		dev_err(&client->dev, "firmware file '%s' not found\n",
 			fw_name);
 		goto err;
-- 
2.33.1

