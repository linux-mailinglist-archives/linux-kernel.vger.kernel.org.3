Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D45220E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbiEJQVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347189AbiEJQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:21:17 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CBE28B85A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:17:19 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A5TVpe021012;
        Tue, 10 May 2022 11:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=zXofkY1bd3XtG154r7H2+Sqnxy0DHw+79gdGYM1CoL8=;
 b=BJ1IDdv+25911XUZUZVcM8S3KMrQHBK+C6OnpU+dlcsAONI5D2yfYapVUc+x8xKet5HF
 8Nm0AQ3/xE55kku8CxO1cAmqZ3xV0GRc0BA0lu0+4tD7Xzd2Urn4hKKV8sjS8Ywecznr
 VJCgu8a6E7hanZwOx3uI1DHovrB0YffW84JOaqUCK6gu7ArWc76+dvsnOcacYqTO0frc
 eE89DTQ/xQvuiNftyVXQjZn/1crXyC4nVCy9AW+JTmU315S7bNDFTRv/Ieo4ahK94yqp
 5KEuEadPVqiP9BupfFIrcuKp4IRbWGOhCcllvujec+deFYm+N6FDLVwCQU4ZZ1ouhqv+ zw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6nvk88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 May 2022 11:17:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 17:17:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 17:17:06 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.24])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2DA6E475;
        Tue, 10 May 2022 16:17:06 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/3] ALSA: hda/cs8409: Add support for Odin Laptop Variants
Date:   Tue, 10 May 2022 17:16:58 +0100
Message-ID: <20220510161701.851260-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GOqpgBxOq3tQq_4_EliPVL75yfgzbnSF
X-Proofpoint-GUID: GOqpgBxOq3tQq_4_EliPVL75yfgzbnSF
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

Stefan Binding (3):
  ALSA: hda/cs8409: Support new Odin Variants
  ALSA: hda/cs8409: Add Speaker Playback Switch for Cyborg
  ALSA: hda/cs8409: Add Speaker Playback Switch for Warlock

 sound/pci/hda/patch_cs8409-tables.c | 19 +++++++
 sound/pci/hda/patch_cs8409.c        | 85 ++++++++++++++++++++++++-----
 sound/pci/hda/patch_cs8409.h        |  5 ++
 3 files changed, 95 insertions(+), 14 deletions(-)

-- 
2.25.1

