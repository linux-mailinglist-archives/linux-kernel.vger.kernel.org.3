Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021C94B72C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbiBOPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:11:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiBOPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:11:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E7F108572;
        Tue, 15 Feb 2022 07:11:16 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FF9kj2003390;
        Tue, 15 Feb 2022 15:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=inQ7ERtewt1fTYCyG4tNrmkbS9COvMX3pRhHsOkVZg4=;
 b=pRRGXAAa3p2hdFVPw6hyAUAJxHdKg4pN+iKSwGWS2yVfE+IzQxoxY8ofv2ZXL81Yqa9v
 vQLAh9vDX2um7qp2Qusnk1dWFJVoXRlTwXxy7Rg+bJjGUEgdFCiF8m/U3UuIwzpwhpA/
 ConaK2d73G0OOkzormIGuK58XS71FIJGsn8RRvPiUrET4X5grAKLB8jvIjb/P2agfhwH
 K7iOdEHOWRbtUizAiWppbxe4F7Qw5mQYIyRZSkLpOfi5GPe0LwuNSfuOctLVf1lf1LhY
 ZqrnBDxyXr/MRz9L0OswCEORzj7dcLuFobNdkk1+BmCsBHmILc8U+jUofkIVFeQYVgZg /g== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8atse3wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:11:00 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FF8G8U026375;
        Tue, 15 Feb 2022 15:10:58 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3e64hatv7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 15:10:58 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FFAv1S29884810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 15:10:57 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67A5412405C;
        Tue, 15 Feb 2022 15:10:57 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFF911240C4;
        Tue, 15 Feb 2022 15:10:55 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.156.4])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 15:10:55 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, eajames@linux.ibm.com
Subject: [PATCH 0/4] hwmon: (occ) Add various poll response data in sysfs
Date:   Tue, 15 Feb 2022 09:10:18 -0600
Message-Id: <20220215151022.7498-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d3h5qVoRoBTNrQBraY9ZpZl0JH9yF3FS
X-Proofpoint-GUID: d3h5qVoRoBTNrQBraY9ZpZl0JH9yF3FS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=512
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BMC control applications need to check various additional bits in the
extended status in the poll response, as well as the OCC mode and IPS
status bytes. Export all those through sysfs. In addition, add the "soft"
minimum power cap attribute through hwmon.

Eddie James (4):
  hwmon: (occ) Add sysfs entry for IPS (Idle Power Saver) status
  hwmon: (occ) Add sysfs entry for OCC mode
  hwmon: (occ) Add sysfs entries for additional extended status bits
  hwmon: (occ) Add soft minimum power cap attribute

 drivers/hwmon/occ/common.c | 19 +++++++++++++---
 drivers/hwmon/occ/common.h |  2 ++
 drivers/hwmon/occ/sysfs.c  | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.27.0

