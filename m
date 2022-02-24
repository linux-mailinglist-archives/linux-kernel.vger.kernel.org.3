Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A138B4C3948
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiBXW5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiBXW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:57:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20458831;
        Thu, 24 Feb 2022 14:56:58 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OL80RZ018478;
        Thu, 24 Feb 2022 22:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hLMUQDq0hZU27/WUqn+x3uojwC5HLelaS3pmkFmruhI=;
 b=VZdGmlWPt18YeT0z01npFX4CM7OrJo8BcshOeKt7bk8akb9UcRb/ecV0TAgEyhZtV5jb
 1wUbf4jjUiVCmAbvnEGkaCVL+K6j7bc5zqnF6cDu376Y5YIJ3yehzrk8sZPcFJyctpz/
 MMx0+xJfc2etZIrWcijYHkNcABNbDgzyaa6p/qnHs3PIGaThlg1TuFjoZiMrlI546EwM
 6ljlsIg1A0ejVWD5PLNBI5L24Zn515TptgI4OTc1JH5pCv2nG/Z5EMlP6NNW6f0FE/qa
 SG/maEs4jmnSBUus2SNShFbpNiWTKtQKBymOVb0ttEO3C8aJYTjTAnsRcx4X5G2rodtK 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edpjvq48p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 22:56:53 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21OMk7EL005856;
        Thu, 24 Feb 2022 22:56:52 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edpjvq48f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 22:56:52 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21OMqHhj006768;
        Thu, 24 Feb 2022 22:56:51 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3ear6bcc84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 22:56:51 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21OMuoud12517692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 22:56:50 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE23D7805E;
        Thu, 24 Feb 2022 22:56:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53BC87805C;
        Thu, 24 Feb 2022 22:56:50 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.20.50])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 24 Feb 2022 22:56:50 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 0/2] input: misc: Add IBM Operation Panel driver
Date:   Thu, 24 Feb 2022 16:56:33 -0600
Message-Id: <20220224225635.40538-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dIrw9o-CDiqPA5-TMBpr-Eo3BFp-hDOb
X-Proofpoint-GUID: 1W8dCxWg2opM4B2REmJnKuM6Ydk2YrWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_05,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

 .../bindings/input/ibm,op-panel.yaml          |  49 +++++
 MAINTAINERS                                   |   7 +
 drivers/input/misc/Kconfig                    |  18 ++
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/ibm-panel.c                | 198 ++++++++++++++++++
 5 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml
 create mode 100644 drivers/input/misc/ibm-panel.c

-- 
2.27.0

