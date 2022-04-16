Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2072B503840
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 22:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiDPUyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiDPUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BF3732ED9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650142303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MCs9sayLGT9Brlcum9GwaQ0BqXD9O9q7oXRvk2xKu30=;
        b=Qc1Tj5ly84t4M6/6aziK2YgM2v82aPPxMskQ+GjUO6tLhUQdkQC2G5h+PaaUrdPIfdKOxW
        7npMF9OJ1TQ9tcJFyIn/xdo6yWKVY55SXIm5GUP0Aztz00UWuLmUbh2qK0oEAiKVCUAZkm
        5+4zwkh4LHwnzKDhH54i6W70LYrYThY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-uw_5I6H3Nbuca5ko7h5f-w-1; Sat, 16 Apr 2022 16:51:42 -0400
X-MC-Unique: uw_5I6H3Nbuca5ko7h5f-w-1
Received: by mail-qv1-f71.google.com with SMTP id f18-20020ad442d2000000b0044642dd1d7eso2059918qvr.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCs9sayLGT9Brlcum9GwaQ0BqXD9O9q7oXRvk2xKu30=;
        b=pUtuDEHvefbp6HZsSDdIOFrnIOSBn5F/8Mf5tiPnHkPGkQ/rTTtb6ipxeKwGH+xa5b
         JnRL3acHMR84hGlnT5wf5ge1SGluFFiqPY/vNYGr5bMJm6Ka/g92x0PDSW/IQK9eZQCV
         CsP3frwqjiE+WRLWB5zOYLwOFlRe5sPKBXmCRrhosod0mJDzRugZYLrRa8cOyZKkkG0p
         RkV+rO8p69cw+APeQQ9J4dTP7is0IOYkREoW9F+5lOLRsEAHuCygdbcWDu8rYTKn4Pb3
         zi0aqvCvShq9zcbxHiSgeZp+/OHnRNNYwatR5prlWjPEIPY6+pqEJPlnWGk3IpMDqfdj
         NsSA==
X-Gm-Message-State: AOAM531vDfE7crQFYEmlJzKj9ZvBJUswN3275RECXMiFPoU1rhIGmJvN
        cNC4bdt8NpbfJdT+NSIKbJ7LKIu7xQHPe7651HlgpF7P+0fDjoKpTD4wTOQ86pTYquMUBy44BgE
        jZSA8eOY7R4ec0fVRfK7rDuMn
X-Received: by 2002:a05:6214:1c4b:b0:446:3f7e:a35f with SMTP id if11-20020a0562141c4b00b004463f7ea35fmr3645560qvb.122.1650142301786;
        Sat, 16 Apr 2022 13:51:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTuW3w9sGv8eepPDQ4d/FajXjVBd+8BPaPmfU4U9Pg98GQ/3Wfo5Tqv35AdG630N6byhpPMQ==
X-Received: by 2002:a05:6214:1c4b:b0:446:3f7e:a35f with SMTP id if11-20020a0562141c4b00b004463f7ea35fmr3645551qvb.122.1650142301616;
        Sat, 16 Apr 2022 13:51:41 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bj12-20020a05620a190c00b0069c7df40747sm4079774qkb.133.2022.04.16.13.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 13:51:41 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     broonie@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        paul.kocialkowski@bootlin.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] spi: initialize status to success
Date:   Sat, 16 Apr 2022 16:51:32 -0400
Message-Id: <20220416205132.295779-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang static analysis reports this issue
spi.c:3583:2: warning: 2nd function call argument
  is an uninitialized value
  trace_spi_setup(spi, status);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is possible that status is never set because
its function level setting was removed by the
commit listed in the Fixes: tag.

Assume that setting 8 bits-per-word is ok and
initialize the status to 0.

Fixes: b3fe2e516741 ("spi: core: Only check bits_per_word validity when explicitly provided")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 563a56ce34a0..890ff46c784a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3475,7 +3475,7 @@ static int __spi_validate_bits_per_word(struct spi_controller *ctlr,
 int spi_setup(struct spi_device *spi)
 {
 	unsigned	bad_bits, ugly_bits;
-	int		status;
+	int		status = 0;
 
 	/*
 	 * Check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
-- 
2.27.0

