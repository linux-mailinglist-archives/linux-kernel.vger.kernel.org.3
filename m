Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6043655C7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbiF1MNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344914AbiF1MN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:13:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7A237C2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:13:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cv13so12387283pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSDinnzl56D9PFKDeB860nkVQnIp9oqH1T1HFaPBfr4=;
        b=LZrAI0t9vW3GfRkSpY5xnTWBpPAMoPHypn1lKSOQhWtqPjmYD3IWl5ZGZwnfqNH4cA
         UNELUthAvR2LaChKvDDw8gu9lKukzIBW1qWYIakbZ2iOSuacjr0Xi5vGfhCIvf3edIoG
         Iym+3aKlyhlV8HgZaFldWhGZM/KL1pBVLab4Qn0wUwzNv22YkDl/2EmzqhDUVe8vh/d5
         CrdV9xvFs1eslvwDl+QI6nx6D4NFcuvzAk58AmdWg7p4DkFHRYMgFrunqJDT2eQ1POvO
         OvziMaJsAhq/Ued3JYdCr+Z+mQvn1bDRO6QwdMUH2j8tNCWzZPYpUhKlJZQM0Dvi2iiF
         FneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSDinnzl56D9PFKDeB860nkVQnIp9oqH1T1HFaPBfr4=;
        b=2wN77AuybqYuQjSd/Hvz3kHKDth/xLrb7mPMhR0t6maJsRZOwoTE2lhTP3xL+fVp2u
         LrUfeH8EBicC8EFxQi6hePgGFkJbzMhtO+KNHIhOMCSczSnT7taexh3ZjXw06RFZ7YmL
         evaafTD2qfdHk4ZvtApGnc/DUwa1QWU/pX01czBrl9XRF/pqcZqEAWfvmjHx+r+q+6pv
         GhevMMTdlTO+f9OdVU0MlgulcF/hWXw8cyfPqTFwbY62+MW+FxEWh+SFei3yYFsJFh0S
         2iZQlpACwln9pjDydpBA42xBDoEOXtHMLKaDnmGNZ+EBNDyLoxsX3vkxAzJUa8rtUeK+
         wgDw==
X-Gm-Message-State: AJIora85Hf1fHmO++Z+ceZHVcGpFAfVjsljIqxviD15GRIT4if0tcnyr
        GwEMGjGeUALDxBrCGhHo9rbgX9FkX2AH7A==
X-Google-Smtp-Source: AGRyM1sAf5ZuIfFPHYHjm02zMm3ex+WsIGHP3DaH/nqnRS89Qycce/vuhFMht33UFBTpn5MzHyxBPQ==
X-Received: by 2002:a17:902:c40f:b0:16a:37de:89c2 with SMTP id k15-20020a170902c40f00b0016a37de89c2mr3505380plk.105.1656418408006;
        Tue, 28 Jun 2022 05:13:28 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:37e8:2f95:a443:c532])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902e3d300b00163f8ddf160sm9070496ple.161.2022.06.28.05.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:13:27 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] drivers/soc/mediatek: mark svs_resume and svs_suspend as maybe unused
Date:   Tue, 28 Jun 2022 05:13:26 -0700
Message-Id: <20220628121326.2097912-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following build errors on platforms without hibernation
support in linux-next:

drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not used [-Werror=unused-function]
drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not used [-Werror=unused-function]

Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/soc/mediatek/mtk-svs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 87e05ab51552..363ab8bffa9f 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1478,7 +1478,7 @@ static int svs_start(struct svs_platform *svsp)
 	return 0;
 }
 
-static int svs_suspend(struct device *dev)
+static int __maybe_unused svs_suspend(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	struct svs_bank *svsb;
@@ -1512,7 +1512,7 @@ static int svs_suspend(struct device *dev)
 	return 0;
 }
 
-static int svs_resume(struct device *dev)
+static int __maybe_unused svs_resume(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	int ret;
-- 
2.30.2

