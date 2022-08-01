Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5911E586F98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiHARc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiHARcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:32:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E72655D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:32:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v18so11076782plo.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=SunuZnU7T4CE2remubz9UBNubgP2sRU6U2kOV3j7OxI=;
        b=jR0Q5aUO8du9aLHcUQDHwAwJI5wVFt/2RONi9H+OMvd+6a7Z2cFeeBsX1RKXVv7PIn
         8bG+egZ4Y5DYlG1e+B/TwOtYt+wb8NOpEz5jwRb4YKtTB1RcJ7U9qjaLDQP4IVNndTgp
         UEnxminfoj1iujfrDUE677GASaAvWyfUf6bFybTEXPrvaC1JfTaHHVlUAFKVCQrjAkG9
         89kZk5YRtP+XegbBxSDRMxJzJBBb09B+/v9Gl3/aUKLfCMaEtrvFjszCXRI8wfgdNNSm
         ww+vUsbh/V5WNWPBEFKwyFamWfpbqGNvvtEDMxSvXtncPJ+Z+2XDlvu4Dv4c4VVhln2N
         labQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SunuZnU7T4CE2remubz9UBNubgP2sRU6U2kOV3j7OxI=;
        b=Uf2AXimruGb9B3C6/MrxbyYfrb8AFkpH4a64W5R9Mt2T1MHATEaoWEQxdTBYKo6ksh
         w7WCqyLXmQKLxIqo0ZjLtpes5uaKU7vK5CNf4MOC2Ez3PSLdxMY3zRQSTNz55/xcF23y
         K52xDLBUWLBlW2Cf1Lp1X6b+TwUTVzQsjHXga8FW64W+Swt5Kv3cCe91KiiQaGWjsjIm
         DD2gX7EILklmHUn/LJh5MUctnm7xmXuuO9WGor5GO1mILtnc4thTg5OmdnSpS22rPIMr
         S02+LIzy9FTCgP1cUDhFIC9LRs9zrnf+Jp1BHIj9IXsFMdfVMXUWKsNnItezutNbovVa
         lNfQ==
X-Gm-Message-State: ACgBeo1kl7m4zlva6mdQMcFTjVhi3q4qeMmhrMrHIbFja3deUSsyKfhM
        0NUweWMhNq/ZO4Or4MIAqv+ZfuC/hHG7eryMXIw=
X-Google-Smtp-Source: AA6agR6RKZHX/DsN5s+EpIqK6F4Fe8VFvCU6UXdmiCHA1tLHK3pbipCkdwWe9KYMp5YkYCCYN8vfJA==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr19797299pjb.98.1659375142655;
        Mon, 01 Aug 2022 10:32:22 -0700 (PDT)
Received: from localhost.localdomain ([240e:305:1782:73ba:780e:897a:ec8d:6b79])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090b010500b001f325b97913sm8961486pjz.53.2022.08.01.10.32.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Aug 2022 10:32:22 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm/util: reduce stack usage of folio_mapcount
Date:   Tue,  2 Aug 2022 01:31:55 +0800
Message-Id: <20220801173155.92008-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

folio_entire_mapcount will call PageHeadHuge which is a function call,
and blocks the compiler from recognizing this redundant load.

After rearranging the code, stack usage is dropped from 32 to 24, and
the function size is smaller (tested on GCC 12):

Before:
Stack usage:
mm/util.c:845:5:folio_mapcount  32      static
Size:
0000000000000ea0 00000000000000c7 T folio_mapcount

After:
Stack usage:
mm/util.c:845:5:folio_mapcount  24      static
Size:
0000000000000ea0 00000000000000b0 T folio_mapcount

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 0837570c9225..98a589bb89c9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -850,10 +850,10 @@ int folio_mapcount(struct folio *folio)
 		return atomic_read(&folio->_mapcount) + 1;
 
 	compound = folio_entire_mapcount(folio);
-	nr = folio_nr_pages(folio);
 	if (folio_test_hugetlb(folio))
 		return compound;
 	ret = compound;
+	nr = folio_nr_pages(folio);
 	for (i = 0; i < nr; i++)
 		ret += atomic_read(&folio_page(folio, i)->_mapcount) + 1;
 	/* File pages has compound_mapcount included in _mapcount */
-- 
2.35.2

