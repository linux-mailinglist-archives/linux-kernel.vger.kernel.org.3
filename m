Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A21593122
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbiHOO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiHOO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:57:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C510B1C114;
        Mon, 15 Aug 2022 07:57:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FEsflu014721;
        Mon, 15 Aug 2022 14:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8ZTg0G+Wa4/8+mqlKuuc4tufXoqRTRsIKVo19S0zDC0=;
 b=P3+NnXyCWwQT1/K4lvaBzOtLYCFi+n+K7f0STa4RjjMc94GQgTHWaA8OCUdcFxvT18Gu
 o5cdIaYGwREx+OUQuHe/WLDrgcZfdBUsi2TyHT4suyta02Boq3XVuX4frYupeuYzPAOp
 f8xbTTNc8266SiqFpaVSeImTn9gJSqNhui9gfTvH4m71AedrhXzluH50Llvy1ehj+aIX
 unKDUI5jHYfFGqW7YMrdL1T7TNYxGnVKdZE8uPYGuVnYqct5gwgiHMlN4HRZOK5Dkezc
 2lYquK+gAipaYuwXV9YJ1B1PlI0KcA3sytLETHj16snFmhIniOtPRVvNVOfki0rr74vL 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyratr18c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:57:09 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27FEsc9T014618;
        Mon, 15 Aug 2022 14:57:09 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyratr180-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:57:09 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27FEoHIB018077;
        Mon, 15 Aug 2022 14:57:08 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3hx3k94jan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 14:57:08 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27FEv7o923593406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 14:57:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AD0113604F;
        Mon, 15 Aug 2022 14:57:07 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 683CA136051;
        Mon, 15 Aug 2022 14:57:06 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.146.160])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Aug 2022 14:57:06 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, eajames@linux.ibm.com,
        andy.shevchenko@gmail.com, joel@jms.id.au
Subject: [PATCH v5 0/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
Date:   Mon, 15 Aug 2022 09:57:03 -0500
Message-Id: <20220815145705.203017-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 63zzjKSfGn8_H0hPmYbanUxRUB8zKibq
X-Proofpoint-GUID: TLXgZYmcAp48EC3iOf81oHLjmYrDO9dm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150056
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
  iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt

 drivers/iio/pressure/dps310.c | 277 +++++++++++++++++++++-------------
 1 file changed, 173 insertions(+), 104 deletions(-)

-- 
2.31.1

