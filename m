Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649EF513A33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbiD1Qrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350268AbiD1Qrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:47:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF96B1AB0;
        Thu, 28 Apr 2022 09:44:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q20so3287882wmq.1;
        Thu, 28 Apr 2022 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jo7tWOSsCgtTcP6fE9H4HS3FFxnoGMJ2maOVgOmkHE0=;
        b=A+Fljyzwqh3DrLonRv/nd+/Y/uw/gWADsGYkS4ovl3z2I+C+xEQm61Mx9p4Lzmgqoc
         XOB8U4z4+Enx3gYB9+pN90dvB8/A/AWe2FDKR6irzVvYpRoBO1uNX4S2AancqNqHpOe0
         TSpVGhx2tq7nvbQkir5MnS3y//cuuWt1g7EAxS170vhq7OhZqfa146HSSjtpIZiDxhx4
         hc9Alpt7SmiHpiHDZGtMz12+CN5t36Uxm3pZ7jDyeuebKoKMF6R8r/xqJk/i0rWm/C3i
         sdAuwP0LmoYEI6TZeevRTuEls4oYhO5tL5QGsjC8GICW4EAJcuzE+FP7AwUy6o4gUp4H
         LC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jo7tWOSsCgtTcP6fE9H4HS3FFxnoGMJ2maOVgOmkHE0=;
        b=VIcJsj+koqJ0Gp0mVZS70SVWugHidlceLSO7iU0MjEAy2rcL56KK8Bd7+t1h0yMUoI
         4VEyNowuPAJ5UiKDRe3I8ZBq1iq8x3kyKkGNcACu2avFlxIL6BPnX23O610BuA9IVCc8
         m/RD7cFZSMBqebYu8hr4x80VYcHxmqzQP6BafbOSzec71jAEnSNH991RzngJl2zJnxlQ
         nCxhrprJ2iKgn1eyUzKJlic4lpKqoo40i6GTL+XP3wzBxTVwRauO4EvvT2g4VOGtYIos
         itezATjQfhsu1C19mcIY/DH0xWrhsrNrM3DVLjOhHkKOUdnP/ExqHLXCPg2jjkw7EI/1
         frbg==
X-Gm-Message-State: AOAM531Xgl1TPTbedYh3vzwMwnd71DpZuDuLYB3tLOYVRD79zYtLe/Gv
        1Fs8DjCGhQlxhIPJm49TnOQF60P7wtg=
X-Google-Smtp-Source: ABdhPJxUYMZqevp8Zfb4hVitKz5HC6RoWvg4OvuYXpeMGOGS33WIGlZIsiJFrF9s5ka2N9tlveXlvQ==
X-Received: by 2002:a05:600c:3b9c:b0:394:1611:ff1b with SMTP id n28-20020a05600c3b9c00b003941611ff1bmr2751593wms.185.1651164261239;
        Thu, 28 Apr 2022 09:44:21 -0700 (PDT)
Received: from localhost (92.40.203.206.threembb.co.uk. [92.40.203.206])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm4453035wma.43.2022.04.28.09.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:44:20 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 1/3] clk: ingenic: Allow specifying common clock flags
Date:   Thu, 28 Apr 2022 17:44:52 +0100
Message-Id: <20220428164454.17908-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
References: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a flags field for clocks under the ingenic-cgu driver,
which can be used to set generic common clock framework flags
on the created clocks. For example, the CLK_IS_CRITICAL flag
is needed for some clocks (such as CPU or memory) to stop them
being automatically disabled.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 2 +-
 drivers/clk/ingenic/cgu.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index af31633a8862..861c50d6cb24 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -660,7 +660,7 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 	ingenic_clk->idx = idx;
 
 	clk_init.name = clk_info->name;
-	clk_init.flags = 0;
+	clk_init.flags = clk_info->flags;
 	clk_init.parent_names = parent_names;
 
 	caps = clk_info->type;
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index bfc2b9c38a41..147b7df0d657 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -136,6 +136,7 @@ struct ingenic_cgu_custom_info {
  * struct ingenic_cgu_clk_info - information about a clock
  * @name: name of the clock
  * @type: a bitmask formed from CGU_CLK_* values
+ * @flags: common clock flags to set on this clock
  * @parents: an array of the indices of potential parents of this clock
  *           within the clock_info array of the CGU, or -1 in entries
  *           which correspond to no valid parent
@@ -161,6 +162,8 @@ struct ingenic_cgu_clk_info {
 		CGU_CLK_CUSTOM		= BIT(7),
 	} type;
 
+	unsigned long flags;
+
 	int parents[4];
 
 	union {
-- 
2.35.1

