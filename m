Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E05523D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346679AbiEKTJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbiEKTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A36D95E;
        Wed, 11 May 2022 12:08:55 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BIawYH001334;
        Wed, 11 May 2022 19:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WIc26leyN4kvgLscxzar5uuOaS6OAPL19Uat/7ImhAI=;
 b=ZoLHmde86kEtNAjAzKffUrApQUtzh6wKvTi1T1NnvPM7eh2YZKGif9wZEY2SXQi3U6s7
 N3VbvwOdKhUsG7MeEuZdWNYIHDQOTqGhalLF0uVB6lNYj7P0UzTiGAcVOl8h10e4fZnp
 Tyjdyfd6a0wLZwFu1wCCvZtrLfhupwW0N/CIQorOkLVSYjD3cb6n2aRAsaY/U0LGciGh
 6DfOtDnAGfnPdWE92oMfuThFS7xqw/XjfRXFZEkDG6guT3XEs7Cwy9uOhpvVR1JGUrBF
 kh9z8RaokMNZ1lpkbQxTImBb2l/v2XtRz3Ae7m9ZyWKRXupyLHtmFA92yC281Sqki6jx mw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0fn448fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:08:38 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BJ7FCZ015836;
        Wed, 11 May 2022 19:08:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 3fwgd9xaw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 19:08:37 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BJ8a5734734378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 19:08:36 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E21D6A047;
        Wed, 11 May 2022 19:08:36 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CA786A04D;
        Wed, 11 May 2022 19:08:35 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.61.211])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 19:08:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dbarksdale@uplogix.com,
        eajames@linux.ibm.com
Subject: [PATCH 0/2] iio: humidity: si7020: Check device property for skipping reset in probe
Date:   Wed, 11 May 2022 14:08:33 -0500
Message-Id: <20220511190835.51046-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QCZtPHjS4lDg-wrXH8OpS1eaECTOkuEl
X-Proofpoint-ORIG-GUID: QCZtPHjS4lDg-wrXH8OpS1eaECTOkuEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Eddie James (2):
  dt-bindings: iio: humidity: Add si7020 bindings
  iio: humidity: si7020: Check device property for skipping reset in probe

 .../bindings/iio/humidity/silabs,si7020.yaml  | 42 +++++++++++++++++++
 drivers/iio/humidity/si7020.c                 | 14 ++++---
 2 files changed, 50 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml

-- 
2.27.0

