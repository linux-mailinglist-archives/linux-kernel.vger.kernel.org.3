Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4304E3C99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiCVKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiCVKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:42:31 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CAC8118E;
        Tue, 22 Mar 2022 03:41:04 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22M7Yd7G008885;
        Tue, 22 Mar 2022 06:40:57 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ew9165je5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 06:40:57 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 22MAeuq9036322
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Mar 2022 06:40:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Mar
 2022 06:40:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Mar 2022 06:40:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22MAelC9008328;
        Tue, 22 Mar 2022 06:40:50 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 0/6] iio: adc: ad_sigma_delta: Add sequencer support
Date:   Tue, 22 Mar 2022 12:50:23 +0200
Message-ID: <20220322105029.86389-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZcWShtxLslYC5WeAeL1DESe4-8tlT_Ey
X-Proofpoint-ORIG-GUID: ZcWShtxLslYC5WeAeL1DESe4-8tlT_Ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_03,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Some sigma-delta chips support sampling of multiple
channels in continuous mode.

When the operating with more than one channel enabled,
the channel sequencer cycles through the enabled channels
in sequential order, from first channel to the last one.
If a channel is disabled, it is skipped by the sequencer.

If more than one channel is used in continuous mode,
instruct the device to append the status to the SPI transfer
(1 extra byte) every time we receive a sample.
All sigma-delta chips possessing a sampling sequencer have
this ability. Inside the status register there will be
the number of the converted channel. In this way, even
if the CPU won't keep up with the sampling rate, it won't
send to userspace wrong channel samples.

1. Removed the 1 byte .shift from channel spec in AD7124,
it confuses userspace apps (no need to shift right).

2. Add update_scan_mode to AD7124, it is required in order
to enable/disable multiple channels at once

3. Add update_scan_mode to AD7192, it is required in order
to enable/disable multiple channels at once

4. Add sequencer support for sigma_delta library.

5. Add sigma_delta_info values and callbacks for sequencer
support in AD7124.

6. Add sigma_delta_info values and callbacks for sequencer
support in AD7192.

Alexandru Tachici (5):
  iio: adc: ad7124: Remove shift from scan_type
  iio: adc: ad7124: Add update_scan_mode
  iio: adc: ad7192: Add update_scan_mode
  iio: adc: ad7124: add sequencer support
  iio: adc: ad7192: add sequencer support

Lars-Peter Clausen (1):
  iio: adc: ad_sigma_delta: Add sequencer support

Changelog V2 -> V3:
  - ad_sd_buffer_postenable(), aligned (slot * storagebits) to 8 bytes
  - devm_krealloc instead of krealloc for samples_buf in ad_sd_buffer_postenable()
  - in ad_sigma_delta_append_status, check return value before setting .status_appended
  - iio: adc: ad_sigma_delta: Add sequencer support: added explanations on
  desynchronization checking and recovery
  - in ad7124_append_status() modify st->adc_control after write has taken place without errors
  - in ad7124_update_scan_mode() take cfg mutex only once instead of every time a
  set_channel happens
  - in ad7192_disable_all() modify st->conf after write taken place without errors
  - in ad7192_append_status() modify st->mode after write taken place without errors

 drivers/iio/adc/ad7124.c               |  86 ++++++++++++++-
 drivers/iio/adc/ad7192.c               |  64 ++++++++++-
 drivers/iio/adc/ad_sigma_delta.c       | 143 +++++++++++++++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |  38 +++++++
 4 files changed, 315 insertions(+), 16 deletions(-)

--
2.25.1
