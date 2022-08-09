Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDFD58E142
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245370AbiHIUmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbiHIUmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:42:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB71EEE9;
        Tue,  9 Aug 2022 13:42:01 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JWNlh003455;
        Tue, 9 Aug 2022 20:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=B6mRnnWo1suxCrUqt9vYJL76ZNWbx4MAKXH9o83uMH4=;
 b=Zb6FDQguQWg7SEqnZIH1DE08XintRdYM9K5zm2wuGDCfFPvLKxS/MomlIAAYLGStQh+0
 6Zt5tbo5n2JP10q/gfFZw61rGXR2PkTjoLAhYeffMhaSluSepwNXideiuxuDQUW4oRzf
 wv46HeYGVgidDfvIdmyGD2IwA4KMgDrp5rGsagL/J1JMJQ7O0YNIT3o/5S6QBAevYLI0
 mfi9K2RwNlgdeBYkDYGse8cFoP435SwGLaDcyUwNoz6MdsK9RliylKt5WG+rCDNq/vsj
 CE1SIcXPmXEi/29WDgmGTObM8jqUEx/sNToGCQSPKNMsEgB8rgRrsw7s07hjUF/a/7Ny Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwu11vmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:50 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 279KG6kn034724;
        Tue, 9 Aug 2022 20:41:50 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwu11vkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:50 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279KLHWw031604;
        Tue, 9 Aug 2022 20:41:49 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3huwvk8e1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:49 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279KfmGl3211808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:41:48 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D60128060;
        Tue,  9 Aug 2022 20:41:48 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8704A2805A;
        Tue,  9 Aug 2022 20:41:47 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 20:41:47 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au,
        wsa+renesas@sang-engineering.com, eajames@linux.ibm.com
Subject: [PATCH v5 0/2] input: misc: Add IBM Operation Panel driver
Date:   Tue,  9 Aug 2022 15:41:45 -0500
Message-Id: <20220809204147.238132-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: runN4XRMR4H1nubwfbxbn8vqXbPlzAgJ
X-Proofpoint-ORIG-GUID: R9ZzoPkD5prD5ZK_Yfz3HPqwssB-zDQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for input from the IBM Operation Panel, which is
a simple controller with three buttons and an LCD display meant for
interacting with a server. It's connected over I2C, typically to a service
processor. This series only supports the input from the panel, in which the
panel masters the I2C bus and sends data to the host system when someone
presses a button on the controller.

Changes since v4:
 - Fix missing input include in dt binding resulting in make check failure

Changes since v3:
 - Document linux,keycodes property
 - Use linux,keycodes property to map the buttons
 - Put the checksumming in a seperate function
 - Don't do unneccessary input_unregister calls
 - Minor cleanup and add debug data to dev_dbg calls

Changes since v2:
 - Add "additionalProperties: false" to dts doc
 - Refactor switch statement in the input driver; check command size and call
   the processing function within the STOP case
 - Use a different definition name for Aspeed interrupt status mask

Changes since v1:
 - Redo DTS documentation example to use I2C_OWN_SLAVE_ADDRESS
 - Reject commands received in the input driver that are too long
 - Add a definition for the interrupt status mask in the Aspeed I2C driver
 - Use I2C_OWN_SLAVE_ADDRESS for both dts additions

Eddie James (2):
  dt-bindings: input: Add documentation for IBM Operation Panel
  input: misc: Add IBM Operation Panel driver

 .../bindings/input/ibm,op-panel.yaml          |  50 +++++
 MAINTAINERS                                   |   7 +
 drivers/input/misc/Kconfig                    |  18 ++
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/ibm-panel.c                | 198 ++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml
 create mode 100644 drivers/input/misc/ibm-panel.c

-- 
2.31.1

