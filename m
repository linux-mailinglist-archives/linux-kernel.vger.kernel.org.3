Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796FE507940
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357280AbiDSSbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357501AbiDSS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 158303DA59
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650392508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lWTHKMQjdn7m9FQKkTKQCYJuIOK57zO3rzKobW88z1Q=;
        b=WXdVBCkS6JzGNteX2DBURbPEWqGtOQNFQdMfTbZo7XdvGGsmUC3846F2DIV8HvKn73oN6i
        ScxfM1Jii4U+f6qjltSfDLv65zCCFrNS8V3jbs9siSkkLno4SvmOm/fREbyXFz7u9LQSgp
        6+boS+b6IxF7KmyMtwjTkBLD3mey+vU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-aZgSQoUENiiK9T_sFzw9nQ-1; Tue, 19 Apr 2022 14:21:47 -0400
X-MC-Unique: aZgSQoUENiiK9T_sFzw9nQ-1
Received: by mail-qv1-f71.google.com with SMTP id dd5-20020ad45805000000b004461b16d4caso13806142qvb.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWTHKMQjdn7m9FQKkTKQCYJuIOK57zO3rzKobW88z1Q=;
        b=i4fvKxYDGoJgAqzUA1VmSfPnwUMUWxroLNjU4uwJ+eNqYpVJeR0Bq87g7vNWakVtfk
         RBqHMPwQoLsOdU9Lfgc16K6WJbgnjEyuqRJ6XKF4KIeKvD4OFTmAFUc7xcBU7ZViEbxX
         jGlNBs1uJgkqNFwLVS6qp7Sn9thro1Ib4gAPogCTBFDsY/qE26RibCHLMKQEfDswf6Y+
         DRxaFuFhEaYcxdbK4w+J1aCLJhfDhLu1uSqj/9eLy5tFMbcPLprvQdctARKXIoAr3mzi
         nmOnBQLYylcCjjgWJu0JA2Rf5L1lGsb0PW3neVGxIRl4jNCZ5yqLh45Y4+wniVqvSlrc
         DQPw==
X-Gm-Message-State: AOAM533eKBCSqzJ7e3DkDyV3rAOFBGMOi9SDtQUFCbNQHkQNnQcXVKOb
        +yB0GkKOHXgVU0jqdT8E4q+FZqThvt9KzMMpvGK7cwXkgFvItAX5h/knW7HA8IHypYEFNkwW8/O
        Xp8BA4p9OsZNpqHkFjtVyORFu
X-Received: by 2002:a05:622a:52:b0:2f3:3e3b:8d05 with SMTP id y18-20020a05622a005200b002f33e3b8d05mr1167017qtw.159.1650392506153;
        Tue, 19 Apr 2022 11:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCDAj7ir4s3pP6W0rSrBZtTkPI1yRL/hmNRGfB1yQs8OUlkx6UOtPpKbXFB/CBhC0UzH/F1g==
X-Received: by 2002:a05:622a:52:b0:2f3:3e3b:8d05 with SMTP id y18-20020a05622a005200b002f33e3b8d05mr1167006qtw.159.1650392505973;
        Tue, 19 Apr 2022 11:21:45 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b002f1ff52c518sm453121qtj.28.2022.04.19.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:21:45 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, colin.king@intel.com,
        stern@rowland.harvard.edu, jakobkoschel@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: gadget: net2272: clean up comments
Date:   Tue, 19 Apr 2022 14:21:42 -0400
Message-Id: <20220419182142.1805918-1-trix@redhat.com>
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

Spelling replacements
definiton to definition
acceptible to acceptable
seperately to separately

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/net2272.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 6a8884632273..c97cd4bc817c 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -71,7 +71,7 @@ static ushort dma_ep = 1;
 module_param(dma_ep, ushort, 0644);
 
 /*
- * dma_mode: net2272 dma mode setting (see LOCCTL1 definiton):
+ * dma_mode: net2272 dma mode setting (see LOCCTL1 definition):
  *	mode 0 == Slow DREQ mode
  *	mode 1 == Fast DREQ mode
  *	mode 2 == Burst mode
@@ -97,7 +97,7 @@ module_param(fifo_mode, ushort, 0644);
 /*
  * enable_suspend: When enabled, the driver will respond to
  * USB suspend requests by powering down the NET2272.  Otherwise,
- * USB suspend requests will be ignored.  This is acceptible for
+ * USB suspend requests will be ignored.  This is acceptable for
  * self-powered devices.  For bus powered devices set this to 1.
  */
 static ushort enable_suspend = 0;
@@ -288,7 +288,7 @@ static void net2272_ep_reset(struct net2272_ep *ep)
 			  | (1 << LOCAL_OUT_ZLP)
 			  | (1 << BUFFER_FLUSH));
 
-	/* fifo size is handled seperately */
+	/* fifo size is handled separately */
 }
 
 static int net2272_disable(struct usb_ep *_ep)
-- 
2.27.0

