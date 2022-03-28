Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369084E95FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiC1L7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242654AbiC1L6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:58:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC9D8B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:56:59 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8AHva030601;
        Mon, 28 Mar 2022 06:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=s17bH2wq48xeJSQODDx6n6E0adzoVMT9RDU32m9kPUg=;
 b=I3qcisXfuv6M760Xi3vyJlUx43PHVplJTKG1PAbmjEcxmirAnXtk8sH206F9xkPT1wh0
 4xAB0UDprKSVQx5OrwCNQ8oZR93egwd55ROsSdmPoKeTU4qJeLJaBxtHXtYDSi9xE/vi
 a05AUEOGRc++J0P5lw9mvWt7UeRuONiU8o4CZFgr1NYHqiucuBqsQ283N/gAdN1uK9WG
 dolaGNoJzpStz9Ad/bG27fcyDS+bXGW2cubjzZ2tuh3QimuJ6InfQFhtH+s3SjcJCZGf
 hiOBewlc7y6XhVZ5YdtvpVicBmQvfrpQHlwyiXugS+yszch6xqDBNwL44GMyX578h/px uQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081apda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Mar 2022 06:56:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 12:56:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 12:56:15 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.244])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B4B9E46A;
        Mon, 28 Mar 2022 11:56:14 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] Add new HW variants and fix few minor issues
Date:   Mon, 28 Mar 2022 12:56:08 +0100
Message-ID: <20220328115614.15761-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5YFiUiG9ZSd899pGMXi9hRSEPnpMLp1m
X-Proofpoint-GUID: 5YFiUiG9ZSd899pGMXi9hRSEPnpMLp1m
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new HW variants for Dell's Dolphin and Warlock,
and also fixies few very minor issues.

Stefan Binding (5):
  ALSA: hda/cs8409: Fix Warlock to use mono mic configuration
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

