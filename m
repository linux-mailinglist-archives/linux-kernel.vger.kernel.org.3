Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA03475396
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhLOHUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbhLOHUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:20:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:20:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g18so19918806pfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOkgZnYw6kGe9a36s49H+b7Q/uyCAsopsbeYrhXtAvI=;
        b=Glb79vzuvbbH5nTBEPKrc47DssIU1jb3cDm1iK+jGOu7M/7l+E5meR0RI+SIYW5SmH
         ezs58ymRq8FfXKrTh90YTUkIX0PUjtM6QJLRcPYjcaCIVTNAA/XyYkHV8sALsv5GhvPg
         B6JtjfHGzZo2dJx+sXgSDwGHCrP4zRSrnqZsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOkgZnYw6kGe9a36s49H+b7Q/uyCAsopsbeYrhXtAvI=;
        b=1di01OBCXCJTkKYToJkY9eMhZ/Hlelh7oDRrvRZpWS/QdX5ZVvNUnzRsJpruQckhf+
         92+teYqL7bbxvcKwnSq0w3JYkghFqkUFmO2sKlnKgeqjF1tp3yY/bazZcxoSIba9vN5r
         eKsZJDM8jpr6uYXbEgK6JHm+aLIVgvhzXk5+qbgi59cPzYFnR+Upj+wmE1rjAWh7FNBr
         miyCCfyGjaETjh1bF0MYFKS4XmAnQt1QpfV2alTh4hCFc9F3CgQy+c+yZpm8MdynISlU
         UTRo+OFYNBYKWTzdHghxCcYhu+hI/vy6asRlUGjNbl74QsDkiFJGWmCV650ZJaEs6oUw
         L3wg==
X-Gm-Message-State: AOAM530Tm4puGEAHO9RWZsM7zltqpYHUveUpcwkGGL5TUCBtJfOcoI4U
        T5O2TTIvwj9iBTReUwEpC62ZqZmTmDPlbw==
X-Google-Smtp-Source: ABdhPJxybBG2WjOl3dKpIIJmd34vozfkMrI3qpBePO3HvTg1G1kvYqOD6D04UsrXyzbSJvjR7+JTww==
X-Received: by 2002:a05:6a00:22ce:b0:4b1:39d2:bc7c with SMTP id f14-20020a056a0022ce00b004b139d2bc7cmr7895685pfj.27.1639552813727;
        Tue, 14 Dec 2021 23:20:13 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:46aa:90e5:f847:f509])
        by smtp.gmail.com with ESMTPSA id b9sm533214pfm.122.2021.12.14.23.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 23:20:12 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] of/fdt: Don't worry about non-memory region overlap for no-map
Date:   Tue, 14 Dec 2021 23:20:11 -0800
Message-Id: <20211215072011.496998-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
already reserved regions") we returned -EBUSY when trying to mark
regions as no-map when they're in the reserved memory node. This if
condition will still trigger though if the DT has a /memreserve/ that
completely subsumes the no-map memory carveouts in the reserved memory
node. Let's only consider this to be a problem if we're trying to mark a
region as no-map and it is actually memory. If it isn't memory,
presumably it was removed from the memory map via /memreserve/ and thus
can't be mapped anyway.

This silences a warning seen at boot on sc7180-trogdor.dtsi boards that
have /memreserve/ populated by the bootloader where those reserved
regions overlap with the reserved-memory carveouts that we have in DT
for other purposes like communicating with remote processors.

For example

 OF: fdt: Reserved memory: failed to reserve memory for node 'memory@80900000': base 0x0000000080900000, size 2 MiB

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Quentin Perret <qperret@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already reserved regions")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20210520012731.3731314-1-swboyd@chromium.org):
 * Use memblock_overlaps_region instead of memblock_is_region_memory()
 * Add more details to commit text 

 drivers/of/fdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bdca35284ceb..c736e5bcc2f6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -482,9 +482,11 @@ static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
 	if (nomap) {
 		/*
 		 * If the memory is already reserved (by another region), we
-		 * should not allow it to be marked nomap.
+		 * should not allow it to be marked nomap, but don't worry
+		 * if the region isn't memory as it won't be mapped.
 		 */
-		if (memblock_is_region_reserved(base, size))
+		if (memblock_overlaps_region(&memblock.memory, base, size) &&
+		    memblock_is_region_reserved(base, size))
 			return -EBUSY;
 
 		return memblock_mark_nomap(base, size);

base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
https://chromeos.dev

