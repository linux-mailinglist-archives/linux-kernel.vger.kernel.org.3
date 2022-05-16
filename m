Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8252815D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiEPKDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiEPKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:02:43 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8925755A5;
        Mon, 16 May 2022 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pGQX1JKxanPmqedEue8d2htEoS8AyrUnifwuz1TiUYY=; b=stj2aNYDMNKtVVFXkAJyNwiVwE
        5jmjneZb5CXQlIaAfydH3UNASfeBHXJcLNzbvqYwsBt2IrRd9XfI+1teMYw5QlVX5eqDFFjnFJeXO
        QTdBoeSqgSkHaJzS3Pz2gQPsDt7oGbRlvvMOFUF8dP8ZqOD0ul8dfjg2JmQu91KrDV9VHotNsjAbI
        QTJYH9rOwmmOZ5V3l0OXeu4AluaJosZCBME2vLXAKa+bmjW4pVVpIR7H/6gt/dVZel1Svrb0Xk39P
        rup9+leHFKAvzB912bBW6/1wYRtxqRgmgHyyz6pB+gj+cDkEuAbntk1l8rP3GMvxuyRaBRQWh1dEW
        xZSey3CQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nqXYg-0005yU-O8; Mon, 16 May 2022 13:02:34 +0300
From:   cyndis@kapsi.fi
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v1 12/13] gpu: host1x: Use RESTART_W to skip timed out jobs on Tegra186+
Date:   Mon, 16 May 2022 13:02:12 +0300
Message-Id: <20220516100213.1536571-13-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516100213.1536571-1-cyndis@kapsi.fi>
References: <20220516100213.1536571-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

When MLOCK enforcement is enabled, the 0-word write currently done
is rejected by the hardware outside of an MLOCK region. As such,
on these chips, which also have the newer, more convenient RESTART_W
opcode, use that instead to skip over the timed out job.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/cdma.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 765e5aa64eb6..bb1f3c746be4 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -457,9 +457,24 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 				 * to offset 0xbad. This does nothing but
 				 * has a easily detected signature in debug
 				 * traces.
+				 *
+				 * On systems with MLOCK enforcement enabled,
+				 * the above 0 word writes would fall foul of
+				 * the enforcement. As such, in the first slot
+				 * put a RESTART_W opcode to the beginning
+				 * of the next job. We don't use this for older
+				 * chips since those only support the RESTART
+				 * opcode with inconvenient alignment requirements.
 				 */
-				mapped[2*slot+0] = 0x1bad0000;
-				mapped[2*slot+1] = 0x1bad0000;
+				if (i == 0 && host1x->info->has_wide_gather) {
+					unsigned int next_job = (job->first_get/8 + job->num_slots)
+						% HOST1X_PUSHBUFFER_SLOTS;
+					mapped[2*slot+0] = (0xd << 28) | (next_job * 2);
+					mapped[2*slot+1] = 0x0;
+				} else {
+					mapped[2*slot+0] = 0x1bad0000;
+					mapped[2*slot+1] = 0x1bad0000;
+				}
 			}
 
 			job->cancelled = true;
-- 
2.36.1

