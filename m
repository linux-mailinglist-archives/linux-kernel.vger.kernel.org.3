Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D916C58E0AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbiHIUIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbiHIUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:07:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1E26135;
        Tue,  9 Aug 2022 13:07:34 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JZ7Zd028577;
        Tue, 9 Aug 2022 20:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XhTfRHtQQ3J+kqsTKqVAdu6zOe4KblffmYnJduqjQCM=;
 b=DiaM5qliT/LlUpa8O/fyt1hiSOlDXB+aUr3D/trM3Exu4xsLEtnXYtcT53Rk6X9gAJ4o
 InHr2tu1YJxYsc6svwGjLEX+ENbmWPgJyNHPN+328EgZGJMoqgMWgCLU39uqU4052WPh
 bjrusdD3TK8pficccCCrJ4PDHKO3CrNPeogtMgNSucwkpA4MRmDIai9iIPAr29FdFTbQ
 M2XcsHKz1tf4FwkV26t7JQ2eJvTu6Qwd/+4+xLPJlp8i34DlhwMXLTOXXsBFw1j1E9wd
 58+lX85NYEQK7ZpoIu4d+1f3JWjVk+zwQ4qV/UKusswF4nKsIysF8V9LyxEBrPcR49VU MA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwv30x9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:08 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279JoMUH021454;
        Tue, 9 Aug 2022 20:07:07 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3huww3r6je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:07:07 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279K76f010093198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:07:06 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8C99AC060;
        Tue,  9 Aug 2022 20:07:06 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D34B3AC05E;
        Tue,  9 Aug 2022 20:07:05 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 20:07:05 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/3] occ: Restore default behavior of polling OCC during init
Date:   Tue,  9 Aug 2022 15:06:58 -0500
Message-Id: <20220809200701.218059-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: suf1LuQiorXI5posfLdlpmKTcTmJ04A8
X-Proofpoint-ORIG-GUID: suf1LuQiorXI5posfLdlpmKTcTmJ04A8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=866 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
"ibm,no-poll-on-init" boolean present, the driver will now do the
previous behavior of polling the OCC.

Changes since v1:
 - Fix bindings and rename ibm,inactive-on-init to ibm,no-poll-on-init
 - Fix incorrect MODULE_DEVICE_TABLE argument

Eddie James (3):
  dt-bindings: hwmon: Add IBM OCC bindings
  fsi: occ: Support probing the hwmon child device from dts node
  hwmon: (occ) Check for device property for setting OCC active during
    probe

 .../bindings/hwmon/ibm,occ-hwmon.yaml         | 39 ++++++++++++++++++
 drivers/fsi/fsi-occ.c                         | 41 +++++++++++++++----
 drivers/hwmon/occ/common.c                    | 11 ++++-
 drivers/hwmon/occ/p9_sbe.c                    |  9 ++++
 4 files changed, 92 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml

-- 
2.31.1

