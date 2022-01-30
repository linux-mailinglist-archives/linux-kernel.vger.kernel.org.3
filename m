Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A034A360A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354708AbiA3Lpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:45:54 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:43338 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354689AbiA3Lpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:45:52 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 23EFDCE852;
        Sun, 30 Jan 2022 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1643543147; bh=+J7dsbVz0Gr8InKACrreO1d9W/9Jj6OF5yJF+RWIf/E=;
        h=From:To:Cc:Subject:Date;
        b=c10RlLUlhqufnyLDvfgaFSw4/SeapNyg8sHtOOCs2asKq8bYgmIo5jMHiQrO4sVtn
         bPDvbPVUDDhHSLnswp3shlNPnW51H3wvzOwcEZppmr/yi164niHla/lSA2M3yCz15a
         VDxkxHqguH1CGgef7Q+WRr1vWpE+fLPIyZLxJeJ4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-cpufreq-nvmem: fix reading of PVS Valid fuse
Date:   Sun, 30 Jan 2022 12:45:35 +0100
Message-Id: <20220130114535.1570634-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fuse consists of 64 bits, with this statement we're supposed to get
the upper 32 bits but it actually read out of bounds and got 0 instead
of the desired value which lead to the "PVS bin not set." codepath being
run resetting our pvs value.

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index d1744b5d9619..6dfa86971a75 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -130,7 +130,7 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
 	}
 
 	/* Check PVS_BLOW_STATUS */
-	pte_efuse = *(((u32 *)buf) + 4);
+	pte_efuse = *(((u32 *)buf) + 1);
 	pte_efuse &= BIT(21);
 	if (pte_efuse) {
 		dev_dbg(cpu_dev, "PVS bin: %d\n", *pvs);
-- 
2.34.1

