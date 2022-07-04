Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50326565DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiGDTLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiGDTLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:11:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CB81E4;
        Mon,  4 Jul 2022 12:11:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so6239613wms.5;
        Mon, 04 Jul 2022 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYJdC2yjixYZ+kyoc4OE/b9ZX8JV+K3bG8EqjiFuHfE=;
        b=fje1ujhgj4n/NClwNNLHrpiSj15S0MbR6wPpKmARyWcCqj7LnSnL192M+mQGvNyp1K
         eZn+EjTBF/itc620E6fFsD0nau4Jlj4KhWv/HrRCYAYxwM4i5LTDj9sO3mbANvEVTRgi
         zpLog+Yu5gRu2dZX7ASksMXWC31cdaFwl8R1qRhIzat35MWDvmhq6fHl12zIYGfAgP17
         OasHWEyHzyyfxjvJBKllakT4ieCOTjaProgiMtiZQZWCIaTW32YD5OHa+FDNZ4plWfCB
         gz58FwamG9Iv4FiyngWPEn3h2G3NDmOUGIYG3dVAhqh1/KBdexoTGeQFhbDiB8hLhvwe
         uxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYJdC2yjixYZ+kyoc4OE/b9ZX8JV+K3bG8EqjiFuHfE=;
        b=6BLTfviJgioaOy7jozc+CbMXHSpV5Ch0J99X1o2AWslxHC4jf7bluNbaIFSNvjRtwb
         uufoAyfKrJwjAhbEzySJim1/iBkQsPkBvEDYqmrIVebqirGLvSmIAvVJpxNjN+3ca6VB
         MJcuudn4LP9JNlWjMlyekaDYjGpHZ2iV3xYdOJz4Idj8BkDuDUuthae8N9vGJ3SPAAlw
         yccZrxw0KZhOwl0e7wvfcA34Fy5OBWXtY/VjJoDmHP+QuqX5PMquErXeqXyjeKYFGCbS
         0CWE26uFwk5ThShB8MuJa8M+6WiYLXj06z1lJXfL6E3m43iTJcMtXziSmqQtYj4ezmJN
         oqEg==
X-Gm-Message-State: AJIora9IuU1wGi+k/eIgD6QMSQkvuDobKcx1Mg1b+nKFdRxDpIrZrhik
        +zcsFpqPk6ASs4CPTnXoMubItqreeQ+WSw==
X-Google-Smtp-Source: AGRyM1sAc/Upb3IqdwlY5v1NzPeFFGkBDLEmAeR9nyVvA46bGnSTXTLOAUBZR/2RGb8Mfc+m9opcgQ==
X-Received: by 2002:a05:600c:1d0e:b0:3a0:50bb:55e0 with SMTP id l14-20020a05600c1d0e00b003a050bb55e0mr33718555wms.89.1656961908597;
        Mon, 04 Jul 2022 12:11:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c378400b003a2b708c26dsm122983wmr.40.2022.07.04.12.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 12:11:48 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Airlie <airlied@linux.ie>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/amd_nb: remove redundant initialization of variable i
Date:   Mon,  4 Jul 2022 20:11:47 +0100
Message-Id: <20220704191147.594032-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable i is initialized with a value and then re-assigned with
the same value in the following for-loop. The first initialization
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 84a4aa9312cf..c7bf2c4bc0b0 100644
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
2.35.3

