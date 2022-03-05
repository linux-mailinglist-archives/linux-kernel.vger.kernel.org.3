Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3B4CE71D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiCEU5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiCEU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F267062A02
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 12:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646513771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e2EYH75BVmIbRhMybWcunmFifuSH0lEu5dUIGZ1WvCM=;
        b=F9k5P+uidCH24bg5ywFxOBHVmSnTE6B51DdbSqidnWCb/E1/OD8Mv6tD40VA152DIGeSxM
        lRCY/taBxa0z2x3NPOPppZyj5GMFk2YaPxxNvWAl356/rJdOH7x+tHil+Qncj+Ytepy/ND
        n8vVCHULcvtio3njsJEjMtbr8feZI4U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-WH00X1V6NTiRx0FRaenc2g-1; Sat, 05 Mar 2022 15:56:10 -0500
X-MC-Unique: WH00X1V6NTiRx0FRaenc2g-1
Received: by mail-qv1-f70.google.com with SMTP id u1-20020ad45aa1000000b00435311d5b9fso8040868qvg.19
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 12:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2EYH75BVmIbRhMybWcunmFifuSH0lEu5dUIGZ1WvCM=;
        b=4/pYluG8B+PFrF8rS9R+tmnwZyunq0/zQM1TqhBHuUrgfTDANUwknXr+1qq19UZWvn
         ElEuvcGv8xkxBstK/oC+/+jD4+PzlBgIyHoix3gNsB0yVYGxF3oO1GbxzgyQVFmL1nfx
         ZZdLanSDE59uhN7ZoFOt35CFCb6w+1jzGaPyd6KCmb7gETfn/r4j8fyHsrRcJrnqRA3e
         ZIW55+ySXoO5X5gYyVht/tAHsYE9pVA6HzUjaCfktVTRYMvy1b3MFdFW4X3EgPE+7Qr9
         Ls9FzQgo64RQF54gF5ElTn43DXxBZ+E1Ywqu5uRKuu2R+eclgmaXiWnGwauLWk6YOfL+
         usvA==
X-Gm-Message-State: AOAM530hcp+hwJ2PzSq7tdu4+OjrFt7fPuqK5uTURchzrhD8QcU6LJp8
        tCEfO8Ymb6Jsb9FE/Qdh1Qn85Mzn2XTF789yNA/Q+ixMkzMAllVECfHgKk3wos1zd3tJ3VZuq0S
        o7pWOTztkbjOw6+uaclnaI/Gk
X-Received: by 2002:a05:622a:2cb:b0:2df:f334:c892 with SMTP id a11-20020a05622a02cb00b002dff334c892mr4196453qtx.434.1646513770537;
        Sat, 05 Mar 2022 12:56:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj73gLFo//3TCHm3Z930BC1F7OmYMKClBEjNJNDMR5NVGWqWD3Q63p2CMbPiFF9mel4Lxivg==
X-Received: by 2002:a05:622a:2cb:b0:2df:f334:c892 with SMTP id a11-20020a05622a02cb00b002dff334c892mr4196449qtx.434.1646513770323;
        Sat, 05 Mar 2022 12:56:10 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m10-20020a05622a054a00b002e049ff99f2sm4774777qtx.7.2022.03.05.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 12:56:09 -0800 (PST)
From:   trix@redhat.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] clocksource/timer-imx-tpm: define tpm_read_sched_clock() conditionally for arm
Date:   Sat,  5 Mar 2022 12:56:05 -0800
Message-Id: <20220305205605.707937-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

On aarch64 allyesconfig there is this error
timer-imx-tpm.c:78:20: error: 'tpm_read_sched_clock'
  defined but not used [-Werror=unused-function]
   78 | static u64 notrace tpm_read_sched_clock(void)
      |                    ^~~~~~~~~~~~~~~~~~~~

tpm_read_sched_clock() is only used conditionally
for arm.  So also define conditionally for arm.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 60cefc247b715..bd64a8a8427f3 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -73,12 +73,12 @@ static unsigned long tpm_read_current_timer(void)
 {
 	return tpm_read_counter();
 }
-#endif
 
 static u64 notrace tpm_read_sched_clock(void)
 {
 	return tpm_read_counter();
 }
+#endif
 
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
-- 
2.26.3

