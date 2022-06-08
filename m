Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE5543040
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiFHM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbiFHM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:26:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B3B184845;
        Wed,  8 Jun 2022 05:26:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258AWS13010581;
        Wed, 8 Jun 2022 12:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=gGlz3Xh4fMvnsBn24mDsLniCAW1xIzKldQYRF4hoszE=;
 b=Wo6GeMF981XG1B6wF082NcFuruHywIngJ5vIr9xS1YP2b9LeI0vjL4DawEFadrDdWGOz
 XlTWUJ85HuCTfW4bdYi+Vq1Y4eYV8SDOXoqqO7MEZP9EKRnssp7DK1wnCvTJyS4GHKNW
 rzfCpzrMMyJwuei2T6gh1nlAd1+ugKoHc1xrxsqCOFMWAQJLX9heScaBTtlTQP2GwPaK
 eGxNpASHMwZ3fOYERfMsc2581ZlY/RZegUcU+Ukoa1bees8jjzhZ2AWt0JmqgS9cbgS9
 mQcj5U5WvPwM2ogES9OlrBp0Pn0hyVaBGJaZT1tFre1QdrYJ/o7CE6a5rtONUgLWX3xO ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs3bqrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 12:26:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258CAL4J029684;
        Wed, 8 Jun 2022 12:26:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu40reu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 12:26:47 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 258CQkwi029417;
        Wed, 8 Jun 2022 12:26:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu40ree-1;
        Wed, 08 Jun 2022 12:26:46 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com, eudean@arista.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] HID: cp2112: prevent a buffer overflow in cp2112_xfer()
Date:   Wed,  8 Jun 2022 05:26:09 -0700
Message-Id: <20220608122609.70861-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ir0h6eEqx-nPpZSZtiKT0-4OL6USv3By
X-Proofpoint-GUID: Ir0h6eEqx-nPpZSZtiKT0-4OL6USv3By
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warnings:
drivers/hid/hid-cp2112.c:793 cp2112_xfer() error: __memcpy()
'data->block[1]' too small (33 vs 255)
drivers/hid/hid-cp2112.c:793 cp2112_xfer() error: __memcpy() 'buf' too
small (64 vs 255)

The 'read_length' variable is provided by 'data->block[0]' which comes
from user and it(read_length) can take a value between 0-255. Add an
upper bound to 'read_length' variable to prevent a buffer overflow in
memcpy().

Fixes: 542134c0375b ("HID: cp2112: Fix I2C_BLOCK_DATA transactions")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/hid/hid-cp2112.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index ece147d1a278..1e16b0fa310d 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -790,6 +790,11 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		data->word = le16_to_cpup((__le16 *)buf);
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (read_length > I2C_SMBUS_BLOCK_MAX) {
+			ret = -EINVAL;
+			goto power_normal;
+		}
+
 		memcpy(data->block + 1, buf, read_length);
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-- 
2.31.1

