Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739D04ECC50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349999AbiC3ScK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350328AbiC3Sby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:31:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7A37BF2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t9-20020a5b03c9000000b0063363e52dd1so16122603ybp.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ca47COXmBSszi4QxX+ReqmieWG7XNF5pnVRBaC+7k/E=;
        b=dY6w8gATGTxU0oNaihHTArpigSBMGSDZdhWG+2MS0O+jEhyjlDO3/ysyQit/uDsBYz
         wg+yTX02eZSaSK+vxrIdsm1UVZs7xxdNqogAqn7Mq9I2of4rjdRvpctH8PYpzmuu1yEg
         0JcFeel+gkQG1Ijjh9OqF1gfHXu3qK+jnZ8SLKwFs5V9v1mjHapyq/CEGIOoamMomdWt
         lotHjr0Aobw2mgmuWrTRJ/+hkrU1r0MxcyjUwre+HXdREOg8gnvzca5mz/f22zyVSOEz
         4N1yZU961ExZRDDToX1pqFxqAHlpejEs15E353IIPvZX+5mMqDra+qnwfrnDHh9UvObg
         r1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ca47COXmBSszi4QxX+ReqmieWG7XNF5pnVRBaC+7k/E=;
        b=yq3Yv8SIzqlzYrY9qzyTYYjkCAbQX5PlO7iZopiZHxHRRMvWsCYsKa3Gb0oue0jWI+
         8iuyrCvoegyG9awRAJj6Vwstl2dHFgLTtF/kvYx3cv4hVda2sPeIvnLIjnaHw23Q8uJw
         XgRyno4lu3WHzb+waJalp516RXVdTbevHzYjwNORgYtp5DrbjXXQ3Qz4i/nXgfz6Nz2O
         QDZw2H3po6l94lAk9m1n8dqEgJGBg1ArSupIUV1WjEOgC8tHgTF2Ja8Ic8Cv3QUhplsf
         6ms9q24mbsAajHAKD6dGn/GHGkrQ/bAF+OGuiAUdyJpBW+TdWh6C4PVfIFS0o27sTsYR
         OU+A==
X-Gm-Message-State: AOAM533sodPI3ZgWaKx0tyH8/zEAB3Q6nakjsJM3doVRTDHdXwSCBhKq
        1FBkAydQAuciIADX8hjLTKvq/hj5b/lB
X-Google-Smtp-Source: ABdhPJzP6uTDXLRNjGFtbGrlIV7fZWAmSbGYegCnOyFjySA8kz89Txm0ba1/6Dn2TklOHEuqSdQ5smAQh8bM
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:1db:3f32:3ad1:f38])
 (user=jmeurin job=sendgmr) by 2002:a81:4e4a:0:b0:2e5:aa2b:4ab0 with SMTP id
 c71-20020a814e4a000000b002e5aa2b4ab0mr1105409ywb.258.1648664913021; Wed, 30
 Mar 2022 11:28:33 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:28:15 -0700
In-Reply-To: <20220330182816.1177341-1-jmeurin@google.com>
Message-Id: <20220330182816.1177341-3-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13> <20220330182816.1177341-1-jmeurin@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 1/2] mtd: mtdoops: Fix the size of the header read buffer.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1.1094.g7c7d902a7c-goog

