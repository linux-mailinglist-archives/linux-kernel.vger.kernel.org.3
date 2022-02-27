Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5524C5C73
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 15:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiB0Ovc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 09:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiB0OvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 09:51:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A85D649;
        Sun, 27 Feb 2022 06:50:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qx21so20003552ejb.13;
        Sun, 27 Feb 2022 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnzEjils2SDzogeoSREvhcmiHUjDXu33htT9pPxePe4=;
        b=m6Y1LV2epMZzSJyQq0X3DAGh8KCjFJY62r3nYRRB9Zo0o51gjA0BGoSRQGYpvdc07p
         dVQ8R8CJsDb7DddzgpOBYB3fkV1Bh50ROZNJZFfWPTsYsLOICFsID4sXsrkmSSNpP6gb
         dfMV98gTBsKuucYg8YqWiCrxU3qwLd/NziUpBqFPNGH02N82YZ9RqRWTlMwcw2xjcHzg
         KJ4FBy9RCw9WDFGgRdljcjr4tkLhlReb5DtyOEcqfMKubi5aELqKNsDLtwBR7CK+ymKv
         birbV5SOVJUOl3VDquTajA6oUGZbrELv2cOQ+jqaBU/RWOZLuiWFO4CKAUxcoR88j+Kv
         iXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnzEjils2SDzogeoSREvhcmiHUjDXu33htT9pPxePe4=;
        b=CENSJCgyYKgxK5dSwkS0DyZVdeosaLV8Vx/mqnuI/JQhOBff4aOPmSdkLy1tBcLnay
         GJcK0c5gqEIo9VF6L5saGYi65Ij32fcG25hKAwSl/uui4+NSAcWAQlW/ZJ2JnaniHvVp
         y/MBgCBQ2rvu9WHziyq3tS6U8AK+MvBcIiTSyoXfX2LP8numFLjVK6+6IniyhgwsjQDO
         wvvI8Emeu3LRpA5aCIxGyDK+nLpcY45e2ZVv1zYX5ZwaBzdf8GLmOPGqwgYCnkrr93yn
         7HeFSk689eO95VpW1YztezmCZVtHaZMtmTqiuChuOTM9JRsy7gRt2LgIe6LmwZFNAMiV
         FOyA==
X-Gm-Message-State: AOAM533v6Cidg1Bw9TpYcISj6tyXjWI6MZm+EnC6V7J/8JVvYHfGHFBG
        uw6r4ZMD/70xXo4NH2ILZdE=
X-Google-Smtp-Source: ABdhPJwgCbRgGf3irdtMpQv3bFTprq05+49kal0GzQYFZiM7sAzIqFstRyzM4xfgu4hDpCCw86KV6A==
X-Received: by 2002:a17:907:2087:b0:6cf:e170:171 with SMTP id pv7-20020a170907208700b006cfe1700171mr12676273ejb.163.1645973438900;
        Sun, 27 Feb 2022 06:50:38 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm3501887ejj.142.2022.02.27.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 06:50:38 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [RFC PATCH 8/8] media: hantro: sunxi: Increase frequency
Date:   Sun, 27 Feb 2022 15:49:26 +0100
Message-Id: <20220227144926.3006585-9-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
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

It turns Android boxes use G2 core on much higher frequency. Let's match
that here too.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/sunxi_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
index 8d8a8937d6aa..c86749c406fc 100644
--- a/drivers/staging/media/hantro/sunxi_vpu_hw.c
+++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
@@ -50,7 +50,7 @@ static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
 
 static int sunxi_vpu_hw_init(struct hantro_dev *vpu)
 {
-	clk_set_rate(vpu->clocks[0].clk, 300000000);
+	clk_set_rate(vpu->clocks[0].clk, 576000000);
 
 	return 0;
 }
-- 
2.35.1

