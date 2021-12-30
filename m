Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDC48195B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhL3Ekn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhL3Ekl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:40:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE14C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 20:40:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 205so20434862pfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 20:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6a2eJMjdkb7q3Rq0byPqY41/G2oYARLL3kUgQBTOqL4=;
        b=QrCYs10P515dtKvYAEfAwBEzCcQqgship5StVjOHbtD8s0Gc/Aq709WSzPoSaoxd3f
         2tJ8ChHK2wj7hWzSOJfhIEdMd9VK7H/E0o6tBlOqvDn8z9KcDnxAOPgRlJqj06SwWzGD
         7uZCssknxMVJIcI0RSGRmYskHewBRBOWrmAbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6a2eJMjdkb7q3Rq0byPqY41/G2oYARLL3kUgQBTOqL4=;
        b=21yY7tXLpogd9kRri5lYztTAKNA7y0trlzSEGOD3YB9YPSfTkfxyVsq1fhVBbgtV4O
         VI9vIoIH8oapVPsxIcF+NGykHAtz3sVTfL1iWAGqYbBVWpvcm5kmffm3LI5rgX4ENk0E
         zH1oa+xW7yR/ePKH92grhUJMrRYWPWrzC+m4wDIfSYRB7BC+v2Qk8dTuOXktMOJkKYST
         7/7TBO5fhAH9Wrr9qcxtb8atTnb44R4jmHmiOFD+tKzItPYbULQQkfktg7f/bzsd0x4z
         GwHsMdmtk3gIXaUW6EAFAAVZhYGj8ZkpGTmfQ51PZTYAKlHcupCC0uwiwfAhzSEtYLEN
         yIlg==
X-Gm-Message-State: AOAM531+Mpwo8lX6DfMaG8vDC9GRYiiHd1csWleAffqlrfJCa/T3+MDX
        MuM4JelghjfYq2xhNujtokfa3w==
X-Google-Smtp-Source: ABdhPJyu7WVgvRa8SHTVMU6I6eqvQmRe6SiRLcyrWEhuZAEximWE0zNJmp5wcEOizd5OTD58vupQhA==
X-Received: by 2002:a63:5403:: with SMTP id i3mr26054724pgb.562.1640839240178;
        Wed, 29 Dec 2021 20:40:40 -0800 (PST)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id f16sm27246772pfj.6.2021.12.29.20.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 20:40:39 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] rtc: msc313: Select by default on MSTARV7
Date:   Thu, 30 Dec 2021 13:40:27 +0900
Message-Id: <20211230044027.2739732-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the ARCH_MSTARV7 chips have this RTC so it's more likey
ARCH_MSTARV7 wants it than doesn't.

At the same time fix up the indent on the depends on line that looks
like it got converted from a tab to spaces at some point.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/rtc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 058e56a10ab8..9acd4ea267df 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1924,7 +1924,8 @@ config RTC_DRV_WILCO_EC
 
 config RTC_DRV_MSC313
 	tristate "MStar MSC313 RTC"
-        depends on ARCH_MSTARV7 || COMPILE_TEST
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	default ARCH_MSTARV7
 	help
 	  If you say yes here you get support for the Mstar MSC313e On-Chip
 	  Real Time Clock.
-- 
2.34.1

