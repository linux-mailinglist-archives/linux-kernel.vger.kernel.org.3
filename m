Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5694953402A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiEYPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbiEYPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4D3DB0A7A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653491721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gcTixSZTkvL/w/7L1HwLNEqSifq3qq6EouMS7B6x8F4=;
        b=F/dfPQP5oqOdhKXnv5KmE8m4/REJe3wFZGl3hcvAarXwZjR9dF0YhCVHJoZ3FTioM+wkI0
        pJNow9+fqNGKOCYC+Ln3nXHHqQtXPRRbGcj5/6djF2xbxnQ0ffaJshm/38AsA8SFWTemBQ
        wKd9RPmadpedNxXt8jbmGFinypEeFoo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-4_fxuDUvMWSoI3dK1IN28Q-1; Wed, 25 May 2022 11:15:19 -0400
X-MC-Unique: 4_fxuDUvMWSoI3dK1IN28Q-1
Received: by mail-ed1-f69.google.com with SMTP id j7-20020a056402238700b0042b9c2e9c64so2719893eda.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcTixSZTkvL/w/7L1HwLNEqSifq3qq6EouMS7B6x8F4=;
        b=PFYs/hhC+9bwAEtUspV+hx1HfbrEiSpoOIVXYWA8Jy0ba5pur2+PmDjT8Lb4kechXH
         bps8b68Q9NG2P2m2fuJIV8y86jPDtDQzdYvynpWqF3kyuuWhG7IVe7hmqZb8e4aWyS9A
         /3q1JljHVPC4++LuhSWmhLmJ0jHPQUKT+vRP43E2pXm57XNWh7kh/a2O31nfxxO7nE/i
         CrnXB1j1BCcufZ5dvT/l4YhEbZ2DJkbqV+5i2o09dupGRFKJThJovH6TWfnLwGxtOJzN
         V9wzlqU/7NSNfVH3orS28ad+g3oXq2nssKz75gxQaEavkIkEF3qpeJfUmYrBJ5PjAZ/9
         Lpsg==
X-Gm-Message-State: AOAM5327Qo+ay9tNYsbcnrzrNY5E8wAbys6suErn9KfVT5599FZnF8oP
        qYFMCt6IAy8ge7hVEJMNDP+zWcxQLoaPlfPaXFR60F8a89y7CvbFsLUpWHLAiE110zl22xNWhmO
        kABwTt8rgNs+wXYKcodmCC/8=
X-Received: by 2002:a17:906:2416:b0:6fe:a0be:91d5 with SMTP id z22-20020a170906241600b006fea0be91d5mr26367688eja.132.1653491718360;
        Wed, 25 May 2022 08:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTgN7zmlntoiNwoEyCgikQcdFrAhVHRko25ErlIb+NvzlhfgJXKvym4ZuzCjZcuR88JwVR7Q==
X-Received: by 2002:a17:906:2416:b0:6fe:a0be:91d5 with SMTP id z22-20020a170906241600b006fea0be91d5mr26367677eja.132.1653491718216;
        Wed, 25 May 2022 08:15:18 -0700 (PDT)
Received: from auir.redhat.com (net-188-216-46-176.cust.vodafonedsl.it. [188.216.46.176])
        by smtp.gmail.com with ESMTPSA id n17-20020aa7c791000000b0042ab02e3485sm10762135eds.44.2022.05.25.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:15:17 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: altera-pr-ip: fix unsigned comparison with less than zero
Date:   Wed, 25 May 2022 17:14:52 +0200
Message-Id: <20220525151453.55725-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the "comparison with less than zero" warning reported by
cppcheck for the unsigned (size_t) parameter count of the
alt_pr_fpga_write() function.

Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
Changes v1 -> v2:
- Coding style fix
---
 drivers/fpga/altera-pr-ip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index be0667968d33..df8671af4a92 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
 	u32 *buffer_32 = (u32 *)buf;
 	size_t i = 0;
 
-	if (count <= 0)
+	if (!count)
 		return -EINVAL;
 
 	/* Write out the complete 32-bit chunks */
-- 
2.35.3

