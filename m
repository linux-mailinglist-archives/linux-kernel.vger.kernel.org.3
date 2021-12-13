Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D28473797
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbhLMWeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243629AbhLMWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:42 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02BC061201
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id l18so11083150pgj.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H18NXfK/bjqmSrlgsrOjG9VSgAOPaQTZdlxtzpyzsKU=;
        b=YK9Rp9QUr5GNXLR/LrK9JhjX0JHk8f2RdWEXjvqR7Kt7PYX4IBVWFsmJLncA1QLbpl
         G9rcYMoGKaYeOteZeN/RAczvlvnTWzetUGxsOnh95Qo+JAgFlri+SZ42zcQ/uQH/Ecdz
         dd/5eG6IrZNananuc+wLz+JCdTfjHrBOLGrPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H18NXfK/bjqmSrlgsrOjG9VSgAOPaQTZdlxtzpyzsKU=;
        b=WWZAWZiiMzeXMD19bdutV190k+Jd3eckSDg13/N2eY7+WFU0dN2pypj5qcuRjr8MjK
         skEtKkuERzl4uv41m7koL0pcIkPCCGUjXK2u217WUGEHIYmHiJvX+DMyLWenMaehO9/L
         4LJ57bQLQrbJW5VpfZtHq6P6CWcJhWyhvwNWqs3mgeKYCotNOvPHWFYuT9hKE23yuqsF
         WVs+/VoRUjwq0Tm+/TZKCkgPEGSu6U+Fif9DKtlSAWljBaqtCbQFYjnmO51DDBcHyH6e
         YNQjmwMbSgenTMEz4X0upYpT8xoSOh4m7IuWCo2LmIELpd6FefPRj3a1rNgLECs/NHZk
         iX1w==
X-Gm-Message-State: AOAM533W8msr5lC4/h0l/Bvyh1LTzDR0wlgi5R4Xk4tmVr0bzREelKLO
        +/bo6BqpNtG+Vq8BcG4wNhBRAA==
X-Google-Smtp-Source: ABdhPJz14xIXX2kGfXl8gyTxbCTpoifJhXNd0GGbEO4+OpopT3ZSB0VqAQQANM5PEykiGhDNwF365Q==
X-Received: by 2002:a63:2c8e:: with SMTP id s136mr1007041pgs.431.1639434821443;
        Mon, 13 Dec 2021 14:33:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19sm13874418pfc.145.2021.12.13.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] IB/mthca: Use memset_startat() for clearing mpt_entry
Date:   Mon, 13 Dec 2021 14:33:28 -0800
Message-Id: <20211213223331.135412-15-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=CV20v1MQywYF1pj6PK6kDL4NryK+fx8i1kaxeE/OwZY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o5w0TL2V5kLLzewuU+wu+r1+X368UfQYM+9S1i XMpTg/WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKOQAKCRCJcvTf3G3AJr7ID/ 9mkrNCeI2WFCLh079AeP1+U5QNSmbqnVVSdFsaQDiX1da0O0vzJBjpHdHvSKNabcKXR/qOCVGIjiYH hihMd1my8FQjQOejGolDH1/9D19C4Yjug7wYxWEPGmeez/bpDkD/lBQ0t43rdGVm6Q286+0oSi/s7K gOt5oheZoRveZDWibbq/Tl7WQA9ysGrSdKpZmRiV92W9+cZq98dDWmuG79vGin/OjNnArcy1UK+rSk G+LYNm28IBh8LGag/brGRStXhvEsEi41YvRvrIw3GX77BT1wj8aNKyaQiIL+36UtpelTOy+XpEi9ol TQrkNJaZzqz+N1nNQS74wWibegWSyNPkalXaHJ3+PcqWFLVbnvPzjFlTabIs985nUSGkhBxmvA2cCc 82PUBzdztKLjKatMywXaf8Ro2+obpnZKtotAC3so1oD+USjYfRhZ/sOVkjzj9mN1MTyXWF/MKPBHJN UqQOXE+Mj9jfnLVYBbj54QFkshXXY47TkukQFrlpd9UHjIiShHMTZLWS48MAEOa684AufNY9E7NKFH 1D3jzgKTxFf3lOUSLgHCe0Wa5xT/BtJJBKXllSJQDKFdUcUGXxh75Df1Eq+oin+igUmudrGrsMCzIz fd3d/QmBG+2db0DT7uNCjBiGh3/8tRV/0aCrCbXOckjyjYxkEHWMCwRy/waw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mthca/mthca_mr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index a59100c496b4..192f83fd7c8a 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -467,8 +467,7 @@ int mthca_mr_alloc(struct mthca_dev *dev, u32 pd, int buffer_size_shift,
 	mpt_entry->start     = cpu_to_be64(iova);
 	mpt_entry->length    = cpu_to_be64(total_size);
 
-	memset(&mpt_entry->lkey, 0,
-	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
+	memset_startat(mpt_entry, 0, lkey);
 
 	if (mr->mtt)
 		mpt_entry->mtt_seg =
-- 
2.30.2

