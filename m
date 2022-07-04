Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A63564C53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiGDEH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiGDEHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:07:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7BF2ACE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:07:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so6821289otq.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 21:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=bvZuO32vJ2MCGPhr75NSscuQcLF7fdjUpkGaB7ujgdZ7K8joQaXmKsfPYgSak81Plk
         dhoPh4p90SN7qXr4wdTWDfC2Jf090G37MajTNPOTq2lvGYaCgLdUczxIt3rIlzsoE/kO
         U7RZfauPfFIq3s9mPTtYXcYgAx/ABINwR5dW8g85FT/TsxZmnNtUvW65unhCKviKzfJo
         E/eQes5imgo8eBAg1kYhyNdcOpYKRg8M60zNPy+IR9DOtpcYOAcfZ87BeDLV1UKuhL9W
         MfdXiH1I+FIAtwVjbTR/0KTwnsSI8aZfPmguxLr8e5sSyB/4lzmetZE6u6tBH2fBTvAw
         PrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfXx6OUKFv9lmYSVpe2VK14vOIkFTYrGx9cnZE6j00U=;
        b=hF1ys42o5/nSj2otwJ5wlGlj9TufO6GoT0XQioNepCshD+hVQfUn2mzijN4XUYEHh/
         P4FvzQ9KVh/roWylAYeq00srfnY2SLWvOzdgaVr1ejlsxTzdWG+lOTlmpI1BPcpi17Yc
         QqTIK4CI11mWR1o0u9Afd5zVu3H/nzBbuX9ILhCmhwJx278vQYS25dAXkvDYQ72J0Gsr
         pvkc+65rs6ctwTXOzvPuKCcazbcmOGqGoYkT08szCk+5a+4UJ5zgv47v8sGrfcu7/qNf
         /bfCo1kyWNQyeCjamUnOK2hDgbc07Te/r5Pec6XHZzihbJBPXgD4TL4SgBwJuCnH8dZO
         s14g==
X-Gm-Message-State: AJIora8j6jw/lj59tI/A80JuQpeiwKhNqrscaxGPLMzMBLoepv5kP085
        f0byeNj3C2DxVsp12ar5+Fg=
X-Google-Smtp-Source: AGRyM1sbIfiJ+QR7LTy6Xg6T8755iwDb2eCo2/QbwTTb5gbze+0xpygZ4kwQxX0+jHlfHxHzZ4s+hA==
X-Received: by 2002:a05:6830:1216:b0:616:e7e6:501a with SMTP id r22-20020a056830121600b00616e7e6501amr12208407otp.311.1656907635929;
        Sun, 03 Jul 2022 21:07:15 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id bo44-20020a05680822ac00b00335b297ec71sm6079090oib.9.2022.07.03.21.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:07:15 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 3/4] memblock tests: set memblock_debug to enable memblock_dbg() messages
Date:   Sun,  3 Jul 2022 23:06:57 -0500
Message-Id: <aee4200cce1c09992ed055006a81fde1b6b5b567.1656907314.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656907314.git.remckee0@gmail.com>
References: <cover.1656907314.git.remckee0@gmail.com>
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

