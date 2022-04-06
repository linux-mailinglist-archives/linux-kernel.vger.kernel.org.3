Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F04F5CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiDFL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiDFL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0133BE630
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:29:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z19so3038770qtw.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VE08dsgukeGG5IChIzOIKz1Sx9tWGQgZeReJDKhgy2Y=;
        b=FUuVzC2mh2PVAGCMRzU0asrMqYuRHc8mtDR5m5TiIlCPxpg/IWOWW0Zdfm3/eLqi2R
         2p7j5BO1/HkIb7o4D2nSTOo/Pr9CaSHq4DN7QdoDCAb02JfVSPV1dPTdYrwSHgoSW659
         KKSXTOllrtnDh55cJMQot97phLbbifmvR1+xfuSGrduOtaBhdWJm1wO4jaUSrTSwq90S
         8KyvuqNUQUwpfhQY7SouUIWg2PIQIKrGfRBUeX16AGAPJBgExu4TQlsIaqia1hf60TkR
         5MKJZGi9MfiM6PwShYFhEnUYjvPvRGZ5KQ8lpxtXCUGjfEXvLyF/VGfKo2tz0n/DVCKL
         uBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VE08dsgukeGG5IChIzOIKz1Sx9tWGQgZeReJDKhgy2Y=;
        b=XQtjUn2XIUF/aA+Ga8eSwpQ/JIGvvBuWs4NRuxPlFGAKU8TOd4fKCk3SSFr0D+oiyR
         gNRPFg+nDLxa9KXB/3mZRJogEv/75kcpQh6IB3JjfoQn5XXa6V1yMV4BDygU/k+dUvkp
         72y3GpB8zZ18t2xdispIs9SqbHZPJYPLEEO0s9PJdZ27vWGgJJluEUS4Ri9TTL/qBrm2
         4YYKdwAyqJJq7wMBDx2lhLxYWHO+nmAGswWK58kUol3hWHYEE+i1hVXs3zXGza7sHfiX
         tBQ0JuOj3GLYwCMJGfb/mlm1MiheSgJho7aay8NRi7qYOKy+jqeHTRXGHeTIOQqyY/Y1
         w53A==
X-Gm-Message-State: AOAM531ftehRr7I+VrZuA0eT3nERjEce37RDJ/1V0JvC/3Juhg5C26gl
        uLKAU64XouMhi0M+hhZ9ILBEiIwy+rU=
X-Google-Smtp-Source: ABdhPJwigMtxTwtlbYYuXX75zJfRY1b7cxmWJvS5iiYcfK8nJ29v69OEJU8x+gG+EYqd39myJHe+pg==
X-Received: by 2002:ac8:5f07:0:b0:2e1:d695:d857 with SMTP id x7-20020ac85f07000000b002e1d695d857mr6317759qta.40.1649230151230;
        Wed, 06 Apr 2022 00:29:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d124-20020ae9ef82000000b00699a8b42aa8sm7949525qkg.16.2022.04.06.00.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:29:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     harry.wentland@amd.com, sunpeng.li@amd.com
Cc:     Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Jun.Lei@amd.com, qingqing.zhuo@amd.com,
        hvanzyll@amd.com, Anthony.Koo@amd.com, Angus.Wang@amd.com,
        alvin.lee2@amd.com, lv.ruyi@zte.com.cn, Bing.Guo@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amd/dc:: remove duplicate include
Date:   Wed,  6 Apr 2022 07:28:40 +0000
Message-Id: <20220406072840.2488056-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

'dm_services.h' included in 'freesync,c' is duplicated, so remove one.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index d72566c6928a..0130f1879116 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -29,7 +29,6 @@
 #include "dc.h"
 #include "mod_freesync.h"
 #include "core_types.h"
-#include "dm_services.h"
 
 #define MOD_FREESYNC_MAX_CONCURRENT_STREAMS  32
 
-- 
2.25.1

