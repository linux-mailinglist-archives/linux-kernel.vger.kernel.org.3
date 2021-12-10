Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC63E4705E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbhLJQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243714AbhLJQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:41:28 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF1C061D72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:37:51 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p65so11057787iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CgSHoGMd3MZ0+RwfUhTHIWklywVMelQpZkd8mqp/LWA=;
        b=h9I0eI9TL9mZt8Dgdc2RYu1igsfIYeWryF/71YWTW0uxiQf5q1x/o5Sn0Hzx+eOLnu
         rWkrcJSfF8QrHMZc3EXkFUoZWuecSpSbjbHlQqzn08MpzR2zaB4c9Gs5rfga0iVE5X4U
         2tqkbf2yWCPMDx3ZQXJlYYd5YYMA2oeQzg10emvxWyxaBifRLm/DZvQU1W/h374TCQQW
         deZIJ3m8A9nmeMqpRVLOhhIO0J4tN5GGSMtFHxBcJekAphomxwGOdq9jfx4fF26UnNVD
         AZ7P/6b4dKw/gZarwhf26d3d9dgHqUiVldEZnqHHkaVfYl0qPplUfdGdaJjSrorYqhv8
         OQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgSHoGMd3MZ0+RwfUhTHIWklywVMelQpZkd8mqp/LWA=;
        b=QgycnWlES04Mcv/HGrUxTxOtWQnFblZ+Sdl0fJ1KBJiwbXTUUfdhZ/3C2KS0tpuRMB
         3sMj026DV6j1tkqVuQLS7Ur5hNVXXKDOdjRVsxQ1qbQZ1FB9a9TeEXd3dUIHe+5Nb3Fx
         Vt1ZT3NUEtT2YHZ2kHUi69Hrwl2SIrX7YBgwzzJPf/hN7n9KEG0VPPg4aYBwUuJ/yN2Q
         JATXsv5EK1KDQG8Ujx01Zh/rvNS53YVBK4jUmO6O9BMUtJh3InpZSDt4ySuKIUqOqkqv
         vwAESIKhEdKDJm9PUR1gtUuGCCFTfYlHPmlOci0R9FLv8R+MZd056caWFzE51hehB0dm
         u3gg==
X-Gm-Message-State: AOAM530XgHAJOHL7xMIJYGV1YdPbfKy/wKhom1e7x5GAbDx1Yw8LeJUd
        uwYAxuoa3aPpKm4qdFRdcNKdWA==
X-Google-Smtp-Source: ABdhPJyrLh49PWZhlPD/da4BA3vtRMoZj1q58/rI8uWVBrEwHjVOfGXO/DDmn1S5Nvk7LtUUuQ90xw==
X-Received: by 2002:a05:6638:d46:: with SMTP id d6mr17993604jak.129.1639154271123;
        Fri, 10 Dec 2021 08:37:51 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p14sm2232642iod.38.2021.12.10.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:37:50 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     david@ixit.cz, manivannan.sadhasivam@linaro.org,
        jponduru@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: ipa: fix IPA v4.5 interconnect data
Date:   Fri, 10 Dec 2021 10:37:45 -0600
Message-Id: <20211210163745.34748-3-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210163745.34748-1-elder@linaro.org>
References: <20211210163745.34748-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the definition of the IPA interconnects for IPA v4.5 so
the path between IPA and system memory is represented by a single
"memory" interconnect.

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-v4.5.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-v4.5.c b/drivers/net/ipa/ipa_data-v4.5.c
index e62ab9c3ac672..2da2c4194f2e6 100644
--- a/drivers/net/ipa/ipa_data-v4.5.c
+++ b/drivers/net/ipa/ipa_data-v4.5.c
@@ -420,15 +420,10 @@ static const struct ipa_mem_data ipa_mem_data = {
 /* Interconnect rates are in 1000 byte/second units */
 static const struct ipa_interconnect_data ipa_interconnect_data[] = {
 	{
-		.name			= "memory-a",
+		.name			= "memory",
 		.peak_bandwidth		= 600000,	/* 600 MBps */
 		.average_bandwidth	= 150000,	/* 150 MBps */
 	},
-	{
-		.name			= "memory-b",
-		.peak_bandwidth		= 1804000,	/* 1.804 GBps */
-		.average_bandwidth	= 150000,	/* 150 MBps */
-	},
 	/* Average rate is unused for the next two interconnects */
 	{
 		.name			= "imem",
-- 
2.32.0

