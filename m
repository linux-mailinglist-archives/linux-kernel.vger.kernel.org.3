Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD24462CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhK3Gpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbhK3Gpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:45:51 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674EC061746
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:42:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u80so19580981pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvByH85k2GhB0gfAkNHfHQT5cnwP0kCymtjlqEmdVEg=;
        b=rP2XIR3SzL0k9UD5LzqH+maIwpmypopDDn1/s7o6aJmnQ37C5OcSmZtlLBvGgWJcCd
         vFhOzv1iDCXGhscwnSqOV2e9LNuFCYmeveIEHJbCB/Sh04hzCHkrQ9I3LZFX6Gjl4NPG
         zV5SZuBx/pIo+vA4NzXYw0VrVyBJOAjZu8iAfj2BbU0/K4vL4e+P91LjeT3gfS5PrsPk
         uoQy1BPdSB2b3Dz9tCzOIn6dq03GYyorwPk3fzKzokhve5HtVOMmP9Wp8agZ42O6br8d
         ACWNPFQBDN4pabVExFzoi+uDIZrKzDHDETW5lkCkLhEewJ7f/9C8oUOX1oWy/zszSNRW
         c8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvByH85k2GhB0gfAkNHfHQT5cnwP0kCymtjlqEmdVEg=;
        b=6kxj48v7lwi7XPAEk+Kr5qWB1T11ZRe2tuzoZ7ejq4+1c/rQ68rTR2Y+H4wFLmtipV
         EPETNwxP1PtGCeIG4SWbwgEOTKmuLRG+tohdsAs+piJCLksXZldrJUCWxgaznwn78tJO
         jHZuxP7J5Z6+1yIClPAGig6fCYB0Epbz3K6G3v1orQajk9vBtR9/fFuPMG7Rolla9z+l
         Ef061uX/77LHvfcXLNQq/lzVPqH7zcWzc5FN0/rERYSs1mLSYSk+oXrcpRSB0GZ+XwIe
         rF7UR1apWbfCDs2gtY5vDa31iw91QadNTW85ShmNift8ZuJoItrthoinqxdXgld0yLlc
         Z+/w==
X-Gm-Message-State: AOAM530ROnjuLGgALrOJowgubh4sH3YpCMKyHPWX2Uiq2+gB4Qwqep1e
        va1mlY7/OxQKXPjCg7Ed4a6rh8bKov1u
X-Google-Smtp-Source: ABdhPJzyr8nxGH+zQ/RuB47Y7mPcsgB7bQfz8SJ2nSbYjceTWZnsTbpIwiJmSvc4z146UCWg4sW00w==
X-Received: by 2002:a65:5b41:: with SMTP id y1mr38857743pgr.481.1638254552633;
        Mon, 29 Nov 2021 22:42:32 -0800 (PST)
Received: from localhost.localdomain ([202.21.42.3])
        by smtp.gmail.com with ESMTPSA id d19sm19683993pfv.199.2021.11.29.22.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 22:42:32 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] PCI: qcom: Use __be16 for catching cpu_to_be16() return instead of u16
Date:   Tue, 30 Nov 2021 12:12:15 +0530
Message-Id: <20211130064215.207393-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_to_be16() returns __be16 value but the driver uses u16 and that's
incorrect. Fix it by using __be16 as the datatype of bdf_be variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Modified the commit message and subject to describe the actual issue
as per comments from Bjorn.

 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1c3d1116bb60..ddecd7f341c5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1343,7 +1343,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
 
 	/* Look for an available entry to hold the mapping */
 	for (i = 0; i < nr_map; i++) {
-		u16 bdf_be = cpu_to_be16(map[i].bdf);
+		__be16 bdf_be = cpu_to_be16(map[i].bdf);
 		u32 val;
 		u8 hash;
 
-- 
2.25.1

