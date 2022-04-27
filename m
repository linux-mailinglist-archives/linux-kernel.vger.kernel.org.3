Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0468512215
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiD0THo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiD0THT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:07:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924EE3668B;
        Wed, 27 Apr 2022 11:55:06 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RHfsnP010702;
        Wed, 27 Apr 2022 18:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ofnRWMmuQU5mf1v6F7IRYq6pxl7W7gPF8MARld7FRW8=;
 b=osuuw5QPljuD3KXURSUSCVNKrqX97Ox9vWTjVSQQkb8SFZfUaUgP6prlRnf0VHxcYnN5
 EKl25nwVua4E6OfDr57Ex5PEMwkJpvCEJlExjasy6VRNt/6Fb0tB5tnMm9ChyAfV+uN3
 n4ykenfD8F+EmLkr8uX//HWoUYlrOo3XEaCgVximOe7ud2AQA6NZbI20NTawZ96PcyxD
 Ab86U6rRS8vAY5t/OGXYcX8nRY8JUC2stAJxEObh5UyjhXZWeiDviIoXwCoG/uTLwl44
 M/BKvlvoUjeHllJQacA81GOQ5Yrz7o8pSe3eJHWGC2WWsn/qU4gelpn/81bH+mVzSi92 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqaf1sb4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 18:55:00 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23RIEDnT009015;
        Wed, 27 Apr 2022 18:55:00 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqaf1sb4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 18:55:00 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23RIqPFX007460;
        Wed, 27 Apr 2022 18:54:59 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3fm93adhb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 18:54:59 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23RIswUL26083696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:54:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D04124055;
        Wed, 27 Apr 2022 18:54:58 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A51C124053;
        Wed, 27 Apr 2022 18:54:58 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.88.172])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Apr 2022 18:54:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, eajames@linux.ibm.com,
        dan.carpenter@oracle.com
Subject: [PATCH v5 0/4] leds: pca955x: Add HW blink support
Date:   Wed, 27 Apr 2022 13:54:53 -0500
Message-Id: <20220427185457.27839-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UFZAJ9IRVuIcUVz-nLlVwxqK5BOwMNux
X-Proofpoint-GUID: Pa8PYVxXVGhO1wCk-kDmLgHay3mV-4HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=752
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Also included are some minor clean up and optimization changes that make
the HW blinking a bit easier.

Changes since v4:
 - Set duty cycle to fifty percent for blinked LEDs in order to maintain
   the specified blink rate.

Changes since v3:
 - Initialize return value in the blink function
   Thanks Dan Carpenter and kernel test robot

Changes since v2:
 - Split the cleanup patch
 - Prettier dev_err calls
 - Include units for blink period and use defined unit translations
   rather than just a number.
 - Use positive conditionals.

Changes since v1:
 - Rework the blink function to fallback to software blinking if the
   period is out of range of the chip's capabilities or if another LED
   on the chip is already blinking at a different rate.
 - Add the cleanup patch

Eddie James (4):
  leds: pca955x: Refactor with helper functions and renaming
  leds: pca955x: Use pointers to driver data rather than I2C client
  leds: pca955x: Optimize probe led selection
  leds: pca955x: Add HW blink support

 drivers/leds/leds-pca955x.c | 348 ++++++++++++++++++++++++------------
 1 file changed, 237 insertions(+), 111 deletions(-)

-- 
2.27.0

