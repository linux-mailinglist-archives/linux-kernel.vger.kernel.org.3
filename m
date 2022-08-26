Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9495A25F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbiHZKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiHZKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:38:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF97DD5993
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:38:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb36so2333986ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3qJESbYubFMD5Pl68KvSnzTCaMJv8nnmIuPcfcljgGA=;
        b=BMmK213iwKHTtGXLQ+Jl9K09jzii1LmixoAATTZVHd+coxUxdRdtFvp9ClSm1aSKdJ
         62FSzx13a3JjWCpYpqpf44VhZaP0YC7oqManoiNWzkiNV04JORvBOJEZ3g5NGhzIk5uG
         gQymPuBiPBu7mPxLDJlb92EFW+wrXOvTNWSGhT3V90+N2Gl4QZJBRPz1OOYQfiT+mLjV
         v0/vi/dg8oIlkPrItuWnRf7w/pkqGD4PBivg0+nFR6b6tvMJMlwziO70oVAtT9GaUpTY
         y9sUVePr0iZtQnuRal8qx43lHZez0zeHFIa0+9YnsRk59aIOmlB/rDoRaXCxE5B5QJrR
         /WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3qJESbYubFMD5Pl68KvSnzTCaMJv8nnmIuPcfcljgGA=;
        b=Bwy6rko/2S/fILrz46uP0yQhvb/mpShabroffn/qG/6eKm4C1myHdratc80Gku7Ox5
         Mtol8GpJerS302YDHBKi6AEOwwytn0/iTo5KTtzQJFAVBDyhGHv+ODCD17sydx4zSD/8
         apHTTWE091fvpVVdLm4PW5/VDV0VF4pEbR9xXs+JcRluF4P+2EJ/tl/gbv2GwjSXWWEH
         AsQolYRg1E8ODmTEIWs15No1BOleTE4OrROYU6oFd7yFoJTO9p4P0Bxd8U3GNm5WsnQh
         qAx6OITJ1/Jb9+JUvp0Vae+6wXR4g/baB+dehFPvr7hOV9GHAFtHw3c1y025voTHdhWA
         Ig9g==
X-Gm-Message-State: ACgBeo3JAwN2KL5QIz6e3sKi+TWTvG79iCcK2lvOH1v0RJnPgy99Q5f6
        o3UWiZ4d2H7SLSwrWR3kIJS9RVGSVh1coA==
X-Google-Smtp-Source: AA6agR5pldxWvZDxGPC+I83/e0f/jDzZikBhLKDonJc1XwGfwWhsm/M6BldQSsz8ky2NHve1hI09ng==
X-Received: by 2002:a17:906:6d98:b0:715:76eb:9e33 with SMTP id h24-20020a1709066d9800b0071576eb9e33mr5054178ejt.729.1661510324338;
        Fri, 26 Aug 2022 03:38:44 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:140d:2300:3a17:fa67:2b0b:b905])
        by smtp.gmail.com with ESMTPSA id ot11-20020a170906cccb00b0073dcc912fa3sm707923ejb.202.2022.08.26.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:38:43 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     alexander.shishkin@linux.intel.com
Cc:     christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: [PATCHv2] intel_th: Fix dma_map_sg error check
Date:   Fri, 26 Aug 2022 12:38:43 +0200
Message-Id: <20220826103843.83582-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, return -EIO in case of error.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: christophe.jaillet@wanadoo.fr
Cc: linux-kernel@vger.kernel.org
Fixes: 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/hwtracing/intel_th/msu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 6c8215a47a60..472e1a4bafc1 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -931,8 +931,10 @@ static int msc_buffer_contig_alloc(struct msc *msc, unsigned long size)
 
 	ret = dma_map_sg(msc_dev(msc)->parent->parent, msc->single_sgt.sgl, 1,
 			 DMA_FROM_DEVICE);
-	if (ret < 0)
+	if (!ret) {
+		ret = -EIO;
 		goto err_free_pages;
+	}
 
 	msc->nr_pages = nr_pages;
 	msc->base = page_address(page);
-- 
2.34.1

