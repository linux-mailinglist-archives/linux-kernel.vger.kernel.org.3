Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B492A52525D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356396AbiELQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356282AbiELQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:20:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B6C266F25;
        Thu, 12 May 2022 09:20:36 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CGCHiM025500;
        Thu, 12 May 2022 16:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=44OAk8luAeHOIAbOpd8uA482tC0czWaKmVXOaJBVrcU=;
 b=e91aM6ZHfLTOKoe481DuUSJCRA7fVhRbgRQeIH+EIcQk3fto1uMufmwY0kZooyiuCP+V
 QIfbG9eA0JrMAvPLalACJfSZcH70r0uFI9tjKzO3ClIIh+/nK5chdx5XjosvtGYH4ssl
 1bIdjaqReW5guFw4tDOMjLTkYcn8znBZHgbssDXwQ37mpUHbLH0OasurIKYpcjCd2jhA
 0sN/OusImGZmYLLvyemrzGPIugh/y9jl4mr1/bjqgGNIEYB1GasqQ7dopbvjKAeHfCjz
 2HASbpglnj5SBjxQOA2xZnpFXH77LzuJjH59QpVz5R/HaTgRjlE1EkGWse2rI/Dh2qDK 6w== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g15augjka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:20:23 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CGHDxn008337;
        Thu, 12 May 2022 16:20:23 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3fwgd9vgwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 16:20:22 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CGKM9i27328858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:20:22 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25348112069;
        Thu, 12 May 2022 16:20:22 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 336F2112062;
        Thu, 12 May 2022 16:20:21 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.56.168])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 16:20:21 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, jic23@kernel.org, miltonm@us.ibm.com,
        eajames@linux.ibm.com
Subject: [PATCH v2 0/2] iio: humidity: si7020: Check device property for skipping reset in probe
Date:   Thu, 12 May 2022 11:20:18 -0500
Message-Id: <20220512162020.33450-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IKnhrhY2RpZMAQaOtNS6hsyY006g-cMG
X-Proofpoint-ORIG-GUID: IKnhrhY2RpZMAQaOtNS6hsyY006g-cMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_12,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Changes since v1:
 - Fix dt binding document

Eddie James (2):
  dt-bindings: iio: humidity: Add si7020 bindings
  iio: humidity: si7020: Check device property for skipping reset in probe

 .../bindings/iio/humidity/silabs,si7020.yaml  | 47 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 drivers/iio/humidity/si7020.c                 | 14 +++---
 3 files changed, 55 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml

-- 
2.27.0

