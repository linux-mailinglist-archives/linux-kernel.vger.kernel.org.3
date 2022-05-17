Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB7152ADA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiEQVr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiEQVr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:47:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DAE52B18
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:47:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n10so110340pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7pyy6E2RnWeIWkxBWEXgMm6xwmOUjrAOyo0FwZHE3M=;
        b=i5ZizIgKjPC5FWkkv4pQ9fzdJ2F9jey36U2ePt8A2qFCy/BSpVAkfHeucHfnA2aJdl
         3h1wzls8pry+KvjypLKRkqVS+B6RWmHgI67Oq+m/nCYuzzZdFoamUlfS29sl0uKSSl6P
         QsH/kFcc4Kn1Je1iJOByK9mYHr04kVaT9/Jnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7pyy6E2RnWeIWkxBWEXgMm6xwmOUjrAOyo0FwZHE3M=;
        b=hLqfqiY0fPmtW6GBynAzp1BmDqVlaReC/pwMZEOtiXv7IGZI+yW2gZ4BN6l0Fsq+jZ
         iZ//7ELlbv77+K43HuJ3zxvFRRiUyXSIwjRKvQzV+JKbOOTAqTPt2BgYk8lHxCap9Ppm
         Eyo7QtF7qCoguNIZ3T7uJJKpgnSYjMNXoKXq5EkGIOWh/V3DQDVwu1pZen7V4lmlvjWe
         Hy6+PDJkJmey40fBDfTsnXTNgMqLokbLgHsQUvSmIKsJsy9ztOnah/wtdk1GCs7ClgJr
         nomxwIWFF944cuQ7LEv8nOkGDRfw7FDj+NGUDrzEUNIMp1yyU3ircBRzSMB6TByiMV/D
         txKA==
X-Gm-Message-State: AOAM531oV3r9N7+hf+wcdUqha5vV1XxXS24zBRN9K8Xa5Jwvi2T2QiTf
        nwkjz1RBrQQOVWF8EY9FOpAbmBtHB5Y1Sg==
X-Google-Smtp-Source: ABdhPJwcOvKdR0sEAIITObq8HPR9LzoCRWxSkOWIKeyktUa3Hag3FVvj7utF86QSQvkLCYPpQPNXhA==
X-Received: by 2002:a17:90b:1b47:b0:1dc:3c0a:dde3 with SMTP id nv7-20020a17090b1b4700b001dc3c0adde3mr26988737pjb.52.1652824074462;
        Tue, 17 May 2022 14:47:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r24-20020a635d18000000b003c1bf4c064fsm25644pgb.72.2022.05.17.14.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:47:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/heap: Hide allocation size from -Warray-bounds
Date:   Tue, 17 May 2022 14:47:52 -0700
Message-Id: <20220517214752.877892-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; h=from:subject; bh=r1vvWyPMo+weXnHfU6apxX06asx5XlIDPRF3oTBkz4Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihBgHWCusDKC4hKbABxxKuztggfit8AvSMH+iVFLV XdNdeyWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQYBwAKCRCJcvTf3G3AJjcZD/ 9DCny8GCVsW0cFQv+UlrgbRciJZMVxV3sPQg0y69mLu1L2uZrYtntwxnxGEW3/L5Ppak9V7w+XgAdQ wUv3G+wT9o/3SkTYMUWbhXbGCTGou1pBPK6lUfWqhPAT/UTmyiYrLC852k2SkubodYpOI085tfSlVA udqJUNCTnR85JZZ/WcXjDocQpTIebmaPSZ7HFLqIF6VjDPJKQBLXWHn5r6711D+6wrUJzgVFK3jErv sHm6Cx9y00dfrkh17PTZsU0BR5g6V4vqarf9Z/lK0UnhPyg3N/+SeJTo5ji4XbofJXm2uCRVOyL5Cs odMp+7d/eHr2WAa88EU+FzUrJfnZeOVzgvlqbsFL6hiyDAleGBKmxL46RHC5YavCUyp5IGbBvjRmdv qmz2dORdoU0C1dilfNKFhsbe19+ahllY9gcyd1wr+L9LFt4r6RvE6YDkUyWwWzjkRGff3oxRh1i6oG aVfYYSzSp+6NYviKODolr/tUl5ujVBopySkGylOB2U58ClcIWo0VEHXbraO6Aog9J0nyJ4d922toqb 2NgXkbtoD3a3gtQ8wrbztQnp/ZtIAaY3KeBc/ZMmDM6HSgsH+COMjWY7+8bam0l/uDbAHG3vVzNuAp KQQMVyYiGQ2sk4XxdPK5lkfNz2ertlaoshGJ8Ym5Ly4UeywnFczLZyUerx8g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the kmalloc() size annotations, GCC is smart enough to realize that
LKDTM is intentionally writing past the end of the buffer. This is on
purpose, of course, so hide the buffer from the optimizer. Silences:

../drivers/misc/lkdtm/heap.c: In function 'lkdtm_SLAB_LINEAR_OVERFLOW':
../drivers/misc/lkdtm/heap.c:59:13: warning: array subscript 256 is outside array bounds of 'void[1020]' [-Warray-bounds]
   59 |         data[1024 / sizeof(u32)] = 0x12345678;
      |         ~~~~^~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/misc/lkdtm/heap.c:7:
In function 'kmalloc',
    inlined from 'lkdtm_SLAB_LINEAR_OVERFLOW' at ../drivers/misc/lkdtm/heap.c:54:14:
../include/linux/slab.h:581:24: note: at offset 1024 into object of size 1020 allocated by 'kmem_cache_alloc_trace'
  581 |                 return kmem_cache_alloc_trace(
      |                        ^~~~~~~~~~~~~~~~~~~~~~~
  582 |                                 kmalloc_caches[kmalloc_type(flags)][index],
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  583 |                                 flags, size);
      |                                 ~~~~~~~~~~~~

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/heap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 5d3b92cd23bd..62516078a619 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -56,6 +56,7 @@ static void lkdtm_SLAB_LINEAR_OVERFLOW(void)
 		return;
 
 	pr_info("Attempting slab linear overflow ...\n");
+	OPTIMIZER_HIDE_VAR(data);
 	data[1024 / sizeof(u32)] = 0x12345678;
 	kfree(data);
 }
-- 
2.32.0

