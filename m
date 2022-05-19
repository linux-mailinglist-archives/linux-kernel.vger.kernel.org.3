Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9743652CCAE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiESHQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiESHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:16:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7F5C352
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:16:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l14so4474579pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XyPdRLUOvzyoOkl8AJ9Cmk/FDiuMmkecbpR5XkIBENg=;
        b=AHJDPTazWz30qIgRscFtjGVTG8wlsDJmoNh5UcTl0JQ/yWCFbfHhNh44c0efaWZr/4
         NEiMqB/xHIS6ggcyJQ/jKNYgPdDQ1mke5W7ctIIlMEdNsH+1+b/egjr49xT8pcxMcZbo
         Te6muBz0eEZ0C1v+nEA4lan5cookOvqsJkG1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyPdRLUOvzyoOkl8AJ9Cmk/FDiuMmkecbpR5XkIBENg=;
        b=ceHOy+F7pR0pTuBYzgjYpC0y4wpmjlry5kA7UeBRz6M8YopHw1pbRgbvVVBmfgu8NB
         VrZiYlznSZddwyHxm//BF7ny1xLbcc42PyeQ30Z54dm0DsyXU9w/wQMBiW8cxlW6iXDA
         ac00mNYt5o3QHux1Dn1VFKjp4kmIDL2ICfDBsRy9WD/Ok31AT1xoF1kycaCUuwvvIqhA
         Ii9UblZsy1Yyl9vXzLA5m6mRRH7QxoBPqGuvzImu0+3nvtqRc1io7DenQLcvVxgtYK2K
         xbtgT+cIYTkTmtpyas0fO/T1gep24WSPmQpv1084ElxNThZt82m04HnqHk2rXdd0g6sd
         Kqyw==
X-Gm-Message-State: AOAM530xEB4ZRGqtj+90FentSk1UYW15bSaxx7fnpqWf2D+FQqKhswey
        dywtCwWft2JgSnSwNrzbXa+NIQ==
X-Google-Smtp-Source: ABdhPJxLeoOFy08yRDFcGKNoS/bVuLsPzcc7Ug2Ns0s1mjVz6L+U54MF0RlA8KbO8s47+cog8MHGQw==
X-Received: by 2002:a17:90b:390b:b0:1df:b3dc:514a with SMTP id ob11-20020a17090b390b00b001dfb3dc514amr4322602pjb.25.1652944602480;
        Thu, 19 May 2022 00:16:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2338:2871:9320:bed0])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b00160c970eeb7sm2972945plx.234.2022.05.19.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:16:42 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] clk: mediatek: apmixed: Drop error message from clk_register() failure
Date:   Thu, 19 May 2022 15:16:07 +0800
Message-Id: <20220519071610.423372-3-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519071610.423372-1-wenst@chromium.org>
References: <20220519071610.423372-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_clk_register_ref2usb_tx() prints an error message if clk_register()
fails. It doesn't if kzalloc() fails though. The caller would then tack
on its own error message to handle this.

Also, All other clk registration functions in the MediaTek clk library
leave the error message printing to the bulk registration functions,
while the helpers that register individual clks just return error codes.

Drop the error message that is printed when clk_register() fails in
mtk_clk_register_ref2usb_tx() to make its behavior consistent both
across its failure modes, and with the rest of the driver library.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index a29339cc26c4..06400c043fe7 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -91,10 +91,8 @@ struct clk * __init mtk_clk_register_ref2usb_tx(const char *name,
 
 	clk = clk_register(NULL, &tx->hw);
 
-	if (IS_ERR(clk)) {
-		pr_err("Failed to register clk %s: %pe\n", name, clk);
+	if (IS_ERR(clk))
 		kfree(tx);
-	}
 
 	return clk;
 }
-- 
2.36.1.124.g0e6072fb45-goog

