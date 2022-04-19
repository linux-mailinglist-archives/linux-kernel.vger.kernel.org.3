Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB6B507D48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358067AbiDSXqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiDSXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:46:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1020BE6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:43:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e21so24435784wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HKQLOdPaQ3Mw3cBSPXtTxWv22p46uaNKqi/2UnH+TaU=;
        b=W+DL2plQDmeF6M+8AnbzgopnqINjz5xpZNqMbikOKgoHFPRR+2r5EWaHfQkEeeyh8Y
         4x3B0Cqy4qQjSieeCV93kllUXHcH1UEDOyJ4H3wi3nGkncyyG69gMCxdhJrYyUgoMASs
         byoRivqsbbPGEE5WgsXzZwjw4W9tp8cTrS2PGq8BAEhXE767YJOJn1HZSX0oG6fO7+gi
         xLn3V8FkF2M8NwqWPNExwEjR/LxGIsYI7oaOyzgmVo32APXgz+OmYl1Y48HnpBXCupPQ
         yXxgbu5sru6YT/MpEjkix0vIoBcBKYwhlN6gKA5aSrgKRu9UJZxn3uW2VAIeWPPrevdr
         3hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HKQLOdPaQ3Mw3cBSPXtTxWv22p46uaNKqi/2UnH+TaU=;
        b=WE+niIfcCtNJ4bZwkN66RckQuPzLvdFcbOg6sXGuCsWNTtyju8ZDJTbbrMaHypf+Pw
         ktw4b0UtkmIGjISMTykqOMcUa1KauN2eWPuwjXCQd7OrOfKbZ8rOzbzH4brlSkzRdU4k
         zOSlj7rBAbuSggH00Byloq1HbA62QX7T5BAfW63NuJ53LcTnreTGMNm7yfLreh/L8A+v
         9bmTSYIgKRC0PLzQlM1xbjeP7a2+pk3+vCu5WMRWpDa5scVSCYzGVmXi7LMnhNj54NKt
         NXql3M4LPV2EgHBC0MTdfmDwN8iHZUDTvMrJ4IekvexNNFzXs6aXRH7zgmKedlwptIyM
         7HNA==
X-Gm-Message-State: AOAM531gmH9AZDsbXo2MsTRvatLH/sHiNK+2htuMMNZ0jA8C7xNVJi7z
        l0rgFd5axXWYR6+xsU1v6CWh/th+lLaoiw==
X-Google-Smtp-Source: ABdhPJwAIcFXMCqod1EDSxcxDLBq3kQdWuUNKRazc7JRrvo6vjc1W5NvWFPzXoUkm5DwO/gOBUTKUg==
X-Received: by 2002:a5d:45ce:0:b0:207:9e7e:9a4b with SMTP id b14-20020a5d45ce000000b002079e7e9a4bmr13248177wrs.559.1650411811661;
        Tue, 19 Apr 2022 16:43:31 -0700 (PDT)
Received: from alaa-emad ([102.41.109.205])
        by smtp.gmail.com with ESMTPSA id x4-20020adfdd84000000b00207b60ed68esm13255849wrl.100.2022.04.19.16.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 16:43:31 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com,
        eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH v2] xen:  Convert kmap() to kmap_local_page()
Date:   Wed, 20 Apr 2022 01:43:28 +0200
Message-Id: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com>
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

kmap() is being deprecated and these usages are all local to the thread
so there is no reason kmap_local_page() can't be used.

Replace kmap() calls with kmap_local_page().

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
changes in V2:
	-edit commit subject
	-edit commit message
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

