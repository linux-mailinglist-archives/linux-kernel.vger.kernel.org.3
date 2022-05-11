Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB1523D20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbiEKTJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiEKTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697F6EB10;
        Wed, 11 May 2022 12:08:55 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BIftZV029492;
        Wed, 11 May 2022 19:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qlOWqXyfi0rR8T2Ty+QTIJ3Y8i5IUOUaQI1MNmkuf5Y=;
 b=OVTqrNx28vOMpJb0sSyFMSCbcFQ9jbIfWD8ZP4gYo+lPxI8UWtZY/DJqRAWLtUV45eD8
 fzBb0PyT1Cj4Bjq3XFDN7yZCu2QIWwHDhzpEubrHgJyCleZK4lGr0iKezhWu83QqX2NP
 2og3I1aajaNQHk1XRHkDTH+vGjxLTPtvqG8XixZlnWWRvg4t9+Nb9DtuqvSPayRHoHxe
 B7MNjCePSXoujGXpxDUqR8ted4/zYg4f8ZG6MYzMyXqcWDmmG1AVoI7hCnRKd1bbbTnG
 POhlWceP5hJO5HMXtD/UDHKDhKwl9Y4GvyYMjIambMoOmbcVD4diXnExTKz2OG2DXUUl Uw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0jn5rdu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:08:39 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BJ8Soj002140;
        Wed, 11 May 2022 19:08:38 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3fwgda5sg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:08:38 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BJ8bqI31654354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 19:08:37 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 249F66A04F;
        Wed, 11 May 2022 19:08:37 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B358D6A04D;
        Wed, 11 May 2022 19:08:36 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.61.211])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 19:08:36 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dbarksdale@uplogix.com,
        eajames@linux.ibm.com
Subject: [PATCH 2/2] iio: humidity: si7020: Check device property for skipping reset in probe
Date:   Wed, 11 May 2022 14:08:35 -0500
Message-Id: <20220511190835.51046-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220511190835.51046-1-eajames@linux.ibm.com>
References: <20220511190835.51046-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -_y8u645Od0zadYsOSuBHFg1MVzJMxeA
X-Proofpoint-ORIG-GUID: -_y8u645Od0zadYsOSuBHFg1MVzJMxeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110083
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

