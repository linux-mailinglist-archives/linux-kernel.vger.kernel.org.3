Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825450C92F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiDWK2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiDWK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:27:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AFF10E4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f6so76674wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnzJn9/apOse1TRdog9QxKjgDoh08yuT8iYmEPjnkLo=;
        b=EdRnFs11rrayuYTjd5BRRXOPQ+6lHEDn37pxNXH+HIV3NgWTWMAzKj3mdnLsnM7ntT
         q05koXcf1+O2OIpp3SfPEK9RptcDXAr6XlEyDnuOQ+Poug3JuqInykzDCJnjQLqq13I2
         MXclDmF1rAmIMpbZ9wI77X72rk9zp9AN+zxKfWMhMvHVypCkm9VzQlrIA1S5kh0oBUjg
         1DqtbpsbmQfT9LU33EtELKde09//wwPjGq3kWkyKnVk72c1jd12/zfeHXnkK3xMqEKUe
         dpoCsaBFopex08M2tgjBPQhIiVq2P1Xrzi4licGX4dNkfqg7853kCehT2Af/eJE87sYy
         S6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnzJn9/apOse1TRdog9QxKjgDoh08yuT8iYmEPjnkLo=;
        b=iHfiMqegn+dM2owAmFgEkWFgcD9p+B+2EqDCZLhnnz+2+L05DJt1I7KvWgFFUYN0Y7
         2PdVuYXYd4MlSkgCoQiXiEpwwBB9dSXeduQNok7xHKyglRgfwkJQs/6lrYUOpKO178Vl
         DCPxsWTvZqo3m1y+bBLxcLbsoKIFZbixugsJ7jNy48ZvqE/lS/0743ghIwK3Kqk6LTVS
         2ofs+mC2I/uyJ9er6of/NXUmkzB6t3sZaS7gMUumfK/iCySex2fGIGSXsZCCv+8m0OyQ
         JTuuI4s3n90PkrVGM2ukHX9AGGSS+w/ZLdqo6+5uBZ7J3FcwtcMnJusoHGfqv2/1Afy5
         Yikg==
X-Gm-Message-State: AOAM532TMcNe8ALnaxzQ4q6pGgyj8wcIechbztf4bW0gsJxMfUth4037
        nuGE2PYiflig03C+d59QUMTeulBtRjE=
X-Google-Smtp-Source: ABdhPJyS1uQmxp9EjFBBuu7Wu0WbDYSAIAiNH9tMqDan9RYRWsD+dh/C82c+oe7q2B0VbV9fc3mpvg==
X-Received: by 2002:a05:600c:3641:b0:38e:4b2f:330 with SMTP id y1-20020a05600c364100b0038e4b2f0330mr17410186wmq.180.1650709475085;
        Sat, 23 Apr 2022 03:24:35 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm4089057wrn.114.2022.04.23.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 03:24:33 -0700 (PDT)
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
Subject: [PATCH 2/3] binder: Use kmap_local_page() in binder_alloc_copy_user_to_buffer()
Date:   Sat, 23 Apr 2022 12:24:20 +0200
Message-Id: <20220423102421.16869-3-fmdefrancesco@gmail.com>
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

binder_alloc_copy_user_to_buffer() is a function where the use of
kmap_local_page() in place of kmap() is correctly suited because
the mapping is local to the thread.

Therefore, use kmap_local_page() / kunmap_local().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/android/binder_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 0b3f2f569053..0875c463c002 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1217,9 +1217,9 @@ binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
 		page = binder_alloc_get_page(alloc, buffer,
 					     buffer_offset, &pgoff);
 		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
-		kptr = kmap(page) + pgoff;
+		kptr = kmap_local_page(page) + pgoff;
 		ret = copy_from_user(kptr, from, size);
-		kunmap(page);
+		kunmap_local(kptr);
 		if (ret)
 			return bytes - size + ret;
 		bytes -= size;
-- 
2.34.1

