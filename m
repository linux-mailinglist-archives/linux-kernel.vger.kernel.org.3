Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260C656BB7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiGHOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiGHOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:07:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF93313A8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:07:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so37850354ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UmQMSw/Lo/aUgwdf6X3tLXsFA1/lan16IQ3/ce55QGc=;
        b=e//7/zevFojSgOmv1iUZPcR9RxpOxiTq/3m9/uN6nMSXeI3cXH4ixaWg5fpOBb1Xyq
         2/6CsOMlmIQ90xk3ZqpS9GmPsMEN77fRzrXujYwyvsFbFyV+Yr6pt7yDy8oh4YLBJHuI
         J4kwdndVmwW26wL2r1fIHKQXzEUE7DZIyQAZGyj6Jt0fO9fs6YuDgnPOK9CNdckL5ovW
         9ckRgnYGvYqeB3OyMnm6b6nYTos1wFBo2zRVCQH6TzwBZY1iiWIj/wS0HJu578+a/37m
         CBMaGj+SfkKAEihV4KGfQTD6lzxvioUDTGkr2PHCMSz63svr+8UiaWd4Huyh6CIUuIWQ
         Gt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UmQMSw/Lo/aUgwdf6X3tLXsFA1/lan16IQ3/ce55QGc=;
        b=YYsjxGiXX5iPnui2qAzY6Sx19tDduizZwFLHCW0pFWGMlzjjiP9vGPt/U1EiqcxAI1
         bJ/IKNWvxo8wpvbcLe7tLT0ad/Veu7lSEpBUQiSmwMJN2N882LIMayREpN7YSx0OLMBa
         Z8Hn/BwDVSvi2oGPslQzO6QSK8iI9yqmiddpU9BLmD66WAIyjhAbPWSqnDhBb1F7A/Rq
         sxi3RJP7nLY8r1jz61lHDCJz89DoWeZwIoAGMcKWcPnwF/JaQomwm1epU2WGhukj8uFm
         IX2xwaLDdmxk3laEbyIxRkmWE3CXDQ6DgSX+lvvfHuQNI28LS0lQ5E/LGIHYFlbPVkT1
         uW9g==
X-Gm-Message-State: AJIora8NXW7RZFR3+NiPndmewAPbMs3mhOM7/3BPAoq/sSAu/gUjjbgG
        fJ/AOl722b8T+79UNaAdh3FrwUQ6gZI=
X-Google-Smtp-Source: AGRyM1t1DjCzfOwLiRgELsKcXKYuqKjMDw7UMRA/ZepHVRPjeRcW0Dz4HWw2KyJ1desnWjuhUEvOGw==
X-Received: by 2002:a17:906:e16:b0:726:a026:27ff with SMTP id l22-20020a1709060e1600b00726a02627ffmr3646857eji.573.1657289266405;
        Fri, 08 Jul 2022 07:07:46 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906308100b007030c97ae62sm9533959ejv.191.2022.07.08.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:07:45 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/page_alloc: use try_cmpxchg in set_pfnblock_flags_mask
Date:   Fri,  8 Jul 2022 16:07:36 +0200
Message-Id: <20220708140736.8737-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Use try_cmpxchg instead of cmpxchg in set_pfnblock_flags_mask.
x86 CMPXCHG instruction returns success in ZF flag, so this
change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg). The main loop improves from:

    1c5d:	48 89 c2             	mov    %rax,%rdx
    1c60:	48 89 c1             	mov    %rax,%rcx
    1c63:	48 21 fa             	and    %rdi,%rdx
    1c66:	4c 09 c2             	or     %r8,%rdx
    1c69:	f0 48 0f b1 16       	lock cmpxchg %rdx,(%rsi)
    1c6e:	48 39 c1             	cmp    %rax,%rcx
    1c71:	75 ea                	jne    1c5d <...>

to:

    1c60:	48 89 ca             	mov    %rcx,%rdx
    1c63:	48 21 c2             	and    %rax,%rdx
    1c66:	4c 09 c2             	or     %r8,%rdx
    1c69:	f0 48 0f b1 16       	lock cmpxchg %rdx,(%rsi)
    1c6e:	75 f0                	jne    1c60 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_alloc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..d415d5b539b7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -524,7 +524,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 {
 	unsigned long *bitmap;
 	unsigned long bitidx, word_bitidx;
-	unsigned long old_word, word;
+	unsigned long word;
 
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
@@ -540,12 +540,8 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	flags <<= bitidx;
 
 	word = READ_ONCE(bitmap[word_bitidx]);
-	for (;;) {
-		old_word = cmpxchg(&bitmap[word_bitidx], word, (word & ~mask) | flags);
-		if (word == old_word)
-			break;
-		word = old_word;
-	}
+	do {
+	} while (!try_cmpxchg(&bitmap[word_bitidx], &word, (word & ~mask) | flags));
 }
 
 void set_pageblock_migratetype(struct page *page, int migratetype)
-- 
2.35.3

