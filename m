Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE33476670
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhLOXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhLOXYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:24:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD13C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:24:34 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id m15so21363630pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayBO3fheqltGpQuWWy/ylkJKTwFSYRcjXfWCB08z91I=;
        b=jqteNayx6//raCiQTS4nAXfjev6anJEbYPoCILHayKrjHpgTJGAT2R1MELBRXXqoHB
         YpmZc0iNX4O1z50B684EvtfRqiYuQ+0WK56Y49DoxTrJliTE6tSkBl0HXXUStxYLr1LY
         PMEUdOHfdH5DC0fpHxdu0tHnDV89ly/jSI22w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayBO3fheqltGpQuWWy/ylkJKTwFSYRcjXfWCB08z91I=;
        b=1JUahBK+16bFZSP32r81Au5UWUUE2QJkhzzVv7cpQuy+vDOAduJItac7+oGK5bYj82
         8MIcgcjEVC6LAJ6mu1KCUYEuxSWsJD3vaH2ZSBqKgJgUSplM/QgkBDV9rvPUBCFdILiK
         XIujoCYoivp7LXaVyCoBuPtQw7lGrhqlWiKX5rG24/QHcl34j5Jqp8idQQyrtb4MYiD0
         8fpkBD7jI1WeC3iZkl2q4Ny5b8qaUxRsuYn4fBs4ZyUNMNQkUUXxFT4m7aWXubPrI6GT
         ysNMnQFPMcvGZ41q0ruxSIlcU2/bYeWzQp6tWaffN3mIa24Q8FOIbKrrdwGSJQEN6k+L
         FDnA==
X-Gm-Message-State: AOAM530zSo35M1d8LRNztetTKxVQD8VHpxiK0+E5TXeAIQ65dPYSgWb5
        kWNH2T0nl1I0t87uXy2RWPLs/A==
X-Google-Smtp-Source: ABdhPJwrZkD0iKdINA4QR7VSHJa604alVBLeOr1zMA+cOIjJtV0eFPZKqX9zwyo/2NvOHdJ9J0GPYQ==
X-Received: by 2002:a65:4889:: with SMTP id n9mr9635992pgs.303.1639610674215;
        Wed, 15 Dec 2021 15:24:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm4157129pjr.57.2021.12.15.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:24:33 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] iommu: Use correctly sized arguments for bit field
Date:   Wed, 15 Dec 2021 15:24:32 -0800
Message-Id: <20211215232432.2069605-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; h=from:subject; bh=DHxJ43DwsvodL9fr243QH0FkW2/Hzca3VP7CBqjLMoI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhunkv1AK+0eSVn76RoUsVTovgFFDeNYkloZE8C4IZ Y+Eh7buJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbp5LwAKCRCJcvTf3G3AJv24D/ wL8hOVWaupn+8pSw5h5luG10DqIeT1kD2UWy3//byDHbeVZsw/Kb8liFDJLwAxS/t1ElXINwmH0r9W jjdJhYm1/FxF2FIF4KORdBXP9NaUtVU3ce+Tdb9OFOUg6LMyU8BPdEBzzMhUrrgTYS8jjbBtJzTtv4 qCUKzNby6lLTH4YMC+ClGdcpk7WySgsjuC71f5dvcVLuyoFLFOpbD6vqpxIcWtCElfE/sdKIVD08SS WwxrfVSWzTWwKe3LOU5Cc9szQBXZvqORZkTI/PlVDpWB5YNYTYjo538m0T0H6gci+Xz1bp8/qBWKIq xuNEb4PbJCWCYk6Zt/RFwAqF6uG70vCTppiJ3JTL3YpcsuX66gNgSEZhzuA2QMJfdXYqkJ7c1nlDGw 6jx4eNMDfwZqR6Lcf239ftgHck7jbgjBYEmtm7MRdwj1mkc7V+QQaYRaElX0Wk65nIjJQ2a++urkCn t0Y386EjikhGtvRcL/Wo0b0DmhSyBs5j9TZ82oOE7GfvwEX0dcRnG0F4Gdb78Kyufa9j4osv8K9+NI 8uTAlm00UChCMAZyqKxXHvFrmjlwpTPy60+q3ylWsuEkgTVSw5B1O0n+kMhmgdeEHEnXhnOiY3HTAk xvWz+OkATj9r1TGDfrSvJvhJFLiufZc6c9PPgdcyYVmD66B8j0aS6iUPW9Ag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The find.h APIs are designed to be used only on unsigned long arguments.
This can technically result in a over-read, but it is harmless in this
case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
which we'd like to enable globally:

In file included from ./include/linux/bitmap.h:9,
                 from drivers/iommu/intel/iommu.c:17:
drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
./include/linux/find.h:119:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                     ^~~~~
drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
 2115 |         int pds, max_pde;
      |                  ^~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b6a8f3282411..99f9e8229384 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2112,10 +2112,10 @@ static void domain_exit(struct dmar_domain *domain)
  */
 static inline unsigned long context_get_sm_pds(struct pasid_table *table)
 {
-	int pds, max_pde;
+	unsigned long pds, max_pde;
 
 	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
-	pds = find_first_bit((unsigned long *)&max_pde, MAX_NR_PASID_BITS);
+	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
 	if (pds < 7)
 		return 0;
 
-- 
2.30.2

