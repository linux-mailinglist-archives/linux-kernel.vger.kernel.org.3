Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF0950E7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbiDYSBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbiDYSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:01:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FC286CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:58:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so6134354edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ogzFF1vidBXb8qUr8gbdeuYvvr4G0L7hay7vGN5jrk=;
        b=fQk1z1BqeH70BndD2TZKd5xfNwDkTjv0pCOIscV3w0xlpv4EByQ3g0nDFXzpYuYmaT
         RvuXfazqN51WsaphX9uC8uMOJzdPsRFjef1QnIjbJv6usa5cFne57w/1WeFj+YG2/dEm
         fiZsYE79OI1QraVMFla8BNx98JNUbyny0gjtxD1UBLKOXaADFgF64qiwJhpmKsCnW13l
         Zvp7CtVGE1LPjR2dHhE8/6Qxb0uSItPF+cbEapdHUd7M6U9lHDeI3bbSjv6n0kuPJew7
         gGTXYdlq/iFOX46RHhEPwXw1o9Uaaa3nkECP9jk+yGhUgEFOSnQ2IRilFCv8oU8ak5Lg
         qtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ogzFF1vidBXb8qUr8gbdeuYvvr4G0L7hay7vGN5jrk=;
        b=GV8biGD3Itm7JRoXQBJRcS8D3Y6V8ujeKXGGTnoty2m0T1aBlD4ZTy3t+ncREEV4to
         wg3dY1wPZ/Ai8NfyjnV9RIM6StR4s1qBdkLFU/ISA+6tzGt8M72G+qOTCxJCJKyz3Yh7
         OBSGdWFwzs8Sv1/l5Db/YaviI9pNoUaEJZdDH3BCXOC4dAjabqQqY60Ul7Hz/Q3jHxB2
         cyfpJBRvxQP2sDFIUZhlNeCsqnohl//5HTEJsUJ9a6Iuy0gNW6UjzXeohrv4u+YR0ehN
         OopMdoI/k3knBAq9DqsbJYiWQqjc8ALfpu1lM0gPnb/LQu5fJt/prENC243QZm+0LZzr
         y0FA==
X-Gm-Message-State: AOAM532/a+u4FlEV/S45fTDwIRHua5qvvy8a5daEa6v2XKJEJ8v1iSYT
        9e5QPwvN2+5KLSa1IRl3d1HkDDta2oI=
X-Google-Smtp-Source: ABdhPJwjFtfMyK+sAOiJ7QyESeOYFPoQId61DP7WcjKDuglqZugmp3vyRhWpSHMX6Dxt9u3oD+yP3g==
X-Received: by 2002:a05:6402:1a26:b0:425:d3cf:d7f0 with SMTP id be6-20020a0564021a2600b00425d3cfd7f0mr13265179edb.251.1650909483031;
        Mon, 25 Apr 2022 10:58:03 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ia5-20020a170907a06500b006f392df973bsm1497207ejc.107.2022.04.25.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:58:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH v2 2/3] binder: Use kmap_local_page() in binder_alloc_copy_user_to_buffer()
Date:   Mon, 25 Apr 2022 19:57:53 +0200
Message-Id: <20220425175754.8180-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425175754.8180-1-fmdefrancesco@gmail.com>
References: <20220425175754.8180-1-fmdefrancesco@gmail.com>
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

Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Add Todd Kjos's tag in the commit message (thanks!).

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

