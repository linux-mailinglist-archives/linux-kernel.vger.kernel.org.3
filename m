Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2B4A39A3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356375AbiA3VCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356341AbiA3VCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:02:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A608C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s18so21594789wrv.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur09E2BAlQbHBoQW12ExIyAlHsPuIZyNSXmQmRscxHA=;
        b=uWIG+K0iME4rkTZkYIgbY/4+Hof+QfUMh3mg5kMss2eZstXyZG1tM3uSYXzcIu0TST
         23KujVjT3bt3WCHwDFArIheZTGDbxKjouuIWjUKxpinYqP4gGaoIii4UfW6G7EUsG8Dt
         fstHaN/XVoYXffyG9HeWlE4kzWkdXt6HZDDxe25qvJ18fyw9rBUmnHAlZU9FX5q85cdq
         oAmz3x3nBdGfpeaqw1Xvc4jheNHhb/GuGD4AX3FgvVkAnRZ9YNdN5EcmXrA3OtMqKjcP
         AmXil7+1fHGKy5eLrkF8wsawIOKLY9sYDz1Zd/EvDcm+ngOUJZretssOOEP/x6h6F8DG
         hmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur09E2BAlQbHBoQW12ExIyAlHsPuIZyNSXmQmRscxHA=;
        b=f66F/3oIJBKVjbH6JyD8ynTje+D8LF/LDZpTGiKIHGehoeaeIOGz+YFX/LZX8nP4fs
         OSB/uvMTcmC6+Gy3VU3LFk14sS24Atnvo9StGLWK3VReG0RnSu3jqRt1vmJEWACdDFw5
         pYMy0UjSJqLk0HVw0Cob3MzhQx7SaWpv6AblZcDUNLmY3tRWgi6/EVc2QDCh762aEiHY
         hweuYE0eJfp4eSpH7gbCMbfw9NDpZyL696bItySXqHannY0aXh1DHdV2mwTfUgUidHKN
         512VeNl8rhfuqZsM5mfGuKSjQ7ZISDVK116tUygt016koDVLyYUCq5LR2Nsp3m6rpT5R
         fYeA==
X-Gm-Message-State: AOAM5305hTdL+N7BZoYsW/chrPoFuFvTH1lXjlsZvNtOE3UZ+vrBs0sV
        a8sazolAaAt5y1n5q5X6dJqWcQ==
X-Google-Smtp-Source: ABdhPJwC78R0INZHCPq73eDSe/F+I905pCVnyo0D0UxRSUWb5HkQMAacwtObO31ze84S9e+T4zW44w==
X-Received: by 2002:a05:6000:388:: with SMTP id u8mr14483475wrf.688.1643576537727;
        Sun, 30 Jan 2022 13:02:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
Date:   Sun, 30 Jan 2022 22:02:05 +0100
Message-Id: <20220130210210.549877-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the node is virtual there is no release function associated which
can free the memory.

Free the memory when no 'ops' exists.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 0b0121c37a1b..7bddd25a6767 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -181,12 +181,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 
 	if (dtpm->ops)
 		dtpm->ops->release(dtpm);
+	else
+		kfree(dtpm);
 
 	if (root == dtpm)
 		root = NULL;
 
-	kfree(dtpm);
-
 	return 0;
 }
 
-- 
2.25.1

