Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6167D476B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhLPINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhLPIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:12:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6BDC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:12:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso105073pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mt6qH9wg2HiNJp3oZFCB8NuLQwRDayptPKArDcWgPjQ=;
        b=XxvU683CzxpeCViTlb+8YUPdNVyjUhP2ATrxWO5RVkK+ReVlW5oDZy2uIXwloIoiki
         L90QqWViEiXk+3ypfAk7fHjjzqMFuWlrzwnDgC/79dwxp9NigIqX+tIyTufl4mN19mrw
         RXz7M4gr447nO3pugOGCYtZGkM6bCpJBtwVW263NICMGrhAhPb7F193yHLRu5Dh48QT8
         eBk44QKiI1FJ6gs7qbYQGZbA/g2iIedxWXJxPOAQPoIl7vWIDVHx5gY3GHn797LzPCU5
         6GGiy9XhWZYmtMYBv98jetUjjIXYumySF0wr2Y8VQdOPSM5V8qMViGLuiEUZ7O8rMNuL
         cF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mt6qH9wg2HiNJp3oZFCB8NuLQwRDayptPKArDcWgPjQ=;
        b=k2dTwEo8RpKs6JkoS2Ssnd6C+kWAK7+d6Qu2VVxKGMb2ZBllBX0XffC3QNGpu96Mut
         +LuOXyI1Pg11f2wPrRsRsid7rpuyYzS6aoJD/paRnlY/NRVjOPddBDiihtXtRp4K8v/O
         a0A+DXnGs1uf7PUvTB3hQpvd7HsRUqeZBrtU3fiVPFLW/rdEpKZYh76c3pywcqRMgdGc
         wgqswhhzLbny4UaewaPPxwJnFU+dBPeRd5OU50+UI20xanhhWlmofS3lsONFRBsyZmSZ
         96RNE7gWOTSQYogAeAwAv0fSOWYmmwYYXPOC/cXb8eez7ClwCCl8NLauQuM4YasIH4ZF
         V/Dg==
X-Gm-Message-State: AOAM5327MlyUUaVAMvgS0pQy31WYmdP6A9tRbAyXNnFVBMrBI5eBnrVB
        ZIrB8EHEWForioA/THjn53eQ
X-Google-Smtp-Source: ABdhPJxBbjQVhIe6Oqwp4R18GBDQ/XJwTfPGwhPzRT792+Gr8WDNRLDD4vO/3L0WMGMErUs+IrQ5pw==
X-Received: by 2002:a17:90a:7e10:: with SMTP id i16mr4623303pjl.185.1639642379034;
        Thu, 16 Dec 2021 00:12:59 -0800 (PST)
Received: from localhost.localdomain ([117.193.208.121])
        by smtp.gmail.com with ESMTPSA id u38sm326835pfg.4.2021.12.16.00.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:12:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, thomas.perrot@bootlin.com,
        aleksander@aleksander.es, slark_xiao@163.com,
        christophe.jaillet@wanadoo.fr, keescook@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/10] bus: mhi: pci_generic: Graceful shutdown on freeze
Date:   Thu, 16 Dec 2021 13:42:19 +0530
Message-Id: <20211216081227.237749-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216081227.237749-1-manivannan.sadhasivam@linaro.org>
References: <20211216081227.237749-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

There is no reason for shutting down MHI ungracefully on freeze,
this causes the MHI host stack & device stack to not be aligned
anymore since the proper MHI reset sequence is not performed for
ungraceful shutdown.

Fixes: 5f0c2ee1fe8d ("bus: mhi: pci-generic: Fix hibernation")
Suggested-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1635268180-13699-1-git-send-email-loic.poulain@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/pci_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 94d8aa9c2eae..4f72bbcc53c9 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -1021,7 +1021,7 @@ static int __maybe_unused mhi_pci_freeze(struct device *dev)
 	 * context.
 	 */
 	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
-		mhi_power_down(mhi_cntrl, false);
+		mhi_power_down(mhi_cntrl, true);
 		mhi_unprepare_after_power_down(mhi_cntrl);
 	}
 
-- 
2.25.1

