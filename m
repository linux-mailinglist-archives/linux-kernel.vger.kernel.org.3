Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8511C4B536E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355196AbiBNOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:36:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355191AbiBNOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C7E4B438
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644849373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kVJ+z4YH6B72BWSTmP8yMFYZrE6Av+D/1oK0/HiB/pQ=;
        b=MOe12nkRa9LX5dCA6z76M/+hwtRKeadbIpMUH08vcfuj/yV26/MyExofOpFyieUOe/YZ+b
        EIsOoQwyRzjhYi7/o+X4545RtGkppuq7eBYfs8gx1IRdUkL5jzNpikTqZSyGtHkoYEaRT0
        /fpgUHULZC4e01U2Zj3Lqymcc2c9h3E=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-QbW1uhR5M42Jv1yaJiKR_Q-1; Mon, 14 Feb 2022 09:36:11 -0500
X-MC-Unique: QbW1uhR5M42Jv1yaJiKR_Q-1
Received: by mail-oi1-f197.google.com with SMTP id w7-20020a0568080d4700b002cf36aea563so3606398oik.16
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVJ+z4YH6B72BWSTmP8yMFYZrE6Av+D/1oK0/HiB/pQ=;
        b=uwTxMCfhHjGpHEmXV4ea+a6htYrJRNRN4QYRbJdmDe4h3EDm37ypx3+wO3M2+J9FpD
         0mFHDV+oja4NUnTyKEpFBBlMn4JOgh5j4TCJWukGsVOFBaINv5DlluoAPWQg297wh5b6
         vrARETWoNYcxlUhaTFj25lKlVP77ZR9JnPL5ghAKu2xzMxT09u+RQttz14JaWKOsvDvt
         1THCbzEdCqU08n4V+iOfGhjXQ6+mH+hSiv0wrfGHUeuKOoCmJjPW+6j6J2q9J0v+5c+6
         iz48A6tSl1pq6GtpIXtrDF8Z5E6yJMaeGfdQmTKWLwRY2oshSJrFLh5RfpjyXuHM6d9j
         sSCg==
X-Gm-Message-State: AOAM531t0irODM1NLNhk4TjdlETduZTDRctL3Kxp3AX31cGwybWALXrC
        B65pI9oYGhmcVAwedlbxm4SQ0s/vpubsdCbjcmGm00sXPD+86sI6gNKk7NUO8uM2qkeCa9L5Gxl
        ANt20BcRFuY07VPzASTAAHUXY
X-Received: by 2002:a9d:7c8b:: with SMTP id q11mr4221otn.335.1644849370928;
        Mon, 14 Feb 2022 06:36:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwY7JD+FtDDlOALhfL6r9Iutn1sPA3RX+bkwBFoaFGI3BC7Xgd0v/k6O60Le1wQzkpYFVKkkQ==
X-Received: by 2002:a9d:7c8b:: with SMTP id q11mr4214otn.335.1644849370760;
        Mon, 14 Feb 2022 06:36:10 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 16sm12470825oat.8.2022.02.14.06.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:36:10 -0800 (PST)
From:   trix@redhat.com
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] regmap: irq: cleanup double word in comment
Date:   Mon, 14 Feb 2022 06:36:06 -0800
Message-Id: <20220214143606.2884581-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Replace the second 'which' with 'the'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: drop spelling fix

 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d5604f497296..9263f2715d66 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -1082,7 +1082,7 @@ EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip);
 /**
  * devm_regmap_del_irq_chip() - Resource managed regmap_del_irq_chip()
  *
- * @dev: Device for which which resource was allocated.
+ * @dev: Device for which the resource was allocated.
  * @irq: Primary IRQ for the device.
  * @data: &regmap_irq_chip_data allocated by regmap_add_irq_chip().
  *
-- 
2.26.3

