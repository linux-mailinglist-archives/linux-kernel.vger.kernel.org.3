Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B725446656A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358649AbhLBOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358626AbhLBOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:41:08 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC2C06174A;
        Thu,  2 Dec 2021 06:37:45 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 13so36719ljj.11;
        Thu, 02 Dec 2021 06:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3+uRqlfOdJ9gdXpk4Ag6b50mCMEDFtsf4SbSiWu+Vc=;
        b=Ui2nu3+p4GaXUqPr7aBujCoNJtOGWsaecqehONsKBBfp4C1702TzgwbtHky2ba+8Tv
         YcEYpw1vl83gkFX61plvk6MDupATnQPdzYqgkue1hih7Tu3pT3fU1Ex43b4zo6spwRXE
         TdJSWDW+Aj5deDYvgHDoE92U8hoetG0xD3WtcesJ2iAV46jWIFIHnklnL43gzTi1057i
         j71ySM1u/HzdeCsXFgbd81WGZsHRgwe0bxpJjVX02QejZfjyqODpSiIjg1SASXW4IzNv
         rr9s4mG8y0oQvHNctC0d/K02VIYZQW0w5S5dmO2w3vUuip8IuAj18nugWIPHjcZ0fJGd
         IaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3+uRqlfOdJ9gdXpk4Ag6b50mCMEDFtsf4SbSiWu+Vc=;
        b=mtwNchX5gO6UvV7ebNKDeHqm+UnnqSpK0Ot25gXyonNZT6jEuRsByMwIHkTbcaJTnp
         i8HhkB6JM9Qj4KQcghrywNRCqQ1ZGsLiUTSQipUPvj8cowmyuiRSmHaeiaUMJwrMW4Df
         Y4r/EkTNZTAYLo2fgM2RAr+csyTh+2jY06y6wmpA9FwH43B6C9J1N5sziH8IG3YZQ4DQ
         gzlASHvFRVkrFdEG76gGn/+LWaFHyTustuAS5WRkofzV3gYt8/K+7+OmLcCcVbrlYGLl
         BEvTOZDSnEdGAV1GgIUxXsM3E5bvfEGcDFqhC3t/gOdxqGOmlyf8jRJNzqgMvC1Ecw+m
         G4QA==
X-Gm-Message-State: AOAM5334o5EETUACi+/WeSD2Q5vqCU8OgSQv1mVwqeprBtc9I9x+XG0i
        9XwoGT4PjVE261R9Xts+U9s=
X-Google-Smtp-Source: ABdhPJwvY8mbcLlIfE3pEzBVN9nFXr0lE8mxAcn3TUVpblULI1egT//PrBCue4QhcsJBN9IUBDImeg==
X-Received: by 2002:a2e:3518:: with SMTP id z24mr12151763ljz.293.1638455864176;
        Thu, 02 Dec 2021 06:37:44 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id f19sm368976lfm.119.2021.12.02.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:37:43 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/2] powercap/drivers/dtpm: Constify dtpm_ops
Date:   Thu,  2 Dec 2021 15:37:34 +0100
Message-Id: <20211202143734.101760-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202143734.101760-1-rikard.falkeborn@gmail.com>
References: <20211202143734.101760-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtpm_ops is never modified, so update functions and structs to reflect
that, and constify the one static instance to allow the compiler to put
it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/powercap/dtpm.c     | 2 +-
 drivers/powercap/dtpm_cpu.c | 2 +-
 include/linux/dtpm.h        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index d7ac5e79fee1..07e4dec604de 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -361,7 +361,7 @@ static const struct powercap_zone_ops zone_ops = {
  * @dtpm: The dtpm struct pointer to be initialized
  * @ops: The dtpm device specific ops, NULL for a virtual node
  */
-void dtpm_init(struct dtpm *dtpm, struct dtpm_ops *ops)
+void dtpm_init(struct dtpm *dtpm, const struct dtpm_ops *ops)
 {
 	if (dtpm) {
 		INIT_LIST_HEAD(&dtpm->children);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..2eeff292ffbe 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -157,7 +157,7 @@ static void pd_release(struct dtpm *dtpm)
 	kfree(dtpm_cpu);
 }
 
-static struct dtpm_ops dtpm_ops = {
+static const struct dtpm_ops dtpm_ops = {
 	.set_power_uw	 = set_pd_power_limit,
 	.get_power_uw	 = get_pd_power_uw,
 	.update_power_uw = update_pd_power_uw,
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 2890f6370eb9..883f5ab213f3 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -17,7 +17,7 @@ struct dtpm {
 	struct dtpm *parent;
 	struct list_head sibling;
 	struct list_head children;
-	struct dtpm_ops *ops;
+	const struct dtpm_ops *ops;
 	unsigned long flags;
 	u64 power_limit;
 	u64 power_max;
@@ -64,7 +64,7 @@ int dtpm_update_power(struct dtpm *dtpm);
 
 int dtpm_release_zone(struct powercap_zone *pcz);
 
-void dtpm_init(struct dtpm *dtpm, struct dtpm_ops *ops);
+void dtpm_init(struct dtpm *dtpm, const struct dtpm_ops *ops);
 
 void dtpm_unregister(struct dtpm *dtpm);
 
-- 
2.34.1

