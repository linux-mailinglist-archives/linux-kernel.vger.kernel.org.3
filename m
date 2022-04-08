Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB504F9F9F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiDHWdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiDHWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:33:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269971B7B0;
        Fri,  8 Apr 2022 15:31:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l26so19974713ejx.1;
        Fri, 08 Apr 2022 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MIEuyIQOzr7GBajh+n+UsyE5Wi+bFa0QsRrOoLXPvQs=;
        b=oHP7fYwJCiexaqI8I+it/ifNdESNBhEUa2a5EkkGsFvbgoDOGdrPlE92AvQHwRpIDd
         /2zBlS69RK/2kPbk2Z1sP2bWuSWKvAozNmBOfX2WC0UxKS12GpP+PTgWuSNmznBMVCgh
         BTcggNlDq4v3L46zaP5NHvj7lpIIc7+FtoLFHX0+hfpcXogu6CwiWqwje49BvnLpMw49
         mrFS7+KNGpdlw6+9eibEvPSalKElKm5HsN1HkC8TVP1/E0kk7d0sc7fjwN0gWKvIiCIz
         cE7ktDUlnYWlsC9Bq54WCoZ/tskD+JFwd0njFZzQvQYrwD+R6pTKWEXHZX9SoloMJQMU
         i7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MIEuyIQOzr7GBajh+n+UsyE5Wi+bFa0QsRrOoLXPvQs=;
        b=LDJzUa/OHTSmlXrZZwvXs5qMjD9ypeRSuxgRMmm8bo7nDRZKxPuBtCXnUy6Ksa6I4E
         UJr4UGox6hgk5gEYSeT0JZxAMdxDDCQw5WqRhdV6yhRSXAFIfzOmDjGgPG0qvbeIwvzC
         Ef/Mm+MuD/l9uIhF4Y+Gni8+u3r75DcC4s+WJ8DCBNSQV80QyyUz289k+b9iYFNss78V
         JbYVoCfOpmKKq7DA0C8l8JP1CGNMdn+17GGY11aNJ0p46jyqkA0+UKfVSzMIfZ1mSQAV
         jCMfa2hpt6WuFxSCLbTtOy9BsqsfFA+51+pFfgR++41F8e9PT8r3j6pQ0RkPriJeIwBX
         f9ug==
X-Gm-Message-State: AOAM530IJclH4wpjuzPdfmR/OOvkNYJefKQCYolM5pu+KhEcp0DfPVDN
        5XQrGXkJ1MBTNcaa8ENyqqM=
X-Google-Smtp-Source: ABdhPJwZHXUsf05CmofYgOWQixJUrHdRv1lrpE/Q183lJUyfC1JgwjV4k3etYG6TKy/yNZO0btD4Sw==
X-Received: by 2002:a17:907:7f8d:b0:6da:b3d6:a427 with SMTP id qk13-20020a1709077f8d00b006dab3d6a427mr19782384ejc.509.1649457094569;
        Fri, 08 Apr 2022 15:31:34 -0700 (PDT)
Received: from localhost.localdomain (host-87-4-4-217.retail.telecomitalia.it. [87.4.4.217])
        by smtp.gmail.com with ESMTPSA id m14-20020a056402510e00b0041d0c0942adsm2277425edd.52.2022.04.08.15.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 15:31:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: media: atomisp: Convert kmap() to kmap_local_page()
Date:   Sat,  9 Apr 2022 00:31:29 +0200
Message-Id: <20220408223129.3844-1-fmdefrancesco@gmail.com>
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

The use of kmap() is being deprecated in favor of kmap_local_page() where
it is feasible. With kmap_local_page(), the mapping is per thread, CPU
local and not globally visible.

load_and_flush_by_kmap() is a function where the use of kmap_local_page()
in place of kmap() is correctly suited.

Convert load_and_flush_by_kmap() from kmap() to kmap_local_page().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index c1cda16f2dc0..6394385b6637 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -350,7 +350,7 @@ static int load_and_flush_by_kmap(ia_css_ptr virt, void *data,
 		idx = (virt - bo->start) >> PAGE_SHIFT;
 		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
 
-		src = (char *)kmap(bo->page_obj[idx].page) + offset;
+		src = (char *)kmap_local_page(bo->page_obj[idx].page) + offset;
 
 		if ((bytes + offset) >= PAGE_SIZE) {
 			len = PAGE_SIZE - offset;
@@ -369,7 +369,7 @@ static int load_and_flush_by_kmap(ia_css_ptr virt, void *data,
 
 		clflush_cache_range(src, len);
 
-		kunmap(bo->page_obj[idx].page);
+		kunmap_local(src);
 	}
 
 	return 0;
-- 
2.34.1

