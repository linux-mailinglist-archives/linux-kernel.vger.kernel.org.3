Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D548CF86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiAMAFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiAMAFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:05:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818EDC06173F;
        Wed, 12 Jan 2022 16:05:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k30so7080877wrd.9;
        Wed, 12 Jan 2022 16:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B96Zf7JbGiWB8a0l9E4LUmhTdYONZVGjIpO5gBzcQpU=;
        b=nUWTJxjyqxw239n79lbq8UFam5zo7paOS3rJ/H9NI5WUpZefKsbDGUhKk57qXhppfS
         xr4A6cULiA7qoedsyMMi2l4KQyZjMfNdzpk7393cxz0J3ioIyLuuLNs9FDhFUTnpl0f5
         QI01BHdZBB8UyGS2+toen3wH0F2RKXI87F4CkycCJksHjOrgwhu/MQfUMZ1/IaXh9+JQ
         Icd6uhfCb7V5k+eVsPFgq7LF52QRRSKDwwg8Hj0mYGzBiKBRWrW89k82JmlUJVTYx2aG
         WCrkmmdiysKfChK2MV9ydbaxCf6ujZoXRT5Eyo+7GerKEG6fN5RyCUqYIyR5WLhbKyXV
         6SWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B96Zf7JbGiWB8a0l9E4LUmhTdYONZVGjIpO5gBzcQpU=;
        b=e89h8bM45AraQr1W66is+qNm/4K81UcbPgiS+N/afAvwoEFHCNf6eyO1T55ETVG5Ge
         GTAxW8tSksQtCxBXK9zxWiMoacVjxXYbaX8JYGf13Z+5J8lzfMjVv41UGOPauxCf1Fpp
         V1B9uGdD0RE9ryCq6Hu3/VxCTEuvg4/0UAZZOmbLNJt3c6aFyb3AgaBmerTaJwLtggEh
         +UgnRXAp2biOD1YrquIXg8s+PkYGJLxBSlGqiwSjBkVgOw/+raTM60z3ZPvagIUibDly
         3lLxoOtlUeBlHgRclI572u2Ilyjy5iQ1pdbxDdFualtanl+/0bqNoudTbVjlwI4UY7Yp
         VYcQ==
X-Gm-Message-State: AOAM531dfqu/B32ghPWVVbH2m8LgCfIf96n7t4Z7b+5SiktXpGwkhP3f
        RYYf2lTJLNKjCey5VeZP9EI=
X-Google-Smtp-Source: ABdhPJwpRmxNptr0kCGBzfBMdeVGo5gGW6lImhDWjH6nq9cG/U50U1+eHHcQHwb59H/2QHvslDyRfw==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr1713767wrs.365.1642032346183;
        Wed, 12 Jan 2022 16:05:46 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a3sm1255693wri.89.2022.01.12.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 16:05:45 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] aoe: remove redundant assignment on variable n
Date:   Thu, 13 Jan 2022 00:05:45 +0000
Message-Id: <20220113000545.1307091-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable n is being bit-wise or'd with a value and reassigned
before being returned. The update of n is redundant, replace
the |= operator with | instead. Cleans up clang scan warning:

drivers/block/aoe/aoecmd.c:125:9: warning: Although the value stored
to 'n' is used in the enclosing expression, the value is never
actually read from 'n' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 588889bea7c3..6af111f568e4 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -122,7 +122,7 @@ newtag(struct aoedev *d)
 	register ulong n;
 
 	n = jiffies & 0xffff;
-	return n |= (++d->lasttag & 0x7fff) << 16;
+	return n | (++d->lasttag & 0x7fff) << 16;
 }
 
 static u32
-- 
2.33.1

