Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933744A39A5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356413AbiA3VCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356346AbiA3VCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:02:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C870CC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so6694082wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ithO/SYTnsee84comcLV1v8xrhItpMkDguw8atTZK/s=;
        b=pzxLkgSIDPizAvQzi/Z4rkcv9NnVAZUlnC7Xguxppjx+JOs1+blnWBzFAo0bW7wBHD
         GFNugIclNSwYRf11usjqo2OzHfSV7n2X4wFnXFSedyzuMtuJB4l5ZXUAK8RjG5GJjSgf
         UwnjgCRbYNvbDyetKo4KgomsuMyzmWzHgu8NUcXWtOwc8TWNQoteXKvp6WFTuQW8rTyJ
         o2J05bnnBwrWi4CtNhzNEH+lTYMaFOWsINcikp1i74eITClupp1F2bCXZqGs3PsL1EDm
         PxIaJBtt1BSVcZNUW2XiKie4EbS44JX0HDR071hB30F0QpOf+TMHLXA2l665kTYZwaeI
         VrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ithO/SYTnsee84comcLV1v8xrhItpMkDguw8atTZK/s=;
        b=LA5uZ1z/45eY7KUbm1S6IhHsrMLdmP3bqd29tvEl4gfzPuOqi7vSap5irZ4Z4tRnJr
         WT7FKOnCehaY1oJVSfCxtB0t7XfH9svxJiFB0tPqnowIHpCxKQDl2QlLhk9gTF/D+sMc
         MDBNh7+YSyaKtWiA8ZvN17WZViv+Xf4dHVO+qttwgleKGr1HdrtYYrW6hMz+I32n+QIi
         q2nDdHbMxbtjOZaQxhsjU1IxVB56oiWEC9bhVpxtkY4i8B0cn8hRXNwr41UQ/Bcxz2k9
         Tjnes+0WsvxsrCVYYZOPCFxYlPjnpvXXtfZarQzCFoUIVrRcrbKQIZQlHbEEVBZ0l3Hi
         l9Lg==
X-Gm-Message-State: AOAM5329hTflM8auUPrc5JnDK6q7i1c2esJaR6IPcLXerk4OaV99m+/P
        9+KA3++989eW6cIohpSWjMJxKSQs70mVmg==
X-Google-Smtp-Source: ABdhPJzQBkb2Ykpl/FUs+I+2wd7ewr2SsnlQsLiH22Tebb5rc9YByWShua6Tl+JcrGciTh/6avWD5A==
X-Received: by 2002:a05:600c:694:: with SMTP id a20mr15648018wmn.186.1643576539319;
        Sun, 30 Jan 2022 13:02:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 4/7] powercap/dtpm: Destroy hierarchy function
Date:   Sun, 30 Jan 2022 22:02:06 +0100
Message-Id: <20220130210210.549877-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hierarchy creation function exits but without a destroy hierarchy
function. Due to that, the modules creating the hierarchy can not be
unloaded properly because they don't have an exit callback.

Provide the dtpm_destroy_hierarchy() function to remove the previously
created hierarchy.

The function relies on all the release mechanisms implemented by the
underlying powercap framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dtpm.h    |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 7bddd25a6767..d9d74f981118 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -617,3 +617,46 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
+
+static void __dtpm_destroy_hierarchy(struct dtpm *dtpm)
+{
+	struct dtpm *child, *aux;
+
+	list_for_each_entry_safe(child, aux, &dtpm->children, sibling)
+		__dtpm_destroy_hierarchy(child);
+
+	/*
+	 * At this point, we know all children were removed from the
+	 * recursive call before
+	 */
+	dtpm_unregister(dtpm);
+}
+
+void dtpm_destroy_hierarchy(void)
+{
+	int i;
+
+	mutex_lock(&dtpm_lock);
+
+	if (!pct)
+		goto out_unlock;
+
+	__dtpm_destroy_hierarchy(root);
+	
+
+	for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
+
+		if (!dtpm_subsys[i]->exit)
+			continue;
+
+		dtpm_subsys[i]->exit();
+	}
+
+	powercap_unregister_control_type(pct);
+
+	pct = NULL;
+
+out_unlock:
+	mutex_unlock(&dtpm_lock);
+}
+EXPORT_SYMBOL_GPL(dtpm_destroy_hierarchy);
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index f7a25c70dd4c..a4a13514b730 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -37,6 +37,7 @@ struct device_node;
 struct dtpm_subsys_ops {
 	const char *name;
 	int (*init)(void);
+	void (*exit)(void);
 	int (*setup)(struct dtpm *, struct device_node *);
 };
 
@@ -67,4 +68,6 @@ void dtpm_unregister(struct dtpm *dtpm);
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
 int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);
+
+void dtpm_destroy_hierarchy(void);
 #endif
-- 
2.25.1

