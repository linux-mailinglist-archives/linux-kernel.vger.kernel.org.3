Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3CD4EED07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiDAMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345823AbiDAMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:22:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125AE27854F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8B2FB824B7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77525C2BBE4;
        Fri,  1 Apr 2022 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815628;
        bh=JWMnPK9xfOKcsKa/WLR9bFDyRp32aC01n3oRXaMGNOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQTf6oTTrJIerDQx8Bc4hjrsL2MNeKvhhWSRnEix6GA0LW51WGcitQuLY0osrEoub
         1As+hibk4Esmux6JBdZc0KyTa2TrPq4lf5MG/jo2MYiVJ/yduhqcjMk5/IrsxTwrIz
         ZYN5IWqimf0jfbEw6g7ObbulJGpavcyj4bxxk2xn2tlbsX2Dcv5Wk3A02eX1TFzkPR
         +QcoCgsnrg1ZdJSxjI00XNl/bgU09IqNlALusaFQoRcpdhQHRCEmIng3xbrUE6wjBM
         lyoFiBpQfm5n/eNkzwOO+yERrkwXq7W43vHYNTd3T4twTG0guVonv4i4ulGvIBetVB
         B8SHPAkX4b3oQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 5/7] habanalabs: wrong handle removal in memory manager
Date:   Fri,  1 Apr 2022 15:20:15 +0300
Message-Id: <20220401122017.116205-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401122017.116205-1-ogabbay@kernel.org>
References: <20220401122017.116205-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

During the unified memory manager release, a wrong id was used to remove
an entry from the idr.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 3828ba44c660..a1f499a1519c 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -48,7 +48,7 @@ static void hl_mmap_mem_buf_release(struct kref *kref)
 		container_of(kref, struct hl_mmap_mem_buf, refcount);
 
 	spin_lock(&buf->mmg->lock);
-	idr_remove(&buf->mmg->handles, buf->handle);
+	idr_remove(&buf->mmg->handles, lower_32_bits(buf->handle >> PAGE_SHIFT));
 	spin_unlock(&buf->mmg->lock);
 
 	if (buf->ops->release)
-- 
2.25.1

