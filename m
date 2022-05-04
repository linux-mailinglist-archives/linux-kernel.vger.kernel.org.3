Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4330D51A50A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353120AbiEDQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiEDQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:16:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADADA289B5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:13:06 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446CVn2001835;
        Wed, 4 May 2022 11:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=CA8OB2CanPoJtK8+jq1whJdPE6KMUGj3tSd1euRzv2Q=;
 b=VACKymnWpd+seCKgTPyTvpO6eq3lkfSLCMhal19NtpUucLrbMeottc52dhi2diwkGM1T
 oYQkK9boW36Yvnn9H7ajkHZLjePqvYXMPNR8ZIP+P9gxCryW9FpGhL2nLXSugyq18zSX
 eZ2xxsdL7KKhMEn2saecVbH0OlMqPvbhw9mVcIEChqeKcJLf2ndmNjcLiYRZIVch+0aI
 Aya7O8GVgWMjp6pxbRrdbprp+E3MUGny65bxSP6CiWbRZIx4JV04tWmKdQnLnsBr/ohk
 Xkt9cf+qUH6Gc+ufT0gSiAhg1NQg0qXapR2Z38qqWZwhoCCIoVEyWM6sb8vY6yX0BBch 9w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fs2h2d6b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 May 2022 11:12:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 17:12:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 4 May 2022 17:12:46 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.73])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9A7D6B10;
        Wed,  4 May 2022 16:12:45 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/3]  Add Manual Mode Jack Detection for CS42L42 in HDA
Date:   Wed, 4 May 2022 17:12:33 +0100
Message-ID: <20220504161236.2490532-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NlKOMX4SqaNPXbsdBqJoaKx2gXEXZEJS
X-Proofpoint-GUID: NlKOMX4SqaNPXbsdBqJoaKx2gXEXZEJS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS42L42 supports automatic type detection, to determine headset type,
or headphones. However, automatic type detection does not always work
correctly. To improve detection accuracy, manual mode detection can be
run. This is already done in the ASoC version of the CS42L42 driver,
and this chain adds the same support into the HDA version.

In addition, to better align the ASoC and HDA drivers, the ASoC header
file has been moved into the general sound includes, which allows both
ASoC and HDA to have access to the header.
This improves the maintainability of the HDA driver, and makes it
easier to port fixes/features from CS42L42 ASoC to HDA.

Stefan Binding (3):
  ASoC: cs42l42: Move CS42L42 register descriptions to general include
  ALSA: hda/cs8409: Use general cs42l42 include in cs8409 hda driver
  ALSA: hda/cs8409: Support manual mode detection for CS42L42

 include/sound/cs42l42.h             | 810 +++++++++++++++++++++++++++
 sound/pci/hda/patch_cs8409-tables.c | 327 ++++++-----
 sound/pci/hda/patch_cs8409.c        | 275 ++++++---
 sound/pci/hda/patch_cs8409.h        |   9 +-
 sound/soc/codecs/cs42l42.h          | 826 +---------------------------
 5 files changed, 1167 insertions(+), 1080 deletions(-)
 create mode 100644 include/sound/cs42l42.h

-- 
2.25.1

