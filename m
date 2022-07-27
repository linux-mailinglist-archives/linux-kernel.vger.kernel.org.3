Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A058239A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiG0J76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiG0J7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:59:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B349429800;
        Wed, 27 Jul 2022 02:59:53 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4SNEc032560;
        Wed, 27 Jul 2022 04:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=BbGXTgpT1IEb5EFQjmHXxXYe4Upr+BQfUJUo9eyfsh8=;
 b=o338mblIeSTcC723yseD6IPQMjazyJ1WSvfOiffTitQLZn5KCGQQ7/98XYIYXr24u90F
 wFhkhxpiGflERQi8TkfcQiaY5+0Ao3B5nvmeWIfcYNfPHZ3JRroQ7g+eFep3HZqzDz9b
 tVU7YwMNa5+54EzjjXkYcdiAbBaiK2YXbKcK7Ov64NGN4gI4KDLT4tlZgp6QDPFgHakG
 OJ/EXItu7Si7rYTVTlhGpNPC7pH7R7GGUYDh5xQK+2zbHzho66yWXw07UrqYlrch0SgM
 IQG+YNG3Q1pdkhLPePABpIkJXAped6WyCqGAeWPpt4xsLvWejxGjYAK4lWHJx0KOTNEx 1A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hged1vtk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:59:30 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 04:59:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Wed, 27 Jul 2022 04:59:28 -0500
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B38012D4;
        Wed, 27 Jul 2022 09:59:27 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Cameron Berkenpas <cam@neo-zeon.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 0/4] Add support for CLSA0101
Date:   Wed, 27 Jul 2022 10:59:20 +0100
Message-ID: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NqQOa9stilE_d5Zo1AKuxDdkdZiXk_q0
X-Proofpoint-ORIG-GUID: NqQOa9stilE_d5Zo1AKuxDdkdZiXk_q0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for the CLSA0101 laptop, an Intel version of CLSA0100.
This patch has been tested using the CLSA0100, ensuring it
doesn't break the sound for it.
We appreciate it if someone with CLSA0101 could verify that this
the patch works for them.

Changes from V1:
 - Add CLSA0101 id into scan.c, serial-multi-instantiate.c
 and cs35l41_hda_i2c.c

Lucas Tanure (4):
  ALSA: hda: cs35l41: Use the CS35L41 HDA internal define
  ALSA: hda: cs35l41: Support CLSA0101
  ACPI: scan: Add CLSA0101 Laptop Support
  platform/x86: serial-multi-instantiate: Add CLSA0101 Laptop

 drivers/acpi/scan.c                           |  1 +
 .../platform/x86/serial-multi-instantiate.c   |  1 +
 sound/pci/hda/cs35l41_hda.c                   | 67 ++++++++++++-------
 sound/pci/hda/cs35l41_hda_i2c.c               |  3 +
 sound/pci/hda/patch_realtek.c                 | 12 ++++
 5 files changed, 58 insertions(+), 26 deletions(-)

-- 
2.37.1

