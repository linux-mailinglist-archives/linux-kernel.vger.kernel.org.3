Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A253530F35
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiEWLLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiEWLLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:11:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439AA19F89
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:11:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so10792923pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5BnpyT21XxmPEltzzCAln/RtmxzwllCEL8G3E1N/fc=;
        b=KABL5hpsiMRjUN5/8tnsKM1eG36tCM6CN5WjGMrOIzb9gaR5xpba37erhgDZmN0lXJ
         9U24mJHt31S60KaPAHRFSbE8N95K7qQBjWakaI7KpUAFXl0NQFYap8HgSkH7IjavJoOB
         IQ9EdIj5aiR/ywpgF15fQ5WTmEcbq06e+l9MO8l/zuvjqB76iIo2JJBLXVbvNi2yjfBL
         9a9MSRgPbAKuRdPKPXdKNu0biJ4HHjR09irLAtuTLLP0oA5ciEuLk5sj20mp98t5J+D7
         yBTj47Gxs+2Y1t2zgQtXI4LPtKC9EsdTHSBDi6Clq1rD/fx4bgW5TW4kduKCjhPNisbb
         ecig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5BnpyT21XxmPEltzzCAln/RtmxzwllCEL8G3E1N/fc=;
        b=4V/YpkcKMvrcGx0OZoJrrQAw0QF9n9ZXRpicakdIpwpsZ6F+PR7F3RWioKWwYm7DL8
         3FB8mSneLE78HF6pm38y/16QGsjPorpmpCDdW6Q3ng8oss6wJ4stEc2xQVz9DC0X83NT
         QFkcKl+y3iUMXFFo7fwmtK2R5TozZUZ6eKT7ULIIAw5PDw9MJy7C14MLjjZUXVMlz8u4
         wcRU/orZSoaLPl8QVwyfAxMkbGKUvAQ0/IW5dAV0Edup+QLsMZO25y7YQQc7WWR4rcG1
         teUU+vb+lXIS54mCp0bJtltCCuL2Cx8Sfnf6e4MZqNWyy4w5yWGCmgCnqN0c/geO8Own
         1gVg==
X-Gm-Message-State: AOAM533lruK/74yI+GKQ6+cK/NGOTdtTsqfgf6HPp8PBStc73vV8ybZT
        6YZhyc+29FQ0rJBPnhUN3ZssAaWICIc=
X-Google-Smtp-Source: ABdhPJwzc2locnUHLd9zvUFe31j5Q893w4ciZJAyxd61TfgGUxaEunrUjdF6HHe+c518HQPoozEJvg==
X-Received: by 2002:a17:902:7483:b0:161:ff6a:402b with SMTP id h3-20020a170902748300b00161ff6a402bmr12788392pll.89.1653304309520;
        Mon, 23 May 2022 04:11:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id md2-20020a17090b23c200b001df2f8f0a45sm7048321pjb.1.2022.05.23.04.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:11:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] iommu/ipmmu-vmsa: Avoid leak OF node on error
Date:   Mon, 23 May 2022 11:11:45 +0000
Message-Id: <20220523111145.2976-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The OF node should be put before returning error in ipmmu_init(),
otherwise node's refcount will be leaked.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8fdb84b3642b..f6440b106f46 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1179,11 +1179,10 @@ static int __init ipmmu_init(void)
 		return 0;
 
 	np = of_find_matching_node(NULL, ipmmu_of_ids);
+	of_node_put(np);
 	if (!np)
 		return 0;
 
-	of_node_put(np);
-
 	ret = platform_driver_register(&ipmmu_driver);
 	if (ret < 0)
 		return ret;
-- 
2.25.1


