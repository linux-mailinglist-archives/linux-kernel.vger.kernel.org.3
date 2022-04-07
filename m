Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83C4F8731
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbiDGSmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiDGSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:42:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C16DEB3;
        Thu,  7 Apr 2022 11:40:28 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237IdFVG023828;
        Thu, 7 Apr 2022 18:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Fl2GO6wGc28nQZYONKzjL4fEx5OpdVBXnH9xBytf0oc=;
 b=Xf0jad1zfUolVMIrE1lmF28wJxnLOWII3wckW7BnIRXF56iDtyZV9dEmE5Ik6c/l+FrN
 9yhraT0O6ONmX0/DAZs3ETgwDrDZpunJnrso/5Dt6KXtiyEWw/I9pk1hnBvEcHKJkkLC
 PFxVi+RrArEpWMhPY4hoAYNbns2ApzoMIph2jlcdUzQ5icfwHu1J+UfVU5R2wjUDbczM
 aYKQ/r8Qe0ugbeuSJQw0fYED/8Ghi6kyDbUvUdM6FRKgCSj0LRpCzskHfkAErmneJcRf
 JPKaY1+0Jsb5Cb16D/dtQEkNDky0RXkW9YrUuS9WQosKjRZfriVxiqZyRCBSvbZLBckv sQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f9xkbjdra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 18:39:46 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237INFeK002168;
        Thu, 7 Apr 2022 18:39:45 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3f6e4aaepv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 18:39:45 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237IdiKY57082314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 18:39:44 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1CA4124052;
        Thu,  7 Apr 2022 18:39:44 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0180912405B;
        Thu,  7 Apr 2022 18:39:44 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.114.26])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Apr 2022 18:39:43 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pavel@ucw.cz,
        openbmc@lists.ozlabs.org, joel@jms.id.au, patrick@stwcx.xyz,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/2] leds: pca955x: Add HW blink support
Date:   Thu,  7 Apr 2022 13:39:39 -0500
Message-Id: <20220407183941.36555-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eANAoUZdpDgqsjUuRtf-3i-NZZM81AUi
X-Proofpoint-ORIG-GUID: eANAoUZdpDgqsjUuRtf-3i-NZZM81AUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_04,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=422 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for blinking using the PCA955x chip, falling
back to software blinking if another LED on the chip is already blinking
at a different rate, or if the requested rate isn't representable with
the PCA955x.

Changes since v1:
 - Rework the blink function to fallback to software blinking if the
   period is out of range of the chip's capabilities or if another LED
   on the chip is already blinking at a different rate.
 - Add the cleanup patch

Eddie James (2):
  leds: pca955x: Clean up and optimize
  leds: pca955x: Add HW blink support

 drivers/leds/leds-pca955x.c | 340 +++++++++++++++++++++++++-----------
 1 file changed, 236 insertions(+), 104 deletions(-)

-- 
2.27.0

