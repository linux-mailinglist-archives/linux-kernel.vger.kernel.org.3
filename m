Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4207D54259D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiFHByF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584071AbiFGXrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:47:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC39F262D61
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:20:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e9so6345877pju.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAR2/RmOjZbYj98rO6ac1mg+RH5GE5HBqimT+k5kjhE=;
        b=M3MPEpZWkUQnUQtZkqtKjHgTaFJPCuP8yD6txsdbih3NMKLrTcEvP0q/avKLCBU41/
         /3puSqoegNDh7Vw58ZqTAqzFQvXNZo4vjupzMO9x6vGIuef2mPLe7QDoK12FQf8TRNCU
         QXDScL4D3ps9PbPDGeE2keSpUqUtL0+rZ+N+gpkGis57IM+IWoIh39TagtQ/5ncRsRFB
         rUvPu3HI3WC7nwKIGFJgWkBm9tDiJ/IAkD64f5OZO24Fdg3LlE9AH/BANr5RyATboyZA
         RGUeSYZ4GkusZ++xgV7AaoVhJFjcoyb3Xlm3XaDEUfvY6itgyXI7eYERZqVVaMGoHmtS
         VyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAR2/RmOjZbYj98rO6ac1mg+RH5GE5HBqimT+k5kjhE=;
        b=uY2eFttuil6IY13dYCgnakF3cZ/I9gWphLY1mBk52Yw2ezC0fFK61mvPAYWBiYnGuA
         m/NnxsubIR4i/2YcNo89vmmy3+CiTnWneZQibnwNHvsIKxbVIe53jPgKy6hDKyE+8v86
         sBqUbOOmWg5Vem/N+vxqybccUcXYRse9QzjcjejBaXsHP5p/XNAomevBg8JrHjGOGWZc
         ByjJq9l8HH+O7THLc2PnmCcygM9QQVABsjZ4ZRfZR1WwmX8XoT3eprQeoWFqWGqX88RU
         gJCSz+0m5tPMPBktgQExKcKRnTqRyOfMlHt749bNGHfwwjNdkcCK0J4ZgcVoVyP3KsOo
         XDqA==
X-Gm-Message-State: AOAM531J4/FtWOf3muo2dRA2NzluiZRlUQCgL0qvBKr6v5GkZv8zgsuz
        sF5J9iXduU9Y7IJtr0Zoo6w=
X-Google-Smtp-Source: ABdhPJwXcISX0IOahOjg2aruo+uAMtXRJD494uIGO8TUrweujgZqug76VqTpGVNJXoGSOVg1tSYsMA==
X-Received: by 2002:a17:903:1247:b0:156:25b4:4206 with SMTP id u7-20020a170903124700b0015625b44206mr31259117plh.146.1654640450835;
        Tue, 07 Jun 2022 15:20:50 -0700 (PDT)
Received: from penguin.lxd ([2620:0:1000:2514:216:3eff:fe31:a1ca])
        by smtp.googlemail.com with ESMTPSA id p10-20020a170902780a00b001640aad2f71sm13286969pll.180.2022.06.07.15.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 15:20:50 -0700 (PDT)
From:   Justin Stitt <jstitt007@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <jstitt007@gmail.com>
Subject: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16 conditional
Date:   Tue,  7 Jun 2022 15:20:06 -0700
Message-Id: <20220607222006.22719-1-jstitt007@gmail.com>
X-Mailer: git-send-email 2.30.2
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

if __HAVE_BUILTIN_BSWAP16__ is defined then __swab16 utilizes a __u16 cast.
This same cast should be used if __HAVE_BUILTIN_BSWAP16__ is not defined as
well. This should fix loads (at least a few) clang -Wformat warnings
specifically with `ntohs()`

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <jstitt007@gmail.com>
---
 include/uapi/linux/swab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 7272f85d6d6a..f6be3f2e6fee 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -102,7 +102,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
 #else
 #define __swab16(x)				\
-	(__builtin_constant_p((__u16)(x)) ?	\
+	(__u16)(__builtin_constant_p((__u16)(x)) ?	\
 	___constant_swab16(x) :			\
 	__fswab16(x))
 #endif
-- 
2.30.2

