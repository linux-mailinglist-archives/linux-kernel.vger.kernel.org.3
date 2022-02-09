Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57874AF6B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiBIQag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiBIQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5423AC0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644424237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1bQbhgSAF2lPgwQubVMn3pqKT77IeuZyyfYEoagC560=;
        b=iFYedRAzoilrSJsFl7p+/4Hv9u+1VZWNdGh+g7ONc1pl3cL2CrBMv3u4J1hfNHYDSPytvo
        CTgG4Ed5rba9yqZGlVLyb6bQEfMkjQ0FnaYIqyCxot2srMMqtsryaeHbqPjE5HubrvreQS
        5ED77XOCOaDZmWjkD7v5MBAKKZ27XrA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-4N8etcSkMhaMEU0fMxACyQ-1; Wed, 09 Feb 2022 11:30:36 -0500
X-MC-Unique: 4N8etcSkMhaMEU0fMxACyQ-1
Received: by mail-qk1-f198.google.com with SMTP id bl5-20020a05620a1a8500b005088d061be4so1740391qkb.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bQbhgSAF2lPgwQubVMn3pqKT77IeuZyyfYEoagC560=;
        b=pGYgDxJn7PL5UniHyoWjDPp1qeZk+v+hOsICuYVfRm6yQvyLkt/6g1bWwyjN3CWPb6
         zqo1U/g4wYXVi6ZJGOjDlTSewYYXzlx4jGJ1SRhIInRzmTaK+kR9DjiOS1n6NGCx3oxM
         pOMflhawRAOfcWomcedmsQYiFWKHdOkjlp2DD2b3A7vE1mR693yS3gApuRBNf4M8v58T
         I/8/rD82fKR0t8MtyUSOubnu39YYxnji35qkTbOz315WI8y99w0mR72sMHkwqWbtkuXw
         ZRLo/KnakgdzcLZsSBKwQzuAe609+aoL+q53oeNGAqvXWfnlOaGgGKrMgk8niS1fRvOV
         tb4w==
X-Gm-Message-State: AOAM531eE/LH+UxcR7XobZGjNNlSIslpITBNAl9eJbgEuTfjeh4X2QVn
        WNAIXNbzPlSjcxtUu54asSATDBd8JQdTrbIXsXnFpWwHgU8VwJmE0htRmPVN259HGZvtKQ2NCwy
        VCq6ASsEsISLjOtFJ7Cwa3Qpu
X-Received: by 2002:a37:4648:: with SMTP id t69mr1512061qka.702.1644424235750;
        Wed, 09 Feb 2022 08:30:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnwrxGYEFisJG8vsAxtzWQegq11Myco9LBMvHqdQZ4x/6E6Yb1DWf2feI7/8QDUXQ7/ItaQg==
X-Received: by 2002:a37:4648:: with SMTP id t69mr1512046qka.702.1644424235520;
        Wed, 09 Feb 2022 08:30:35 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m4sm8323725qka.111.2022.02.09.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:30:34 -0800 (PST)
From:   trix@redhat.com
To:     lhjeff911@gmail.com, broonie@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] spi: initialize ret variable
Date:   Wed,  9 Feb 2022 08:30:29 -0800
Message-Id: <20220209163029.2299009-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang build fails with
spi-sunplus-sp7021.c:405:2: error: variable 'ret' is used
  uninitialized whenever switch default is taken
        default:
        ^~~~~~~

Restore initializing ret.

Fixes: 47e8fe57a66f ("spi: Modify irq request position and modify parameters")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index ba5ed9f7277a3..fc61578ce5c47 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -375,7 +375,7 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 {
 	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(ctlr);
 	struct device *dev = pspim->dev;
-	int mode, ret;
+	int mode, ret = 0;
 
 	mode = SP7021_SPI_IDLE;
 	if (xfer->tx_buf && xfer->rx_buf) {
-- 
2.26.3

