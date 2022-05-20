Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD21352F154
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352018AbiETRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351887AbiETRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:11:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A19018628E;
        Fri, 20 May 2022 10:11:43 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFIwOI017865;
        Fri, 20 May 2022 17:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Qik/WpMegT6kBHq4VWZ7dqYh2ejbPr+aUI4/3qdtL4U=;
 b=j4I5O7SAF9buTiVvETP66B01PNedpQsn3rsh7TTNttQT/mIfg+JcI+cceyaqO5hypETy
 IJlXRFet9veCPFYc95G9PmpBwvWgbIyQmmDr9nt2NGHQiAqCWFExX8ZLlpEjzSQH9Rlb
 ivufIA8XFtyKL/RsqJp/jVRHzOTpRumRP9CUo8fzSC2B0OMV2CiGQvkcXMiC6RoqlmlY
 JeQ3cEAhVQ+ztqOsuyWMvNljs4ro9b2UFverybM2/oy1QD6UX/scTjZwunTWPaPulKFD
 dIQFG+bUToV0nKWAbtmFnor7B1vZglwwaY2ssDNC1zaTnm0mA5YttIk1AudPgf9DR9xW zw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6b7edp89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 17:11:37 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KH2voL032383;
        Fri, 20 May 2022 17:11:36 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3g242ac9bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 17:11:36 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KHBZ8Y30671272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 17:11:35 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AB9A6E050;
        Fri, 20 May 2022 17:11:35 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36E0E6E04E;
        Fri, 20 May 2022 17:11:35 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.18.112])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 20 May 2022 17:11:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH] leds: Ensure hardware blinking turns off when requested
Date:   Fri, 20 May 2022 12:11:34 -0500
Message-Id: <20220520171134.31415-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jq4UOpWgwRN_LAuEtyCWCD_zLuD8DQ-w
X-Proofpoint-ORIG-GUID: jq4UOpWgwRN_LAuEtyCWCD_zLuD8DQ-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_05,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=611
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an LED is blinking through the hardware and the trigger is deactivated,
the driver will set the brightness to 0 to disable blinking. However, if
the LED driver doesn't support non-blocking operations, the request for
setting brightness to 0 will get queued. Then if a user requests a new
non-zero brightness before the request for 0 brightness is executed, the
LED blinking will not get disabled since the brightness will simply be
updated.
Fix this by flushing the workqueue before updating the requested
brightness.

Fixes: 4d71a4a12b13 ("leds: Add support for setting brightness in a synchronous way")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/leds/led-class.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 6a8ea94834fa..861a1cb5df5b 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -55,6 +55,8 @@ static ssize_t brightness_store(struct device *dev,
 
 	if (state == LED_OFF)
 		led_trigger_remove(led_cdev);
+	/* flush out any request to disable blinking */
+	flush_work(&led_cdev->set_brightness_work);
 	led_set_brightness(led_cdev, state);
 	flush_work(&led_cdev->set_brightness_work);
 
-- 
2.27.0

