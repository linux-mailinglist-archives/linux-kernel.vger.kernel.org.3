Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E373469411
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhLFKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhLFKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:47:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B73DC061746;
        Mon,  6 Dec 2021 02:43:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso10041127wms.3;
        Mon, 06 Dec 2021 02:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLASlUtqj3rgHKOjIchiYlRgvNvxvaJfqetirWbBQds=;
        b=FWbm/rktWpkICw+G9X1z4X085uaf1VUMHvcX43kleWSsPsg+7DmfA4wU4ncxEN+IYi
         KKTaNCPcg3a8+kEXb0dew2HhKGxpiJ9AgAEyW2J5QRQqmDso/mpcmxNfLhQJFEOplM+p
         Kk2NFG9BentIlzJfKygAuxFEoL+DXLZSlw8GcZ1zpI7MhmQCFEjzIcQA6XSaf9yeAxGc
         qnLU55fpTveCWh+vVBEtZSdgozpDkKvHhHBzDyk2QgGFH+1lcBCYc/Ay3tjSnSa32FSj
         vLIGGRtDCONfPzo0nJjhSq+D4FO27BuF6CTSZoHczPYtTpLjeujDOZSTCDELlEe840ei
         1uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLASlUtqj3rgHKOjIchiYlRgvNvxvaJfqetirWbBQds=;
        b=qLrEC+nJel+v1nwiT758bLPmySsrTpMFgSY4fcudV6blqdIAaTvVIwdsbmkDR1rFt2
         3sDeacvyiQFBBhbkqLPifkp1o9x4R+AtNlwYhA/MasZvkOaYssjtn57wBUeC8azAajy5
         Y8GckaseILJQ9pM6wEF3wcNz0xGKxkpNQZ4goa/ftNPgHWWlUYHU1SiMMO/SqetayFI1
         Dq/VLgr+j6vJ28pyPv+YZE5nls8GVw2nXIAx3rZFY1ZKop4chQRRLHOHXn9fXpJ1y1Y8
         6gZ9SWaGA8ciNqgC5HluCX/aIMGlOJuQqMEhGfIakHD7Xn2dNxdfqptfS7R2QosQGEQr
         CVkQ==
X-Gm-Message-State: AOAM5315AMhAd4thqTxOntSdvnrafHpvF1kr3RfPeRqYjxrVmUOvyj0h
        Xdi2U8qsh4TavE4UcO/4XpfysQ8+4h5jKxsQih8=
X-Google-Smtp-Source: ABdhPJyhrnCZ2KqH3XdtbSasyT8NEE+1Mr7Evy0FLi0y0mhdS+UZgSTNt8QZ+DE9p8pe8igP5ILRUQ==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr38057982wme.72.1638787413632;
        Mon, 06 Dec 2021 02:43:33 -0800 (PST)
Received: from localhost.localdomain ([39.48.147.147])
        by smtp.gmail.com with ESMTPSA id l5sm14032106wrs.59.2021.12.06.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:43:33 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     kieran.bingham@ideasonboard.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        stanimir.varbanov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amhamza.mgc@gmail.com
Subject: [PATCH v3] media: venus: vdec: fixed possible memory leak issue
Date:   Mon,  6 Dec 2021 15:43:15 +0500
Message-Id: <20211206104315.12516-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163878547435.2211244.3536763956780138208@Monstersaurus>
References: <163878547435.2211244.3536763956780138208@Monstersaurus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The venus_helper_alloc_dpb_bufs() implementation allows an early return
on an error path when checking the id from ida_alloc_min() which would
not release the earlier buffer allocation.

Move the direct kfree() from the error checking of dma_alloc_attrs() to
the common fail path to ensure that allocations are released on all
error paths in this function.

Addresses-Coverity: 1494120 ("Resource leak")

Fixes: 40d87aafee29 ("media: venus: vdec: decoded picture buffer handling during reconfig sequence")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>

---
Changes in v3:
Updated description and added fix tag
---
 drivers/media/platform/qcom/venus/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 84c3a511ec31..0bca95d01650 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -189,7 +189,6 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 		buf->va = dma_alloc_attrs(dev, buf->size, &buf->da, GFP_KERNEL,
 					  buf->attrs);
 		if (!buf->va) {
-			kfree(buf);
 			ret = -ENOMEM;
 			goto fail;
 		}
@@ -209,6 +208,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 	return 0;
 
 fail:
+	kfree(buf);
 	venus_helper_free_dpb_bufs(inst);
 	return ret;
 }
-- 
2.25.1

