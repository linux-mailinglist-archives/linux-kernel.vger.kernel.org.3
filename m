Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A45292B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiEPVTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349310AbiEPVS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:18:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962592C10D;
        Mon, 16 May 2022 14:17:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ch13so30965855ejb.12;
        Mon, 16 May 2022 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35KXda5OBFCKkvBxWwkGiybmXmDjKw5ss0Rm54TgqYY=;
        b=i+OOwp8a+Ns6JmA3zecraa7xhvF4SrBt9OxonU3zgxIMLqIuQq+1wJn0rPRt8mJN4o
         LMO0yQRcFwtjM0saYriQhamE4Fw0YEtk5t3TQ/RM1Vi0r1O3pCyeXRunEEq8TcH6OFso
         vkGt7LDjqxEHo/VZUby/scvLGyC2tDiX63Gsst9+OA1R4gAs1CbduRu5CCe5/wXuhVGm
         9f94pIi+pVT9OaQLr0JmyoLwRKd/D0pc7O0eRi18BOa40zDJjqM1lVzkEBD6yAyeSphI
         Zm9caVX9cBt5sds1QEuRnfXbFigfQZpxfErvR9dhBy7JUfAf1n9hARzxRl0oXFES8wz7
         2nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35KXda5OBFCKkvBxWwkGiybmXmDjKw5ss0Rm54TgqYY=;
        b=vEgKjUs/P+vw3OGYzdM97g4xX9ENfL6j4SHwHvfi1ZQvYrrA8mGXj8LQdcmiyhyOLm
         Ej2ePVEJPXAfMt90riX6zpT9uFp/zM4rMuv2ZQzacEK5A+0SRKzyTQqjV0j4kuCva5VH
         62tp8O0msEiLIn5BCrvW/8nxl7+FV+6KcbBk6n6CexNERIVt1BjsoCC7UaDAYj3s4dSa
         RiE/yEH6COpJhWVw3aPgLiTTY0s9jgadAClCPdRbO8FS+sZr1IPQbYjHMBRnvInsVx8L
         ANa7bIToOisGrDOupfjQ5hqY6KfO01HcyQbQplp6I4QfKmkUUYMuc91g+G3sIOjurs47
         aOWw==
X-Gm-Message-State: AOAM531v3rp1RguKtqi4AYYJD5uKyJwdPvCjh5A9hZbRWVkI+Fmpvzsd
        7wKS6EJiR3TXz51SAyreoKKJOcrClwsWsXfC
X-Google-Smtp-Source: ABdhPJz+c4SIyaDIRS17VWMsh5DYkuYDVpureeE7lY55lFd4fmJuYT5KuXvj3NnifMvVo2q76fvdHw==
X-Received: by 2002:a17:907:e91:b0:6f4:d1e7:417d with SMTP id ho17-20020a1709070e9100b006f4d1e7417dmr17216724ejc.123.1652735867100;
        Mon, 16 May 2022 14:17:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709063e9700b006f3ef214dc5sm198147ejj.43.2022.05.16.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 14:17:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: asymmetric_keys: remove redundant pointer secs
Date:   Mon, 16 May 2022 22:17:45 +0100
Message-Id: <20220516211745.55382-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Pointer secs is being assigned a value that is never read. The pointer
is redundant and can be removed.

Cleans up clang-scan build warning:
warning: Although the value stored to 'secs' is used in the enclosing
expression, the value is never actually read from 'secs'
[deadcode.DeadStores]

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
2.35.1

