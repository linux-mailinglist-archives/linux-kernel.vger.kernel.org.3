Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14375A949E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiIAK24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiIAK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:28:37 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FED27B16
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:28:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id E5B9B40D403D;
        Thu,  1 Sep 2022 10:28:31 +0000 (UTC)
From:   Valentina Goncharenko <goncharenko.vp@ispras.ru>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Valentina Goncharenko <goncharenko.vp@ispras.ru>,
        Takashi Iwai <tiwai@suse.com>,
        Eliot Blennerhassett <eblennerhassett@audioscience.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] ALSA: asihpi - Remove useless code in hpi_meter_get_peak()
Date:   Thu,  1 Sep 2022 13:28:14 +0300
Message-Id: <20220901102814.131855-1-goncharenko.vp@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hpi_meter_get_peak() function contains the expression
"hm.obj_index = hm.obj_index", which does not carry any semantic load.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 719f82d3987a ("ALSA: Add support of AudioScience ASI boards")
Signed-off-by: Valentina Goncharenko <goncharenko.vp@ispras.ru>
---
 sound/pci/asihpi/hpifunc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/asihpi/hpifunc.c b/sound/pci/asihpi/hpifunc.c
index 1de05383126a..24047fafef51 100644
--- a/sound/pci/asihpi/hpifunc.c
+++ b/sound/pci/asihpi/hpifunc.c
@@ -2020,7 +2020,6 @@ u16 hpi_meter_get_peak(u32 h_control, short an_peakdB[HPI_MAX_CHANNELS]
 		HPI_CONTROL_GET_STATE);
 	if (hpi_handle_indexes(h_control, &hm.adapter_index, &hm.obj_index))
 		return HPI_ERROR_INVALID_HANDLE;
-	hm.obj_index = hm.obj_index;
 	hm.u.c.attribute = HPI_METER_PEAK;
 
 	hpi_send_recv(&hm, &hr);
-- 
2.25.1

