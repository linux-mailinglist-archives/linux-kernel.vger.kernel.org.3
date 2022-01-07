Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F51487D35
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiAGTmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiAGTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:42:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38417C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:42:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ie13so5969837pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtmOkm4tlorzaHKca2qCjbfJUGmTbV7oQE7a1RCVjnQ=;
        b=SzLGEciYFtDUqG0heQCE0I8BuYSYDrYh08RlREgf2NqK9x0kL8XVBFrV1521AeOztc
         fjmgoSizkszOWbqcvZiJMS7GCJQr5z0eSh9cuAkROyvzTvEzLy3F0YXdwPOvN7QAb9+o
         VFrzDo0GBIMd54U+Kt0Q+tPFSJN2UUnw9zbBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtmOkm4tlorzaHKca2qCjbfJUGmTbV7oQE7a1RCVjnQ=;
        b=oSeC4UpNbfPte476/QqEmx/zTYz/k4OGShl/42mxl7wRqMgdmpiOqrGK2681CVGrOp
         atDzXlQFfpIvOIMWLGn/Q7p3Hjr8gSCBbe7rqM0NHmNQtSNuIjWihyuLGlITJfAYrNUY
         GViox6qUk/gzRto1GnCq8iNC3znHYGR21XUHflMtiT5/5YpR1UQ6ASLumwbEJZFirctw
         S5cqYd3nUY0nJW+0osoER9Sb9MBx6PXwNgnznFRgjE4B1Tyc+mTnm+Pq7doPQ9e5XvSX
         U49zZfLLEqaPN9fyS3OddVn3BjfGy5J9FebdJML5qGizVatSVaIthlpJgJd9wI/CtkRv
         /lhw==
X-Gm-Message-State: AOAM531ZnUyMO8Nh1+FH9lFXR3T717F7LimmmfoAt7+V2cEIT+rLOgJK
        vTF2whrZ+1f/3l3oRo1LQFfxJA==
X-Google-Smtp-Source: ABdhPJzSTiUPr9SUuX9KKQvrIOo/qmgbJ8HAJXDpHZypFVkLKqzgmRsc+d9f/GH8JVtn4UQn+tbn/w==
X-Received: by 2002:a17:902:bd05:b0:148:a2f7:9d87 with SMTP id p5-20020a170902bd0500b00148a2f79d87mr64760796pls.166.1641584557727;
        Fri, 07 Jan 2022 11:42:37 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5681:18f1:24f0:d55c])
        by smtp.gmail.com with ESMTPSA id j20sm6294327pfh.22.2022.01.07.11.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:42:35 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v4] of/fdt: Don't worry about non-memory region overlap for no-map
Date:   Fri,  7 Jan 2022 11:42:32 -0800
Message-Id: <20220107194233.2793146-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
already reserved regions") we returned -EBUSY when trying to mark
regions as no-map when they intersect with reserved memory. The goal was
to find bad no-map reserved memory DT nodes that would unmap the kernel
text/data sections.

The problem is the reserved memory check will still trigger if the DT
has a /memreserve/ that completely subsumes the no-map memory carveouts
in the reserved memory node _and_ that region is also not part of the
memory reg property. For example in sc7180.dtsi we have the following
reserved-memory and memory node:

      memory@80000000 {
          /* We expect the bootloader to fill in the size */
          reg = <0 0x80000000 0 0>;
      };

      smem_mem: memory@80900000 {
              reg = <0x0 0x80900000 0x0 0x200000>;
              no-map;
      };

and the memreserve filled in by the bootloader is

      /memreserve/ 0x80800000 0x400000;

while the /memory node is transformed into

      memory@80000000 {
          /* The bootloader fills in the size, and adds another region */
          reg = <0 0x80000000 0 0x00800000>,
                <0 0x80c00000 0 0x7f200000>;
      };

The smem region is doubly reserved via /memreserve/ and by not being
part of the /memory reg property. This leads to the following warning
printed at boot.

 OF: fdt: Reserved memory: failed to reserve memory for node 'memory@80900000': base 0x0000000080900000, size 2 MiB

Otherwise nothing really goes wrong because the smem region is not going
to be mapped by the kernel's direct linear mapping given that it isn't
part of the memory node. Therefore, let's only consider this to be a
problem if we're trying to mark a region as no-map and it is actually
memory that we're intending to keep out of the kernel's direct mapping
but it's already been reserved.

Acked-by: Mike Rapoport <rppt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Quentin Perret <qperret@google.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove already reserved regions")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v3 (https://lore.kernel.org/r/20211215195354.634746-1-swboyd@chromium.org):
 * Even more details in commit text

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

