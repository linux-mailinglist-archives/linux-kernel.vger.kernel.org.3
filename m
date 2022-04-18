Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBADB505A90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiDRPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiDRPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB59378070
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650289727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tbhR6AfcnCx9wqk3Kzu5GujenphZ3L6As870SyTIgjc=;
        b=axnsdQYRgObLT70YUso47lEJaj1fk09HK1a/PIe9iBIsCUFTPI4+2xMmgWB7gtuT84uiBv
        E+yN85awKyYShrSF9Voq5XeT9S1qz2QN+Ph6F4KjGTZP6LVJ6GN4U+NMn6cG8kUDmbjzLE
        N4fZM9iIqq9JkrnAmd1AxkSuhkFKPSA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-JH2YUNucNXqmSF-E84OT6Q-1; Mon, 18 Apr 2022 09:48:46 -0400
X-MC-Unique: JH2YUNucNXqmSF-E84OT6Q-1
Received: by mail-qt1-f197.google.com with SMTP id w18-20020ac857d2000000b002f1fa23a40eso1802301qta.14
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbhR6AfcnCx9wqk3Kzu5GujenphZ3L6As870SyTIgjc=;
        b=zccmzdC1STKEF0gZcNs+ikftWMi36Icye+suuyO2vJCPOGe/2oeFBSDKLK8KdYC739
         VOREq6QW/Um3Mazq7VXg7xas6F6P/B+OlASAS7zi43Dk9c8FemhA/pHdFsBFw9cAsS+E
         BA+B+f3R2J/uUuRJXxtpT2pCLCfJN+I+zCjpMsQrsWQpoQmigOlgkEfzULsE9E0YpZXY
         6czeG1P4gbQzHjoyRUI+ooHEjzprzMmsnzOpUU0jGhC5o0I2Sg1kPVwRURpODtuCFTcu
         +6U5b0+wLvUWSB4NpJHOvEIPE7h1IexxioCtKiU5pb00rMUU41SMB0tFwnPZds4XHsgH
         8Tvg==
X-Gm-Message-State: AOAM530PqFT/KQyoi3L/x1uSYNETlYSAgBDlT8RlqsM9V9bos/YG0nQ6
        Y7NRPa9Vkb/fhQGvsQlRwLADIKV6sIZllawUjYjPK8VFOW9NexXjZDdEfOoMvlj7CAMrO1W/6Ax
        dnVubaA/V0lr34oF4Z/N8PJcB
X-Received: by 2002:a05:6214:caa:b0:441:2e8f:f398 with SMTP id s10-20020a0562140caa00b004412e8ff398mr8038940qvs.61.1650289725826;
        Mon, 18 Apr 2022 06:48:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj3pRTnuFOdkq/AHZ/+E5RDqX2djhn1Iw2byebM/R10ayUX37I/AG+/4Ru96jninNhWG8FkQ==
X-Received: by 2002:a05:6214:caa:b0:441:2e8f:f398 with SMTP id s10-20020a0562140caa00b004412e8ff398mr8038923qvs.61.1650289725618;
        Mon, 18 Apr 2022 06:48:45 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm7854020qtx.89.2022.04.18.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:48:45 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, balbi@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: gadget: pxa27x_udc: clean up comment
Date:   Mon, 18 Apr 2022 09:48:38 -0400
Message-Id: <20220418134838.1236023-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling replacement
endpoitn to endpoint

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.h b/drivers/usb/gadget/udc/pxa27x_udc.h
index 0a6bc18a1264..31bf79ce931c 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.h
+++ b/drivers/usb/gadget/udc/pxa27x_udc.h
@@ -326,7 +326,7 @@ struct udc_usb_ep {
  * @addr: usb endpoint number
  * @config: configuration in which this endpoint is active
  * @interface: interface in which this endpoint is active
- * @alternate: altsetting in which this endpoitn is active
+ * @alternate: altsetting in which this endpoint is active
  * @fifo_size: max packet size in the endpoint fifo
  * @type: endpoint type (bulk, iso, int, ...)
  * @udccsr_value: save register of UDCCSR0 for suspend/resume
-- 
2.27.0

