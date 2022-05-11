Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFF6523033
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiEKKEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiEKKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:02:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A5DCD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:02:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B7elHA020340;
        Wed, 11 May 2022 05:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=00wJVCtHOpovRtoQGKNdyELkUs6JBl/FkJMVXuWpoBc=;
 b=q6ilppPUw6PdvJ9K5+yPPi8nWyBL1KJeHRntaDx+lUcuyHm3FdIuSSh+2FwxFJewJtoB
 kwi2ZrAZa7kuZT2GtOdm5m1pzttJDBV1/UdgjdHsTwtrL1x9uwCLnN5ZZr2TrUICdcTG
 ucJyxcaUmf6L4IUUf5A2gSSagdY4+XH19+08jTmGDPqdAFq3qcem+31hgKb+yZcbJVgn
 BQGNBDxpB8Xxn2JPYDK2kEnKz37LLlthZFQfO0zGRi3bY0EN6lSFFi53s7lBLYprS7pC
 +o1bJGf/DFsD4cVSRPh6gAfWc27tPPpg93nAp5S8sySh3tzO5JPS/cyS9dBkSIa+gTT+ Dg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nwt0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 May 2022 05:02:14 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 11:02:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 11 May 2022 11:02:12 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.24])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 742EA468;
        Wed, 11 May 2022 10:02:12 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/3] ALSA: hda/cs8409: Add support for Odin Laptop Variants
Date:   Wed, 11 May 2022 11:02:04 +0100
Message-ID: <20220511100207.1268321-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: O1pm8yeQOuMQqCSrohZLglniBXwZmXIx
X-Proofpoint-GUID: O1pm8yeQOuMQqCSrohZLglniBXwZmXIx
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new Odin Laptop Variants into CS8409 HDA Driver.

Since these laptops require Speaker Playback Switch, support must be added into
CS8409 HDA driver. Since CS8409 does not have amplifier parameters for the NID
associated with the speaker, the HDA driver does not add the switch
automatically, so the driver needs to add this support manually.

changes since v1:
- add missing break in switch statement

Stefan Binding (3):
  ALSA: hda/cs8409: Support new Odin Variants
  ALSA: hda/cs8409: Add Speaker Playback Switch for Cyborg
  ALSA: hda/cs8409: Add Speaker Playback Switch for Warlock

 sound/pci/hda/patch_cs8409-tables.c | 19 +++++++
 sound/pci/hda/patch_cs8409.c        | 86 ++++++++++++++++++++++++-----
 sound/pci/hda/patch_cs8409.h        |  5 ++
 3 files changed, 96 insertions(+), 14 deletions(-)

-- 
2.25.1

