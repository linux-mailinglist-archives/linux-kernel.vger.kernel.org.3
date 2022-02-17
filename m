Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8664BA202
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiBQNwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:52:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiBQNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:52:21 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D21E1ADBA;
        Thu, 17 Feb 2022 05:52:04 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HDdnbY022572;
        Thu, 17 Feb 2022 08:52:01 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e9fu11tqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 08:52:01 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 21HDq0YI050788
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 08:52:00 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 17 Feb
 2022 08:51:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 17 Feb 2022 08:51:59 -0500
Received: from chegbeli-l02.ad.analog.com ([10.48.65.189])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21HDppjW000640;
        Thu, 17 Feb 2022 08:51:54 -0500
From:   chegbeli <ciprian.hegbeli@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     chegbeli <ciprian.hegbeli@analog.com>
Subject: [PATCH 0/3] Add ADE9078 Driver
Date:   Thu, 17 Feb 2022 15:51:37 +0200
Message-ID: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: A9w7Djpbz1Q6Wrf8jMO9WA59w6Mfkxn5
X-Proofpoint-GUID: A9w7Djpbz1Q6Wrf8jMO9WA59w6Mfkxn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_05,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 mlxlogscore=929
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170063
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADE9078 is a highly accurate, fully integrated energy metering
device. It allows the monitoring of three independent phases
simultaneously, by using seven high performances ADCs and a flexible
DSP core for a fixed fundamental signal frequency.

Datasheet:
www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf

NOTE:
Given the unique nature of this type of ADC a new sub-folder has been
created in the driver/iio/ section. This folder would serve as a
location for energy meters.

This series of patches provide an initial implementation of the
driver with access from the userspace to the:
 - For each active phase from the device tree:
 	- Current (read raw, read scale, set hwgain)
 	- Voltage (read raw, read scale, set hwgain)
 	- Current RMS (read raw, read scale, set offset)
 	- Voltage RMS (read raw, read scale, set offset)
	- Active Power (read raw, read scale, set hwgain, set offset)
	- Reactive Power (read raw, read scale, set offset)
	- Apparent Power (read raw, read scale)
	- Fundamental Active Power (read raw, read scale, set offset)
	- Apparent Power (read raw, read scale)
- Event control for zero-crossing events on Voltage and Current
- Buffer implementation for read out of the internal FIFO

chegbeli (3):
  iio: add meter subdirectory
  dt-bindings: iio: add ADE9078
  iio: meter: add ADE9078 driver

 .../bindings/iio/meter/adi,ade9078.yaml       |  153 ++
 MAINTAINERS                                   |    8 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/meter/Kconfig                     |   22 +
 drivers/iio/meter/Makefile                    |    7 +
 drivers/iio/meter/ade9078.c                   | 1666 +++++++++++++++++
 include/dt-bindings/iio/meter/adi,ade9078.h   |   21 +
 8 files changed, 1879 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
 create mode 100644 drivers/iio/meter/Kconfig
 create mode 100644 drivers/iio/meter/Makefile
 create mode 100644 drivers/iio/meter/ade9078.c
 create mode 100644 include/dt-bindings/iio/meter/adi,ade9078.h

--
2.34.1
