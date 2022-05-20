Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1952EA81
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbiETLIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiETLIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:08:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1185F7A830
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:08:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v11so7485287pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um6Mtxj9hn6MLF0/DG+dua7GL3nWe8jP1xt8gG30nLY=;
        b=Kj+7Auan4bsUc8KoQwFqczhOJlVHGQfBnGWy608iYQ8110CriJtjyCBAAHB+RWZcHf
         VhiR/XacCdO7kwRyAap6FDCFM6zbxyX0tcYdJblf2/2p4nZq0Q5zA0qO1KBLu8p+gKTo
         zl90Y5Mjl4hOI8IDd9Jmf/4tkmKJWBi3qHex7P1eX3/bMPVaHBAaNkNs+jBft20JLJF7
         qcoROWC7QzVIWsXxCaI/7NSr79rh7jNsCgThmsG+mAKFKRox47W0EABIBgF3K7m+6f0K
         K3TNXZ//JuZ4vImzp5pVFq2+5TrigPiLzmDK8ds+gMANvPyOqzUScpERuO0yLxCrjQdM
         K1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=um6Mtxj9hn6MLF0/DG+dua7GL3nWe8jP1xt8gG30nLY=;
        b=r7iJ/Kc/J8QAkl3bvtTVqqwt6gatEnsr9JET/KWwcYZ7Bf8U4N9GDvZrPqwenpUcBN
         LbRhyr6LuCikjr9ii8fRJ/KNjtbUpzxO2N/kK0abUFBRT72cQF0SSV9jBnwnMjwC01IS
         xjpHIesW6NHA2qZjL0E9s72MW5Ct3eWlnq24R0Uk/ZKIyvo8d3zzY2GsFssSbGrbxBMl
         CaxdxslCTkfuVivJNe4JtGj9GFmwIa8821KMoB9rlvcNhPS/b4UoAiBRx9BzwJgh4hKN
         w/JobcMS5bQ0OqhfJ7XHK9CSBwTSWgKeoH9bA2YbigdX1tfHcoi4sCPzRbQ4PlLWOwxw
         5ChQ==
X-Gm-Message-State: AOAM5327rWAOh3XUInxkvOFX3UwJmmAywyi2JLlua8wT2g0iutvZGO1w
        hbJi0bMX2g0B7cAwqKGqCoRuAQ==
X-Google-Smtp-Source: ABdhPJzaCxARv0TVc1XJwcQ1nIwmAQeK6wnibMcmMKPiqUSE5dM+POfMx56MI0U7lwnC2UEaDu0dFg==
X-Received: by 2002:a63:680a:0:b0:3c2:7c45:c0ab with SMTP id d10-20020a63680a000000b003c27c45c0abmr8251254pgc.63.1653044920549;
        Fri, 20 May 2022 04:08:40 -0700 (PDT)
Received: from localhost.localdomain ([1.200.35.228])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b0015e8d4eb29bsm5530686plg.229.2022.05.20.04.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:08:40 -0700 (PDT)
From:   Scott Chao <scott_chao@wistron.corp-partner.google.com>
To:     hverkuil-cisco@xs4all.nl
Cc:     mchehab@kernel.org, bleung@chromium.org, groeck@chromium.org,
        zhuohao@chromium.org, linux-media@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Scott Chao <scott_chao@wistron.corp-partner.google.com>
Subject: [PATCH] [v3] media: platform: cros-ec: Add moli to the match table
Date:   Fri, 20 May 2022 19:08:31 +0800
Message-Id: <20220520110831.29502-1-scott_chao@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

