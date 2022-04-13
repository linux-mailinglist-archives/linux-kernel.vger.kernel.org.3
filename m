Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57065500124
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiDMVYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiDMVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:24:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B4B66C97;
        Wed, 13 Apr 2022 14:22:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k23so6509134ejd.3;
        Wed, 13 Apr 2022 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbnAeJu+mSJrOhK0YF2KczoT41D0h8PfC3LbVNUGzpE=;
        b=aa+5LyswOpxqjG7WzCPpOCdbgp/WuK2qXlP817DNGTK6jUIufD5TzDs9RA2MsJln1+
         0Z1lvg7BMweewUwAduqBkG49jSLyPlzD9kj6T816ZVKoAnlVMrxCNvd1oSKsRfYUHfeC
         AQsxsu7H8tANDPU42PgNsaHyv0dQGPMzFr2rFPJNsIpQokqz7+ZAAES2h93mssw7W6ZE
         TPP6rEOtrkHPw2Rd/mPb6YYuQcnObWMqeIiACyaUxjwN6YacZTnf18qAheRAd40FK+7V
         z57zj7n4iKeNu1CYELHZbw3k3tknVlfG8nZPMdsu7QPoa8r3NJEYjs2enKa4Y5gEhUld
         WTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbnAeJu+mSJrOhK0YF2KczoT41D0h8PfC3LbVNUGzpE=;
        b=Z8aqcu3AN0d8YUTmutzq+4cuRIa171af1EFZUk3ct6EKW678CcsW5l4+2KHcQHpwOd
         /K5ASkKrIIp9Z1Z6Dz4BHRxdymmxqMVfeUi+hkTDlfzAZE2XfP5En7JXTPOwQaiSC/jA
         s051T439PUfNLADi/OoRKVg+0jWHrhD/TjdAgPHTBoIL6MSdvvq/kDdq/O9LXcxNGshd
         2b3eQMC/7z06/DtNYAQF/Z7NVedwe4+nO0wITT3LN4tNO3a47Hvd5R3Q/IqdAXI7K48g
         8igmX2E/gK/ThWTrRto2MBSLV44n5XMouT66sfvJ6CyKS4Zuu2UXbgQW3svHwPn21+Uj
         qH8g==
X-Gm-Message-State: AOAM533JgvLFtbWNQRdJVGvZLHs9rZsWXnmOvR4gfkh1irqnFMZa3bMG
        +QwMCbTdwCxky8zrjB++AUQ=
X-Google-Smtp-Source: ABdhPJxvooD4u6SAjw+4A4hPyn40ux/U5r40VIzqQDjzdLtvQHLsWPGxk146dW4t8vuSsZKQFmNgbQ==
X-Received: by 2002:a17:907:3f0f:b0:6e8:3b05:cc6 with SMTP id hq15-20020a1709073f0f00b006e83b050cc6mr30886644ejc.91.1649884935461;
        Wed, 13 Apr 2022 14:22:15 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id k22-20020a508ad6000000b00420bd71e06bsm30883edk.79.2022.04.13.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:22:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_set()
Date:   Wed, 13 Apr 2022 23:22:10 +0200
Message-Id: <20220413212210.18494-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible. In file pci/hmm/hmm.c, function hmm_set() calls
kmap() / kunmap() where kmap_local_page() can instead do the mapping.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Therefore, hmm_set()() is a function where the use
of kmap_local_page() in place of kmap() is correctly suited.

Convert the calls of kmap() / kunmap() to kmap_local_page() /
kunmap_local().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index 6394385b6637..46ac082cd3f1 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -563,7 +563,7 @@ int hmm_set(ia_css_ptr virt, int c, unsigned int bytes)
 		idx = (virt - bo->start) >> PAGE_SHIFT;
 		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
 
-		des = (char *)kmap(bo->page_obj[idx].page) + offset;
+		des = (char *)kmap_local_page(bo->page_obj[idx].page) + offset;
 
 		if ((bytes + offset) >= PAGE_SIZE) {
 			len = PAGE_SIZE - offset;
@@ -579,7 +579,7 @@ int hmm_set(ia_css_ptr virt, int c, unsigned int bytes)
 
 		clflush_cache_range(des, len);
 
-		kunmap(bo->page_obj[idx].page);
+		kunmap_local(des);
 	}
 
 	return 0;
-- 
2.34.1

