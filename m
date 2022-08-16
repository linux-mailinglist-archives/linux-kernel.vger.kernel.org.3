Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5959542E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiHPHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiHPHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:55:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6110D53D17
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:09:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f192so8412418pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KdmzXP13CNxy15WwYF58LgbgciSZbTqWHtRKPzesVZQ=;
        b=WD+/gTBCSHLbVlCq/CMvy4XoQK9mqHwypW9eDbK2RGQr/izdBf8unDeJZ98vVDttyk
         I7XalW4qBXEyZubojjtoZxKr3mP/tLeVMFSg2M4r6whQFB+usjT5Gzmavu8S7/rAJT/m
         nbyzocIyxua/k701B0Qr2vV7mraykF6bUKzd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KdmzXP13CNxy15WwYF58LgbgciSZbTqWHtRKPzesVZQ=;
        b=j0ueRuoAKN0YQfGR+Zeif9AkvbB0aJOGi1mn8/hN7jmsfrS94ZtNUDnXwIqlC8Ao/q
         ZeBl8SvdOqqUNC6/4JNhjewOCYyYVqqZl7b4CbG2inTaXNdyujwdkf26OqjBiZKwJd+4
         n6SQ98HE52+t1LsInuIK3b5NfqEXhOqU5mRjZdcVgaxl9pNdc971G+Jlf5YbPY4MmZEO
         eif3SHd0K3rcZyaNexMjR6clrOj3AA+K3E2FGPgh6oj07lGm6XHjDWqmxeZN5wPAXFwF
         Fk7tmvXjIYaBlUxQxUEdKiunzopgGSxztULn4BvFasJ1FX7ic4a1c7t5emytfxkFVxcn
         gnZw==
X-Gm-Message-State: ACgBeo0iDW8uwQjQjmdtNMeDa1RyZfKY0TSW4kviV7kkHU1hlZtrV4fh
        CRH27r80mW03xuxzlCggv5/5n8/XgMv+ew==
X-Google-Smtp-Source: AA6agR48kTeSKkrtvQ8tb5usR+/EYoYHUSB8vHFruj5BBWEQ8HYs0FVXAl45joibuxZasZghOpN36w==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr19681095pfi.84.1660626551898;
        Mon, 15 Aug 2022 22:09:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4b3e:670a:79ec:7666])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090300c100b00170a8973137sm7911363plc.17.2022.08.15.22.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 22:09:11 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm/zsmalloc: do not attempt to free IS_ERR handle
Date:   Tue, 16 Aug 2022 14:09:06 +0900
Message-Id: <20220816050906.2583956-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zsmalloc() now returns ERR_PTR values as handles, which zram
accidentally can pass to zs_free(). Another bad scenario
is when zcomp_compress() fails - handle has default -ENOMEM
value, and zs_free() will try to free that "pointer value".

Add the missing check and make sure that zs_free() bails out
when ERR_PTR() is passed to it.

Fixes: c7e6f17b52e9 ("zsmalloc: zs_malloc: return ERR_PTR on failure")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 99d93a48cbe0..7b3bffc06078 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1487,7 +1487,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	struct size_class *class;
 	enum fullness_group fullness;
 
-	if (unlikely(!handle))
+	if (IS_ERR_OR_NULL((void *)handle))
 		return;
 
 	/*
-- 
2.37.1.595.g718a3a8f04-goog

