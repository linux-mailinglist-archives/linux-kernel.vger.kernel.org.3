Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902C566974
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGELc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGELcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:32:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72C165AC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:32:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so16479484pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ric4fzw9LJrNcSTyTbiVbmxdWQkgNYXNndpMyI1IIbo=;
        b=bno77WZ9RFLUA1l5FIyvVKOlbQeZOgroHT8krb9x/2BeGPyEyF3d4DMC/A6FJPLsIy
         Xh68b6iMHQDHj6wr4x0VhPEDYyIcjrLT37xsEAvLNUArogpa23P8Il09lM0o+gNssS0c
         0tuD3JCPSpIqHWokuxBFhr6jv7arq2VtVzQiYVkDR+pepwn+xsRP4CflanZGLpfngjWO
         bHq5EH89mKUZHb1HEFXYk9Ovy0bYsflOcQRJ0pLomQ90Dso8+QCeR+xy5hQt+Dpi4uCI
         zH0WRDo1y3pVD3Q3jWm8nUkRAsKpWjh28ibSovr6OrIEATo/+SoKGJJp+2rVyVNPIKYC
         FGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ric4fzw9LJrNcSTyTbiVbmxdWQkgNYXNndpMyI1IIbo=;
        b=0SmBTlhXke9EmOFEMSAT0LdnIN95Ih+21SmOkZt/LKzHjMocfSVZ/kWxEUbi6B/4md
         msZ2MNVfCAjAUROy9YtMgYxH3L91dZObcCnBaphkClaAmevYPMvOYfHcAXS6iRi5zjya
         aa0Um+fZUqkrrQgwZtfNIimC7IzABnMfk6fL2/BbNy7PnrgZcK1IL0udwvufoVP6PWnO
         JyC2VWhe2p2owG714wU0uPJhTec+mkjWh7x7cXFOGn9y0cqYxbdUF8BbsCvJ5NdLvdKa
         p8FcFXpn5rWX0kEtvoj6F/7mbc69bkxxS+b7D9A4bSMAq9371wPfJgjLEyK5sr8HtUi7
         ZWFw==
X-Gm-Message-State: AJIora9UuxfpndhDkMGfR48zs2BvkNALAbN4/TcQ9Cuk4bHw+eLxhNYW
        FfMPIZjS17CUSNaSE+LDqoE=
X-Google-Smtp-Source: AGRyM1syeOueifblOfmGpwHkIsqecYbc6DEx/9cbc/zkvhAdvSCi4VFFxj0dlcUjXP518boRxTLjyQ==
X-Received: by 2002:a17:902:d405:b0:16b:f1ee:27c0 with SMTP id b5-20020a170902d40500b0016bf1ee27c0mr2873828ple.10.1657020757077;
        Tue, 05 Jul 2022 04:32:37 -0700 (PDT)
Received: from localhost ([101.86.201.206])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902bd0a00b00161ac982b9esm23121878pls.185.2022.07.05.04.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 04:32:36 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patrick.wang.shcn@gmail.com
Subject: [PATCH] mm: percpu: use kmemleak_ignore_phys() instead of kmemleak_free()
Date:   Tue,  5 Jul 2022 19:31:58 +0800
Message-Id: <20220705113158.127600-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Kmemleak recently added a rbtree to store the objects
allocted with physical address. Those objects can't be
freed with kmemleak_free(). Use kmemleak_ignore_phys()
instead of kmemleak_free() for those objects.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
Similar to:
https://lkml.kernel.org/r/20220628113714.7792-2-yee.lee@mediatek.com

 mm/percpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 3633eeefaa0d..27697b2429c2 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3104,7 +3104,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 			goto out_free_areas;
 		}
 		/* kmemleak tracks the percpu allocations separately */
-		kmemleak_free(ptr);
+		kmemleak_ignore_phys(__pa(ptr));
 		areas[group] = ptr;
 
 		base = min(ptr, base);
@@ -3304,7 +3304,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 				goto enomem;
 			}
 			/* kmemleak tracks the percpu allocations separately */
-			kmemleak_free(ptr);
+			kmemleak_ignore_phys(__pa(ptr));
 			pages[j++] = virt_to_page(ptr);
 		}
 	}
@@ -3417,7 +3417,7 @@ void __init setup_per_cpu_areas(void)
 	if (!ai || !fc)
 		panic("Failed to allocate memory for percpu areas.");
 	/* kmemleak tracks the percpu allocations separately */
-	kmemleak_free(fc);
+	kmemleak_ignore_phys(__pa(fc));
 
 	ai->dyn_size = unit_size;
 	ai->unit_size = unit_size;
-- 
2.25.1

