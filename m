Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74048512580
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiD0Wtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiD0Wto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:49:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517284339B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:46:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so6097649ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDNmZdaTEeDFa+SYiy2FhMpx+6VvsSpHDLR10ll6ANk=;
        b=UMzpsSwwPouW1UdBJS7hpyHQxIRy9nsYXCcr9W+7hljC2F5PSqtNm+jQpv/doXqgu3
         HHNb11Aqbv0E91en3I4gFKU/Ii3fTqFvtEZBSNF5NiNzxy7j5SmPrYkyEuZJEcgk+vHR
         ZBYuesRRia/y2TI4iP0yu4jutPxojq52zbsFu2RdahZURM8L2tUCeQzAxKnM83oJ703S
         XUBGD5Uv6V3JfnkZAjpopKPf+H6oN1OCemBpy3EBanwiEmr7AqU8d74HMf1j0Q6bg1NO
         TqQ6GfwQPXaSRTzatjK+ukk+PboYm1k7ZbL+p3l8tZoxaVsNYsQRJdofW2p1p6w8K24i
         05qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDNmZdaTEeDFa+SYiy2FhMpx+6VvsSpHDLR10ll6ANk=;
        b=Gwd9uAfZ0TiDNcfyg1IFB0ZX7hoCzd75JmA33eLPkE2+8QzNAjgvtxo3N/VAqJ7Io2
         tiv++FpOawJhArc7qJsds2BWT0diWCVrJi+EZnNv5mRGPW7nn4BDkqeQNr1KL6VvIYwE
         TGaPfpkoK2ILF9LAkULhm/C3dKYLvq7Axar+J0p1yfangAXXVRarWk5zbY4Bp7oDVLB1
         QgaNvie2v5bjyQ9OqndHkpaE3zEVvQrdd43JsTMGfC6SVLHMKBy9/KtydDnbJkYUIw4I
         bxtCbOlo3YJXNtWvQ5PYkH/UYcWdKZw5NYGmSAA00OtPi9hiqjdGWEiK+nYnpU8IxzAW
         Q/Gw==
X-Gm-Message-State: AOAM531kz8YWi9chhnR/NkZK/8AGDd9LE58Z17LDGj+wJVedsouffmlF
        x//KQIA7iK4iZaEqP06O3Gw=
X-Google-Smtp-Source: ABdhPJzH9KUeoZKiyyoLsMaGQe7aDUU5HjyOsWUmyNUcWFoDHmiTTlqcnelDOlnc1Dy+Vj4QInKYZw==
X-Received: by 2002:a17:907:d24:b0:6f3:7c4f:f710 with SMTP id gn36-20020a1709070d2400b006f37c4ff710mr21160019ejc.6.1651099581835;
        Wed, 27 Apr 2022 15:46:21 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm7351657ejn.169.2022.04.27.15.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:46:21 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH 1/2] mm: mremap: fix sign for EFAULT error return value
Date:   Thu, 28 Apr 2022 00:44:38 +0200
Message-Id: <20220427224439.23828-2-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220427224439.23828-1-dossche.niels@gmail.com>
References: <20220427224439.23828-1-dossche.niels@gmail.com>
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

The mremap syscall is supposed to return a pointer to the new virtual
memory area on success, and a negative value of the error code in case
of failure. Currently, EFAULT is returned when the VMA is not found,
instead of -EFAULT. The users of this syscall will therefore believe
the syscall succeeded in case the VMA didn't exist, as it returns a
pointer to address 0xe (0xe being the value of EFAULT).
Fix the sign of the error value.

Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 mm/mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 303d3290b938..0b93fac76851 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -947,7 +947,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		return -EINTR;
 	vma = vma_lookup(mm, addr);
 	if (!vma) {
-		ret = EFAULT;
+		ret = -EFAULT;
 		goto out;
 	}
 
-- 
2.35.2

