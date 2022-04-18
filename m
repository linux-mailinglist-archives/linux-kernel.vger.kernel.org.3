Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44014504C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiDRGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiDRGWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:22:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAEA17E23
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:19:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso11244233wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TpWXWlsIiwFWqITQBBmHqt+ptX9YU3vyMz2FKFbBljI=;
        b=KVf+4C/PtpEfuB/Nxd/EYlIv9rV9YIYR3O2bMQguZFWKge/IUlTq8vQWAZQe8oiaVp
         tSbS/pFY1PvpYzcU3FT9E8BRiWtfFu5LHlsOjEmoAi7ACi+Iy1ESCvvP4miqPbcT8X8j
         fFiFpDshwNnmiXZ11QLg/k9C528xaqqbPLvtDAIxe/C2/xIV1DalMdAup68C2N13YvlV
         +Euy8Huqd/3jlzskYYaJTeN7QjGP7T0lPwSx0WQmyKkF0TicIgSgJVnDmChDfq/cmVJu
         wBFN3wCYNC2QFtJ8ZvakpGXI6GS2j/tdOF/sDc/nVPvMpu2Xh1aU376/LhlyUkX967ky
         Psrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TpWXWlsIiwFWqITQBBmHqt+ptX9YU3vyMz2FKFbBljI=;
        b=aRe2aPeuB+s6Kr/4RXC3PhcKhC/B2TmaRqGOdLTW3Wy6ewJwnoUbWvH63+NFWYAWTY
         O3Rj5aqCQ7IVSaYm5ZMmgVuIMvDqcsyQS59AFYr0docDBui3wGAiRnFmSxMh/3pWf35L
         Kfqr7NBgt0U487EwkITqKVTz95pPZbyJV9IDD57YzDZ9SQ2RwwIg/TmqDvmtoBt+OIw3
         AR5uW98GfW8flvidAgt8MSx7QBpm0n4Nq3RYnnDtv93byctJCp4LWPkMUXZqwNsDISxn
         TxgX/pBoFgupnYe1VVRK3OfjFTX+XO9d06Rpe5K9jWFMJE8ta1NsdbxcxbcQ7qZs6NQv
         QGrA==
X-Gm-Message-State: AOAM532p7Xe+36h9RySuFhyow/mMbiExLfF9JEeORQJ8Oddb6Iw8FTAq
        FfaqS0cZ32VAP+q+UQUNFKA=
X-Google-Smtp-Source: ABdhPJyZ1HNParLvvy4rzpznCl7QS81uDSoiwV8fB4OIS0XVE5dQ8FZK+15fz5DY06IYoRqXJpCRHw==
X-Received: by 2002:a05:600c:4f87:b0:392:9236:3c73 with SMTP id n7-20020a05600c4f8700b0039292363c73mr5367903wmq.158.1650262770786;
        Sun, 17 Apr 2022 23:19:30 -0700 (PDT)
Received: from alaa-emad ([197.57.90.163])
        by smtp.gmail.com with ESMTPSA id q16-20020a1ce910000000b0038eabd31749sm13992199wmc.32.2022.04.17.23.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 23:19:30 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com,
        eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] xen: gntalloc.c:  Convert kmap() to kmap_local_page()
Date:   Mon, 18 Apr 2022 08:19:27 +0200
Message-Id: <20220418061927.6833-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.2
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

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Therefore __del_gref() is a function
where the use of kmap_local_page() in place of kmap() is correctly
suited.

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/xen/gntalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 4849f94372a4..55acb32842a3 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -178,9 +178,9 @@ static void __del_gref(struct gntalloc_gref *gref)
 	unsigned long addr;
 
 	if (gref->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
-		uint8_t *tmp = kmap(gref->page);
+		uint8_t *tmp = kmap_local_page(gref->page);
 		tmp[gref->notify.pgoff] = 0;
-		kunmap(gref->page);
+		kunmap_local(tmp);
 	}
 	if (gref->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
 		notify_remote_via_evtchn(gref->notify.event);
-- 
2.35.2

