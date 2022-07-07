Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3348569C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiGGHws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiGGHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:52:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27133364
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:52:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so15491851wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+0V1FswFhS8JDSDQi560ezRR3egayVm0kqkR8HX1a0=;
        b=s7qniQ82clkr0qiDz/59anL2Yhq0MJPmg5Uo+vvMjhFZ2nNzPjMoByBSrPJZvNcNyJ
         ijbTMdy1h4wdCvGOOU18QWioh7teFl4wVHMQ+O47et+Aca3Gyi2aNjbtYa6j+PGDAbem
         We2Y6w8oMpa44OGB09r5nzcNCuMgj3poFhkqfMb8iDPwPu/s5VufDiGu3yqMgzvte3Nl
         DwxzWvI0fHEcUTDyZwfcdmZVyzjkjU0xNv1JOPsnfU6TABEotuD1zrg7jdXu0tNnz93v
         hG/hTE8orD4FTYfMjh6pA5aR1murMAGzonAcIFaoRU+l3wmjCAgOOMnNCL2xfuW5iLq2
         7x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+0V1FswFhS8JDSDQi560ezRR3egayVm0kqkR8HX1a0=;
        b=gPn7A1d+8qd7QLQY7WRRnZxB1MldwBuC2A1KXUW9Bw4EChrt80LKwvbu9KmC6cQoL5
         HqgWVpWzDH0GCuiC71u4+U0PamOxjac6IwsEHpxvZm5bFHr+H095kdqKDQ7zUabqbNm8
         R0odNdRn+t8UJaDoqum/9X7aOFzylGnpy7C96qU0ZV7TTHOr3q1OdrG6AckIjgEIpjUF
         7h2vUYOD0psZ5sEz+QfGv0sGmJjmlUITnBHajveEGEE5g4fAi1LYKDjpkvumKicJQiF9
         fs4tZhv1T5VTEXQ39iZPuGM9MPEMZIX+kzn0KVfPTiECai7XhtFNYxJfcjXkEhwusY0V
         deUQ==
X-Gm-Message-State: AJIora+XIVySB0t0Jsw+dnYDj/66TyadeZmwV38qf7ffnw1BIs4PQFMy
        27s65uE6JsiSl4clWKz5AWTSWw==
X-Google-Smtp-Source: AGRyM1vpNxZN7VNyJdlVhEnP2s+sR0sREI2vQy0cjQ06bLJ4egqraKcgsxkQF5alFIsdPU+dYGR5nA==
X-Received: by 2002:a05:6000:1ac7:b0:21d:134e:5d74 with SMTP id i7-20020a0560001ac700b0021d134e5d74mr42907947wry.78.1657180360266;
        Thu, 07 Jul 2022 00:52:40 -0700 (PDT)
Received: from groot.home ([2a01:cb19:85e6:1900:334b:5931:88c6:bbd2])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe950000000b0021d70a871cbsm6972089wrn.32.2022.07.07.00.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:52:39 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <parent.f@gmail.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Subject: [RESEND PATCH v3 1/2] Input: mt6779-keypad - match hardware matrix organization
Date:   Thu,  7 Jul 2022 09:52:35 +0200
Message-Id: <20220707075236.126631-2-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707075236.126631-1-mkorpershoek@baylibre.com>
References: <20220707075236.126631-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek keypad has a set of bits representing keys,
from KEY0 to KEY77, arranged in 5 chunks of 15 bits split into 5 32-bit
registers.

In our implementation, we simply decided to use register number as row
and offset in the register as column when encoding our "matrix".

Because of this, we can have a 5x32 matrix which does not match the
hardware at all, which is confusing.

Change the row/column calculation to match the hardware.

Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
Co-developed-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/keyboard/mt6779-keypad.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index 2e7c9187c10f..bd86cb95bde3 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -42,7 +42,7 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
 	const unsigned short *keycode = keypad->input_dev->keycode;
 	DECLARE_BITMAP(new_state, MTK_KPD_NUM_BITS);
 	DECLARE_BITMAP(change, MTK_KPD_NUM_BITS);
-	unsigned int bit_nr;
+	unsigned int bit_nr, key;
 	unsigned int row, col;
 	unsigned int scancode;
 	unsigned int row_shift = get_count_order(keypad->n_cols);
@@ -61,8 +61,10 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
 		if (bit_nr % 32 >= 16)
 			continue;
 
-		row = bit_nr / 32;
-		col = bit_nr % 32;
+		key = bit_nr / 32 * 16 + bit_nr % 32;
+		row = key / 9;
+		col = key % 9;
+
 		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
 		/* 1: not pressed, 0: pressed */
 		pressed = !test_bit(bit_nr, new_state);
-- 
2.34.1

