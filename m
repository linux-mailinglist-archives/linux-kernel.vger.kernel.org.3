Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7450855F3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiF2DCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiF2DCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:02:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A57326F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:02:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so8644817pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fK+F1u9+R3REeVl0kt+G63d+2/3HR03h+p6LZBEkA/Y=;
        b=lhJYJIxJeBxCVZn0m1eQwAN9git5rHLIK+iQxEvSUSMjeNDO9QIjA2j1nSTCZenY8H
         XbePQ6iu2/ULvSHxwtmnZtR4m3zBdT3dKjL/mm2W57AxFI8SzMVijOjSAwUAlJafzc56
         z1JAgTncAo+SZOfhfS7H5WyhF4ZieleY9g56qDuGH7WHBk85YJn5xRyTGlc5r93ibaNi
         beXvhRHnRwpRnv/GXyjAXUh2Qad3ggjbkCfTzJS0samn+i/TM+dBzcJs79Qa8d0EDDQZ
         DWy1r7EPtosH/iOT+pIDbAP9PazMGukwRCekQ6RCMc1dAiBFbzAQfsrQsvqclaZHVBq5
         cKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fK+F1u9+R3REeVl0kt+G63d+2/3HR03h+p6LZBEkA/Y=;
        b=zATuU3QX8gnnSNVkg5Qn5jRaQLHfswbQJaB9uhakx51D0ltqL7+smQ8wSpEmpZ7lng
         XcbqSIOTzk28EoLzN7hni6DvZEjU8YOYORDNyzazGFEH2LJnzCwaMajSOPP+seJNPB2P
         sapTH4DAXH57R+1XBS0OsXPaZY3+JFQukMG1b8hKUYPWXlsfTsDstf6jJRwECjXDiqFH
         UxJdF1HzNT01BXNvnP7dqjfTmPxWIW2mxBQLImEAc+OSuxaSt5GdfH+xtBDsXIYNwuRj
         smS8xfCc4xRXw2f9gCr+75uBYNo8SzO/8slcE6+uUBqmgOjbwASNMBauYZfYTKftNy1b
         fwoA==
X-Gm-Message-State: AJIora+HJj30RnAvpulslrjdR+4OxTxWwMZBCqwvxO9HZHuciNx0kPYs
        WfE9J6iAY3sVLMaS1YMNUTMuIa2C7kg=
X-Google-Smtp-Source: AGRyM1u0wyhhV8Tj6BcuTGK3K6B2oQmfH2LBfJbboD67qApOw0Q2KjoNW+ixdImBlST0v/YICznxLQ==
X-Received: by 2002:a17:90b:1210:b0:1ec:7f2e:4218 with SMTP id gl16-20020a17090b121000b001ec7f2e4218mr1321075pjb.69.1656471768659;
        Tue, 28 Jun 2022 20:02:48 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([61.120.150.69])
        by smtp.gmail.com with ESMTPSA id y67-20020a626446000000b0051bd9981cacsm10163436pfb.123.2022.06.28.20.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 20:02:48 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     maorg@nvidia.com, ming.lei@redhat.com, hch@lst.de,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/scatterlist: use matched parameter type when call __sg_free_table
Date:   Wed, 29 Jun 2022 11:02:41 +0800
Message-Id: <20220629030241.84559-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

commit <4635873c561a> (scsi: lib/sg_pool.c: improve APIs for
allocating sg pool) had change @(bool)skip_first_chunk of
__sg_free_table to @(unsigned int)nents_first_chunk, so use unsigend
int type instead of bool type (false -> 0) when call the function in
sg_free_append_table and sg_free_table.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/scatterlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index d5e82e4a57ad..c8c3d675845c 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -240,7 +240,7 @@ EXPORT_SYMBOL(__sg_free_table);
  **/
 void sg_free_append_table(struct sg_append_table *table)
 {
-	__sg_free_table(&table->sgt, SG_MAX_SINGLE_ALLOC, false, sg_kfree,
+	__sg_free_table(&table->sgt, SG_MAX_SINGLE_ALLOC, 0, sg_kfree,
 			table->total_nents);
 }
 EXPORT_SYMBOL(sg_free_append_table);
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(sg_free_append_table);
  **/
 void sg_free_table(struct sg_table *table)
 {
-	__sg_free_table(table, SG_MAX_SINGLE_ALLOC, false, sg_kfree,
+	__sg_free_table(table, SG_MAX_SINGLE_ALLOC, 0, sg_kfree,
 			table->orig_nents);
 }
 EXPORT_SYMBOL(sg_free_table);
-- 
2.20.1

