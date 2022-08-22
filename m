Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD13B59BFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiHVMwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiHVMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:52:42 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB352E6B6;
        Mon, 22 Aug 2022 05:52:42 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MCUTKD010968;
        Mon, 22 Aug 2022 08:52:27 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j2whtdny2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 08:52:27 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27MCqQcX035248
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 08:52:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 22 Aug
 2022 08:52:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 22 Aug 2022 08:52:25 -0400
Received: from debian.ad.analog.com ([10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27MCqBGU003358;
        Mon, 22 Aug 2022 08:52:14 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH 0/3] Add support for LTC2499 ADC
Date:   Mon, 22 Aug 2022 15:51:03 +0300
Message-ID: <20220822125106.1106798-1-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Vwam74M_iK-WfNgt5XugHWn6rjfabxeD
X-Proofpoint-GUID: Vwam74M_iK-WfNgt5XugHWn6rjfabxeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=791 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTC2499 is a 16-channel (eight differential), 24-bit,
ADC with Easy Drive technology and a 2-wire, I2C interface.

This adds support for the LTC2499 ADC by extending the LTC2497
driver.

Note: This fix is required to be applied first:
https://patchwork.kernel.org/project/linux-iio/patch/20220815091647.1523532-1-dzagorui@cisco.com

Ciprian Regus (3):
  dt-bindings: iio: adc: Add docs for LTC2499
  drivers: iio: adc: LTC2499 support
  drivers: iio: adc: Rename the LTC249x iio device

 .../bindings/iio/adc/lltc,ltc2497.yaml        |  6 +++-
 MAINTAINERS                                   |  1 +
 drivers/iio/adc/ltc2496.c                     |  9 ++++-
 drivers/iio/adc/ltc2497-core.c                |  4 +--
 drivers/iio/adc/ltc2497.c                     | 36 ++++++++++++++++---
 drivers/iio/adc/ltc2497.h                     | 14 +++++++-
 6 files changed, 60 insertions(+), 10 deletions(-)

-- 
2.30.2

