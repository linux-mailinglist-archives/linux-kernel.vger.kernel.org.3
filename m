Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88EE4A0340
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbiA1WCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiA1WCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:02:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A1C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:02:14 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q21-20020a170902edd500b0014ae79cc6d5so3830656plk.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=69G4sVrTM6Oebk85axmgqm6tVz3OwOvgPCpKMqCiPco=;
        b=r9CLrnZJeyMD+YWaJkb33H8XK0Rn3mXzmfuhYPQYh1mXy84qQbpTOTaatS4U5Egjbg
         DW/6TRosstDehWJ5fQzm7fZNEOv5pz9ozapCuK9mpifIQ9ERRCBfJHAhTbYrRl0dM7To
         x9qsvr6qHgfjzNKy0uDwy+PRB0+ZvKoTWYlsOI8EwJ8QQdRYHud+lBq3+iNhJL5Drrrs
         G71gK2hPwWBBtE03hteS058k8idPK4bmtqC7CxJdOyHnUBsjc2rCC1ZasKOC5OJe23zr
         3QO8/3orXoumYcJR3NyZPN9pbFZPc78w0F+s4nCZBjq/DelD2laPH2sa+++ZE/Gph8ax
         kbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=69G4sVrTM6Oebk85axmgqm6tVz3OwOvgPCpKMqCiPco=;
        b=0KLU1XI5Vc/tyVKlA+3N52mKO1sDvpY9TOnxAsCKlrKO80I3Z2jPt/ZmbM7lEHxU3o
         HD3jRHYzzQZQsS3EaHVWLaNUxAooGspY4rnUX+TSCPvp94sb2kKOk1jP/aSvbx6sHN2x
         2IfzieE4xe1TmgXZgRxqjaKPYqq0Uv80IvbbMu85WJra7xFPmqA9hhwGzD98vMq4Iep4
         8f1NwBqoy29JcWJaloLbp0heP80eryWiTckJc5xRK7JSG4WuXVibHfn/oK2lAO8VISXF
         qjF1AhGuW0En/82fOfWGkDwN3N2Xft0RGvguxYj1FgOO0pzQ/5m8FQXSg6QLk8EQ2Dpr
         ky6g==
X-Gm-Message-State: AOAM533VKe4FQzXybtxtGcYHBshaq1wz4zgjOu8vgGBekzguAxV5SV6L
        J9gKcoEN9hOlxpAbzRh+veV5JCdplTd1
X-Google-Smtp-Source: ABdhPJzk+NX1p5MORYml/JXQrYMcHyi1MKvCEYPbSjKfF+bc47ppwgtX0j9v2VNUKwlkUuQKDyP2zLPsK5z/
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:562d:d821:bf6:b545])
 (user=jmeurin job=sendgmr) by 2002:a63:e314:: with SMTP id
 f20mr8051217pgh.577.1643407333621; Fri, 28 Jan 2022 14:02:13 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:01:56 -0800
Message-Id: <20220128220156.4057446-1-jmeurin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] Fix the size of the header read buffer.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read buffer size depends on the MTDOOPS_HEADER_SIZE.

Tested: Changed the header size, it doesn't panic, header is still
read/written correctly.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 227df24387df..09a26747f490 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -223,7 +223,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 {
 	struct mtd_info *mtd = cxt->mtd;
 	int ret, page, maxpos = 0;
-	u32 count[2], maxcount = 0xffffffff;
+	u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount = 0xffffffff;
 	size_t retlen;
 
 	for (page = 0; page < cxt->oops_pages; page++) {
-- 
2.35.0.rc2.247.g8bbb082509-goog

