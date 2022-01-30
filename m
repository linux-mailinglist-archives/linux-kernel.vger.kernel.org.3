Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947914A39A6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356421AbiA3VCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356348AbiA3VCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:02:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52720C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c2so8846363wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRlA2mW2VZ0B7IKeYTrrJglGZpUD87Qspht3pCuXF60=;
        b=s4poMru3W116uAHW4cFJKcEjX0Hw2P5QiUgwieczodybEcf5nPtZA4OeDuqaZB/w70
         UBwKIaSVwXslwXVnrDGe7vX2uRfHVpSgpDhO4wjSNaemdgLOfUyNFYaOHSR5MobInWyj
         Cz1jEIoO1mqVobQWHbWauKgvvs4uud+9fQkuNmT7E6FEdswU8XUqph0qDK1N6HI30at4
         ZCFaVWYmJpYV8Qe4sQIWbGhCrA/QbOQzAP+mcqdeBlt5gClWAb38xsAz+vr3mqgVUWe7
         hXFMOdq/MUMj5kbSfwF4lB9bxp5Anzpglq/eeKibWaiB1RVPJr4PSfnp6q5X/rK06z05
         A7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRlA2mW2VZ0B7IKeYTrrJglGZpUD87Qspht3pCuXF60=;
        b=biebn44BR8Zm3jWy5YHZZisSxbl+e7HRcR3gZZg7QMFfVCnZNCVpOVkXuDgF2/Yp0e
         YezWR5eeGsA5X7KcS7hc2PU5ri3gkYGLzXVgzQ2/HKkGj2yzscpjXS7C9D9/xg2J7oZe
         noJ7HUy/LYprfD+P7O8OQUtIyBK5PA0fGSi5DdTzBblb6/M5eYl8cTx+jO4wN7y/pK06
         zvY/JqOn8aMp96xQG7OC/6D5FWSfqesSP9d5sWZtEVnNqYNEfIHq7On6TA2gUAMtiIGx
         c2sCzDZxsJgdu4PzLJ+bjUtm10RwE/uig2QY/C6SbsGBWs3hgBedgVBJtzZ3KYuDOGaR
         P3kQ==
X-Gm-Message-State: AOAM533GNKAoAMBArXkW70GYHEuTh8j4layrW0buRQOGSb7Wfye9vRXW
        E1jtfOstxg/Bdxa5FB4T/zPjyA==
X-Google-Smtp-Source: ABdhPJyms0o/aq6IjOZs+4GOCYsm+xmkn2HDMprqxPuL3cCmBVwz3Tog10rmEdQ5oe57II3F/ow6mQ==
X-Received: by 2002:a05:600c:4808:: with SMTP id i8mr7723214wmo.23.1643576540890;
        Sun, 30 Jan 2022 13:02:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.gmail.com with ESMTPSA id i6sm9845185wrw.8.2022.01.30.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:02:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 5/7] powercap/dtpm: Move the 'root' reset place
Date:   Sun, 30 Jan 2022 22:02:07 +0100
Message-Id: <20220130210210.549877-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'root' node is checked everytime a dtpm node is destroyed.

When we reach the end of the hierarchy destruction function, we can
unconditionnaly set the 'root' node to NULL again.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index d9d74f981118..ec931a06d90a 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -184,9 +184,6 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	else
 		kfree(dtpm);
 
-	if (root == dtpm)
-		root = NULL;
-
 	return 0;
 }
 
@@ -656,6 +653,8 @@ void dtpm_destroy_hierarchy(void)
 
 	pct = NULL;
 
+	root = NULL;
+
 out_unlock:
 	mutex_unlock(&dtpm_lock);
 }
-- 
2.25.1

