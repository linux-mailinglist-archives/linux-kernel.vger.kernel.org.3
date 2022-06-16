Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40354E9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378132AbiFPTLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiFPTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:11:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3093A5DF;
        Thu, 16 Jun 2022 12:11:42 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GHvN52015313;
        Thu, 16 Jun 2022 19:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Gi4D21+TGtq8NM9IhuW3KnTyLPDV0Qd0GHT/kz34hrY=;
 b=kI1Fd0XS5NLrN1CuW6nXGnjcDceRRPBDil57+58wMPpANPS8yMDtVv8l/UPF+B7ksXDZ
 e6ZuBcHRlXNHlLOGMTVY6NW+SW9jlOoisuCNyj/eKk+WtbjbUYmvyJ+TzmXDU0XkhsKY
 qdmtVUbM6V0evzb1J/fgnxkYPolo/5IGDMy7p13IBU36VV7Q+I2FZ9YmNadYnb3picdQ
 Rf8Y6vIhxnZHbLR/vu/+u6Qtnm8HAV8wAodq5iWuY6cgX+uvTvQ7OYBLYPRGmaMzSdxZ
 bx2QrlJykBJ1wicgP25NoXuly/5PuJzb6sFt8Q8VJvIsGPUOobrTe/mbUG4hQ9nWoZzE +w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqhbdqh8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 19:11:35 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25GJ5ijE014083;
        Thu, 16 Jun 2022 19:11:35 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3gmjpamjug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 19:11:34 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25GJBXhA27984154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 19:11:33 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78B59136055;
        Thu, 16 Jun 2022 19:11:33 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C342136053;
        Thu, 16 Jun 2022 19:11:32 +0000 (GMT)
Received: from li-37e927cc-2b02-11b2-a85c-931637a79255.ibm.com.com (unknown [9.160.59.133])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jun 2022 19:11:31 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH] ibmvfc: multiqueue bug fixes
Date:   Thu, 16 Jun 2022 12:11:24 -0700
Message-Id: <20220616191126.1281259-1-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OuC6Z17xocPFoGl6bUNTJgnPPSSq_d0k
X-Proofpoint-GUID: OuC6Z17xocPFoGl6bUNTJgnPPSSq_d0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_16,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=480 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for a couple observed crashes of the ibmvfc driver when in MQ mode.

Tyrel Datwyler (2):
  ibmvfc: store vhost pointer during subcrq allocation
  ibmvfc: alloc/free queue resource only during probe/remove

 drivers/scsi/ibmvscsi/ibmvfc.c | 82 ++++++++++++++++++++++++++--------
 drivers/scsi/ibmvscsi/ibmvfc.h |  2 +-
 2 files changed, 65 insertions(+), 19 deletions(-)

-- 
2.35.3

