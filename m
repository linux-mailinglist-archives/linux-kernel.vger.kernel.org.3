Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0303950E79E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbiDYSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiDYSBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:01:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5196433A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:58:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a1so13741692edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HJrozkvVkscS0zdSWk9LaftjL2z1E2cnMkC2nHI7pY=;
        b=gitlin4eSQ5kEyFnKB9CpAO9Q3nsVpEq4IfwfoQ63ph3VaYJTDat6BhbWTkBxi9kx3
         YeGbtuODl9+entPhkyr5TpazRNM8RHiJ8lQTcE+nXzQPQQtBsDUBwfhHsLKUB7w/2bgn
         qBLInehp/cdVF+tHJHIF7cDP2yRYa0Uin/xEa4B/t2m4A9nQc1wxL0Y3HOF4Ett8gEb+
         bi4Q//JL9HzsdKkOox1lyIF/7yFf/lqUol+hUpGX/J+6Ho31bniPadBz5CvqHAHh0yqB
         7DLYuzquCDpmjp2A5akX0rKMbBYz1qnsOY7m3F/eVYgusgq3q0IrNkdCT6CFcqlIBYRp
         iLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HJrozkvVkscS0zdSWk9LaftjL2z1E2cnMkC2nHI7pY=;
        b=goUTzfCk/DVZJLJ6Ms4pczZ/1Uqxv9/Y9Y7WlnmeouX8bTUqrJpCmQvguSueU3DGWV
         QKsNN7jRykZuGOUVy54eTZaa8aQKSU4A2hA0h6ZjqQRefQAQs+y4g9IGxs0v1P6tGWxL
         DI8tBDelsunZiWq4EqEjYxmg0JVmfLuVNqBUJIjvscM4vPIiV669PxSMu196TIMgdsGM
         1l6kt/rL7GkUmPJxBS3Hbz7gnBHpqBVCRYjoTmVPS6ny9NzXVzUCOKBtN12TkrmlOd4c
         9OqokvwzZzzXDxT1sXFYv+Bpq94xCW7Yk8BYfL9r9LS/CPnZ476QN1QMyaaToQXGlpSG
         zbEg==
X-Gm-Message-State: AOAM5337VK00WI7LqB2ate1uwA23NiE5znc/Mrb4Isui8RJUW2rxwxSp
        3nDE+jMfrw5hXumhpX9mIyg=
X-Google-Smtp-Source: ABdhPJy6AzM9WCKC1+WGQWunE0TwIw9DcswsxtS8VT8z5/lj5NUxCxegU64lNkHjPnC3a2aARqaBTw==
X-Received: by 2002:aa7:d9d6:0:b0:425:dafc:2fc6 with SMTP id v22-20020aa7d9d6000000b00425dafc2fc6mr8299494eds.340.1650909480802;
        Mon, 25 Apr 2022 10:58:00 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ia5-20020a170907a06500b006f392df973bsm1497207ejc.107.2022.04.25.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:57:59 -0700 (PDT)
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
Subject: [PATCH v2 1/3] binder: Use memset_page() in binder_alloc_clear_buf()
Date:   Mon, 25 Apr 2022 19:57:52 +0200
Message-Id: <20220425175754.8180-2-fmdefrancesco@gmail.com>
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

binder_alloc_clear_buf() is a function where the use of kmap_local_page()
in place of kmap() is correctly suited because the mapping is local to the
thread.

Therefore, use kmap_local_page() / kunmap_local() but, instead of open
coding these two functions and adding a memset() of the virtual address
of the mapping, prefer memset_page().

Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Add Todd Kjos's tag in the commit message (thanks!)

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

