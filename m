Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5054DDE88
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiCRQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239143AbiCRQTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:19:05 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24481103D88;
        Fri, 18 Mar 2022 09:17:45 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22IDsqZ6013807;
        Fri, 18 Mar 2022 12:17:43 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3evfqqmx5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 12:17:42 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 22IGHf2L009326
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Mar 2022 12:17:41 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 18 Mar 2022 12:17:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 18 Mar 2022 12:17:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 18 Mar 2022 12:17:40 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 22IGHWUf024583;
        Fri, 18 Mar 2022 12:17:34 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v2 0/8] iio: adc: ad_sigma_delta: Add sequencer support
Date:   Fri, 18 Mar 2022 18:27:14 +0200
Message-ID: <20220318162722.51215-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: xJ5_kHd-DwpnC4vE7qQGx5J-AQXI6wCp
X-Proofpoint-ORIG-GUID: xJ5_kHd-DwpnC4vE7qQGx5J-AQXI6wCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_11,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 mlxlogscore=958 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180088
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

7. Add disable_all() callback in AD7124 driver. Need this to
disable channels in ad_sd_buffer_postdisable.

8. Add disable_all() callback in AD7192 driver. Need this to
disable channels in ad_sd_buffer_postdisable.

Alexandru Tachici (8):
  iio: adc: ad7124: Remove shift from scan_type
  iio: adc: ad7124: Add update_scan_mode
  iio: adc: ad7192: Add update_scan_mode
  iio: adc: ad_sigma_delta: Add sequencer support
  iio: adc: ad7124: add sequencer support
  iio: adc: ad7192: add sequencer support
  iio: adc: ad7124: add disable_all() callback
  iio: adc: ad7192: add disable_all() callback

Changelog V1 -> V2:
  - changed commits descriptions
  - in ad_sd_buffer_postenable: switched from kzalloc to krealloc and added
  space for the timestamp too.
  - added a fast path that avoids the extra copies created during sample number tracking
  for scans with (active_slots == 1) in ad_sd_trigger_handler
  - in ad7192_update_scan_mode(), use for_each_set_bit() instead of a simple for()
  - in ad_sd_init(), initialize num_slots to 1 if set on 0.
  - added disable_all() callback in ad_sigma_delta_info that should disable all channels
  It is always called in ad_sd_buffer_postdisable
  - in ad_sd_buffer_postenable(), use ad_sigma_delta_set_channel() only for devices
  with only one sequencer slot. For the ones with .num_slots > 1, update_scan_mode
  will already have enabled the required channels
  - add checks in ad_sd_init() for disable_all() and update_scan_mode() when
  num_slots > 1 (these are needed for normal operation of the sequencer)
  - in ad7124_update_scan_mode call set_channel on each channel

 drivers/iio/adc/ad7124.c               |  62 +++++++++++-
 drivers/iio/adc/ad7192.c               |  40 +++++++-
 drivers/iio/adc/ad_sigma_delta.c       | 134 +++++++++++++++++++++++--
 include/linux/iio/adc/ad_sigma_delta.h |  33 ++++++
 4 files changed, 254 insertions(+), 15 deletions(-)

--
2.25.1
