Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA88495D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379706AbiAUJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAUJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:47:41 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52723C061574;
        Fri, 21 Jan 2022 01:47:41 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id o135so9304784qke.8;
        Fri, 21 Jan 2022 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4alRYNA0bZSUpUO0RvXdY6tMCVcCPN7Mpy2jJJWzikQ=;
        b=YaQKORsMB2bdN1W4/mkTZKwGRaWhrXkJgweMN8CATucj7B1cciRG8rekkt1b2xDg9t
         OR1nB307gTVwzXqlANGyg69IAd0VlVH0rlTuwJpiPftztRO4wBKaRE8uwXpORtGswc0I
         +UXoFLN0sgWTItAvwTNYmQv3ktrsows6ugjMzl0GYxmFQZJWph4XKwIJYiZo/DQEDW0c
         HwL+EV9JTiHIgenYsVZya3r9Kh8uN+ihjvL0Wl5scRy/FHgM8KUsHQ4+O6DKdjqo5h9r
         uqvn9lvnrkhsJRG/Ks+eanMv1gsfEtCNTlWdc35zYnUW3i/rjAcsvXFYU1xoKcJ7IllY
         Q5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4alRYNA0bZSUpUO0RvXdY6tMCVcCPN7Mpy2jJJWzikQ=;
        b=oN7uwx1ZPZgZP1ffZ5d0fIXMmf2PGoT5RllLqiKAJV4VDZXQ49FWwjwMuj70pmP/fJ
         c9WsfQxJ1WLwJsmo4Bk/KVHsVSUiKXDtjTcP8OOj4W5Wpcy//hKORc8BUzCp0IpkfkLZ
         9GFNJbB58X+kX36DEi6EAM1uz8CZLIKAUD8FGFyMivJlJu4D4L9afnhIITHV4IZtaQzG
         km6O3Tb+taJw90UVZuNpRW3ER/tg0rbQR2e3JcixSaS9wgvXef6hiontgEN/ZSzZqZSp
         aK6t1MgRQtUGuraq1on54L2rvfwcN4PmMrrbZ4BN8bqxl8uaqDbwuQ0NxPB5uVUrjeTt
         t57g==
X-Gm-Message-State: AOAM5323iAtXTiq+0N0PQ0paWkUumdbZx41PN0l2qYe4e8esDgZ8y5lj
        cP7iH9sxa4oMC7tmGtyygMg=
X-Google-Smtp-Source: ABdhPJx1gI5f8FBHlXxXyrC9Ba766FCQ1GJNTMXVKJGTEMUCTEJMioQKkaqdjQTjXF1cBIYyZAGQjA==
X-Received: by 2002:a05:620a:1991:: with SMTP id bm17mr2090145qkb.132.1642758460482;
        Fri, 21 Jan 2022 01:47:40 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l22sm2941282qkp.92.2022.01.21.01.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 01:47:40 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] block: fix boolreturn.cocci warning
Date:   Fri, 21 Jan 2022 09:47:32 +0000
Message-Id: <20220121094732.1002257-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./block/bio.c: 1057: 9-10: WARNING:
return of 0/1 in function 'bio_add_folio' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 4312a8085396..108b11106c8d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1054,7 +1054,7 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 		   size_t off)
 {
 	if (len > UINT_MAX || off > UINT_MAX)
-		return 0;
+		return false;
 	return bio_add_page(bio, &folio->page, len, off) > 0;
 }
 
-- 
2.25.1

