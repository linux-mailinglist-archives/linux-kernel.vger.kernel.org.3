Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43F347D789
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbhLVTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhLVTOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:14:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421E3C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 11:14:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t26so6865867wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 11:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkplSK95bDKaTLjATnzK24WfR1amNRzKPTQ6bpBxUWU=;
        b=wJ0O6g0Su6lKuUQLlrcYmS87eThzM17dE7zlGitj65GOQeE2QpFdXnVoZGbhGarbeN
         QAa2zd/sNoZDHhdtMx1hWRp/oP6WlBaI3blEhODOrUdr6+9VDtBx+aLCvkrADKtcKffN
         PgIXNRz56Pw5ssz4SZeTnih7rSr2XBEEgqmRVlETaJvsktqmkcwoqicHpWsf95Ac+oUB
         uc1C0zF9rxXqw0egy+OBt78/mI8Iewp86jeX0+jlYn3GLLXkpOl7zFXitMUoTXLoUvna
         erCqFHiw1Wohjt8a57p8IgokwY940wpwJXg5165emujcjwt4PudF1zeApABRpm+2qWBx
         9vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkplSK95bDKaTLjATnzK24WfR1amNRzKPTQ6bpBxUWU=;
        b=KitazilNl71cn2ZxKkzckKZkwDTrhCYrYUvDnCcsgoWN3eCWK3XJ+/FHL6HvCDWj+g
         McQMIxUDecU5ulPggoWslEwZaZJRU7Lg8Gbs/EXhH0A15lEZoHJZwZevtIOM0YvUEdG2
         XhhKWYpsXkgcbPxA4dqRplOY67wPzVQEOpKK2fGUSjFs8wu7JiML2SyENtmEkMfNm2tN
         Yk8uMe/1fC4BhB6mHUB08N38qNbLljKoA4jRwWj8v7vFAeFmb95kjRy2dXG3yH9eqv+5
         ZaKhaYOm75cXL3H4jEHj7nYyLkewSV9i7oUL0boPox8IpVfvj5SPgvPFIXxkVEfH5Ycx
         76iA==
X-Gm-Message-State: AOAM531bLfJL4pNLMmb54eWiZpsMaN5vtHJBR76mZmAdQeFtdwDfVBD2
        bs4gLCg9VhYCO00gjicpvTFurJmDvv69KNjd
X-Google-Smtp-Source: ABdhPJyQ5jIxCHtbfMjppNaBywIRDKKryWuFHi/znnznIFbJ61IvUWj87rSqcX51FPDNjw1C6ZLgaQ==
X-Received: by 2002:adf:fd02:: with SMTP id e2mr2952627wrr.139.1640200464719;
        Wed, 22 Dec 2021 11:14:24 -0800 (PST)
Received: from localhost.localdomain (p200300d9970878003dae64a47964a371.dip0.t-ipconnect.de. [2003:d9:9708:7800:3dae:64a4:7964:a371])
        by smtp.googlemail.com with ESMTPSA id s1sm5798360wmh.35.2021.12.22.11.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:14:24 -0800 (PST)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki " <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>
Subject: drivers/acpi/processor_thermal.c: avoid cpufreq_get_policy()
Date:   Wed, 22 Dec 2021 20:14:11 +0100
Message-Id: <20211222191411.13805-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_has_cpufreq() stores a 'struct cpufreq_policy' on the stack.
Unfortunately, with debugging options enabled, the structure can be
larger than 1024 bytes, which causes a compiler warning/error.

(actually observed: 1184 bytes).

Therefore: Switch to cpufreq_cpu_get().

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

---
 drivers/acpi/processor_thermal.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index a3d34e3f9f94..74210d63f62c 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -53,10 +53,19 @@ static int phys_package_first_cpu(int cpu)
 
 static int cpu_has_cpufreq(unsigned int cpu)
 {
-	struct cpufreq_policy policy;
-	if (!acpi_processor_cpufreq_init || cpufreq_get_policy(&policy, cpu))
+	struct cpufreq_policy *policy;
+	int retval;
+
+	if (!acpi_processor_cpufreq_init)
 		return 0;
-	return 1;
+
+	retval = 0;
+	policy = cpufreq_cpu_get(cpu);
+	if (policy) {
+		cpufreq_cpu_put(policy);
+		retval = 1;
+	}
+	return retval;
 }
 
 static int cpufreq_get_max_state(unsigned int cpu)
-- 
2.33.1

