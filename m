Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33D55460D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355667AbiFVJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356754AbiFVJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:29:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD8E396AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:24 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s20-20020a056830439400b0060c3e43b548so12633982otv.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=mUFh8eRq4qQBRgjBDWi3lpzdhCpt1bXMCv9galxgsLml+K45xfP7UjqZXIy9RuhagS
         XUqMzrrmcYIKCfsGkH0NOHLyUMo6/CtqoK9DOQJ7Piih2sJS5fbzWNK7EhTuyNaxx88r
         MEBil20mlTGEWwTZxmnW8OVTQ8lvH4Fyxz/0Z2MwZMSpiva1vO21WL60Z9NjcLq6auQ6
         PtmhFI+5TDJXLcFtOP3CT9FVrKte1y2v34vAf6r4xHQpaBrqlw9sbKuuiGmk99u7/oME
         hhzzPILM94kzYPCu86ZDcYRQj1K20CBPaOHsHOgIVgoHg8kyO5E8mzgVTFXP6xOxbKFG
         tJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=xrBaL6mB28hZP1lLjuum5dZvfdn3CByMzdOmha2YfClvLECfA8wkKBsYo2sQHknSzf
         btvaZkkuTRDxg70LEtEwQHfe+8CixFyQLS2gVYsSm06gJtKxxRDtsFXzB5EuZP7kkvuE
         LQpiviUf5InimUsLkAHDIhgRidTtdfPjmK7+ndsSLpzEksmQngnhGPv7kolqKPfcLGD5
         xN0UhdqepDtRiKjpbnGjLWzOWHxrdDEvKtoIyil447hVSCiefmPbEKkOGIMyEpEjE1D/
         vssL+Dg3KNvRGmlfjBZX7CBycsNDkStg0wgIOWNAKExymWT8IJu2GzAwfVKpi+kg0Sp1
         nZBQ==
X-Gm-Message-State: AJIora9k1P1PHzAt4KnPa5tsY182JlQ9lPUxadCfUuG1UWJQXv9xWMCM
        35dW1IkpZ+hOj8SGh35HiH40TlYQc40=
X-Google-Smtp-Source: AGRyM1sVGvUWz0BD8tejsjDQkqxdmNwvMms1D0vqtRylPH4AAbRLuj4vjhqcFhAGnzGbBhtD8XX4gg==
X-Received: by 2002:a05:6830:2016:b0:60c:468:e30 with SMTP id e22-20020a056830201600b0060c04680e30mr1065968otp.271.1655890164154;
        Wed, 22 Jun 2022 02:29:24 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id r23-20020a056830419700b0060c03836d04sm10867095otu.77.2022.06.22.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:29:24 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 3/4] memblock tests: set memblock_debug to enable memblock_dbg() messages
Date:   Wed, 22 Jun 2022 04:29:08 -0500
Message-Id: <39c5c97d2b5c1ab88b7bbbf02633f840fd5dfcdf.1655889641.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655889641.git.remckee0@gmail.com>
References: <cover.1655889641.git.remckee0@gmail.com>
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

