Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80FE51D05A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 06:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbiEFEsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiEFEr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:47:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004AB580DA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:44:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s14so6328312plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 21:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kq/Z8Eu7SYNiz5MUjUzvhIS5G1c7BzRPRvFl7aaXh+0=;
        b=GawM/MbZQdX0Vx7RCXLe5rZU11ZFRdq3erkTMZM03251cxj/+0eOyJTlgPaoSQ6lj7
         aJXyyeX2sqmlmEudrNMS1+C4SH1K2aroqYpVAlqYoIQGg3yqxqcZENe9fAslw5VcG8ip
         FITqZJo5NuwCiLiTCaDobXYQtRbG7hhhlKIqPhpQYtQJIKrkj3IxitgKuRYtBFt4um+b
         1k7Cc1JOyoEecxXLGVQnrA2WXL+/ECZzqJeSMxs3eXH9WzFpJ9+mvJESou+UAmZ3prtr
         HXF4NQOv2Eg8whkdz9sDvWVdRPZEYoHuqXbxiUiOjoS1mT4D0rErWa/+2MRiYb35k/DT
         1M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kq/Z8Eu7SYNiz5MUjUzvhIS5G1c7BzRPRvFl7aaXh+0=;
        b=joqo2C2LjQRngEaxgPA1dtPdXSpCm/imP6tx0/tARekUwdrGY/+xIiGJbeFegWlXXI
         wtluIXwRR+w7mOaPA+Y4sXyAtvvrDDw+Z2gBm6av877R26gHePzZANMHxRQorq8VvIBv
         yfbm9yk1NVS0TqvIqys0Q0oqVvNbI6y+QMQ27cKS09X5o1ZhG2AbHeHKLyqcK+nwx9DP
         AFF4PbdlqGZRDMEMHU9vYcQyF5mRXmlp0prZ6PAhGjpHIEvbAZPJktc4ympFTKl7d6NH
         57YRNegqEORWNIqG7P1bYaZPUgLszEimDxe+14rdfyhqKLEG3M7W8JfWdE7BtDIpf3IQ
         Ox5w==
X-Gm-Message-State: AOAM533lofMl7b0odGVoUngjxnG9Znqv6YJsjAEZzaXBYaMXSZoMesm1
        NMzbuG/ZhdFgaYF+x0zyvJM=
X-Google-Smtp-Source: ABdhPJzNsK/jz7fYCLSHM2b8PguVbNca9cnYGw1tP0XGzKH3LgnHS/nuIVLNKACmZIl6FxUrcWlOZA==
X-Received: by 2002:a17:90a:528f:b0:1dc:9a7c:4a3 with SMTP id w15-20020a17090a528f00b001dc9a7c04a3mr2023445pjh.112.1651812255491;
        Thu, 05 May 2022 21:44:15 -0700 (PDT)
Received: from localhost.localdomain ([183.14.31.73])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0015e8d4eb273sm513770plo.189.2022.05.05.21.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 21:44:14 -0700 (PDT)
From:   Puyou Lu <puyou.lu@gmail.com>
To:     puyou.lu@gmail.com
Cc:     akpm@linux-foundation.org, andy@kernel.org, chris@chrisdown.name,
        keescook@chromium.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, pmladek@suse.com
Subject: [PATCH] lib/string_helpers: add allocated strarray to device's resource list.
Date:   Fri,  6 May 2022 12:44:09 +0800
Message-Id: <20220506044409.30066-1-puyou.lu@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506032333.28249-1-puyou.lu@gmail.com>
References: <20220506032333.28249-1-puyou.lu@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a must to automatically release strarray when the device
disappears.

Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
---
 lib/string_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f877e9551d5..5ed3beb066e6 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -757,6 +757,9 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	ptr->n = n;
+	devres_add(dev, ptr);
+
 	return ptr->array;
 }
 EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
-- 
2.17.1

