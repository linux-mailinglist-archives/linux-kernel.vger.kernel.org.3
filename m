Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64B44BDF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355341AbiBUKm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:42:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355662AbiBUKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:41:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A934DF44
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:03:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw13so31684355ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh0eRL7BT5Z1WXEJ64jweV7rcRpasXXUz8D11sbvc0I=;
        b=O0DO7UV9/V0cgw2npjm4LvFZr7r1UuEju8ciSbTbz6C5X6iNMOeRhSlHhNL+8JDjZZ
         uM/Db/9p5NVa5BPHv0tqec4SvbVP+BZemzUjiEPIUwttvwUP+f02aSX+ZXDqoNr60wQa
         RMhNvOa28cEuJjugcF8NTLpuLxDGnjX2d9avnJMKHMtzK3cYc26dNRuviAnUeODPcWA6
         1T+DZmJ/mLNeiTcITJzxFdCNe5N62HuKW5XATmuDJxhFFO5XHSiNkH+TEQzHRCuR0Gvb
         3VRL5ry3YUw1+bKYdRjWgGqKQoEaey3beEY/bfyccM6CiC4GK80WynkfzKoAuOvzw7zn
         FARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh0eRL7BT5Z1WXEJ64jweV7rcRpasXXUz8D11sbvc0I=;
        b=2QhU9DGvveI8AcqI8OxjFa5tumddNQr0/E/VOcByBCgd9GbHsDpFn5TeNyT+Zqok9i
         3VBlRaMYmZNxSYVXY/UFoQGCadBgGq4tA+oUNIwhAhUpJDisUDa2IHgjX2iXSC16eN5R
         pNfeoD4lwuX5jeVawbA6NWFy36eDF1iNuBJo7UwAxqx2Zxhrh+9e0d96FSHbN3NBLLxe
         1/VGGgQnKdMK4PPo9oxV69wKO+uWOlRGOy7JAVmpm8IilFyjAFgGfw5uXXf8CcHHKKvq
         OYS4WMPgSA0W9kiCFxwHOOT7oczWzvIHFunjS74wSFWWrTlWQMSHuNm8NXIyE/k8YhhY
         W+RQ==
X-Gm-Message-State: AOAM531RwknyAD9mlu4+YZB3kbpSi744KoGjsesUfefJSrjhVyuyytNE
        A/NnbTcZwGSj26RH/lrD7eg6F6DrRRaa4w==
X-Google-Smtp-Source: ABdhPJyV7L0YYwyTuZ/fifIPcrP8wPaiSWRfwfyjDDIstsO3blI6E/TwIzeeOVaKDmJRp9HzzEGKww==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr15617394ejs.105.1645437800059;
        Mon, 21 Feb 2022 02:03:20 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f260d000000000000000fd2.dip0.t-ipconnect.de. [2003:dc:6f26:d00::fd2])
        by smtp.gmail.com with ESMTPSA id ed11sm8148684edb.81.2022.02.21.02.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:03:19 -0800 (PST)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@ionos.com>, stable@vger.kernel.org
Subject: [PATCH] lib/iov_iter: initialize "flags" in new pipe_buffer
Date:   Mon, 21 Feb 2022 11:03:13 +0100
Message-Id: <20220221100313.1504449-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions copy_page_to_iter_pipe() and push_pipe() can both
allocate a new pipe_buffer, but the "flags" member initializer is
missing.

Fixes: 241699cd72a8 ("new iov_iter flavour: pipe-backed")
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 lib/iov_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b0e0acdf96c1..6dd5330f7a99 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -414,6 +414,7 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 		return 0;
 
 	buf->ops = &page_cache_pipe_buf_ops;
+	buf->flags = 0;
 	get_page(page);
 	buf->page = page;
 	buf->offset = offset;
@@ -577,6 +578,7 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 			break;
 
 		buf->ops = &default_pipe_buf_ops;
+		buf->flags = 0;
 		buf->page = page;
 		buf->offset = 0;
 		buf->len = min_t(ssize_t, left, PAGE_SIZE);
-- 
2.34.0

