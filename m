Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5946F487409
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbiAGISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiAGISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:18:35 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D879C061245;
        Fri,  7 Jan 2022 00:18:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q14so4371667plx.4;
        Fri, 07 Jan 2022 00:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=n6vfAQzSFOpgYjKm5NJhTvllBmQl5dP9+oW26E2m/6g=;
        b=IXKDPtYu9RXlpIBNEZ0uZAl/Wx+mnwPeHSnuKUtwXOGu2Y/A1UWWGdbZzmxF8M2HG9
         xtWIjsum5LY9bAsuCccjR3veRlPGZk2G3znW9xTm9j160xosgfrymMW9bVoJKmVrWGIK
         yH8uQQWqgbNRUD/MBYECiWBldp6J8KZxxdHwcIxc3qZaNSwuM7t3fti2SHHNkADEViTY
         3QiLOVcgRjYeg78iNwDAKXp/FrIa0G7QPaDQkCJPWqy66bOHcRWN6Yz6Qz9ervMH9VyC
         5y6Xbl1MslF5jf8eWTItm2R0w7Dkmclk5hrhdv/iCBvVka0n9JnuVTVbh+yhFZsNSpP7
         eheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n6vfAQzSFOpgYjKm5NJhTvllBmQl5dP9+oW26E2m/6g=;
        b=EliNIVS+/qtf9ii3zNZ/pTxMxA2Ueo0jpri3YdzWW8AIkBBJsF9W2wjVEM5ThtuD0E
         HIY0hbNQf30ZOJkSwe9D3PUE1gxVFA5GwhFOLOUlt4hcZ8DPDnqwyknCXpJGw81A06yp
         an/eWyMPOFpAFUXMe10Wn2djVGPFPVtIDmO4UqDcoMLJwS7IQeZWoEVcEnKbmo13/CvZ
         s8E4ohLxj3dNLqknZ1rB5vi3QQkoIg0Eofhx72lVFohcDYhnVpasPgsZfz3A/Bmc38bU
         ze284v+lGNfq8FgvoMmSUKgfW1V4n5TRAioenXwZtUjOWFyfEK9byqbmOcpb5dUcmtJ6
         A4cQ==
X-Gm-Message-State: AOAM53068ULy/aBjsTLjmqWedU8JSw43KiODLq4jfEMpaw7xCQ09t454
        pMR8VRACcbovF7iGFsgggX4=
X-Google-Smtp-Source: ABdhPJwLyWyiNHtxq9qOeBdae4iZ4Y4S8/sywIRhMpbFXwz+sTEF+2B1NSWYC2RIww14DJHRM5GlSA==
X-Received: by 2002:a17:902:7617:b0:149:9c02:f260 with SMTP id k23-20020a170902761700b001499c02f260mr38820198pll.30.1641543514607;
        Fri, 07 Jan 2022 00:18:34 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id p15sm4696047pfh.86.2022.01.07.00.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:18:34 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: coda: Fix missing put_device() call in coda_get_vdoa_data
Date:   Fri,  7 Jan 2022 08:18:29 +0000
Message-Id: <20220107081829.15108-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: e7f3c5481035 ("[media] coda: use VDOA for un-tiling custom macroblock format")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/platform/coda/coda-common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 0e312b0842d7..579849082488 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -405,9 +405,13 @@ static struct vdoa_data *coda_get_vdoa_data(void)
 		goto out;
 
 	vdoa_data = platform_get_drvdata(vdoa_pdev);
-	if (!vdoa_data)
+	if (!vdoa_data) {
 		vdoa_data = ERR_PTR(-EPROBE_DEFER);
+		goto put;
+	}
 
+put:
+	put_device(&vdoa_pdev->dev);
 out:
 	of_node_put(vdoa_node);
 
-- 
2.17.1

