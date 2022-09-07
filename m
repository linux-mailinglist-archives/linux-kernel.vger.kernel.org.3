Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0DD5B016B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiIGKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIGKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:14:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18F24098
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:14:57 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877p1GG032346;
        Wed, 7 Sep 2022 05:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=IiVoG2fnJzlYy5zIJA+PVp/Rv31qKQR5pP87OgUZQuU=;
 b=SQi3tDQH1HHKmBemUnVJl6u++lrEr0kRo0xFv0DLLwLqBblQDn/Yf+qCinnDBKHZdWeF
 bAxHxKYdngd1ZCvCFJN1OBXrbZ31yKu16OVnXyh3jFI+GKrGKK73GJrJG1B4cBZ1nG7Z
 QjjwQtYICILOGkAoq5iJjUyu0bjfiXET/KZXaF+t6eEvHhUqxaXgzLuWcII3hNmw9sNe
 tFoBz0e6bcLDYYIVd91R1+9goh1xXz7mWYPyRGQa6q8soUS6WwMCoOyqNFiOnSe4UrBE
 q26t4PkAvQ0B2FF+fsS4I2XmClbYXtVQOYKkVcmGd/ogKl5lsdg5aQIF6O4/4F/Slodh KQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jc3bpw4sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 05:14:13 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 7 Sep
 2022 05:14:12 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 7 Sep 2022 05:14:12 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.149])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2C1FFB06;
        Wed,  7 Sep 2022 10:14:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <sanyog.r.kale@intel.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/7] soundwire: Fix driver removal
Date:   Wed, 7 Sep 2022 11:13:55 +0100
Message-ID: <20220907101402.4685-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zO4yBel3wvibvReJBzwxEzDL20GZCnK_
X-Proofpoint-ORIG-GUID: zO4yBel3wvibvReJBzwxEzDL20GZCnK_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of child drivers and the bus driver was broken and would
result in a slew of various errors.

Most of these were caused by the code shutting down in the wrong
order, shutting down the bus driver first. The bus driver should
be shut down after the child drivers have been removed (compare
with the I2C and SPI subsystem for example).

These patches fix that.

A secondary problem was over the cleanup of child drivers. The
removal functions were not the opposite of the probe function,
and the ownership of struct sdw_slave is tricky because it mixes
two separate usages and currently has to be "owned" by the bus
driver.

Tested with 4 peripherals on 1 bus and 8 peripherals on 2 buses.

Richard Fitzgerald (7):
  soundwire: bus: Do not forcibly disable child pm_runtime
  soundwire: intel_init: Separate shutdown and cleanup
  ASoC: SOF: Intel: Don't disable Soundwire interrupt before the bus has
    shut down
  soundwire: bus: Add remove callback to struct sdw_master_ops
  soundwire: intel: Don't disable interrupt until children are removed
  soundwire: intel: Don't disable pm_runtime until children are removed
  soundwire: bus: Fix premature removal of sdw_slave objects

 drivers/soundwire/bus.c             | 37 ++++++++++++++++++++++++-----
 drivers/soundwire/intel.c           | 13 ++++++++--
 drivers/soundwire/intel_init.c      | 25 +++++++++++++++----
 drivers/soundwire/slave.c           | 21 ++++++++++++----
 include/linux/soundwire/sdw.h       |  3 ++-
 include/linux/soundwire/sdw_intel.h |  2 ++
 sound/soc/sof/intel/hda.c           | 16 ++++++++++---
 7 files changed, 96 insertions(+), 21 deletions(-)

-- 
2.30.2

