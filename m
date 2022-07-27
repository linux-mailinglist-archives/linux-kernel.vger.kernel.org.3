Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B96581FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiG0GDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiG0GDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:03:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645752A735
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:03:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z3so15302287plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pHInnhZIapp9ygsJkxHnw8j0AydAm5/Szf/QJZReVwc=;
        b=hOvYEhU98x/GDtGnYnmoR6BJRBXACIoTfxIQJjyK99pcrQKlqKNDGNPCCYvtelWyQZ
         Y183bzy65rDmM1fHouJFY5e0lrHP2DA9cKq0IlsKAlZP4ykSykOuwcz45eXUJsECIkle
         4QKLBROzWhdgL0/SYmLwbPvvfb4CZI6QgsS1oLhLUB1IiQ8o6Xu3pTgvADuCETctHgQd
         3jXASagP1pGOOnh0jhs5ikPcA8d9CtYGSAujv/q62h9Q70hMpicy3GAHNw+nqitfpaG/
         KuGd3q+ZwR1SrHcxOZAo5iWuejtHg7RvbLN2OnmlD5lrihO9XLpQ8t3iTyoV88opuaSb
         hOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pHInnhZIapp9ygsJkxHnw8j0AydAm5/Szf/QJZReVwc=;
        b=5FQWM3wlndc3cu59kBonBnwVW4QMPLDln9nAHlZrm8reOdZpOIjcsHJ398JPITdUA+
         FBMiE+T38+d2rgJNdhPeed50ZpVmp6+dwE25RLaygxnSIohR0lBIjEhDksrlt74NxTeK
         dFKqx0QX8SEqKSElbGdUoVt6cS1X/BV+/dCynBvGSalj974b33Cp3xw9b+qZShlT62eM
         xo+URz1jHuZ8wWBH6MAAS1SbV9RwjNZeFHO9aXhsZKRnsHeikNrUqa0BP0QzUZpvhiOR
         OM06MAkgOD3dFAkW10tDf7jdGOcqrGx7ooxzNMIcZ0whJEAUYN1Qae+BSl6EsO+bCVOp
         FS+w==
X-Gm-Message-State: AJIora/7oQ7bxebeywTBiPgwT4nvukwd7vphCzwVDDxWYpxfDrkWU2Z1
        pDKzgg/98egCWqjEb3pAOpo=
X-Google-Smtp-Source: AGRyM1vMfbDk3zJiVxRQkUQY+kK8oss494ogdScYinwu4OCsDie7+BNXRUd0jGmYyMuCmXwyi8JrxQ==
X-Received: by 2002:a17:902:d2d1:b0:16d:37b3:f8b3 with SMTP id n17-20020a170902d2d100b0016d37b3f8b3mr19612626plc.98.1658901794902;
        Tue, 26 Jul 2022 23:03:14 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id j1-20020a654d41000000b003fadd680908sm11252628pgt.83.2022.07.26.23.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:03:14 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] mtd: physmap-core: Fix NULL pointer dereferencing in of_select_probe_type()
Date:   Wed, 27 Jul 2022 14:03:02 +0800
Message-Id: <20220727060302.1560325-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

Coverity complains of a possible NULL dereference:

in of_select_probe_type():
1. returned_null: of_match_device() returns NULL.
2. var_assigned: match = NULL return value from of_match_device()
309	match = of_match_device(of_flash_match, &dev->dev);

3.dereference: Dereferencing the NULL pointer match.
310	probe_type = match->data;

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 drivers/mtd/maps/physmap-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 4f63b8430c71..69d0ab1f6f94 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -307,6 +307,9 @@ static const char *of_select_probe_type(struct platform_device *dev)
 	const char *probe_type;
 
 	match = of_match_device(of_flash_match, &dev->dev);
+	if (!match)
+		return NULL;
+
 	probe_type = match->data;
 	if (probe_type)
 		return probe_type;
-- 
2.27.0

