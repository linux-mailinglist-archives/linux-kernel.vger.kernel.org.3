Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5250C505ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbiDRPTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbiDRPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:19:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41AF4A3DD;
        Mon, 18 Apr 2022 07:15:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv16so1576023wrb.9;
        Mon, 18 Apr 2022 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aK4MeadfQ+1NbFGxEqfyTLxfUGxa4k4UU8oEM9B0q3s=;
        b=fcEZ9fAONKGlYYsNruXnYxFgZt19JDTUK8qp+ByuHZ0JkZbH6apbRDkpc1XRJ59vft
         0uVcpml9F0gde7E4M5U5QtNEoU2sKbwXixRQID624emGxR+19fSTboUFSCnNulgMuClO
         xRHjqLPCpEr7hbf3m6k+ZimfLyIEmJKmcQh3JoiRI4Or8ZAX3uu4w3vPtsvzaD+63XeX
         Ge6Mdc5QyyAExIhyfa6dhdyJSSYv4sbnf7LEuFrypf4ghQi3A7IkQAhvWGDbkm2bnCxR
         1C/M8CoplMnC6av7EWCpT+cwepH0T2C+EQNsE45ZwoRGasPn7+VFXWA1VODqG9N5pfYs
         qizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aK4MeadfQ+1NbFGxEqfyTLxfUGxa4k4UU8oEM9B0q3s=;
        b=vW8SQVlDIme23ufMD605rrYfeqltNwDHqch8kG9VcArVX6Wi6fG/apUWcarvUJM8Nv
         5CEAW6/UBUgQ6zfmmU1MJnFU9UVImLv5zvLbr40d+pzJ3/eBvTXpEsHnTnTIGbK+k8cc
         tr8CLCHpfQLOI4NVyJJmja4s/Wj4iZ3ZqoL4R7uiRf8J0TzPMYxc8BIdAsFfzPFDFn3O
         jNSYWaja0EtTrG2+F9rA9R2gWpGFJvPK5014JKQMHW6NyPZSyYJAGxFs+gmbp4Lvct/v
         s1m6vFhgTLJjNK/c1xKY07BqOrhZnGLSUBFnVT8VQlNDoaiPonMCSm7PnaL7ATee8Z/G
         Ibgg==
X-Gm-Message-State: AOAM531YnTt6g3WaKS17KWGsTlgmUiFUCeMDFN3URvu4f+qop2tK6foP
        bP1/O8TInXXsbIgPXw7ade0=
X-Google-Smtp-Source: ABdhPJw/7Vqg6N8cUyh7HbbfJ6gTu0/cjFNupDra5Dx1rU7/OccnES44M2MLGIYQlL+fIUwxVz4Dsw==
X-Received: by 2002:a05:6000:154a:b0:20a:9529:aa8d with SMTP id 10-20020a056000154a00b0020a9529aa8dmr4413418wry.93.1650291338318;
        Mon, 18 Apr 2022 07:15:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b00392910b276csm6875688wmq.27.2022.04.18.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:15:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] clk: actions: remove redundant assignment after a mask operation
Date:   Mon, 18 Apr 2022 15:15:37 +0100
Message-Id: <20220418141537.83994-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The assignment operation after a & mask operation is redundant,
the &= operator can be replaced with just the & operator.

Cleans up a clang-scan warning:
drivers/clk/actions/owl-pll.c:28:9: warning: Although the value
stored to 'mul' is used in the enclosing expression, the value is
never actually read from 'mul' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/actions/owl-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
index 02437bdedf4d..155f313986b4 100644
--- a/drivers/clk/actions/owl-pll.c
+++ b/drivers/clk/actions/owl-pll.c
@@ -25,7 +25,7 @@ static u32 owl_pll_calculate_mul(struct owl_pll_hw *pll_hw, unsigned long rate)
 	else if (mul > pll_hw->max_mul)
 		mul = pll_hw->max_mul;
 
-	return mul &= mul_mask(pll_hw);
+	return mul & mul_mask(pll_hw);
 }
 
 static unsigned long _get_table_rate(const struct clk_pll_table *table,
-- 
2.35.1

