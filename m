Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE34C59DE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 08:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiB0HNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 02:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiB0HNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 02:13:46 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4CAFD0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 23:13:09 -0800 (PST)
X-QQ-mid: bizesmtp70t1645945981tu3if8ky
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Feb 2022 15:12:56 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000B00A0000000
X-QQ-FEAT: 3uawQE1sH+3cdVihck04CziGgFHh4ATJm3GZakzx+Xs4mrV+/TiNB0yQq6ycm
        hSVDp20Clsidmp1bFmYpqhACq8pFf+ntNDhYjkIeS6xZx5q/yjR6U98dkV/gCbl3LIArWw9
        VcuiKiJbBvuprbJbgeR6qYN1P/cAx1UdPG26ITK+pyeGAMr3lObdHjzuxrzo36xX5H+M+E8
        +hZp+o1K+nA33j7srjpUp9t10JRqkN6ELO2Gln6txoooE3+ua8RuWatI2Iby370HWQY75vn
        6POAW+fALJWY5Dcj07CaWjOpkJH+p+YbY1+mnyWzniu1wqqNMM4/fGvCrPnyNbjJO+Z1IP0
        0GLFndG1HrRfRve/565GMfQq3MhVWYkv5uNcsUe
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH 1/2] ALSA: core: remove initialise static variables to 0
Date:   Sun, 27 Feb 2022 15:12:52 +0800
Message-Id: <20220227071253.28193-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing the static variable to 0 causes the following error
when exec checkpatch:

ERROR: do not initialise statics to 0
FILE: sound/sound_core.c:142:
static int preclaim_oss = 0;

Static variable does not need to be initialised to 0, because
compiler will initialise all uninitialised statics to 0. Thus,
remove the unneeded initializations.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/sound_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 90d118cd9164..2ee54070b2b5 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -139,7 +139,7 @@ struct sound_unit
 #ifdef CONFIG_SOUND_OSS_CORE_PRECLAIM
 static int preclaim_oss = 1;
 #else
-static int preclaim_oss = 0;
+static int preclaim_oss;
 #endif
 
 module_param(preclaim_oss, int, 0444);
-- 
2.20.1



