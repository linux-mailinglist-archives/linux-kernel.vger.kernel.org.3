Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039A50C92C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiDWK2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiDWK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:27:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B8E55B8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso6720013wml.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrJ9VT1U6pXkFDAeCtKaSy4E+WG6fEcoDC8tfVpmfEc=;
        b=VC3B/QEi0icnjr6kEzpD3fkHieeml6wJWcnleIfuqOjC1Y8j+Nhlwr+C7IskW1LXAc
         jQiFYidfnGG3cZt9f5qPLtxQn/B5PVG1VWtcjF3SIMkkgB3fJSeXQY8YPh72biMOxRpq
         Cy9rZkGLO6nZQ63VR3f8yCd4DkBZ4Qzq2ysADdOnBLJJ8OaIdUsrfWieEkRunOGkdl8U
         fhOKzarOb7xvzoAJ549OLmviEq1EOVt+QO+Ezdqgj4v19X5FUtbSh1UMRATP8GsCQ0TM
         ecgb0rPcSr1JfjNViThNoFtwIGBVtcViImCyvoeiwV0GyRj1BqtjVDxhEz0tnVmy69X7
         LViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrJ9VT1U6pXkFDAeCtKaSy4E+WG6fEcoDC8tfVpmfEc=;
        b=Sk1EA5sO14XchnuboEOLjUmf55OsDCftMMlEYiO1f4wXHIlmZ6BiZMQJpiVyDmbvbH
         dEmDnpVKOyKmCh5Qv1mQ5pDJ+Sj+BSfOwtm0FjATmq7ltI8Rn6emyoGavEzCzLMK9dKK
         lX3+iFv02M7UFhRazso/TA4Oc8Z0vxFrCNmB6Kl6OcoaG4Uk+l/6VN6c25sXJFcMyPW9
         GVEg0sUTwRNLbrwu11slyKWIg0oCtf1itSYjV3aXihYOZ77U+HjMTpw39cLbUiMNrFzd
         9GaAKoKUHsu90k/9hA8O4Yoxrz6nQbUaaTNOPMqTrmVx+bQNTuJ9rD3+t93DVvrGIt/0
         XnfA==
X-Gm-Message-State: AOAM532OGL6rLcqrvlLocMW6h4j17kXdv2lPHXKTwj90A0/pDmwMXOwZ
        Q7uBP63Prwhv1D6Y6wr1TCc=
X-Google-Smtp-Source: ABdhPJwD2Vte4EbWLpcsvpjuZbfLAin4wGBDAQJiL0Btp/8xWXaXgturiG+CR2Nw+RECunvtIJB0bw==
X-Received: by 2002:a05:600c:1e85:b0:391:ca59:76be with SMTP id be5-20020a05600c1e8500b00391ca5976bemr16985309wmb.184.1650709477436;
        Sat, 23 Apr 2022 03:24:37 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm4089057wrn.114.2022.04.23.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 03:24:36 -0700 (PDT)
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
Subject: [PATCH 3/3] binder: Use kmap_local_page() in binder_alloc_get_page()
Date:   Sat, 23 Apr 2022 12:24:21 +0200
Message-Id: <20220423102421.16869-4-fmdefrancesco@gmail.com>
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

The use of kmap_atomic() is being deprecated in favor of kmap_local_page()
where it is feasible. Each call of kmap_atomic() in the kernel creates
a non-preemptible section and disable pagefaults. This could be a source
of unwanted latency, so it should be only used if it is absolutely
required, otherwise kmap_local_page() should be preferred.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Furthermore, the mapping can be acquired from any context
(including interrupts).

Therefore, use kmap_local_page() / kunmap_local() in place of
kmap_atomic() / kunmap_atomic().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/android/binder_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 0875c463c002..058595cc7ff0 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1250,17 +1250,17 @@ static int binder_alloc_do_buffer_copy(struct binder_alloc *alloc,
 		page = binder_alloc_get_page(alloc, buffer,
 					     buffer_offset, &pgoff);
 		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
-		base_ptr = kmap_atomic(page);
+		base_ptr = kmap_local_page(page);
 		tmpptr = base_ptr + pgoff;
 		if (to_buffer)
 			memcpy(tmpptr, ptr, size);
 		else
 			memcpy(ptr, tmpptr, size);
 		/*
-		 * kunmap_atomic() takes care of flushing the cache
+		 * kunmap_local() takes care of flushing the cache
 		 * if this device has VIVT cache arch
 		 */
-		kunmap_atomic(base_ptr);
+		kunmap_local(base_ptr);
 		bytes -= size;
 		pgoff = 0;
 		ptr = ptr + size;
-- 
2.34.1

