Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4D50C92E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiDWK23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiDWK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:27:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C710E4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv16so14236419wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LA7DgNA9uVvinJw7IGw388CbOs1kZcBwqiYxarlq+dM=;
        b=W6TgrcHTH/xBgrp1tX2mK8ges1ZzMNhY2uPzGvnSdCY4IDF0tGscn8NKqTJuoYUV4V
         A3QZgQvxb4kfKOEusTZBhFLPOOnQYbPNacKozJOet+/AFWKICBYtZ9ZQdOXn34lMZYsJ
         5m9Pd1dNy6km35hgwA/m8zAUzlEhSuMUtdhmRMMferMtyi0M7cBCMhtH1XiekQjjKWmx
         52W0BrtY9Tq5izVyGZdfqs7aNjxDrIzy9jE6aFxlFs88Ib42/VerfM8EeK2x3bxmk1Is
         zgGUTPrk2Z5+gAhinxEPUzFTjOVPN1G6F62IZepyhctEyOE4TUqUlZu0y/kzOP6bsZAL
         3P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LA7DgNA9uVvinJw7IGw388CbOs1kZcBwqiYxarlq+dM=;
        b=Iyhf5AjrjcOMoqjCbeWv8GCEsm8jiAiePgnj9ayhOU8+jF0DKE0Rlg6bJEzM/GGlzk
         dqR/UuRyxWo0Kp8wUXjodk/fjxfTfsAf6hyJsFZZLh6BLNOywLDxgqLSPS4rxpcWNvkJ
         aaIc3jlE32DFcMvNVVwEDuuPeogElY0te/MWASiCgIMgZJGu/mD+ddrwNt2fXMGo6VwA
         XPHBX4VyuZbvqVS3VywWjg4JPlyCdS9jPItwBFidw8YvwUDTcptAdHV67Sh6YBipCMkQ
         xADKwCY8DbV/hHyOUZwMF/y98GbY9nreup5zTGKsWPz9Wr14iLDVmC2E5bCK/ClysAQV
         ItFw==
X-Gm-Message-State: AOAM5320eNsqwODkTETe4pD0ZPs/6jMmL3VLvVrjndCkU+yixASrK5lS
        yIKh9/L3p0EqArT+nxCuzAo=
X-Google-Smtp-Source: ABdhPJw3UxhCqXYJXJ0AFqJ3QQYGYerqWmYP/Y8CrtobN3Myvvblp2zWl9BxebyfN3bjaRs7jhQ9hg==
X-Received: by 2002:a5d:48c8:0:b0:207:afc8:13fa with SMTP id p8-20020a5d48c8000000b00207afc813famr7038225wrs.487.1650709472633;
        Sat, 23 Apr 2022 03:24:32 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm4089057wrn.114.2022.04.23.03.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 03:24:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/3] binder: Use memset_page() in binder_alloc_clear_buf()
Date:   Sat, 23 Apr 2022 12:24:19 +0200
Message-Id: <20220423102421.16869-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220423102421.16869-1-fmdefrancesco@gmail.com>
References: <20220423102421.16869-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible. With kmap_local_page(), the mapping is per
thread, CPU local and not globally visible.

binder_alloc_clear_buf() is a function where the use of kmap_local_page()
in place of kmap() is correctly suited because the mapping is local to the
thread.

Therefore, use kmap_local_page() / kunmap_local() but, instead of open
coding these two functions and adding a memset() of the virtual address
of the mapping, prefer memset_page().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/android/binder_alloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2ac1008a5f39..0b3f2f569053 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1175,14 +1175,11 @@ static void binder_alloc_clear_buf(struct binder_alloc *alloc,
 		unsigned long size;
 		struct page *page;
 		pgoff_t pgoff;
-		void *kptr;
 
 		page = binder_alloc_get_page(alloc, buffer,
 					     buffer_offset, &pgoff);
 		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
-		kptr = kmap(page) + pgoff;
-		memset(kptr, 0, size);
-		kunmap(page);
+		memset_page(page, pgoff, 0, size);
 		bytes -= size;
 		buffer_offset += size;
 	}
-- 
2.34.1

