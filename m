Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD8750DE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbiDYK6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiDYK6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:58:36 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D6783011;
        Mon, 25 Apr 2022 03:55:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id b17so11448374qvf.12;
        Mon, 25 Apr 2022 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQowOvtwnvitJhIyw/mHRHeUyPQHp1GaeJX0DFKBx9o=;
        b=XPZaJiFiRT4sgoi6kN+1I+XDYpSJBh/58YlS7J26L/+8qANSd/gZObHdkxg7Z2+Ysk
         JpMDWoJFi3SL2SuQuNNpMWKsTaWNnc/9pLLCYASvli9c/B+yt7lC89aqdfKczUYfkDYK
         t//svxbBgdWTVqLrKmYI9z3jahSfT69McYD6M+tiu3LSvMH7U89rl/BbtjUlxE88/Syp
         QuRTPMU7rOXTuGd8cdkl7zWfoqzh3J0IKqpft/VbxPgawUbjDi/k/6R0nS5viSnxfzGx
         /6HNPGPSJLZLawo/cCVT3oyUneBAdQ28Cvqcb1oYsXhVcLWRQrQnlcLXpjc7oZEPxT+M
         4Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UQowOvtwnvitJhIyw/mHRHeUyPQHp1GaeJX0DFKBx9o=;
        b=IRpyTd3Qj0sq7ZIHwDgEy2zhIqS2vfjaLXKY/9kVTVPlJOtk4fINY8/0Ri7dfZeTZ5
         doy6bz1Ut1pGzfZJ2jvgZW8eyl6AE5iZLG5bSqMdNRRRCDtU/cTo1m3j+Xo2pwBgeFeC
         tTzNPegwjVcgYBpJpGsgmJi0BjkyNS+qaJHpgxuYhacRSy+QXqsBK7tXjBVYJfM9FFG4
         TZiNM/BAf7IALRg1YkvtLIyKF0J/Vfhu9YCUZo+lMeEG/R2JUcIIkSxiyDj6/V7mIS49
         agvoSg3TMg2BnCTklb9Zlvh2BH1TZP7QGQXd8KhoZgCRZ5llceQidxo1pmG74li2cHK7
         VMuw==
X-Gm-Message-State: AOAM532EUj2XGHuuRwQ/9W767Bk3hDuaq/4EatKVnsEzEwOFSR89WMoa
        CNWmhJUwW1PQPbje4bmBA4j5fAXMC5Y=
X-Google-Smtp-Source: ABdhPJxr03ffmbjP+1+48PKBtYpelyD+yONBP/Qq0DkkMASnZXBS5mMrpTpiGGEDkB4S5/ehPc/M3w==
X-Received: by 2002:a05:6214:21ec:b0:449:96f8:d7b9 with SMTP id p12-20020a05621421ec00b0044996f8d7b9mr11963484qvj.17.1650884132306;
        Mon, 25 Apr 2022 03:55:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a0e0700b00699a30d6d10sm4634047qkm.111.2022.04.25.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:55:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     irenic.rajneesh@gmail.com
Cc:     david.e.box@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] platform/x86: intel_pmc_core: use kobj_to_dev()
Date:   Mon, 25 Apr 2022 10:55:25 +0000
Message-Id: <20220425105525.3515831-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/platform/x86/intel/pmc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index ac19fcc9abbf..edaf22e5ae98 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -999,7 +999,7 @@ static umode_t etr3_is_visible(struct kobject *kobj,
 				struct attribute *attr,
 				int idx)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 	const struct pmc_reg_map *map = pmcdev->map;
 	u32 reg;
-- 
2.25.1


