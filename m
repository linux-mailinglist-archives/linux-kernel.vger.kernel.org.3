Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC14DAF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355482AbiCPLna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355442AbiCPLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:43:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84028527F4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EFBE616C5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992E2C340F0;
        Wed, 16 Mar 2022 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430907;
        bh=5XX+GQ9HNqBktLDIFfZNGdvpaK0O1w2elpB+xsoz4no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQ4k6aRwU7rIJP1+ji2d1io+Z+vtQvl9XDjn4QEkSFhbFt5Nys2gUKV5QIG5fj2qO
         Gg+YKqDQKYzyhDUMrOTYTSCGy1JM4D7WE6fwoD68LuA5Fo+C6AkDDQ/h2A3tjAj+3T
         +Z73gD1HytqmJpyA2kcWRdamCFuOzsvkWxjzOws6zw7b6uLvOp2eTP0YkVxFKfRNDD
         xQlKIuOeyd7fvNjN26l/CWuPfhElHd17qDATEthLPM/5usVIgWSjV4JULEf06VC+Xt
         eIYn82YyTE4iz+7uwS/WQgyG8wcqNXIUk7d4NmsDS9vRZhje06qHIYZvnC9lC8sM/v
         mlVy2lYJBlaiw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 10/11] habanalabs: parse full firmware versions
Date:   Wed, 16 Mar 2022 13:41:28 +0200
Message-Id: <20220316114129.2520107-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

When parsing firmware versions strings, driver should not
assume a specific length and parse up to the maximum supported
version length.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 3262126cc7ca..2665919dbbdd 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -18,8 +18,9 @@
 static char *extract_fw_ver_from_str(const char *fw_str)
 {
 	char *str, *fw_ver, *whitespace;
+	u32 ver_offset;
 
-	fw_ver = kmalloc(16, GFP_KERNEL);
+	fw_ver = kmalloc(VERSION_MAX_LEN, GFP_KERNEL);
 	if (!fw_ver)
 		return NULL;
 
@@ -29,9 +30,10 @@ static char *extract_fw_ver_from_str(const char *fw_str)
 
 	/* Skip the fw- part */
 	str += 3;
+	ver_offset = str - fw_str;
 
 	/* Copy until the next whitespace */
-	whitespace =  strnstr(str, " ", 15);
+	whitespace =  strnstr(str, " ", VERSION_MAX_LEN - ver_offset);
 	if (!whitespace)
 		goto free_fw_ver;
 
-- 
2.25.1

