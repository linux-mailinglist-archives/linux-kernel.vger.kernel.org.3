Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2651E48FA76
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 04:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiAPDWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 22:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiAPDW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 22:22:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FAC061574;
        Sat, 15 Jan 2022 19:22:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c66so13487181wma.5;
        Sat, 15 Jan 2022 19:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtVAa/r3Ho8RpTk/oGLVeaQ3Tn1StJzXSfcrQ//zcLE=;
        b=CSJLvxWy+3bL9jUbNu+QHIjHM7dacGonCvZqtYmqAqyECJmADWK2uw6wzNa/JO+nar
         umfxiBNbwZKF99mLpsb0sUIcEb2v96V5a7F7bkIE43a9n/7Hr3iaHWiw2y3989DEJR7u
         fGF/bMlsw8RnzXKfvJpjCd6MUG23mhfLA445WI8lCMC6izjGUFPGeySWhP3wuOfXkqsw
         JjEU29NI7+2ZCLNjgHgj8cKBeELLpBOaJOVHcsziAs4tSYDNQR0OCbhUrhAh+5p7qW+5
         kXepoaV2gZz89MQwzn5NUbsVoS+QhwjSa9xtkg4U8L05rTtczg4p9q0ArFaa6AF2UlMM
         Ru0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtVAa/r3Ho8RpTk/oGLVeaQ3Tn1StJzXSfcrQ//zcLE=;
        b=ugO1B6huD+zmO8sO3Y+1HgMGImUlEEGLcRUin70YOdIoj+xANY2Yx+xuXqpS3sdmyV
         7uSEIF17m0PDUoJovazYrkD5tC0+nKyg2JCzI+SFNkhvpLI+C/wj7U1m8RXtv05mNtWN
         C0DB6TH+vKMb/SwFjQf5dOLHBTGeCztfgIsiACSs1mukcOU2c+ukf0uSZaMea6x9zGaq
         +MIr7II+4wwgJJpvbCDeLIc5QzLIM5wbWzyU2sYt8SJFrtOvFlwNNwlPXjmc84UqPznC
         qKpwWHr6hwbDF96hZk+9crAcFnPxoDRq9gvtB33ayap/77IxeNTMMNhVeBB2y3aqiJrd
         LfJg==
X-Gm-Message-State: AOAM530n9s2u6oz4XDjS4tPnHUS14XjtxXDEqalDHrgVmpb9Sdv5m3KL
        Gsj+SN6qQXqvGx+c8EA+TWA=
X-Google-Smtp-Source: ABdhPJx7gMj7wQTQ4DwpJYQDmjcURscLM20JCKTVhXQRYyW91D4imPL/8TFzxIDIXijBJz4N/HG/Mw==
X-Received: by 2002:adf:f102:: with SMTP id r2mr12335057wro.480.1642303346152;
        Sat, 15 Jan 2022 19:22:26 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id u16sm1446785wmq.23.2022.01.15.19.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 19:22:25 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] mtd: parsers: qcom: Fix missing free for pparts in cleanup
Date:   Sun, 16 Jan 2022 04:22:11 +0100
Message-Id: <20220116032211.9728-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220116032211.9728-1-ansuelsmth@gmail.com>
References: <20220116032211.9728-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mtdpart doesn't free pparts when a cleanup function is declared.
Add missing free for pparts in cleanup function for smem to fix the
leak.

Fixes: 10f3b4d79958 ("mtd: parsers: qcom: Fix leaking of partition name")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/parsers/qcomsmempart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/parsers/qcomsmempart.c b/drivers/mtd/parsers/qcomsmempart.c
index f4fc7635c1f3..32ddfea70142 100644
--- a/drivers/mtd/parsers/qcomsmempart.c
+++ b/drivers/mtd/parsers/qcomsmempart.c
@@ -173,6 +173,8 @@ static void parse_qcomsmem_cleanup(const struct mtd_partition *pparts,
 
 	for (i = 0; i < nr_parts; i++)
 		kfree(pparts[i].name);
+
+	kfree(pparts);
 }
 
 static const struct of_device_id qcomsmem_of_match_table[] = {
-- 
2.33.1

