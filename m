Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12153C9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiFCMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiFCMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:15:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5639BB6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:15:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y187so7097034pgd.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9U3qsBSVaLdxBGwysRPnWNY0hSOW5bqS3fMTtRWlOU=;
        b=cFOF6qQSycOAg+gIAm34Ht6pACgpcLc5A505loomEOpN92Mvqy9AKHANFvo1LeIseH
         TQV7gpyd2J8BkQT/qSveitZGLV5UoZXMPoR3f0aJArnGeB4ufeVzCN1yvq8bsGUxonD1
         YdcYdCWfxufluBuZzcb3L3MqHcpEKqr7RdDUHnWDumNGdghvFLJtvJJI56Z3s0lxFxvu
         T2VF48gcILXr+DG8X1OhDunUj1p87J8vaLHFtOmGKRkrB+CltTsjFwleOHXYtNlvCYcI
         bq+nLcz+m98PqzqkNqMD54IGMTy3SmbfqZQwxitiKUw3fG60dgqLfbk48eCf5EDMTrgp
         qCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9U3qsBSVaLdxBGwysRPnWNY0hSOW5bqS3fMTtRWlOU=;
        b=EQCuTQfWgDKXzSn/r4Z7N1O9zj3oSTDJRw5eJcvk1yXwB4evHGeGLBw+p1Gg6iNHWJ
         N5MqXvUoHlT0dMWt9H1Ky4H9Ky7l/yS/iuro8RYG8F1Lb+xH6krNM+hxJ1QLPWCucol1
         eP01hUTHUm9MgQ3xv7Y8CIZ/49+nGlUoyA19OMQOgsTmQD9LZ494GSzyWVLOyY70p9JW
         lrq8hVZdNPDTATAI44ckEzR800KboshHIAypf7qsCFWUSLX3yDRLWPm3WsZL6dh0gOFV
         sPz8PH0DtOsL5U/jw29oG3EaDmy5Mw38btXvPKWh5dYdz2GhaaMcQBTgpGk89QAx9s96
         CHaQ==
X-Gm-Message-State: AOAM531Utx6gfKYRbXYppCnmgEaGww0p8M5bRGXyKG5Oq+Qi2sEBKYT5
        PMlmGm/aYUyOD87wHS2LtGA=
X-Google-Smtp-Source: ABdhPJxsP/J9XGCwUjJcprDJ7lbiUGLbMFq/EQv37a5Rd/1TTPKJOGhRPLSO9Vu4n7hyI2qVikFmFQ==
X-Received: by 2002:a65:63d1:0:b0:3c6:25b2:22ba with SMTP id n17-20020a6563d1000000b003c625b222bamr8702993pgv.360.1654258551714;
        Fri, 03 Jun 2022 05:15:51 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id bg13-20020a17090b0d8d00b001e08461ceaesm7545215pjb.37.2022.06.03.05.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:15:51 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] powerpc/spufs: Fix refcount leak in spufs_init_isolated_loader
Date:   Fri,  3 Jun 2022 16:15:42 +0400
Message-Id: <20220603121543.22884-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 0afacde3df4c ("[POWERPC] spufs: allow isolated mode apps by starting the SPE loader")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 34334c32b7f5..320008528edd 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -660,6 +660,7 @@ spufs_init_isolated_loader(void)
 		return;
 
 	loader = of_get_property(dn, "loader", &size);
+	of_node_put(dn);
 	if (!loader)
 		return;
 
-- 
2.25.1

