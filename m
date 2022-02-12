Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A753E4B35D1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiBLPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 10:09:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiBLPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 10:09:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75440B0B;
        Sat, 12 Feb 2022 07:09:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h6so19844163wrb.9;
        Sat, 12 Feb 2022 07:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6rK33RVsJ8ict1sPgpfIjdEeAWbWsXMVJ0khfSr/MA=;
        b=GKradZqxOgToue9ytU42MEBx+sFCTatmIhU/hgAN0i8fRncz8bb8ao0jjbXEdh/wg0
         xhklPOL8vYJnud/PIzw63QX9CaxFDb01Pd3PxQFSxJX7Fs2DuV8sgEKlwuW8WA99krIP
         FQ03hGJYQqIvhqiE3vxurHjWL1YJISlxEMH/1juBXIkkMOBDT18zOXPkG2BUsknd9gw7
         SJut4z7b0naFdbUDyKMBpSqIKfYH9nCOIhiUKXSmQJyCAsoDoyaF6NLnhxqKVTtw6gax
         D1Vo20ntQOxzIJJRnXVegOdhg59vqFnQeHIhtE0H5PJ2Z+zQyA326UESfl9CeVrrsE6R
         vpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6rK33RVsJ8ict1sPgpfIjdEeAWbWsXMVJ0khfSr/MA=;
        b=Z/yzNDN955ZT9dPgkAZfMm/3xBrjr0Rsz5tTRLknfZYh8rM813tjA+TXvDo1qb6N9/
         ggELDjvmOods54ZsJXdz7P7jWLSWb0Ju7meByv1MwKb11xEvyz4b3D50xDfM9h+9UQ/3
         P/4FUu5v9Kxsm2TXKsYIdbUg7yRyQsiPf7wnW/lhHoXCuLymMCLKj6D2jw3gSKJLziv7
         5PE3hCY5DGgNlXi0fmAOM5jSgX1ouOH1kv0beJBTxlWqpI88iDIMm2UgERfutHh1AXyt
         Sw7X5DB7Y6NU4l6pquynGXqIewew42t6Ca0SYx1okpQ8tqeghdOQ1OMus15jxCi1NDh0
         +9Lg==
X-Gm-Message-State: AOAM533ccAxv+KR+7EwQ/6BSjkbumSP3NAVN3sub3MGfNZYJYMoTH5x3
        M0XfNg2ywA0ulVsCYqD9jz4=
X-Google-Smtp-Source: ABdhPJz/oimDtL1dKb7oi5BhaasQds+dZlobT7RnNlFaApC1121mN3wXqZz0qp7njb1K3LLqge55tg==
X-Received: by 2002:a5d:598a:: with SMTP id n10mr2765332wri.364.1644678590051;
        Sat, 12 Feb 2022 07:09:50 -0800 (PST)
Received: from localhost (92.40.203.136.threembb.co.uk. [92.40.203.136])
        by smtp.gmail.com with ESMTPSA id o4sm4582459wms.9.2022.02.12.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 07:09:49 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoC
Date:   Sat, 12 Feb 2022 15:09:28 +0000
Message-Id: <20220212150927.39513-2-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220212150927.39513-1-aidanmacdonald.0x0@gmail.com>
References: <20220212150927.39513-1-aidanmacdonald.0x0@gmail.com>
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

The X1000 does have a TCU clock gate, so pass it to the driver.
Without this the TCU can be gated automatically, which prevents
timers from running.

Fixes: dc6a81c3382f74fe ("clk: Ingenic: Add support for TCU of X1000.")
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
I've just realized, maybe this is an ABI break. Now that the TCU clock is
required, the driver probe will fail if given an old device tree which is
missing that clock. Is it necessary to add a hack of some sort to support
the old device tree?

 drivers/clk/ingenic/tcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 77acfbeb4830..9c86043f673a 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -320,7 +320,7 @@ static const struct ingenic_soc_info jz4770_soc_info = {
 static const struct ingenic_soc_info x1000_soc_info = {
 	.num_channels = 8,
 	.has_ost = false, /* X1000 has OST, but it not belong TCU */
-	.has_tcu_clk = false,
+	.has_tcu_clk = true,
 };
 
 static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initconst = {
-- 
2.34.1

