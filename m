Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369A852EA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiETKnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiETKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:43:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332714CA0D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:43:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso7568815pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um6Mtxj9hn6MLF0/DG+dua7GL3nWe8jP1xt8gG30nLY=;
        b=QQI6WKxPdPQlxQR2wBHF8ieDOe8AjPnodlbFL2coMjZXGkbYc3ejUJKSdjhWhC5Hrz
         4Frb0wz7hDNs9vuvxfcXLhPiO/Vx5V198ppq/coM2RoCMTxc3hT+fOnO7nrmqY5h3XmR
         G783hWx646iduUN4WKTRng/rwRaGCJB7vVzArrL7IBWE6YrVsiTmBAjOrFsltZZgCWKC
         X8d/1aEJnLduuk18lRy7YYSPFsXQFvixoCfTXD6/cjU0cOScIVj+yBeDz5Fa9UhcAJTX
         pmsDtshY4fB4qdLauDDjsdpLjYYdCUXszo7Ii3G0UeylDOgmy1dvD9zwtGOGV5mHylrI
         +97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um6Mtxj9hn6MLF0/DG+dua7GL3nWe8jP1xt8gG30nLY=;
        b=Q6D6Wk3CK3RjJO5UPuCUyzUVr6XVsoDsdHyw8Du1NIOdG21BzJFzl745zuUU0BPQj/
         HG8EaRrHx7CGyp5S5uQxxjm8snAzJpYosjJIN1g9PFRjwdc7qiB9JpSvaHBQkDAC/4hZ
         NImcWbu7lVacmgn73JBTLV9mm311h7eFQPG3Ub3jt1XL1irA7HIFJf/TeR4LTGsN7qlv
         SWPoLLwBCq/6ODs1CPfeNxH514Yyl3cFjemBriefhhuaElFb3RqGIK3y7CCdMijwNL63
         6aWvmcytRSC1OYeGdIMf4Of/86ZDiLZ7WyCr9rKThtBMTIZkTGei99nzn5UqhrKpYLku
         znaA==
X-Gm-Message-State: AOAM533z+eJ2MLEqgNRsf3K0BvHkQt6ksuQrZt5HB1Qs/DfWXZOhzntV
        RgAKIBJGjnjoJADrQEQ2n7UZVQ==
X-Google-Smtp-Source: ABdhPJzJvp4abACIC9bSi6TaYIAOrBzPR9AkpGWI0uG2VlDBiX0Juhn7NPRg20Zp/1xDQU2YVkvBgQ==
X-Received: by 2002:a17:903:244f:b0:15e:bb9a:3aa9 with SMTP id l15-20020a170903244f00b0015ebb9a3aa9mr9053463pls.78.1653043398455;
        Fri, 20 May 2022 03:43:18 -0700 (PDT)
Received: from localhost.localdomain ([1.200.35.228])
        by smtp.gmail.com with ESMTPSA id ru13-20020a17090b2bcd00b001df4a0e9357sm1598543pjb.12.2022.05.20.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 03:43:18 -0700 (PDT)
From:   Scott Chao <scott_chao@wistron.corp-partner.google.com>
To:     hverkuil-cisco@xs4all.nl
Cc:     mchehab@kernel.org, bleung@chromium.org, groeck@chromium.org,
        zhuohao@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Scott Chao <scott_chao@wistron.corp-partner.google.com>
Subject: [PATCH] [v2] media/platform-wide: platform: Add moli to the match table
Date:   Fri, 20 May 2022 18:42:53 +0800
Message-Id: <20220520104253.26054-1-scott_chao@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Moli device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Scott Chao <scott_chao@wistron.corp-partner.google.com>
---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 8c8d8fc5e63e..25dc7309beab 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -217,6 +217,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Fizz", "0000:00:02.0", "Port B" },
 	/* Google Brask */
 	{ "Google", "Brask", "0000:00:02.0", "Port B" },
+	/* Google Moli */
+	{ "Google", "Moli", "0000:00:02.0", "Port B" },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.36.1

