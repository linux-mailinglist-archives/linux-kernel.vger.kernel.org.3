Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431ED50E79C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiDYSBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244164AbiDYSBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:01:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB352AE03
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:58:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z99so19385529ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bHZ+tZqolAzcHU1cWs/VivYqd7VAIYj72XruBW1EAM=;
        b=P7BlxsL/aeh1pYlUxsBLc5Mo7EnxYIpWQvWphQbXeYZ77gJjWeR5TcJk0gulo3zy8+
         GxQXlfUX/knxnXU9334jt9XGaVtoKqEZcx5DGutni/s77D9Uh0Dvk7YXuunBoyf11vLJ
         3TItX+kWCsBTpgkXvt+Ho6HIUZTYZ9hBpAbt3JH4AZycUK2n3tQuWPFsMQpeZqcUk9RT
         s3ayF/XpVArf39DL74YaasD5IJcos1VTWMasARpSHvTsU1H2b5qUQsh/gxZ80ccWJz2G
         zE8NsimWSPm8AGtpaLjXWzngoxM8ySpr0kyUdtN4yitYewfu+a8AaBMOWU75YKSRw4tG
         63KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bHZ+tZqolAzcHU1cWs/VivYqd7VAIYj72XruBW1EAM=;
        b=yaw1HBG6jl6gxP9JKkvI5NSGCV+4svNSNqJ6UNgMzwPlzQ4SUWYQLIIspGommqjKO1
         oMW/W0RiaA51NP26+6cVDa9HF8ckCcZyp/y6BqNcdaORkUS0+wMyQjrB2deeh1GGO4AE
         K73hifsdKXq4TmTQflbvS3wpvEcE2Bf6d85UCcAzx1+TA+q0KGSllbOqJPyYbEszm+ei
         4vNNlKTp+afAxdw/TsintIBk17uFV2EwnTpnBnBBxSKFozNQZ5BGHhrj6LdJvHSTh6Ow
         T1Gsw/O7wHvddmXyn4NhhX5yPEOAcjA1ttvCXsx32P4XCSwKMnazQu2ELAicLVO9+V7E
         lGwA==
X-Gm-Message-State: AOAM533wYYVvMfIP2muPVCcEq+BU52KYvxux8/0cMqr+vgTvtyHgnljU
        AL5s9gM7kSpgPb8ub4W0PJQ=
X-Google-Smtp-Source: ABdhPJwXTHe0xEVLUfl/2/b4vg4MZa5yXWsVhGSqrtQQBZYMJEU6qEbdG2xWdoUp6MmV1IP1THhBKg==
X-Received: by 2002:a05:6402:50d0:b0:423:f4a1:597d with SMTP id h16-20020a05640250d000b00423f4a1597dmr20210068edb.228.1650909485178;
        Mon, 25 Apr 2022 10:58:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ia5-20020a170907a06500b006f392df973bsm1497207ejc.107.2022.04.25.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:58:04 -0700 (PDT)
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
Subject: [PATCH v2 3/3] binder: Use memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()
Date:   Mon, 25 Apr 2022 19:57:54 +0200
Message-Id: <20220425175754.8180-4-fmdefrancesco@gmail.com>
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

The use of kmap_atomic() is being deprecated in favor of kmap_local_page()
where it is feasible. Each call of kmap_atomic() in the kernel creates
a non-preemptible section and disable pagefaults. This could be a source
of unwanted latency, so kmap_local_page() should be preferred.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Furthermore, the mapping can be acquired from any context
(including interrupts). binder_alloc_do_buffer_copy() is a function where
the use of kmap_local_page() in place of kmap_atomic() is correctly suited.

Use kmap_local_page() / kunmap_local() in place of kmap_atomic() /
kunmap_atomic() but, instead of open coding the mappings and call memcpy()
to and from the virtual addresses of the mapped pages, prefer the use of
the memcpy_{to,from}_page() wrappers (as suggested by Christophe
Jaillet).

Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: Add Todd Kjos's tag in the commit message (thanks!); re-write
the subject which referred to another function (my fault!); use the
memcpy_{to,from}_page() (as suggested by Christophe - thanks!); extend
and rework the commit message to say something about the use of the
above-mentioned wrappers.

 drivers/android/binder_alloc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 0875c463c002..5649a0371a1f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1244,23 +1244,14 @@ static int binder_alloc_do_buffer_copy(struct binder_alloc *alloc,
 		unsigned long size;
 		struct page *page;
 		pgoff_t pgoff;
-		void *tmpptr;
-		void *base_ptr;
 
 		page = binder_alloc_get_page(alloc, buffer,
 					     buffer_offset, &pgoff);
 		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
-		base_ptr = kmap_atomic(page);
-		tmpptr = base_ptr + pgoff;
 		if (to_buffer)
-			memcpy(tmpptr, ptr, size);
+			memcpy_to_page(page, pgoff, ptr, size);
 		else
-			memcpy(ptr, tmpptr, size);
-		/*
-		 * kunmap_atomic() takes care of flushing the cache
-		 * if this device has VIVT cache arch
-		 */
-		kunmap_atomic(base_ptr);
+			memcpy_from_page(ptr, page, pgoff, size);
 		bytes -= size;
 		pgoff = 0;
 		ptr = ptr + size;
-- 
2.34.1

