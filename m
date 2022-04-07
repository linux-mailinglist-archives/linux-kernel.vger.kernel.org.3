Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F604F7AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243559AbiDGJDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbiDGJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:02:50 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4278164F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:00:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v13so1642991qkv.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpsn8zlGuEr895I52lJu8BAnUlOryrWv2Qhy+2V7ZP4=;
        b=YVbH4kfpa5m3GX7HPTL5Ve157W4wO+bLgK44lsQR5hIevYJyysuD0Jb1IFCgUHiVPk
         IudRTosA7GPp5f8GqswhyKClc2h1xLDD1KjlcX9VMbcWKh3qEhLdxfqBxhlBbJNaFcuq
         Jj7RQemXnX/40hRbYJStCKLEp0PJ0KARkvo7D4UxpGkkAgoY7dexvMHyDfYdQvAvswAH
         HuLRJyiVFiMO4xok2FpoMLN5uzUcGPQ8j/ShNlS74tY/RHtuajFZ9dZ4zRPmWs+lyiss
         3OmM4Dqlz0O2OrgRjIdbEIFNxaWhslLab64MkAavbsEa6NvmFDNEFco/kexE+tfn6eDK
         cGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cpsn8zlGuEr895I52lJu8BAnUlOryrWv2Qhy+2V7ZP4=;
        b=DYm8c95V/dZw807PA7e8sNe8IqyfYhtyvBLv3L/z2+76nxGw9DgKqPXlEypoqALtpF
         Mqlo5F2FFeNPBQ/YtuwpOnsqwvJhoniulKyLgGhm3AUwz6/b024aUGV66v0HIbHZikjV
         YG9Yw/qHOKSsUWndeinGwPBZdMoUofDcooKn1N9eMIdo0FhFKFLBbrL2uc53vouL2XHc
         0kIbsbKxA1rI59pyzvrJ3aJBMwgag705awFqmqloU+pNXhh4sIC6kYniRic5M6j93Vtr
         1LPa5YApoLwbnw+ZVEL93mNvnK6UySDUPI5gUnj9fyzuejzOnkdKd/ZJpTpoLa2h8kIN
         LXTA==
X-Gm-Message-State: AOAM532DkeZqt9Fmv5p9x0kDlp7V2D97Y3js0E8df0Dmw2Eg8lGv65m1
        10h3lb1RJoqaz1OYpRY6z6E=
X-Google-Smtp-Source: ABdhPJy28M3cmBeS6IRvUM0efW6fbXHiokSkosHV1GY7AEKqurscM5QyDMVXdwfQ1dZETBvWnSWOJg==
X-Received: by 2002:a37:b502:0:b0:69a:ca1:298 with SMTP id e2-20020a37b502000000b0069a0ca10298mr469093qkf.133.1649322049430;
        Thu, 07 Apr 2022 02:00:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm16813270qta.75.2022.04.07.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:00:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     paulus@samba.org, lv.ruyi@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc/powernv: fix missing of_node_put in uv_init()
Date:   Thu,  7 Apr 2022 09:00:43 +0000
Message-Id: <20220407090043.2491854-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

of_find_compatible_node() returns node pointer with refcount incremented,
use of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/powerpc/platforms/powernv/ultravisor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/ultravisor.c b/arch/powerpc/platforms/powernv/ultravisor.c
index e4a00ad06f9d..67c8c4b2d8b1 100644
--- a/arch/powerpc/platforms/powernv/ultravisor.c
+++ b/arch/powerpc/platforms/powernv/ultravisor.c
@@ -55,6 +55,7 @@ static int __init uv_init(void)
 		return -ENODEV;
 
 	uv_memcons = memcons_init(node, "memcons");
+	of_node_put(node);
 	if (!uv_memcons)
 		return -ENOENT;
 
-- 
2.25.1

