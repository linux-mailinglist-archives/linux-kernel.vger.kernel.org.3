Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BBE4635D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbhK3NyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:54:02 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61894 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241761AbhK3NyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:54:01 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AUBvm3O018641;
        Tue, 30 Nov 2021 07:50:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Ax6ssAcwQRjsy8iTK9gvd5o/h7aKkUSTKjNwBGy0ji4=;
 b=jJaqiwVO+BE6RgUx7iOiGE7qAlyn+dPZ7EFqMsRmlcAiOq3MZBdVh9Wja6vPtimwWQ/4
 83S1RvV51T47xfAh8uFD4ysnAIOJsYfHjNPPHtgzHd4wiOJO7Nxz8zKQiqk7Q5Ld341m
 eT3NwLHTKv1yvtzM3PbmjYgLf0VoDeSKO4tJ1253OjuQlRtbdua8UZyw+uWO/lHPeNnD
 1cGNwoH1n/uMQ1ZvkydQzPqaCqXinZDFduP/CHVoOcvN9972prz9jDpHKtlxRJ7m1CoC
 s8f1GZu+ROaO9UbIOdBQLX93pWQGGKTtErdj1/q70d5dQBzoA/QsxpB8eBFWrPU6sPR/ Aw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cmv5u1m5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Nov 2021 07:50:40 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 13:50:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 30 Nov 2021 13:50:39 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 360312AA;
        Tue, 30 Nov 2021 13:50:39 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Input: ff-core - Correct magnitude setting for rumble compatibility
Date:   Tue, 30 Nov 2021 13:50:39 +0000
Message-ID: <20211130135039.13726-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: qtUNgmsBJJXBzABks0jeBI2ARI7Hmk3G
X-Proofpoint-ORIG-GUID: qtUNgmsBJJXBzABks0jeBI2ARI7Hmk3G
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When converting a rumble into a periodic effect, for compatibility,
the magnitude is effectively calculated using:

magnitude = max(strong_rubble / 3 + weak_rubble / 6, 0x7fff);

The rumble magnitudes are both u16 and the resulting magnitude is
s16. The max is presumably an attempt to limit the result of the
calculation to the maximum possible magnitude for the s16 result,
and thus should be a min.

However in the case of strong = weak = 0xffff, the result of the first
part of the calculation is 0x7fff, meaning that the min would be
redundant anyway, so simply remove the current max.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/input/ff-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 1cf5deda06e19..fa8d1a4660142 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -67,7 +67,7 @@ static int compat_effect(struct ff_device *ff, struct ff_effect *effect)
 		effect->type = FF_PERIODIC;
 		effect->u.periodic.waveform = FF_SINE;
 		effect->u.periodic.period = 50;
-		effect->u.periodic.magnitude = max(magnitude, 0x7fff);
+		effect->u.periodic.magnitude = magnitude;
 		effect->u.periodic.offset = 0;
 		effect->u.periodic.phase = 0;
 		effect->u.periodic.envelope.attack_length = 0;
-- 
2.11.0

