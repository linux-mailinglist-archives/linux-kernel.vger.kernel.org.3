Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFB52FC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbiEUNGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbiEUNGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:06:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0B48890
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:06:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so13695633pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJQAargzbSV/bcfEc4GQyAdjSAm8VTpErNGyJaNS7Vw=;
        b=hRn+s4n6HCd9ByvhNlx1TN2XBtvnDw7J/piVBgoGQV1joLdzAUf5NxncpIUhQeR4vT
         CLtW4B+hODgzY09hgBVaBw/z8w55Vtqw9RlOFK1E75Mll3WrQicBR+TrnLjDXD+vEPtK
         lAi7c9AX+gd3pt1HF9LsTfYfw4ikA5Ny0fwgo5i/ojtIuIoGYqS1yMvIwgJF8U7xE1cE
         rxHpi4QtbF2AH//N2SHYRzjr8s3pPHfEQG2LATkawx2eBnKWGHGcBjxCO96aF3HgNSu/
         eQ18rMlVE8PBBr8zObrT+e00fQsgvEX2FZXSp8/DzguumoG7G+mEeHyPaTzkl2Z5u+Ae
         l3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJQAargzbSV/bcfEc4GQyAdjSAm8VTpErNGyJaNS7Vw=;
        b=HA/ASGxSkcCXldF9A0Cei2Juyvu6BUjrltawGJUgqNUVLxwF9tCcqyO7xnT5rUiNUU
         lDxe3OyJF6n+zpjkU1msKW3PaSSS5merY7Yi1fzQciuv677RRo+hgv/veFBKvzB67VMk
         WZzcx4F16thzmN4cY5cJ4ZH/X8qaBVJ1C/WfMVbZ4Birx+Prvpqrnk6Fd1AeRInqKgv7
         Q8eQWeYZmywjIq37B//ze/UEYSML28fZKl4Biq/r1xRkbDehsllQmqLU1AaqeUnmTDZa
         iWsw96sfRJsvT/nVIuDt2xnwXuDksW53B0bJwrWavbQuFeqNe8jiLSjTiYyBRmL8eylD
         ORng==
X-Gm-Message-State: AOAM532Syw1GsYH+HWc4c0eGtKnEuIeTBndMZqvSqhGuPb0jk25F0H+8
        BVcHtAUJU2A6p/X2ctI+h2WrQrZofzHcaqBR
X-Google-Smtp-Source: ABdhPJzMrkUJvtywftBmdzAuAlsNsNjJWqVurrcfzlSPO97CWehLqortg2nUjQEq9cS5R/cDseGdXQ==
X-Received: by 2002:a17:903:32d2:b0:161:d485:613f with SMTP id i18-20020a17090332d200b00161d485613fmr14412470plr.173.1653138373026;
        Sat, 21 May 2022 06:06:13 -0700 (PDT)
Received: from ubuntu.localdomain ([103.230.148.185])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0015e8d4eb267sm1580157plp.177.2022.05.21.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:06:12 -0700 (PDT)
From:   Gautam Menghani <gautam.linuxkernel@gmail.com>
To:     airlied@linux.ie
Cc:     Gautam Menghani <gautam.linuxkernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/agp: Remove unnecessary assignment in cache_nbs()
Date:   Sat, 21 May 2022 06:06:06 -0700
Message-Id: <20220521130606.52642-1-gautam.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary assignment for the variable i. This fixes the clang
scan warning : 
warning: Value stored to 'i' is never read [deadcode.DeadStores]
        i = 0;

Signed-off-by: Gautam Menghani <gautam.linuxkernel@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index dc78a4fb879e..5f64991c73bf 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.25.1

