Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE375AF57B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIFULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIFULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:11:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97301C0E67;
        Tue,  6 Sep 2022 13:05:54 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JuvSA017509;
        Tue, 6 Sep 2022 20:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0hl2TCrGpmkN+t5opJ/VRV+GU+XGbjWuWsWc2hZOqqc=;
 b=NXXU67dauH6qJW5noUKT7c0TeKKO3gxG/xglJ5aBNQhJgoe3ECvKA73Jmnb+krRYy9xZ
 +jssB4j80N57ocNIQOKTmjobAro787jPKmb/qZq7XWREXXJi3fhUndVrUEuyprb6O+ok
 H7yCcAwVw4eFEKGQLuQnd4F69pzgWfZjw71YdTxjD5ItczHAJixisJsgoEXScqFueDad
 p8GygmDzjNBXKZijStiWsmgswgYLNkn+0aiaxssAE5AVMK4Ig/n9r26ie833uvJr14o1
 S4lz1M5lsDB495jjEPmJms0+Xq76MID3uu1pF3QMVtJx7X6tU0cVq/4FAOAplfY00Q+n ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecthg8j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:05:39 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286K5HP3025780;
        Tue, 6 Sep 2022 20:05:38 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecthg8hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:05:38 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286K5NKW010685;
        Tue, 6 Sep 2022 20:05:37 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3jbxj9ty10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:05:37 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286K5a7a40108686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 20:05:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BA756E052;
        Tue,  6 Sep 2022 20:05:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC1E66E04E;
        Tue,  6 Sep 2022 20:05:35 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.74.237])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 20:05:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au,
        andy.shevchenko@gmail.com, eajames@linux.ibm.com
Subject: [PATCH v6 0/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Tue,  6 Sep 2022 15:05:33 -0500
Message-Id: <20220906200535.1919398-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4uK95e48RDHFrgbcTj3oxGJNfarBe5sQ
X-Proofpoint-GUID: 6XZVNeM2AT_KwjysmgEKYiPkrOIvK9Ev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPS310 chip has been observed to get "stuck" such that pressure
and temperature measurements are never indicated as "ready" in the
MEAS_CFG register. The only solution is to reset the device and try
again. In order to avoid continual failures, use a boolean flag to
only try the reset after timeout once if errors persist. Include a
patch to move the startup procedure into a function.

Changes since v5:
 - Completely rework the second patch to reset and reinit in any
   timeout condition, if there haven't been previous timeouts that
   failed to recover the chip.

Changes since v4:
 - Just check for rc rather than rc < 0 in some cases
 - Split declaration and init of rc

Changes since v3:
 - Don't check regmap* return codes for < 0
 - Fix comment spelling

Changes since v2:
 - Add some comments
 - Fix the clunky control flow

Changes since v1:
 - Separate into two patches
 - Rename 'dps310_verify_meas_cfg' to 'dps310_check_reset_meas_cfg'

Eddie James (2):
  iio: pressure: dps310: Refactor startup procedure
  iio: pressure: dps310: Reset chip after timeout

 drivers/iio/pressure/dps310.c | 266 +++++++++++++++++++++-------------
 1 file changed, 167 insertions(+), 99 deletions(-)

-- 
2.31.1

