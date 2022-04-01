Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA64EFC2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352766AbiDAVdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDAVdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:33:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DC264F6E;
        Fri,  1 Apr 2022 14:31:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a30so5473715ljq.13;
        Fri, 01 Apr 2022 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0JK5ihT1MOGfyrbF7/pj0RowTruIVoP8e8CBBTi+S4=;
        b=C3Kf9Jm7U1BjEQwktj6mm0YSGdJta5gC611qurF0ij+1RP2Nw6zIG8ZqJlQeUPFlSR
         4raoXNZ0GZM2xMqM+JWbTCIJOOITuhrDYmCMsyuA540wopq7D/I4dCPHjnz1L1AuC+Ed
         fSVIkEpV+m5VcxY6+rZb96Oyp9TyTWfOOH/32rIrgph10FCwftAH2n/JjYxdXaSqv5ba
         wRchlZZNVv2YkBrwuydSSuEW/BcDn/BkHwRj6Yqk05OS3Qo9R1p28mK9m/JTNJzoCu6N
         I86TdUsZRQ6dD0J6GYUoSB0mZ5zPDkz8CE1W6SIxIVouoS9AipGBIMPgO+P9wu86uIro
         jhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0JK5ihT1MOGfyrbF7/pj0RowTruIVoP8e8CBBTi+S4=;
        b=d+fiXOo2RE3K9dZMme4ExGrkwNOWy2/VGjPBZUPTCoeTHeKCuD+q43/6KJCEkmozbQ
         QuYhTkcvRLCImyfDAdkde4WMrvwUcAPC4bhHfqvS4oKxdTc3pm64mvXVWlhKrfIoQOe9
         CzBCW1mBDYuZ0+E9drVty2W2BTW1tSC5fqE4XL7INPh4uMHRkgeAoZeV1Ey7WWdl+Sm9
         4tE3j5WMAToGz3et/Hq8wh8FoL6VJeZ/OITdxVeRFP64peynSxyD8gkKLBvk7zRnJ/aq
         G/+WXPTQlLAN7VltypWVl1VOowbFPgYsAWZsDHWzf5n5WwT6nnMDyDm9SqTJfldqT6yn
         j4cA==
X-Gm-Message-State: AOAM531ysiwQGCbdA0YqP560hXETGj0UOzxZ1BybmEecazqIRa+mRKgi
        CXLaKvxlbMSgO+FZvDzY9KaM9MSwV64=
X-Google-Smtp-Source: ABdhPJwbmAj/TNXsyVzHxHQSIygbytu2JvhBQgA5HutAlambTIknHU9BwVfiI2XSNvpyitKPuCrnDw==
X-Received: by 2002:a2e:a80e:0:b0:248:5819:b94a with SMTP id l14-20020a2ea80e000000b002485819b94amr14660509ljq.141.1648848676369;
        Fri, 01 Apr 2022 14:31:16 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id m8-20020a194348000000b0044a2ce63ef4sm349523lfj.10.2022.04.01.14.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:31:15 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     sumit.semwal@linaro.org, gustavo@padovan.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH next v2] dma-buf/sync-file: do not allow zero size allocation
Date:   Sat,  2 Apr 2022 00:31:14 +0300
Message-Id: <20220401213114.11956-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <2d1f9ba9-ea2a-e41c-eae6-0ba348cdf202@gmail.com>
References: <2d1f9ba9-ea2a-e41c-eae6-0ba348cdf202@gmail.com>
MIME-Version: 1.0
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

num_fences is user-controlled value and it can be equal to 0. Code
should not pass 0 to kcalloc(), since it will cause kcalloc() to return
ZERO_PTR. ZERO_PTR will pass `!fences` check and kernel will panic
because of dereferencing ZERO_PTR in add_fence()

Fix it by validating num_fences and bail out early if it is equal to 0

Fixes: 519f490db07e ("dma-buf/sync-file: fix warning about fence containers")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes since v1:
	- Dropped already merged part
	- Removed syzkaller's tag

---
 drivers/dma-buf/sync_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index b8dea4ec123b..024f22193e0c 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -212,7 +212,7 @@ static struct sync_file *sync_file_merge(const char *name, struct sync_file *a,
 	dma_fence_unwrap_for_each(b_fence, &b_iter, b->fence)
 		++num_fences;
 
-	if (num_fences > INT_MAX)
+	if (num_fences > INT_MAX || !num_fences)
 		goto err_free_sync_file;
 
 	fences = kcalloc(num_fences, sizeof(*fences), GFP_KERNEL);
-- 
2.35.1

