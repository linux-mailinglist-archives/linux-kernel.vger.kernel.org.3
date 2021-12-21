Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7C47C774
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhLUT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbhLUT2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:28:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8BC061574;
        Tue, 21 Dec 2021 11:28:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so65002wrw.10;
        Tue, 21 Dec 2021 11:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=54zGxX/pNsFEGTRMffzqOdT320nhaq4iFU14GnCGm74=;
        b=fn4lwmVZp4pFH7HMXYHkCiMzn4ZY5ocaXBGnRkxGKfS5xJaDTkQJoy5jvBFH4QSsHl
         G5WANlWXCjg+je7jq6HLL/klgNMTshet2t5KGTVt+TtiyqAuLWSwmLBnd5nuXFnvMDzy
         d4G45gJnFOdZGo/i8eNCCLPJkCYLFwK3eQJXq3wJlb5RSmsyln4g+6zS0QqqhOStpnU4
         cMLkQ8eEpOwgDzLZ+aVsqdH3wWHKO6U2usdnPxDUTuKQE//OhEIdjytKDZH7C3byf4P/
         sjo4uLqyZCupP9RP2H5lVWnIQIzMjc/bWe/P5s6kO+n/AN6fPV+/59s2SZ+uOlbDL/p+
         gmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=54zGxX/pNsFEGTRMffzqOdT320nhaq4iFU14GnCGm74=;
        b=SZRFPmKQrxjzKO1wL1DgD6jUhT3Pwii3ujvvm4WsvrgnTLH48VWyLa+6FJhKiBlzJ0
         i8F5tr9Y2hlPDuqND1DGw5CJVzb0wiwOiyVCP+sVBkGp+cYpL6srEmRcyfeh3Y+fHhmF
         H5Ia23JsXR6wmbhpLdq2a6I7LpUB7CkZ22sNtaytE2vp3mHGu4+uKld564ga+WBVF6sg
         uO0Gix8ydzLtgBgxsb96eKk9+jY7XWxqrZhu5YHmgiI4HfHMuIz91JpNOAovUb9Smz6Z
         5Njbmd/IsGhmNAcqLTCqKOYOzQsZKaDFz1GULA4f7udIYNokRdKoF6mriK7upqT8QnMi
         XrpQ==
X-Gm-Message-State: AOAM530ffsFaayCSfviWYPl5STwbeuem1GVW4xc4PFCYgsdt/HFIQSQn
        laJ/dQdLjC8VXc7Dac0PVS7b++cBuE1eA1q0m0C2gw==
X-Google-Smtp-Source: ABdhPJxuy0ZSllptPGAgjF64vL/b0YoqDQJMy6qH3aN6fJNHc0URALfBDwbJnVyvoUiZYFWSnSd9oQ==
X-Received: by 2002:a05:6000:1ac6:: with SMTP id i6mr3691896wry.373.1640114884119;
        Tue, 21 Dec 2021 11:28:04 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m35sm7942852wms.1.2021.12.21.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:28:03 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Airlie <airlied@linux.ie>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] via-agp: remove redundant pointer current_size
Date:   Tue, 21 Dec 2021 19:28:02 +0000
Message-Id: <20211221192802.636630-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer current_size is being assigned a value but it is never
read. The pointer is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/agp/via-agp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index a460ae352772..b2f484f527fb 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -128,9 +128,6 @@ static int via_fetch_size_agp3(void)
 static int via_configure_agp3(void)
 {
 	u32 temp;
-	struct aper_size_info_16 *current_size;
-
-	current_size = A_SIZE_16(agp_bridge->current_size);
 
 	/* address to map to */
 	agp_bridge->gart_bus_addr = pci_bus_address(agp_bridge->dev,
-- 
2.33.1

