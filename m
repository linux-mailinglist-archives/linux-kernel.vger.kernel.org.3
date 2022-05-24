Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE353532F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiEXR2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiEXR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:28:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC27DE23
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:28:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d22so16410388plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQSXOGBPTe2uw0qPjIIRPCO+MsJXruCMk2fBLAYYqXA=;
        b=SMLKrRvgc/KrH7nqdtcAGv/w6WVgHYGDMTNxXymT+PIT3qI9xE5xRuDvStKpTZbMXt
         zLx0qqGhh9+Xe0u49z7OgT/yzgZzmY/7hM3YveAoRyOyiPXVxyENFk012ZMHkgdO6iF4
         dclSnc56WA7bYzd6iCQrGr4sVbgqKdh2Mjf130eX4fsZuNq7X7RiwjlXJUoDIM2uQZAr
         8Hl7xzfeCJ/KE/pX2xXckAHsN01i2+4TTP7o28H+XBzQXC+/1xhSzJ/lmvBQwfgFiPH0
         +jtlFOfItgDT0bITZgkfDDJXiapu+Z1f6PLIbGnS0TDbauiK37mByB0WywIgAaSA1amA
         Sgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQSXOGBPTe2uw0qPjIIRPCO+MsJXruCMk2fBLAYYqXA=;
        b=ZZiJ8m/ZZjcaS50HV/YZcWuna1OxoGp1ftWJjyDiO4nlBBKnPHNyt3J/Q0fSynNxKs
         eMu4wKJl2L7ZkWathpo6R3/iSZfkAlWjZNgnrguvtcNmnV0rMBkOEKxEvLwzXx6z5UNi
         dLNjT1JtN/jEsAtLMaAA1m7Mkr6hDZ5ucXwGCOhzPS093YZtB4HocSMfRZyOkrpiWaz2
         p3qJdjuEodLedr1TookviRBqEHagVv3NAsDHF/5YVxC0EhoIlk4Ph7uO6QFzFYIc9eXA
         bQj4rFp0w9VosdA7P6mFMRB66h11w4l/qxum8uO85QBwXIKt8PzQf8ZzF/q56r9Czhm5
         9tsA==
X-Gm-Message-State: AOAM531/hTM8LruNtlTDtH78nAcFZWnOxyd6a+3IXzoK09JyBnrKLfFL
        rEwqnePy9p3DPATn2rqspgo=
X-Google-Smtp-Source: ABdhPJxtyLUP5CjnATo5cBrld/MCmrqLC9oAQT9qim9Xt8yHRxK3xMyYy+Qp/XMm3N4d1auSj+NHOg==
X-Received: by 2002:a17:90b:1e4f:b0:1e0:b91:39ef with SMTP id pi15-20020a17090b1e4f00b001e00b9139efmr5532443pjb.51.1653413281244;
        Tue, 24 May 2022 10:28:01 -0700 (PDT)
Received: from ubuntu.localdomain ([103.230.148.185])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b0016144a84c31sm7573894plx.119.2022.05.24.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 10:28:00 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH] include/linux/mm: Initialize an int variable to prevent returning garbage value
Date:   Tue, 24 May 2022 10:27:55 -0700
Message-Id: <20220524172755.11892-1-gautammenghani201@gmail.com>
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

Initialize the variable 'ret' to prevent garbage value from being
returned. This Fixes the clang scan warning: Undefined or garbage value
returned to caller [core.uninitialized.UndefReturn]
        return ret;

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..f437bd81d6a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1700,7 +1700,7 @@ static inline int arch_make_page_accessible(struct page *page)
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 static inline int arch_make_folio_accessible(struct folio *folio)
 {
-	int ret;
+	int ret = 0;
 	long i, nr = folio_nr_pages(folio);
 
 	for (i = 0; i < nr; i++) {
-- 
2.25.1

