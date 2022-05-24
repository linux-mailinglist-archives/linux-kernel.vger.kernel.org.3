Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE8533257
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiEXUSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiEXUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708CA366AE;
        Tue, 24 May 2022 13:18:11 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OJMBJ7030507;
        Tue, 24 May 2022 20:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fkJyyW4S37VR+ksJy9XFe/8EdYH9uwIybbLJlT1gj+0=;
 b=Ec9urzQtjyMMkKcU/Ww1D9WGQTc6lKcvYR2Rz1zf78BwvxBIKD1iSQre26dJX13LNs4Q
 qa+FdhhhO07XFs0ln0oIO+htnV8MNpnGLdovhqltBNAWHb6YIrLNp9F2dsr9hMKTccm1
 tQu5sdUBDmzZH18Yb8f39/GHd9AKkBRK4sSPXeBfA/g4ElPAvePJ9PWV3vNYsQoPHMcs
 QACG/iDd8JDtSzfhEHRGkl9nA1FRtNAtScOVB34XiBl7OlVObVYijIJwmVHMne+bBwIE
 vyy6x2+kUzyRFV1ux5NAzEpm2IPy/sZRvgwmhQ1IllfhtHlgT3BTZlJVPpjWMgO1+1nP WA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g95f09106-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 20:17:35 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OKA67g005482;
        Tue, 24 May 2022 20:17:34 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 3g93uu90hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 20:17:34 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OKHXOT18678084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 20:17:33 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2FC6E052;
        Tue, 24 May 2022 20:17:33 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEAEE6E058;
        Tue, 24 May 2022 20:17:32 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.82.60])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 20:17:32 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 0/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Tue, 24 May 2022 15:17:27 -0500
Message-Id: <20220524201729.39503-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QT2B9JZRuVjo3h2oeHjhqa5ih0bVRfze
X-Proofpoint-ORIG-GUID: QT2B9JZRuVjo3h2oeHjhqa5ih0bVRfze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_10,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=700 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205240100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corruption of the MEAS_CFG register has been observed soon after
system boot. In order to recover this scenario, check MEAS_CFG if
measurement isn't ready, and if it's incorrect, reset the DPS310
and execute the startup procedure. Include a patch to move the
startup procedure into a function.

Changes since v2:
 - Add some comments
 - Fix the clunky control flow

Changes since v1:
 - Separate into two patches
 - Rename 'dps310_verify_meas_cfg' to 'dps310_check_reset_meas_cfg'

Eddie James (2):
  iio: pressure: dps310: Refactor startup procedure
  iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt

 drivers/iio/pressure/dps310.c | 280 +++++++++++++++++++++-------------
 1 file changed, 176 insertions(+), 104 deletions(-)

-- 
2.27.0

