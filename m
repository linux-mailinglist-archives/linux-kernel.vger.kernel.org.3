Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B6495ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbiAUME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:04:26 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36560 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348969AbiAUMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:04:23 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L6W2RJ017662;
        Fri, 21 Jan 2022 06:04:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=cHTdgJoGxUCkn9pYkep3lJ1ELWZc56siT+B8A9L5DDI=;
 b=VYWlH8knO4M5yTnUWpfzlSMMoztDVpXae2Hu2bop0EEiQqNaANS2OH01eDOjrX5JWkiI
 q+VfA85XWZrqTjRaqeaHaMiM0CyTjTFAE7T7Y8uX0lIXTKgJ3Oh21lftarGirN16o1oi
 q4zfIIY6GGCmjQmTZ7MdnpA0H9ngVr8U6fEI+SSTk0oRrCuTAHJ5xj1gxgzmBNo98zN7
 ODso9YE+FKVNxkhfOsGk83p3EPoNmTzSIoOmnl0EE55jbjOfmWPuaVRJnIJekn2eJrn2
 gqROS2mOqtvJb0HjiYCKeFF/FnNSFjmdB3ArHivUQGdpXFN+D5X0k/kBez5tn77IwNyo XQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq0nwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 06:04:17 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 12:04:14 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 12:04:14 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.33])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2373E45D;
        Fri, 21 Jan 2022 12:04:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/3] ASOC: cs42l42: Add support for system suspend
Date:   Fri, 21 Jan 2022 12:04:09 +0000
Message-ID: <20220121120412.672284-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XsTNiSO2CEcw8JrWHXlNdw-zBOZzSyQx
X-Proofpoint-ORIG-GUID: XsTNiSO2CEcw8JrWHXlNdw-zBOZzSyQx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system suspend and resume handlers so that the cs42l42 is cleanly
put into power-off state during system suspend and the registers are
restored in resume.

The first two patches separate out two small changes that can stand
alone and are needed to enable the system suspend implementation:

1) Don't rely on there being a jack unplug IRQ before a plug IRQ.
There won't be if the unplug and plug happened while in system suspend.

2) Put a mutex around the entire IRQ handling so that the suspend can
ensure the last run of the IRQ handler has completed before it powers
down.

Changes since V1:
- Hold irq_lock mutex while restoring registers

Richard Fitzgerald (3):
  ASoC: cs42l42: Report full jack status when plug is detected
  ASoC: cs42l42: Change jack_detect_mutex to a lock of all IRQ handling
  ASoC: cs42l42: Handle system suspend

 sound/soc/codecs/cs42l42.c | 166 ++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/cs42l42.h |   7 +-
 2 files changed, 163 insertions(+), 10 deletions(-)

-- 
2.11.0

