Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1724DDD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiCRP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiCRP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:57:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7E391543
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:56:14 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I4MHlZ013781;
        Fri, 18 Mar 2022 10:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=cmzcuuOB7zcZNMmhHOonmDSCH0EjGkWS73owvHUazrw=;
 b=McrFMSDsaeM1Laj+Cu9VSh8UD81stVpVG87oylaOijvKYbcOX94lOui2oIpoxpJn7vbo
 RUPBzVaqaANnWsRtdNxw5kaAFHTkpN+F6yOWeIlmncQB9dUDzLuQJ1LENyNTdF1CXO/p
 fCW0iuKIdIxjMIzhhYgelqpvYelCAt4INr7r/1nLNd0TgvIX0FX9/vhYp/JJFTFKIvkk
 aS/EsI8a03MSvb4iKn5kPpytrwLVgB+EHQMxbUFsLHEYhu+8SzWSv7p5N39he7rf52Fe
 EION/dZ5pgrhryEWii1QF5aMjuHT0Hw7BpPg6u92US4KdOawljrFS0kpRcEf71SbbKGp WQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3et5yp65wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:55:54 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 15:55:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 15:55:52 +0000
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.229])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A0788B16;
        Fri, 18 Mar 2022 15:55:52 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] Add new HW variants and fix few minor issues
Date:   Fri, 18 Mar 2022 15:55:46 +0000
Message-ID: <20220318155552.24751-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yKRNaiaVsfMRHalU3KpEpTdncN6ULcPp
X-Proofpoint-GUID: yKRNaiaVsfMRHalU3KpEpTdncN6ULcPp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new HW variants for Dell's Dolphin and Warlock,
and also fixies few very minor issues.

Stefan Binding (5):
  ALSA: hda/cs8409: Fix Warlock using dual mic configuration
  ALSA: hda/cs8409: Re-order quirk table into ascending order
  ALSA: hda/cs8409: Fix Full Scale Volume setting for all variants
  ALSA: hda/cs8409: Support new Warlock MLK Variants
  ALSA: hda/cs8409: Disable HSBIAS_SENSE_EN for Cyborg

Vitaly Rodionov (1):
  ALSA: hda/cs8409: Add new Dolphin HW variants

 sound/pci/hda/patch_cs8409-tables.c | 68 +++++++++++++++++++++--------
 sound/pci/hda/patch_cs8409.c        | 47 +++++++++++---------
 sound/pci/hda/patch_cs8409.h        |  5 +++
 3 files changed, 83 insertions(+), 37 deletions(-)

-- 
2.25.1

