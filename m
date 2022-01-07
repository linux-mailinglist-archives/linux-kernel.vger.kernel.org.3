Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FFB487DD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiAGUts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbiAGUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641588587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rFO4WJY3j7pAXTu1RPPXXQTX/D3JtAjVln6pv17Se70=;
        b=QP2uhfeKZQ3pv0c2Zhq0053SBDU3S9zMa+nnPK46aNDGJaJN9PQhK4CQHeGt+w5iI0iT12
        RdYhv1Eprq+ZSS4FxQnNhUZEn93HOzFrRj4CGjad/RlT3k0gE6YKqY3j9TVwBgErUCAzD5
        wBteD1wfOokA9/8IcqkDwdvIPCtpD+0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-Xoe8WidWPkCxo8XaTXAS5g-1; Fri, 07 Jan 2022 15:49:46 -0500
X-MC-Unique: Xoe8WidWPkCxo8XaTXAS5g-1
Received: by mail-oo1-f70.google.com with SMTP id r25-20020a4ae5d9000000b002c9ad00c5a5so4220510oov.22
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 12:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFO4WJY3j7pAXTu1RPPXXQTX/D3JtAjVln6pv17Se70=;
        b=AYcNoGgZm3xYAnJ05QMkjb1UrAvkEFHzobWcBuldKg3U38UoIBSbxElHKAlXcdOXQ5
         AIp2/2Z3e9x9xEV+k+wNIFoWfFe9nPfbnVrcOSM1huUz57aZm0Xv9XQPjBwGB10dP0ge
         2dyDyqDkWTlaZJvfGlnZrcsgxwSqAzAGLI+qTWL9sS59eOuOwZT+zpEDVkScWPEmwJy4
         7omAxtbHzECiCyO3FNHuTErzXFwp4r/72hjr+j/btmjUhJZwbCoA2kjOvEaOJrYCONo9
         dKn0T/EfrCKXNj58OSo3IbNQOZdXQjzA0VFWW1S0EP0G+3rb6RyaXDw+opCAPB8U8wMJ
         W29Q==
X-Gm-Message-State: AOAM531b1Vcc8yF3ELZOaSixGcuyCVLorQxZnfjM6GfCHH4X68zcGtnV
        bsQ4fNueNCVqdpvPFKV/ZVmUCcAEAI+pOHrQW3PDXnt8ACzQuzQrtoPuJczXc8eRQuDS0+mdEQ+
        K2fgaN7RmXWW8QVHA9KMXo867
X-Received: by 2002:a05:6830:2b14:: with SMTP id l20mr47451468otv.42.1641588585253;
        Fri, 07 Jan 2022 12:49:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoF/ZqeM2gXeI5h7MGTxjtgzAX2We+Kfkvc0DuwXwOA198L3Mc61AmDSUseGbyUBDzv34mkA==
X-Received: by 2002:a05:6830:2b14:: with SMTP id l20mr47451453otv.42.1641588585073;
        Fri, 07 Jan 2022 12:49:45 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e4sm1133222oiy.12.2022.01.07.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 12:49:44 -0800 (PST)
From:   trix@redhat.com
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] clk: visconti: fix array's data insert check
Date:   Fri,  7 Jan 2022 12:49:39 -0800
Message-Id: <20220107204939.3939151-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang build fails with
pll.c:292:20: error: address of array 'ctx->clk_data.hws' will
  always evaluate to 'true'
        if (ctx->clk_data.hws && id)
            ~~~~~~~~~~~~~~^~~ ~~

This check protects inserting into the clk_data.hws array.
clk_data is allocated a trailing element of the ctx struct.
If the ctx is ok, the ctx->clk_data.hws will be ok.

Change to checking if 'id' falls outside of the array
bounds.

Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and reset driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clk/visconti/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c
index 3b6e88bb73d5b..7f2e1016536ab 100644
--- a/drivers/clk/visconti/pll.c
+++ b/drivers/clk/visconti/pll.c
@@ -289,7 +289,7 @@ static void visconti_pll_add_lookup(struct visconti_pll_provider *ctx,
 				    struct clk_hw *hw_clk,
 				    unsigned int id)
 {
-	if (ctx->clk_data.hws && id)
+	if (id < ctx->clk_data.num)
 		ctx->clk_data.hws[id] = hw_clk;
 }
 
-- 
2.26.3

