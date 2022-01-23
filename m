Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E989449763C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiAWXCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiAWXCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:02:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBCC06173B;
        Sun, 23 Jan 2022 15:02:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f17so10348032wrx.1;
        Sun, 23 Jan 2022 15:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BX1VS/CBb7A8+2aiy4TYSuWVNfw4jVGiWVZT5XSWvJ4=;
        b=qGU1T0XTDrseSlfsMDhcD+LUWDcwzpTxKiADon3N5gnEX1q50GW2YzUh47mjYjZ83A
         ROrvsGNlAIwDSBRUSbZYyn57Iaw+IZ5NHh1tiCEslZrNEwCVPvx1aVhSsGxSFJjqyamN
         JAQMzEeD9w/km5e4Cxf1L1iD6wKnzPkHMt2/xCsaAijQW8x3sA8dFgmnaBh/Ry9DP6AD
         M+GEeWNaWVDW5IpgOPo/q4MjyoMAOKuFfyoKa7TGaV2Ik+cGNMxChiyo43IuV5bURmiD
         oRZH1u/OO9Qyrk82N5MJnWNhBuMKTh5ribP+3TSNzCIx5PSX68aLSXNTPPXksioSbWRg
         7B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BX1VS/CBb7A8+2aiy4TYSuWVNfw4jVGiWVZT5XSWvJ4=;
        b=SElxOf14/jPSdzCvZBbZPh7EX/c94JeUJ8ELITt4LQ6C2MlmHbEvQcXjsdWGQ18Tnv
         d/vm2AEJmrrAfrqy5R4YCubuQztbaKhmYGy963hG5DuXc/ffamUgCE+a6ILtM+GtsOsH
         ByIUgqTF6ZLoQtag+xyq2iyq6nRj5/QMuz+0V9XbAo3MdXmhvJsOmo3PJbjPW2zrWRFA
         tfaZDSL66BeQHQKf2i1+E2MNnePMeNyVJRLO6fcsuk3/EnSdKvCluj5guTZSi1U9JvH1
         rrdf8GURFOFsLB2RY2ZsyRUqXvBxfzHcMnlzcNWp1ROsl2wuLfmK3aOJBuhC3vyr+qI+
         NPAQ==
X-Gm-Message-State: AOAM532ha5vJTIt3KMC79D4Wm5SeGGxg4BiO4UJOXI0UD+08y0UqLDgq
        05s4f+vtxAbHgUVuGjRM72w=
X-Google-Smtp-Source: ABdhPJz6v2C+dWn1iDjqGGb2eSi85+c+lYUBPxEsWTl8s4BNvOrPYoffZUy7ziXCuXbx3+52lKh3jg==
X-Received: by 2002:adf:db4a:: with SMTP id f10mr2917791wrj.117.1642978963730;
        Sun, 23 Jan 2022 15:02:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b2sm2068317wri.88.2022.01.23.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 15:02:43 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb_frontends: make static read-only array fec_tab const
Date:   Sun, 23 Jan 2022 23:02:42 +0000
Message-Id: <20220123230242.7519-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array fec_tab is read-only so it make sense to make
it const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/dvb-frontends/stv0299.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv0299.c b/drivers/media/dvb-frontends/stv0299.c
index 421395ea3334..fbfc912c1071 100644
--- a/drivers/media/dvb-frontends/stv0299.c
+++ b/drivers/media/dvb-frontends/stv0299.c
@@ -161,8 +161,9 @@ static int stv0299_set_FEC(struct stv0299_state *state, enum fe_code_rate fec)
 
 static enum fe_code_rate stv0299_get_fec(struct stv0299_state *state)
 {
-	static enum fe_code_rate fec_tab[] = { FEC_2_3, FEC_3_4, FEC_5_6,
-					       FEC_7_8, FEC_1_2 };
+	static const enum fe_code_rate fec_tab[] = {
+		FEC_2_3, FEC_3_4, FEC_5_6, FEC_7_8, FEC_1_2
+	};
 	u8 index;
 
 	dprintk ("%s\n", __func__);
-- 
2.33.1

