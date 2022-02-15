Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4735B4B673C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiBOJPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:15:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBOJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:15:35 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0391425EB6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:15:26 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b22so16725827qkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fH01mniveQGAcj6Bbs/JqhkCysLp12SD3HnMWnq6RRs=;
        b=Du7cJLUV35WA3PTMr3lGkBumroUO+hvhoIyHG5iISRKfCN8gJxVAgT1YXCCfL7v5RW
         h5RtYl6DPFxIedqjHJQVQYgnkVJYYehwbDYl1M7X8IA9NRXyqVj86pINXvziIqaGSGUE
         cSEJ1LY/G01QA+NZaom0G6qcsqljT86Jydrn+ucGpFJUyT5dEU1Y49UF/t2oJP2orwNo
         oDB9LWtU9q3qkbU5ehtnfb+CnUSD+eldHMbNX5chX6+LLzZ+q/eImOw3vwInzmzCPYnD
         /4aLl34D1MRjxBd+4wz1d8TlDs2OBArLsb3+k1qm/KYJy30IhPKEX7l4nnWgxd3M54JB
         b5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fH01mniveQGAcj6Bbs/JqhkCysLp12SD3HnMWnq6RRs=;
        b=GgebKb9X0yiHXax+sl1aGGygr7UY2AivHHxPl2Mt4FSzmXK1zTWyxurJtdhsKqjcSR
         QAPi9k2mYi5Wh4IoghvtxycTX7+rKw1jIMJJXllhlCMX5XMetsM42JMMvv/gWUpE6/f+
         RmsCXGPN0+EWH7GxlY+a6VB+aOxNiq+R3Dzetg2pVx8tFgROGODN5HgpJnNbaOJDhryR
         tbBBYmUn/1MuskrTyxA6yuYrxM5mW6p7E3QkfPKK/6tIL1txfBMWLlpfGvvLzHDaeMP5
         LUIfRcJ2oEt7fakoF5E+uyRInhv0ekTLkmOi7YS1SVZZKK9DwYMtDSdde2MtDVjmCSrf
         lYPw==
X-Gm-Message-State: AOAM532i+id526MeN8dabZtNa5u8kkhGd6chmLQQGBuJ2NejLRU6VRXI
        vuggO/uPOsFuXbBGlKcY45OP8zyTcNs=
X-Google-Smtp-Source: ABdhPJzYNTryRZl8IVPI0AadC9z3pnlC4GJYIPZLOHwLGfIxlejwvwuSHZqpnVZTrPQh6UwheIqTng==
X-Received: by 2002:a05:620a:c8a:: with SMTP id q10mr1448813qki.199.1644916525177;
        Tue, 15 Feb 2022 01:15:25 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id de43sm16379488qkb.4.2022.02.15.01.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:15:24 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] lib/test_hmm: use min() to make code cleaner
Date:   Tue, 15 Feb 2022 09:15:18 +0000
Message-Id: <20220215091518.1776063-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use min() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 lib/test_hmm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 361a026c5d21..cc1cdf79b09a 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -800,10 +800,7 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 		unsigned long mapped;
 		int i;
 
-		if (end < addr + (ARRAY_SIZE(pages) << PAGE_SHIFT))
-			next = end;
-		else
-			next = addr + (ARRAY_SIZE(pages) << PAGE_SHIFT);
+		next = min(end, addr + (ARRAY_SIZE(pages) << PAGE_SHIFT));
 
 		ret = make_device_exclusive_range(mm, addr, next, pages, NULL);
 		mapped = dmirror_atomic_map(addr, next, pages, dmirror);
-- 
2.25.1

