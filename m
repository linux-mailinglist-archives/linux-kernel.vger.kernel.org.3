Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6980F4780A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhLPXbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:31:49 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39475 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLPXbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:31:35 -0500
Received: by mail-oi1-f173.google.com with SMTP id bf8so1148882oib.6;
        Thu, 16 Dec 2021 15:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tg2oCBFq5G88h+ck8cHgDUdDvDFgPbXH7dXGlomqHsQ=;
        b=bkhaFBoUjW+8we8ZsYlDsX9gi1mQkHAWGeCvgCRRHoG0vWA77O0iVpAXp7tG+fVljM
         VLgxMbNxcQJ8AmhbkHSiTxXNxE+Y+NSYjZ1956QtSIvRMj8KPLCGQ6Xsyc3+tmpZbu0a
         II/Rj4OztF9aEqwb1S2PnSqK3+yNdKUNTJymnB6mRsXwbH6dWFInaXJouiQI6sKRgwAl
         QLIJVH2lgjWPfg+J/oKQ/jRuUZlvYgcXnfTRdkMwYQj44yMkASlNtFm/2f2DcJftMB1k
         ArzADVKScZYfRiw21TgWqOMmdS3Ux/xHLp7GQ1c5psj1EVoMcPbbVJCtIKdfdlQk44DJ
         VXvA==
X-Gm-Message-State: AOAM533goHL6HKh7X2a1HiP2nTC3W27L2XHCRvYLRI7sBGGna6X/pgfq
        +hIvrSFNGnMfwOSYBdMWououJ6kU0Q==
X-Google-Smtp-Source: ABdhPJzvFgF0rdegvhuQuQN0VTaHMD+mkgyRbm/qcieGt8GT8s/5GRC4K1MdoZJ+46/yeYCuwAF3Yw==
X-Received: by 2002:a05:6808:218b:: with SMTP id be11mr169423oib.80.1639697494978;
        Thu, 16 Dec 2021 15:31:34 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id n11sm1256646oor.9.2021.12.16.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:31:34 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 6/6] cacheinfo: Add cacheinfo_get_cache_affinity() function
Date:   Thu, 16 Dec 2021 17:31:25 -0600
Message-Id: <20211216233125.1130793-7-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233125.1130793-1-robh@kernel.org>
References: <20211216233125.1130793-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a cacheinfo_get_cache_affinity() function to retrieve the CPU affinity
mask for a given cache identified by level and cache id.

This is needed by Arm MPAM to get the CPU affinity of MPAM enabled caches.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/cacheinfo.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 37652cfdd8dc..5e72420cdc75 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -123,4 +123,28 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 	return -1;
 }
 
+/*
+ * Get the CPU affinity of the cache associated with @cpu at level @level and
+ * with identifier @id.
+ * cpuhp lock must be held.
+ */
+static inline int cacheinfo_get_cache_affinity(int cpu, int level, int id,
+					       cpumask_t *mask)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+	int i;
+
+	for (i = 0; ci->info_list && i < ci->num_leaves; i++) {
+		if ((ci->info_list[i].level == level) &&
+		    (ci->info_list[i].attributes & CACHE_ID) &&
+		    (ci->info_list[i].id == id)) {
+			cpumask_copy(mask, &ci->info_list[i].cpu_affinity_map);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.32.0

