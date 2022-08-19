Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D75599C88
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349080AbiHSMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiHSMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:52:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA47C6CDE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:52:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J5QffN021184;
        Fri, 19 Aug 2022 07:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=DEfJ9i42eqkoVYAgl9Ca7Dg0mjK9CUm+t95OA12w4tg=;
 b=IVC4b3HIaQPYpyssKEzkaeGiahh07vid5V7vc6MFSxKJkx3xqLkV3U4gsR+RDySRJhZj
 czm6wQNgE25yGQj4ETx5C8PY1vdQZ8tPu1JcBbruzwL0KA+Rbs9Fp6r+krOP4+RhC8c+
 IGscNVt3v8pWB5iq7bjYbzLsHD88F4G3URZ9IiLqdWcdqAtNVYyQ9JBlB2jA+1DOftJD
 03g1lLDbPk8wUHf4D1gdy8zFIDM+Xi8+k64rSIlaR/DD/cZiRfXCzVbnURsesaRwcsUX
 dIM0HU2FgLyo9nUEaevhSgQnAR2D55cIUD+TvtClllEgkKRV78QESi8f8yIYzdNxpcCH Qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpfuvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 07:52:33 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 19 Aug
 2022 07:52:32 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Fri, 19 Aug 2022 07:52:32 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 19EFD7C;
        Fri, 19 Aug 2022 12:52:30 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 00/12] ASoC: cs42l42: Add Soundwire support
Date:   Fri, 19 Aug 2022 13:52:18 +0100
Message-ID: <20220819125230.42731-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iq25F7LQ021Oc1jlEJEc4xq159PP-sYN
X-Proofpoint-GUID: iq25F7LQ021Oc1jlEJEc4xq159PP-sYN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS42L42 has a Soundwire interface for control and audio. This
chain of patches adds support for this.

Patches #1 .. #10 split out various changes to the existing code that
are needed for adding Soundwire. These are mostly around clocking and
supporting the separate probe and enumeration stages in Soundwire.

Patches #11 and #12 actually add the Soundwire handling.

Richard Fitzgerald (12):
  ASoC: cs42l42: Add SOFT_RESET_REBOOT register
  ASoC: cs42l42: Add bitclock frequency argument to cs42l42_pll_config()
  ASoC: cs42l42: Ensure MCLKint is a multiple of the sample rate
  ASoC: cs42l42: Separate ASP config from PLL config
  ASoC: cs42l42: Use cs42l42->dev instead of &i2c_client->dev
  ASoC: cs42l42: Split probe() and remove() into stages
  ASoC: cs42l42: Split cs42l42_resume into two functions
  ASoC: cs42l42: Pass component and dai defs into common probe
  ASoC: cs42l42: Split I2C identity into separate module
  ASoC: cs42l42: Export some functions for Soundwire
  ASoC: cs42l42: Add Soundwire support
  ASoC: cs42l42: Add support for Soundwire interrupts

 include/sound/cs42l42.h        |   5 +
 sound/soc/codecs/Kconfig       |  14 +-
 sound/soc/codecs/Makefile      |   6 +-
 sound/soc/codecs/cs42l42-i2c.c | 107 +++++
 sound/soc/codecs/cs42l42-sdw.c | 689 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     | 359 +++++++++--------
 sound/soc/codecs/cs42l42.h     |  30 +-
 7 files changed, 1049 insertions(+), 161 deletions(-)
 create mode 100644 sound/soc/codecs/cs42l42-i2c.c
 create mode 100644 sound/soc/codecs/cs42l42-sdw.c

-- 
2.30.2

