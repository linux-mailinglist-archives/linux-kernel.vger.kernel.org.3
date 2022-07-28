Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274135843A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiG1PzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiG1Pyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:54:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB3C6C12F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:54:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e16so2260720pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU+1umJQF2o/NXaZ6DOn2fpiiayOd6S6bPdTx2dKd/k=;
        b=dcP32hnVDAltE5oC+wFB7l+/9L6Z/Bg5HW+o9yRipBBv5uJDAQXieFFGffT0dNJZ7l
         zEqG4XhEhIB0FrK93YOLQ4BJORQ8hjBdq2MOry8P8m+EZz0Cz2Rj7fHJJ1k3L22PNqoW
         9YBcW2a6vn5f+takyY6WspSt+E5TvXmdfcbNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU+1umJQF2o/NXaZ6DOn2fpiiayOd6S6bPdTx2dKd/k=;
        b=L2cQ3SMuTNXk9NAUiLkVvsyv45/w4LTPyt+Je8KVbodi3gmr+cMoWtv5T6Jgaq+DF3
         2nFbwq8vtHwCUIZYvjq6JRxPCbp/W6e5OQh9aD2ZrkyX+CdkDCHjxC+TUANhRZyFvmrT
         Vaar187wd6KoJTuHy2n01XGs1ElZhafnqNx/ORO+ufERDetpH4s7MqQ+5caLIzYFix8e
         0s5Cnj04C644saZvBB3Cgb9qjz+siKxexSe7nU7aMauXqt0vmzWWtGSDo/+I7wF6EA8x
         4ko0NVUavrRoTeJUoD5dLGZqJH6ccdgAtvWBpVTeA2SzbltEcTNprQ+tddFeGoor/8Lz
         y8wg==
X-Gm-Message-State: AJIora+1xhhfllOVfgd+X0cs4QazDRncUQWO8iBLpT/SLU4xQuqECIOs
        vwGCXGJ5Y375QDmq3gFdM1fN9A==
X-Google-Smtp-Source: AGRyM1uEQZQL0BQQkR3RNvEAFIjhq7+7MXq8qU7ybWJ2B13O/5RNLqRZS5pTd/rmE0sG+MnN8+l1Xg==
X-Received: by 2002:a05:6a00:234c:b0:52b:7cb:ed9d with SMTP id j12-20020a056a00234c00b0052b07cbed9dmr27527599pfj.32.1659023686099;
        Thu, 28 Jul 2022 08:54:46 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bb10:e729:7f59:7cbc])
        by smtp.gmail.com with UTF8SMTPSA id i6-20020a626d06000000b0052c70770b24sm974115pfc.40.2022.07.28.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 08:54:45 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>, linux-raid@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
Date:   Thu, 28 Jul 2022 08:54:41 -0700
Message-Id: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2aec377a2925 ("dm table: remove dm_table_get_num_targets()
wrapper") in linux-dm/for-next removed the function
dm_table_get_num_targets() which is used by verity-loadpin. Access
table->num_targets directly instead of using the defunct wrapper.

Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/md/dm-verity-loadpin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
index 10c18bc1652c..387ec43aef72 100644
--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -5,6 +5,7 @@
 #include <linux/dm-verity-loadpin.h>
 
 #include "dm.h"
+#include "dm-core.h"
 #include "dm-verity.h"
 
 #define DM_MSG_PREFIX	"verity-loadpin"
@@ -58,7 +59,7 @@ bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
 
 	table = dm_get_live_table(md, &srcu_idx);
 
-	if (dm_table_get_num_targets(table) != 1)
+	if (table->num_targets != 1)
 		goto out;
 
 	ti = dm_table_get_target(table, 0);
-- 
2.37.1.455.g008518b4e5-goog

