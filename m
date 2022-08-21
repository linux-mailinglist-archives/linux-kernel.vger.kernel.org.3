Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACCA59B256
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 08:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiHUGlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHUGlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:41:06 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8A2A968
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:41:03 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id m66so8167245vsm.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ytZKdYUnft3zw47YJkefPgcAf98Ms5YVeOG27pEj8AI=;
        b=Zsi3WSxLYpU0pacztqUlVPW8iatV0LWto+9rVcDwlyQmTvcmPZhKvpWwU7Xpp/qKP6
         iYXNQslvjML01mRxIc6xM+gAHCHsklGm9G2rM0stiX6V+ihgDnr/HoXKLzBmQ5k+FLqX
         oQK9Ymt+V5VOZ0O8CFvfSHMZJ90IE0ksI2lfn6r3jR6RTaZwZSsR4Uekg2tEZp/5PpiS
         sZtrYY4FsPqvR9d2liHWAde/uRqPK29gbuKllzGczBLgaQ/YBsDIWniFQtrZc8ZrqRpl
         0JgJYcY3099gqq6OaKsPLBbt73Q8H2zqjZDyVRfpjICiXP47BcDsZpRyOBxee609GmrF
         P41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ytZKdYUnft3zw47YJkefPgcAf98Ms5YVeOG27pEj8AI=;
        b=GE9Ei+CFloL5bszdJqUcix2oTLJ2N0ibAJJjFGCqLmv6G+3WXs751SEHQf50pVE6HB
         Vw8UMn/XPO8/Ji0HkPj4NYc/P6nzxHSh1zZq7KTxYRC8iJy1lhfrOxz/77CrFebgxofl
         ir0KYbFsI84b++rUhZFbDlehISZDlyT5odST3My1Co1/LgLW6UBxH1sugLdVo0euBNDj
         ACEY9hdoYL0BTKYAbDutT2Rde7fljVJ4QNHqkuq3ml+TRhkr5Ad1bPVo1FL53XfV7HQX
         jMac8nJ+EO9liz+OJ91hUvVYgRautueU2FmoQVfIYl2ENqfNCcT4EmXEgY11a3MJIBLf
         VrwQ==
X-Gm-Message-State: ACgBeo196DRuEKg9gEoTl18r5pksIMyZmxlzgucUgqoRbXgxPDxCIeEB
        l7DbxY90kcIrUjoQ2rFVlhPniCVbzyl1EQ==
X-Google-Smtp-Source: AA6agR52Y1gL6ZNjDwk8h8fIHUi6BPZq3k5iTk1UOwABDIgsn8hPjCUcSZPeES+9oNlVuslWWIaVXg==
X-Received: by 2002:a05:6102:2753:b0:38a:a86f:6ac5 with SMTP id p19-20020a056102275300b0038aa86f6ac5mr5132744vsu.80.1661064062655;
        Sat, 20 Aug 2022 23:41:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id x4-20020ab07784000000b00391bb2403adsm6695823uar.29.2022.08.20.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 23:41:02 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     Tales Aparecida <tales.aparecida@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove unneeded defines from bios parser
Date:   Sun, 21 Aug 2022 03:25:28 -0300
Message-Id: <20220821062528.13416-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Removes DEFINEs that should have been removed after they were
introduced to ObjectID.h by the commit abea57d70e90
("drm/amdgpu: Add BRACKET_LAYOUT_ENUMs to ObjectID.h")

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 09fbb7ad5362..ead4da11a992 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -44,25 +44,6 @@
 
 #include "bios_parser_common.h"
 
-/* Temporarily add in defines until ObjectID.h patch is updated in a few days */
-#ifndef GENERIC_OBJECT_ID_BRACKET_LAYOUT
-#define GENERIC_OBJECT_ID_BRACKET_LAYOUT          0x05
-#endif /* GENERIC_OBJECT_ID_BRACKET_LAYOUT */
-
-#ifndef GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1
-#define GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1	\
-	(GRAPH_OBJECT_TYPE_GENERIC << OBJECT_TYPE_SHIFT |\
-	GRAPH_OBJECT_ENUM_ID1 << ENUM_ID_SHIFT |\
-	GENERIC_OBJECT_ID_BRACKET_LAYOUT << OBJECT_ID_SHIFT)
-#endif /* GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1 */
-
-#ifndef GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2
-#define GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2	\
-	(GRAPH_OBJECT_TYPE_GENERIC << OBJECT_TYPE_SHIFT |\
-	GRAPH_OBJECT_ENUM_ID2 << ENUM_ID_SHIFT |\
-	GENERIC_OBJECT_ID_BRACKET_LAYOUT << OBJECT_ID_SHIFT)
-#endif /* GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2 */
-
 #define DC_LOGGER \
 	bp->base.ctx->logger
 
-- 
2.37.2

