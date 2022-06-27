Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9018555C6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbiF0Wf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiF0WfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:35:19 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07778205DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h65so14805716oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=J5kQgTgr6JSUUD7EGHpxiWOH7eDrhB/0cYKpphBted9OFDOSVWq5OmmA22fOUQta7j
         4uHphCqZlx40CJMFDvbBv3yLC4AXVl1hVvOmfjnFdlEEeT2A/YAnI2RZnoZoCoA7WlDL
         N4sRXor2rpzDkndOc9sgw8Ya9PMsRFDwLBsjh0UTUXnRwcsm/yeH3JOm2HJwmGD9tpwe
         RM6EBB71MxsgRdoCBntQtN/2xFzgq3GIhzDIHgPyi5WQr//5FRTyeOV/DZ/AEpVNuH3/
         PhpTwLGnpkluxF4wH1bYv2klCYmN3TScTFp4eybapuzkAiFvK/OIddei3Q2x38WNKjMv
         C/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=R2QowHRK12UC/YgLfF8HrdOWBL30/dfjfeg/BEolx3uxTKTvy3kmmyz1DUyvcXaPoq
         98P19QGWoGtOVrDvASLOndkHM1JD2KAe0a7n1we3pNVs41Li6P91RoZDKmkZSl6r2wwY
         YHWBIW0sU0WNWRokVIjFpqz0EiWNDX4cw/hCPpPIs9lKSXouucN2vuS4lVe4IKtsMdci
         a/g6T1e2lln/ZqPyqsKKE+OfO6EtNOcMYqg18rBy5F4c7jhZh1Y735XZSGZc9piRnG9q
         bo5CFk/G+8v8dlMI9t+nA5764M1qmAn7yeCkYLN/akrtLBPHdn8Xp/71dyX5OLeqUJ5c
         k61Q==
X-Gm-Message-State: AJIora8AcMXLbLi9pRso7KUezPKQz+ndEhWzeefcR9wVljp1Gi1iKeMd
        ncSaN1wGuYlFsQLx4R3NBws=
X-Google-Smtp-Source: AGRyM1v7C/R3OZltTwTg3XDCHKk/ykfKaSvmQOv0yaVjZNT3Ft/473i7VabYc47Jbm920piZQjIhSg==
X-Received: by 2002:a05:6808:f03:b0:333:401b:2804 with SMTP id m3-20020a0568080f0300b00333401b2804mr9924301oiw.179.1656369317390;
        Mon, 27 Jun 2022 15:35:17 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id s8-20020aca4508000000b0033578d53265sm1654990oia.54.2022.06.27.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:35:17 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 3/4] memblock tests: set memblock_debug to enable memblock_dbg() messages
Date:   Mon, 27 Jun 2022 17:34:29 -0500
Message-Id: <d4ea624d4cfd319bcb31ce40068febc3d90a3462.1656368930.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656368930.git.remckee0@gmail.com>
References: <cover.1656368930.git.remckee0@gmail.com>
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

