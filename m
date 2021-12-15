Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9C476238
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhLOTx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhLOTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:53:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:53:57 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so17431491plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uI745U4+tijxHRrdNv+E9RurYiXFIl/j0Ykd948eOXA=;
        b=AC55aZq0qPSLyCbNfol6zr0AjlmFKvC97/iz6P38ZpQv/P5UOBNjVYmvCvkZ4m6E4z
         3TkIMdaJO0nPp75Vny0xNVhJ6Mt/r56jyk1k8Yuni8aLz3bSQ/4IjOPDe+D/EB5DqaYk
         BgoMztVkAXE6d+V6OR1/zUUqK8bwC+TZByNwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uI745U4+tijxHRrdNv+E9RurYiXFIl/j0Ykd948eOXA=;
        b=Fmm8r0NrLUffoIjAi4mtMVWTpT4NiqtIKXp1IxP5/Tt4jeIX3a6jkG5OsMFwvfLsuL
         e6SG+sRwkquALKXg9EAMdRX3hIS1v9N6jYDxvKxDDRu3O9gPeL9gleA7zm4ppkhYJXR1
         OAeL7dXdv6GXMEOwTvM/ufuLlkLWdb9Lna6ZpOtoHg+XRiH/FrnvDMuay1EDUnNE9Wmy
         e4l0WGeIdcwO3kYH0X5/SI0dcfSdM1NS0lJrDGzaxTfODyx5yp4GcKgWdYaXe05pBcuJ
         xluk6uOIPpm5YNszc28F9dYDrMpIhBhywpF6RwL2+wnCj/hhXyru+iIG39CXhPP9BoYs
         7g/A==
X-Gm-Message-State: AOAM532IqjmBbMEhdQliHROM710FpJzgP3Qp8egHOtWDDZKh8+XBeRIy
        0Q5NQKm5BIvXcYJaKEx6gsb4pQ==
X-Google-Smtp-Source: ABdhPJz+a8zE1EYyKcAIxba96vnqFNqWcq2auV4ghQ6zcTwva9nJam+B6XHq6hR0kirwyVaQaaLLTA==
X-Received: by 2002:a17:902:e812:b0:148:a2e7:fb48 with SMTP id u18-20020a170902e81200b00148a2e7fb48mr5846300plg.137.1639598036627;
        Wed, 15 Dec 2021 11:53:56 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:6c0f:9060:1bc2:315])
        by smtp.gmail.com with ESMTPSA id r10sm3149313pff.120.2021.12.15.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:53:56 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3] of/fdt: Don't worry about non-memory region overlap for no-map
Date:   Wed, 15 Dec 2021 11:53:54 -0800
Message-Id: <20211215195354.634746-1-swboyd@chromium.org>
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

For example in sc7180.dtsi we have the following reserved-memory
node:

	smem_mem: memory@80900000 {
		reg = <0x0 0x80900000 0x0 0x200000>;
		no-map;
	};

and the memreserve injected by the bootloader is

	/memreserve/ 0x80800000 0x400000;

so the reserved memory region overlaps with the no-map carveouts and we
get the following warning message printed at boot:

 OF: fdt: Reserved memory: failed to reserve memory for node 'memory@80900000': base 0x0000000080900000, size 2 MiB

Everything keeps working, just the no-map property is being ignored in
__reserved_mem_reserve_reg() because the region we're trying to avoid
mapping has already been removed from the memory via the memreserve.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Quentin Perret <qperret@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already reserved regions")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2 (https://lore.kernel.org/r/20211215072011.496998-1-swboyd@chromium.org):
 * More details in commit text

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

