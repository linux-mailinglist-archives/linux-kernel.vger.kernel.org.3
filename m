Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309C848CF29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiALXe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiALXe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:34:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB3C06173F;
        Wed, 12 Jan 2022 15:34:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k30so6987678wrd.9;
        Wed, 12 Jan 2022 15:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DEFgBCX906ok4X/wdH2dxwVHpxsjiS6oUvaGjRJjSc=;
        b=e9IAmlaSjuYmaF9CmGYif8YYLo6UNV3nMGK3jnmOsCdkSHfSTMAEAv2Ra4qJjr0NE/
         zahrF5w/PN6y+8Eb/frfktMb/xueFL+wxRRN2R/EKKmVeg6VJ7OwPGl7UyEbwGFE+R07
         7wsLAOO8ebbFowfkS9p9MEzKjBQQ2wz4LoM0PvPAo6zKPj56ueOHHWNWsTQux55UEtUJ
         bGzUoHAZo99kaLq6IajDlHYr6mpB64hNiLV2xqPeVP6O/BMFBPsJALc60mzqLlgIVnCf
         j7EKQ/2Ko2XyM9AKKM2D1nhiqucm6fymtLaWuuI7uilmjtqmpqcJEoTg/Bc9j+R03j2M
         iGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DEFgBCX906ok4X/wdH2dxwVHpxsjiS6oUvaGjRJjSc=;
        b=Sx3cTmOLDx6THlFaGiVB7ratcPFosSeMAFTChy0Tss5xcat1+Y7M6238hjc/ylSJby
         y91FzL7MuPYkT3roY1wsoET4RLEeN26HLvvqyRtAgv4AeGddvac2QD/xuI8M9FurjGkA
         EEO1natKimoJmWIsLcv/650lfH7tjImIpqCaCn2ASLdsjztxf0JVGOafKQGVm7znebbM
         2vTavCnZDTVYpGjFKq5IMlP866cZ1zEAQCPu7SrKpn2mpPLuJqonNCch9uEhd12SOp0x
         eGWYCe3jGVlxUEhaKBzZdNq8pALePKcZJJ5elCd960DnLvAWlESFdE9+x8jtxRpX7QBh
         jbew==
X-Gm-Message-State: AOAM530w9K+jxDHNV6cg8Mfl6bgqJhUBPFD9KDHZDIKb/KkSQocMgFXO
        FhETVrSBk4pJXR5vmLJbM5w=
X-Google-Smtp-Source: ABdhPJxeMow1qP7JNTiHjKD4H5i8qsaxLomu8bgbsOMr814izohrtas13g4czBsvmKybVqg0ZNUM3A==
X-Received: by 2002:a5d:5282:: with SMTP id c2mr1705884wrv.580.1642030495750;
        Wed, 12 Jan 2022 15:34:55 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x6sm1051652wrt.58.2022.01.12.15.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:34:55 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] crypto: asymmetric_keys: remove redundant pointer secs
Date:   Wed, 12 Jan 2022 23:34:54 +0000
Message-Id: <20220112233454.1207944-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer secs is assigned a value but it is never read. The
pointer is redundant and can be removed. Cleans up clang scan
warning:

crypto/asymmetric_keys/verify_pefile.c:113:14: warning: Although
the value stored to 'secs' is used in the enclosing expression,
the value is never actually read from 'secs' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 crypto/asymmetric_keys/verify_pefile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 7553ab18db89..a660e4d68d50 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -28,7 +28,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	const struct pe32plus_opt_hdr *pe64;
 	const struct data_directory *ddir;
 	const struct data_dirent *dde;
-	const struct section_header *secs, *sec;
+	const struct section_header *sec;
 	size_t cursor, datalen = pelen;
 
 	kenter("");
@@ -110,7 +110,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	ctx->n_sections = pe->sections;
 	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
 		return -ELIBBAD;
-	ctx->secs = secs = pebuf + cursor;
+	ctx->secs = pebuf + cursor;
 
 	return 0;
 }
-- 
2.33.1

