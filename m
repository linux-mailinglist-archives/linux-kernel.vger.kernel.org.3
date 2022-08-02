Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE615882C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiHBTsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiHBTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:47:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D2152FCB;
        Tue,  2 Aug 2022 12:47:47 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272JFRUV008862;
        Tue, 2 Aug 2022 19:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=noWbrVaOPUO/w0UphzMRye+2Bomv7aG3YuUle6322CI=;
 b=Xc625qQdZcOoiwDa+sMwikqBeMzu6geW27LxsAQyFuktyjtsCxR727oiPuNET3Cr9tsm
 39vUhjJhGpPSzdpLRibacBvnyMzWsuGXLKvBqfeCkyNM+BvGIaQNq72O++9VA6u5gC7H
 tKWyEYgs1VsalFv/2iRxvQof0q7VW5tGW9VA3PYN8Pd9iWw+2bhSDlwVurNH3TBKmdR2
 ALVjpShqPaWgtwiN0snzZOXkjZN5CuppCPetnXetEaVZMvzUg/kOsNuXLEn/Lj6LmPmu
 2+rUbMPBDRIRXDD+iIL5gZ322qO75zvX51M/rPUAl7xKFnWVo4/EuaMtgCwJfzkffprB XQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hq9x30ruh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:47:10 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 272JLOQ1020286;
        Tue, 2 Aug 2022 19:47:10 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 3hmv99m074-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:47:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 272Jl9oj56230302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Aug 2022 19:47:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90A6E124055;
        Tue,  2 Aug 2022 19:47:09 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5657124052;
        Tue,  2 Aug 2022 19:47:08 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.144.23])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Aug 2022 19:47:08 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/3] occ: Restore default behavior of polling OCC during init
Date:   Tue,  2 Aug 2022 14:46:53 -0500
Message-Id: <20220802194656.240564-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: foUfB15FyPeo5IxQhrKPr7wYKmk9YzdO
X-Proofpoint-GUID: foUfB15FyPeo5IxQhrKPr7wYKmk9YzdO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=707 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to the OCC hwmon driver modified the default behavior to
no longer poll the OCC during initialization. This does change the
interface, meaning that old applications will not work with the more
recent driver. To resolve this issue, introduce a new dts property to
control the behavior of the driver during initialization, similar to the
FSI master property "no-scan-on-init". Without the new
"ibm,inactive-on-init" boolean present, the driver will now do the
previous behavior of polling the OCC.

Eddie James (3):
  dt-bindings: hwmon: Add IBM OCC bindings
  fsi: occ: Support probing the hwmon child device from dts node
  hwmon: (occ) Check for device property for setting OCC active during
    probe

 .../bindings/hwmon/ibm,occ-hmwon.yaml         | 40 ++++++++++++++++++
 drivers/fsi/fsi-occ.c                         | 41 +++++++++++++++----
 drivers/hwmon/occ/common.c                    | 11 ++++-
 drivers/hwmon/occ/p9_sbe.c                    |  9 ++++
 4 files changed, 93 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hmwon.yaml

-- 
2.31.1

