Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCAF59F534
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiHXI07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiHXI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:26:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8493524
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:26:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso820548pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pVHDk8dc6T3BiOa+xYG3swZFhJjca5Kjxb1hfTc+TEc=;
        b=Q3GPPLyiwudZ2b2XZVmbavLluOlWBfjAouSoJ4Cte3KY5okWZrlxhWnPCAl1u/tSlQ
         L+DggB6EdMBpYOIE+bK6F1ojgDZ1KUeVLaxoRAdTgvwa+3XImVVQOffZ+QIEVG3tF0Ih
         TyI3ivOxrfVvfTM2PZcm7GHkKagDsUoa8irSToBbHNDnWrGyKv+tYJEdDAxFWHY731gR
         g9OGKQR5cGZSdnVK/yPpTY/nZ8j7OK6GdBV05RJwHunDpmMZIAp9inzskJSpR+4iJ4t/
         4I2xcGWFPqSlvENVXLXh44CJllvjvxdSl+okfAmiJTl/Wt8dusV2EAeDr71/EuLgUc6b
         o98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pVHDk8dc6T3BiOa+xYG3swZFhJjca5Kjxb1hfTc+TEc=;
        b=iD0XKLEkJvFbVxasrI82hQUA9+5D7abfoVKpywZhncycOs26VIh2yqoH/NbHT1XEgZ
         Od1ihT+ZCqwa17GLO9PCVKKCpTCz+g1zm4uPh1VUJgryz3sDiqfpdKqvARWyeKV63BPZ
         XWYlWbNp0d65o5q+24Kzw+9n3UjmuhUhl36QF/5oWUN5ZE8xDBj2mRb3Rjaew9ZlEq6j
         +U7wQHAiK75JKK5WHfWlBg0pgYh+qr9+K/naZdgtWosLRB4Op8g1/mOPRnBXWlm9NRJi
         /WDMUemWBFav6uQwNAHBvNsy1Y148BmRddazwOZAogPQzfia1IojiuF7RSYCVn3jhrjH
         ZTNg==
X-Gm-Message-State: ACgBeo1Yw36vpAh5ke/fdUSz5ChBcVT/M4hNejir/8zyQ49kSsG21Tc0
        xfV1LPilWTAZD1abNZovP6UzxW3vCz+j6Q==
X-Google-Smtp-Source: AA6agR4YO6ClsUu0eyqsC+HCg7B+A/ucv/i2Jl2W/FK+PGq6TxbzzhpbSEG/XuJQx8wy7PkB4kBSmQ==
X-Received: by 2002:a17:902:ecd2:b0:16e:d87f:d19e with SMTP id a18-20020a170902ecd200b0016ed87fd19emr27986829plh.75.1661329612214;
        Wed, 24 Aug 2022 01:26:52 -0700 (PDT)
Received: from localhost.localdomain ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b00536562f4c03sm8515027pff.146.2022.08.24.01.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:26:51 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, alastair@d-silva.org,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] misc: ocxl: fix possible refcount leak in afu_ioctl()
Date:   Wed, 24 Aug 2022 16:26:00 +0800
Message-Id: <20220824082600.36159-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

eventfd_ctx_put need to be called to put the refcount that gotten by
eventfd_ctx_fdget when ocxl_irq_set_handler fails.

Fixes: 060146614643 ("ocxl: move event_fd handling to frontend")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/misc/ocxl/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 6777c419a8da..d46dba2df5a1 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -257,6 +257,8 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 		if (IS_ERR(ev_ctx))
 			return PTR_ERR(ev_ctx);
 		rc = ocxl_irq_set_handler(ctx, irq_id, irq_handler, irq_free, ev_ctx);
+		if (rc)
+			eventfd_ctx_put(ev_ctx);
 		break;
 
 	case OCXL_IOCTL_GET_METADATA:
-- 
2.25.1

