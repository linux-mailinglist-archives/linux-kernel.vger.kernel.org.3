Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAD59E771
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbiHWQhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbiHWQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52BFB5E46
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661265993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u6WCJy76wyGRQ/+mlD3iaHvNl3EBMPU7sOD/gN0Mivg=;
        b=CNj0dw/lFaqDH06AHqq+ZjJDgZG2r/QuQYF0swIMDMCMzfJU7U2UCpALbBgI2MpoXhphJX
        cVOLLqgpZTsIj1RfIl6D2VT051irZP02+GMB/piLHbCRZz14IaRGn1VFugDzPZU3mdNrcE
        yOrn3SUC6ZxJvwppdWPNTdYdqZs0KYk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-1Vcdei84NZeZqvq4WW8sOw-1; Tue, 23 Aug 2022 10:46:32 -0400
X-MC-Unique: 1Vcdei84NZeZqvq4WW8sOw-1
Received: by mail-pl1-f200.google.com with SMTP id h12-20020a170902f54c00b0016f8858ce9bso9133146plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=u6WCJy76wyGRQ/+mlD3iaHvNl3EBMPU7sOD/gN0Mivg=;
        b=rkq1zKm5usTBxt8zVTJogubBPITDLdiSY9uRng6QX/H7K1NMcAHr/j2+NEfHj+CvDo
         kp/JIdfG+cdn3XS7frqDI5advKo5qUrtjvXF8Mwoq/LqhM5YRgORYBzmvLnwTRH1aAU/
         bxQfTGF4wk/J0JMwKQr697cBHj+O9QVzhWmyjl+lwtnZf3DkR8f9h0yykUI+ERsysJ82
         8Hutz1KQ41eKmhxEVMvl0uGQsrCv1KPykuVWLty4v6cogHCmSkCNtho97nzLBQPZdomO
         URCHARTla5USoKw3Fj4QKWMfBzvdNV7sfUkVtiqEcMQVOug5kRukBrPdSob26YDOJi1U
         BvPQ==
X-Gm-Message-State: ACgBeo3uxWbGz28epzaYy2N+lQRjB/7jqlNdOD7VK3bPgl6l8hVjhJ7/
        /PvGoQusb54ctqZYdavJvD9yvhfmrwsd7aWiW/GukVUuhBbeg86F++60chrUIpPeaf7FBDenUCV
        LQ0E3xsHCJwhz8Yi7LaT06dmQ
X-Received: by 2002:a17:90a:bc47:b0:1fa:e634:739c with SMTP id t7-20020a17090abc4700b001fae634739cmr3595504pjv.120.1661265991316;
        Tue, 23 Aug 2022 07:46:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7EcORGG0DtriXJLrLj+1Vy8+kFi8dMSE0nWfTxuMefbW3Yi+Gt9GSVqnoMs/8V8/1cNZVjPA==
X-Received: by 2002:a17:90a:bc47:b0:1fa:e634:739c with SMTP id t7-20020a17090abc4700b001fae634739cmr3595488pjv.120.1661265991087;
        Tue, 23 Aug 2022 07:46:31 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b00535e49245d6sm10519824pfl.12.2022.08.23.07.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:46:30 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        "Author : Randy Dunlap" <rdunlap@infradead.org>,
        syzbot+35b87c668935bb55e666@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: Avoid UBSAN error on true_sectors_per_clst()
Date:   Tue, 23 Aug 2022 23:46:25 +0900
Message-Id: <20220823144625.1627736-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported UBSAN error as below:

[   76.901829][ T6677] ================================================================================
[   76.903908][ T6677] UBSAN: shift-out-of-bounds in fs/ntfs3/super.c:675:13
[   76.905363][ T6677] shift exponent -247 is negative

This patch avoid this error.

Link: https://syzkaller.appspot.com/bug?id=b0299c09a14aababf0f1c862dd4ebc8ab9eb0179
Fixes: a3b774342fa7 (fs/ntfs3: validate BOOT sectors_per_clusters)
Cc: Author: Randy Dunlap <rdunlap@infradead.org>
Reported-by: syzbot+35b87c668935bb55e666@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 47012c9bf505..adc4f73722b7 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -672,7 +672,7 @@ static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
 	if (boot->sectors_per_clusters <= 0x80)
 		return boot->sectors_per_clusters;
 	if (boot->sectors_per_clusters >= 0xf4) /* limit shift to 2MB max */
-		return 1U << (0 - boot->sectors_per_clusters);
+		return 1U << -(s8)boot->sectors_per_clusters;
 	return -EINVAL;
 }
 
-- 
2.37.2

