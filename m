Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F54DCCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiCQRwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiCQRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A91691F6356
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647539454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CWUmn/QvK/L7nVX8kGPV5onMGWPPEQZ85b495jUko/o=;
        b=VDDw96qB66Qd/IGq+j3AGfY7++eYnxf9FMkO2vxm+Oaz/A9HyWTM+AbiKFcUC9cNPoGCRN
        chb1FuRsASSY5UiTE78US0rrG7VMberxwqCC7e0sfPvpzMK5FX6hgUAKlCV3VdKEgxQGcq
        HuhlJX2dC8lT/5w60qBQntRDjLDtGs4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-F_hVxsx2NxSFGLZIwHQUzg-1; Thu, 17 Mar 2022 13:50:53 -0400
X-MC-Unique: F_hVxsx2NxSFGLZIwHQUzg-1
Received: by mail-oo1-f70.google.com with SMTP id p1-20020a4adfc1000000b0031cfa60836dso3668147ood.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWUmn/QvK/L7nVX8kGPV5onMGWPPEQZ85b495jUko/o=;
        b=2A9oyEjilplyFOyq7WqfkjDDCNR1Rn+kwkZfEKf5rtauCyUF6/T0b3CmRLIqI30erf
         9wvPpQxKFQ84LDa/xjSTk2YO183yk0ol3llMa9PPofqA90SdZjI3w/UEoI53Cq5ZkN/i
         2ASOJAOU23zbC1QLfwlXXRkB/SAB1cy5/OJ910Irvn3oDJh2C9zV+wlPw8p7lTP+dRze
         EyOS1BJl87+91nIwUD+V4jo4Adjra8eBGTBfiatYFBWZ0ynhHK0eOkTb9zjucd/UvVos
         wN35+0mzCMtwka4yZN8ufAB1h1mqf7twU0MPazVqmHDRZO9P5j89jN7XZ4xcZqZVkVXs
         MfnQ==
X-Gm-Message-State: AOAM533alfaNf/zNx9kWJsKJ7/zpmQyNrV8Gv82/kvqo5Ytnx0XzAbTo
        DTZaBGMtheP5SxKPKu5xUsOHXwn03IKDkaQiPLbVBDQRT8y+8lsXXINObXY8wUAthQEDmcdAMGv
        vYjAuxvFQMEalR1tSIuE3gUIg
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id j13-20020a056808118d00b002d4be7e6748mr2506867oil.123.1647539452735;
        Thu, 17 Mar 2022 10:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztjwuwCNgzs0OEH5TeCj4r7xDj/r/kSgu0Xko2rMEd3ZIk4tDT4v84Ij+AlVx37u4LbZxI4g==
X-Received: by 2002:a05:6808:118d:b0:2d4:be7e:6748 with SMTP id j13-20020a056808118d00b002d4be7e6748mr2506857oil.123.1647539452543;
        Thu, 17 Mar 2022 10:50:52 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e9-20020aca3709000000b002ed1930b253sm2770239oia.30.2022.03.17.10.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:50:52 -0700 (PDT)
From:   trix@redhat.com
To:     konishi.ryusuke@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] nilfs2: move initialization of nr_dirty to decl
Date:   Thu, 17 Mar 2022 10:50:43 -0700
Message-Id: <20220317175043.1972081-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

On clang build there is this error
inode.c:227:13: error: variable 'nr_dirty' is
  used uninitialized whenever 'if' condition is false
        } else if (ret) {
                   ^~~

In nilfs_dirty_folio(), if the call to
filemap_dirty_folio() fails and there
are no buffers, nr_dirty will be uninitialized.
Move the initialization out of the buffer
block and to the decl.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nilfs2/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index c1219c0678a57..01e58b65c9384 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -204,7 +204,7 @@ static bool nilfs_dirty_folio(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct buffer_head *head;
-	unsigned int nr_dirty;
+	unsigned int nr_dirty = 0;
 	bool ret = filemap_dirty_folio(mapping, folio);
 
 	/*
@@ -214,8 +214,6 @@ static bool nilfs_dirty_folio(struct address_space *mapping,
 	head = folio_buffers(folio);
 	if (head) {
 		struct buffer_head *bh = head;
-
-		nr_dirty = 0;
 		do {
 			/* Do not mark hole blocks dirty */
 			if (buffer_dirty(bh) || !buffer_mapped(bh))
-- 
2.26.3

