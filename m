Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F245355490C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357525AbiFVJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357324AbiFVJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:11:51 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D813D7B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:10:04 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so21635086fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=PuiztTqdl2RwR1NhqVtYKiAaZr1SnfcHUzvneUWy9YA6QQHXYrzdtpo0IqVP1O5Q4p
         aNMN9UnfCEqmN1EdwSHZKH+tSrO6PC348HRxEXEc1s83gNEzLyb9vEusOfyGMrOEXtCV
         Vob3cAkPMjZxdzz3GANlGjJTntmyLB3biU/JZvPih9f6Pgl7D1+BL3h1tZP55vFAWjtQ
         fkzXNCZKuMoEjQvXAcKpyY/J8ul8j5Si0uCZElVAT5mt1XlUuBFmeYrsbxMFWRLWYsco
         dCcIbnkO+v2bHUUZm54Pc8vnD4PwkYnGU64XdMktnQdi9b1r2z6bFvP+7AUHpsEBGrxK
         kAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=u9/lZGVKlIng3qrlUBv37E34arDsB24jPKSR0kQ7OZfnFvYSMNVBzesyaBrP8ASpB1
         zlND0nXif6oWwoJEsqQzByRAJXLyL1i1x4idUeOxhUvJLLMfMCc+D7PcyZ+c6Jm/jqhv
         f+cl75DeSI0YrhATh4p5WQKh2jeJmG0+EP5s4rt95hxhgbs1+Cqr7DUiCqE1pEl92Yhx
         NP+XqGE3MzDE/gB2WAEVMNd3A4a/3Uod0TOUiUEoPXrmIT1Oj4YvPBTblgpGm0QKXi/1
         kV0w9HS4KneP+zIsMSLtVmKb6uhnxKMelMQEGa55iavH6DQ4i7mBC2RazaqV11p1f+95
         jYgA==
X-Gm-Message-State: AJIora9gHAf6E/cZ90QAumlNTBXRl7nj4tUQsQxjAYpeQaYh7WFQdW+0
        SVHOtNBjX3huX/nOrU+AhBk=
X-Google-Smtp-Source: AGRyM1s6OZ6mHTCyIOGooSMYkri8CJ/yK32JItOIKeC2zQt29rWrX3ElmiYbaJrNtpypPq7cYMxKdw==
X-Received: by 2002:a05:6870:b40a:b0:101:a393:4cb9 with SMTP id x10-20020a056870b40a00b00101a3934cb9mr1472021oap.12.1655889003627;
        Wed, 22 Jun 2022 02:10:03 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id c5-20020a4ac305000000b0035eb4e5a6bdsm10913829ooq.19.2022.06.22.02.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:10:03 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 3/4] memblock tests: set memblock_debug to enable memblock_dbg() messages
Date:   Wed, 22 Jun 2022 04:09:45 -0500
Message-Id: <d095338302d28d3835d0a031de6c37c99c1072a0.1655887571.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655887571.git.remckee0@gmail.com>
References: <cover.1655887571.git.remckee0@gmail.com>
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

If Memblock simulator was compiled with MEMBLOCK_DEBUG=1, set
memblock_debug to 1 so that memblock_dbg() will print debug information
when memblock functions are tested in Memblock simulator.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index 94b52a8718b5..c2a492c05e0c 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -2,6 +2,13 @@
 #ifndef _MM_INTERNAL_H
 #define _MM_INTERNAL_H
 
+/*
+ * Enable memblock_dbg() messages
+ */
+#ifdef MEMBLOCK_DEBUG
+static int memblock_debug = 1;
+#endif
+
 struct page {};
 
 void memblock_free_pages(struct page *page, unsigned long pfn,
-- 
2.34.1

