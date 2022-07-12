Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA01E572737
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiGLU1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiGLU13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B2ACC791
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657657646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uitgsVWXbdrv8zFt2LqySt7cam5rPIej+nIiQV98pw0=;
        b=XabVJdRnQwkFm8D8LZo+7+56Maa79miZND9G7cM8uNaZwmvGjhi+n/kJmUWjWk7WIEdUaI
        9t648vYUC015WlEkGz+ny8UefHleZ7d0kFRn7HCF5xAT1uZkUjY0og4eKwDA7aXrnTbrLU
        hOA5elVTZUEO3g3NzcUp5XkolASCC0Q=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-U-3W5yqDMzWuUMLA96WY0A-1; Tue, 12 Jul 2022 16:26:20 -0400
X-MC-Unique: U-3W5yqDMzWuUMLA96WY0A-1
Received: by mail-ot1-f69.google.com with SMTP id r5-20020a056830134500b0061c641b26d7so713284otq.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uitgsVWXbdrv8zFt2LqySt7cam5rPIej+nIiQV98pw0=;
        b=M5DClWiXAhyj6xz7sow7uEA0qA7RLUmVuma39ccGK45O6l3zvenMtGw51wmbbI9By1
         FQ8sKZ4LwHBiKlsDwkkHSDeA/I7cY973VvnxK4nx0e5YQInwhZM4fOVFTeoA58jrylzS
         uK6HoJCtBCPz3zsG1DVYA2Md/C/BUcRHY8J69pln3hab92ZoJuYxonTB9fYFKfIZry2M
         KIwOMv3s6bA8IEwSNrm2YLIkdari9fnvVyyrmVYd9diMueo/wFpZdhhIgSbRXNfc0PNW
         26jShmenc1fMM+SuSZjeyTguHZLzKiliNuP7FKhW5wcqpoVRIdS8MQF8zOG6T/14gtoV
         VzWw==
X-Gm-Message-State: AJIora+FHIV+UaKzEYC9FuARIa38cM5Aj5nCFNYiZ01bxw0E+nHM7KPJ
        aiFqFXZGPAQspUd4jaRmUBT5WJrbGkBOkSgVzsTcHs4MTc0PwLWKoWoKTNhtAZwbe5rIyzOvvoi
        9TOoc6Q4BtcTtDj/MPMimmEWV
X-Received: by 2002:a05:6830:608d:b0:616:ecd7:de2 with SMTP id by13-20020a056830608d00b00616ecd70de2mr9966413otb.119.1657657578770;
        Tue, 12 Jul 2022 13:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9ZClxcrqJht1T6mxLG+napIslBEJNktJNzhxGbv3GvFDTtH6eVOCwyrB0kLgCN4MgD4pEBw==
X-Received: by 2002:a05:6830:608d:b0:616:ecd7:de2 with SMTP id by13-20020a056830608d00b00616ecd70de2mr9966403otb.119.1657657578577;
        Tue, 12 Jul 2022 13:26:18 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k26-20020a056830151a00b006168bc4caacsm3992119otp.67.2022.07.12.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:26:18 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     axboe@kernel.dk, nathan@kernel.org, ndesaulniers@google.com,
        viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] block: move initialization of i to its definition
Date:   Tue, 12 Jul 2022 16:26:08 -0400
Message-Id: <20220712202608.630259-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build fails with
block/bio.c:1232:6: error: variable 'i' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (unlikely(!size)) {

In this check, the code jumps to 'end:' over the loop that initializes 'i'.
Move the initialization of i to its definition.

Fixes: 9a6469060316 ("block: convert to advancing variants of iov_iter_get_pages{,_alloc}()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/bio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a98b90489ae0..aff36ca7cabb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1199,7 +1199,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	ssize_t size, left;
-	unsigned len, i;
+	unsigned len, i = 0;
 	size_t offset, trim;
 	int ret = 0;
 
@@ -1234,7 +1234,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		goto out;
 	}
 
-	for (left = size, i = 0; left > 0; left -= len, i++) {
+	for (left = size; left > 0; left -= len, i++) {
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
-- 
2.27.0

