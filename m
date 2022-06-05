Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3899C53DB40
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351005AbiFEKdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245542AbiFEKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:33:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B520F42
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62E85B80B8A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D413C3411C;
        Sun,  5 Jun 2022 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654425203;
        bh=rc2zsORGj01zJ5Lz9EoBugxqUE8xMq+JOutnPoIXF+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsUL65MJsA9+ci1WOLgi36ARNWfkehBbrCyocImJ1McQhL9rwx3Iq/Q7/v5mkKZo9
         oTvkv5cXBQhwnf8D7iadS9o8nnfe9+rn1W2Je0gmVsHPqKcb7f7tRsuRP+xwsVfyD7
         +FmpsjxALTy8vuwF8Ec5OJ8cIJ9+P/n6AS7X96XR4aNKLB5x1Oa/Yie/Y7GvFMMFKr
         cCrI0N3kpSVkrpf0EO6QZPBcv/ajBwWwVkOZqC8JhPh13Gdxal223y8G5IW9mAqUPC
         O2LbapNjeZAi5Sj2Zd1rA4AxuaBPfsX+CT8BFa5fsi08uzNaDTNZ/abjOJHjRpecXm
         y+rjrLTzibVCA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Rapaport <drapaport@habana.ai>
Subject: [PATCH 2/7] habanalabs: align ioctl uapi structures to 64-bit
Date:   Sun,  5 Jun 2022 13:33:11 +0300
Message-Id: <20220605103316.3414541-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605103316.3414541-1-ogabbay@kernel.org>
References: <20220605103316.3414541-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Rapaport <drapaport@habana.ai>

The compiler is padding the members of the struct to be aligned to
64-bit. The content of the padded bytes is and not zeroed explicitly,
hence might copy undefined data. We add a padding member to the struct
to get a zeroed 64-bit align struct.

Signed-off-by: Dan Rapaport <drapaport@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/uapi/misc/habanalabs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 52540d5b4fc9..6d2ccc09dcf2 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -949,6 +949,7 @@ struct hl_cs_in {
 
 	/* Context ID - Currently not in use */
 	__u32 ctx_id;
+	__u8 pad[4];
 };
 
 struct hl_cs_out {
-- 
2.25.1

