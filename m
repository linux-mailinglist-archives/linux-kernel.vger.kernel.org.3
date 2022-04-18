Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27971505A45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbiDROuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345402AbiDROtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E33F27CD9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650288987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HJVF54/3gAvDeSSKK9/o5NZIye3nCH1ybK4Z5ZzOhi4=;
        b=KWhG7eJ7wu3pcO6cSZ/52NP1R8MrlCRokJuaK6D5hs/aZEu3cDt55uJYLHPhvkMgOb3BRp
        meR9RXhE31fklkCecELVrGbkVbhvNZdJHT9kWIEqg1K0IKd2DuP5EIFCNsEKs2dEodG2AT
        d5+/3FSBVZzYMTlxlDBMn+I9rOip5Jg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-QcObC71wOtWypnImNryg7w-1; Mon, 18 Apr 2022 09:36:26 -0400
X-MC-Unique: QcObC71wOtWypnImNryg7w-1
Received: by mail-qt1-f200.google.com with SMTP id br9-20020a05622a1e0900b002f1b4966c53so8533028qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJVF54/3gAvDeSSKK9/o5NZIye3nCH1ybK4Z5ZzOhi4=;
        b=JjYZ1XUdesv9MJIqetzixpqGSjTTlolF55N+D4/6pyW4lUJKPZB83iy4NnpEp3J9VC
         g2RciR+LuvFvpsADqT1nYi7OTwFvFjK87wsPC+r1q40oAbzwf++DjWCl/6jV8+kgMGev
         sC9TUwZo3KjqNNfjj9dfS3XAmQs9+JBoMh0uyYY6e6tSEpDqGrWUfAqG4QfK10upxU+f
         g0bKAjIrKGAzYB+f6NxvMDWzI7KHfbn7KcwjGEfwnHrV/ztZan0guj60d2BNTExY9x86
         pHHwymv9GAbEpraa6E4c9NYvXGq2yOnDtFWVa8jtuOwFCXMi/6fbYtWQa4f2YR/ocRq+
         dsxA==
X-Gm-Message-State: AOAM532DGGAZ0aRzck/s7YGc5l+GHwA2k/zj+Jhzc1K4K7fRmlrBTLZt
        fudzPg3adW/1Fr4JbB6z2bTTSOqHTbaFWKhRz05duH5wjcgS+mfyGb06h3NBGOL0nQbtOI1sDIk
        veWO3EnqtIykT95dK4ElIKcxU
X-Received: by 2002:ac8:5d8e:0:b0:2f1:fbc6:ae89 with SMTP id d14-20020ac85d8e000000b002f1fbc6ae89mr3886141qtx.647.1650288985601;
        Mon, 18 Apr 2022 06:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjY9HHU1Y5nCsGyqMaQmlAvvvIyplvs6JQhMWT7GuPBWxawLkRWfdB8kSBfOyuPiFM6FLzWA==
X-Received: by 2002:ac8:5d8e:0:b0:2f1:fbc6:ae89 with SMTP id d14-20020ac85d8e000000b002f1fbc6ae89mr3886118qtx.647.1650288985408;
        Mon, 18 Apr 2022 06:36:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c22-20020a05620a201600b0069e8e5f1c84sm2147674qka.35.2022.04.18.06.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:36:24 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, krzk@kernel.org,
        jakobkoschel@gmail.com, gustavoars@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: gadget: s3c-hsudc: clean up comments
Date:   Mon, 18 Apr 2022 09:36:19 -0400
Message-Id: <20220418133619.2852678-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling replacements
occured to occurred
currenty to currently

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/s3c-hsudc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index bf803e013458..4b7eb7701470 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -126,7 +126,7 @@ struct s3c_hsudc_req {
 /**
  * struct s3c_hsudc - Driver's abstraction of the device controller.
  * @gadget: Instance of usb_gadget which is referenced by gadget driver.
- * @driver: Reference to currenty active gadget driver.
+ * @driver: Reference to currently active gadget driver.
  * @dev: The device reference used by probe function.
  * @lock: Lock to synchronize the usage of Endpoints (EP's are indexed).
  * @regs: Remapped base address of controller's register space.
@@ -633,7 +633,7 @@ static void s3c_hsudc_process_setup(struct s3c_hsudc *hsudc)
 }
 
 /** s3c_hsudc_handle_ep0_intr - Handle endpoint 0 interrupt.
- * @hsudc: Device controller on which endpoint 0 interrupt has occured.
+ * @hsudc: Device controller on which endpoint 0 interrupt has occurred.
  *
  * Handle endpoint 0 interrupt when it occurs. EP0 interrupt could occur
  * when a stall handshake is sent to host or data is sent/received on
-- 
2.27.0

