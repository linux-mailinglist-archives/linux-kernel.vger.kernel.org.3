Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3424525260
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356421AbiELQUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356402AbiELQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:20:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47F4E3BC;
        Thu, 12 May 2022 09:20:39 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGGJ1T011323;
        Thu, 12 May 2022 16:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qlOWqXyfi0rR8T2Ty+QTIJ3Y8i5IUOUaQI1MNmkuf5Y=;
 b=ajCSLZXNoiOzc0MuSoezQqR5LBPSXbM8zcaqPKqq5uZcP2uqXhmRrCt6ZF2cg0XkZWJw
 jgiQYtIwSuD08vmUnUMcW0mwRCPHlyrKsXV3miH8PWvHyYx4XBt9FACXKs6kTp0QYHBr
 Wm6XrnTBVt6oB4tpmTQdoZMC+Q9lP0P9dpb63qS97zny50fwnkFyoDjsKE4caVRh2z5Q
 ZWvUhlJxZEdNgKzFLJP8lbR9NLZHDe9kVnNcSEi+d2H79gbMEEGxyr6WO/wTN9f1SqzJ
 Ba3zl3/GNjt5650uFoyH775l14tTbAx6nFMsO2Eb1IdxLUGR3c70Qu4UcVEntnDK+0Iu JA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g15m102qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:20:26 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CGHGoO008370;
        Thu, 12 May 2022 16:20:25 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3fwgd9vgwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:20:25 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CGKOiI7930398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:20:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ECFF112064;
        Thu, 12 May 2022 16:20:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59CB6112061;
        Thu, 12 May 2022 16:20:23 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.56.168])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 16:20:23 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, jic23@kernel.org, miltonm@us.ibm.com,
        eajames@linux.ibm.com
Subject: [PATCH v2 2/2] iio: humidity: si7020: Check device property for skipping reset in probe
Date:   Thu, 12 May 2022 11:20:20 -0500
Message-Id: <20220512162020.33450-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220512162020.33450-1-eajames@linux.ibm.com>
References: <20220512162020.33450-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sy1-cqgIabPnJkxxmFtJ1oADa_P0uQ2o
X-Proofpoint-ORIG-GUID: Sy1-cqgIabPnJkxxmFtJ1oADa_P0uQ2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_13,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C commands issued after the SI7020 is starting up or after reset
can potentially upset the startup sequence. Therefore, the host
needs to wait for the startup sequence to finish before issuing
further i2c commands. This is impractical in cases where the SI7020
is on a shared bus or behind a mux, which may switch channels at
any time (generating I2C traffic). Therefore, check for a device
property that indicates that the driver should skip resetting the
device when probing.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/iio/humidity/si7020.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index ab6537f136ba..49f6a1b1f5c4 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -115,12 +115,14 @@ static int si7020_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_READ_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	/* Reset device, loads default settings. */
-	ret = i2c_smbus_write_byte(client, SI7020CMD_RESET);
-	if (ret < 0)
-		return ret;
-	/* Wait the maximum power-up time after software reset. */
-	msleep(15);
+	if (!device_property_read_bool(&client->dev, "silabs,skip-reset")) {
+		/* Reset device, loads default settings. */
+		ret = i2c_smbus_write_byte(client, SI7020CMD_RESET);
+		if (ret < 0)
+			return ret;
+		/* Wait the maximum power-up time after software reset. */
+		msleep(15);
+	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
-- 
2.27.0

