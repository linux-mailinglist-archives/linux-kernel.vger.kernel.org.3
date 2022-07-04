Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D994B565F32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiGDVxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGDVx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:53:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F094F26C2;
        Mon,  4 Jul 2022 14:53:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j7so6043285wmp.2;
        Mon, 04 Jul 2022 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imQEOeZ0iRvWPIQHofWTbp8F/si96v+dyL8UJAbYtRE=;
        b=MKjZQUbAoLeNcvfieU9aGAfdRCrCWwxRfzyvACl1W9FjRAfUrhoEqUT+RDENGG6adF
         idab7kcmkHUPMgen0dIwlYeDguou4SQVHx7l59qhAWaRSYlbayl+40DgHBU/x97UppCn
         cLCXSdGKEc5nELmxVDRbjraTp9NO/3l2EzB1ni2GPgb1XN+ZGawp/a8JbjBHTgqFjsVq
         poKI/j5kJ/StD1WPsMCppaXgL4vZgARqsAlSv7cX99jFNv5g+U1aj0NWxlRQFsTP3Zxt
         maahY7DjHZowjtoDpRVYYalxOxmN/wNppyfH7V3FKntQWVZA5GIMFJMAVyLNnMRlbR4O
         saGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imQEOeZ0iRvWPIQHofWTbp8F/si96v+dyL8UJAbYtRE=;
        b=aiIFj1kcymvsquLLYaMb8Jt/fhRybr0/NWPNNxYSi3Fe7XEDSMcYOTNVzo0D+zgJnV
         Q8gaHL0GEQuWpMKx3fKjDRqI9GEJQAQpjxQRS4rvNgzTb1GsGzYoPAfInC89M02B30fe
         H5vvtu3dEHZhqrAgMnQhSoOQVcp2b6OJZiN20/QbE4bqFGR2tjxt48NZ27EYqBOxNTl8
         rzbR/Pa68M8FX8S5BM9hnScTKL/QLXfFA2XDGnuHF+976zjCm3DLEuerKE9whIr/T7QC
         bEK4UBBgdw/9NGQD8cI//3aDUDk5hs6l4BEqF6ZlU1oHmiXkxD0UFzljKvVE5z2RalqT
         ha1w==
X-Gm-Message-State: AJIora+pY8svJk3ALtnewyCiYSyab/P4fu++/GJt9mvxwqAaWBYQ9btk
        qaT3MRaYA5Bi4G5MLiepyvY=
X-Google-Smtp-Source: AGRyM1uF7pbf7t/2DGN0ONlAglZnl51cuT47+oqMVWri4eWm7nyJAtUyUB8bQKagaPxSxiZ0r2kkiQ==
X-Received: by 2002:a05:600c:886:b0:3a0:49d7:d8b9 with SMTP id l6-20020a05600c088600b003a049d7d8b9mr36999301wmp.115.1656971606484;
        Mon, 04 Jul 2022 14:53:26 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003a199ed4f44sm9108066wmq.27.2022.07.04.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:53:25 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/ts_bm.c: remove redundant store to variable consumed after addition
Date:   Mon,  4 Jul 2022 22:53:25 +0100
Message-Id: <20220704215325.600993-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

There is no need to store the result of the addition back to variable
consumed after the addition. The store is redundant, replace += with
just +

Cleans up clang scan build warning:
lib/ts_bm.c:83:11: warning: Although the value stored to 'consumed' is
used in the enclosing expression, the value is never actually read
from 'consumed' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 lib/ts_bm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 4cf250031f0f..1f2234221dd1 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -80,7 +80,7 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 
 			/* London calling... */
 			DEBUGP("found!\n");
-			return consumed += (shift-(bm->patlen-1));
+			return consumed + (shift-(bm->patlen-1));
 
 next:			bs = bm->bad_shift[text[shift-i]];
 
-- 
2.35.3

