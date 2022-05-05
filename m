Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36951BECD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358137AbiEEMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359512AbiEEMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:08:10 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A6D454F9A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651752270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b6FsSuldSV9lRRf+mgtlrrW/HBBrOUZtFamaruZ97h8=;
        b=iyaAo5j4X9IHJgGKyeiTEdgQnyVYmG6o2X8Je/zMWU0ps7SRgtHhfz5tdpRCe7KA59rXaU
        OT0HMrQL4wkw3ysSY0rQx2qkFb/1MMYsfzpyqXX+2fM1TFhxEGV23STUlveyoe8UFc7Nch
        G4nCRGaeMeMb8QoNP1SJyJq5JfsHMoM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-5Ie_02GPOMeiEEAuI9Ax-A-1; Thu, 05 May 2022 08:04:29 -0400
X-MC-Unique: 5Ie_02GPOMeiEEAuI9Ax-A-1
Received: by mail-wm1-f69.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso4424138wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6FsSuldSV9lRRf+mgtlrrW/HBBrOUZtFamaruZ97h8=;
        b=Mk7F3DGQ4+6sFzJYDcbiN3ol3jYhvVlnt4k5f0uFZ0cP5v6TUzCVrbDbkn2EndmlQR
         enSaEhoMMkStpc6cqqgdFsYBpCaCa4BEU0hA9cWh+6sS9/J+0agwBqbPoyIA08/BuXU5
         qukGGswHaIMs34H52PZrkiFBjyb0W6ozmgn7B0DbxWxEogxmDu+K+6BQ47gSUraJeBdd
         aDsKbMYke2haPEitT0imZVrAwCAx9DWpszrPqywiFNRblziuGS+nr+eR1jQFE21oPDxt
         UbhN7S1jHoP9JXVtdR2fdYqC34aueZmTr5HIVHXxIy6cf0bTLhWkeL1KWMQqqjioT6dW
         qBlw==
X-Gm-Message-State: AOAM531eXg9EemJkmvPGYn1x/uwJNHcOFXT48OoPXC3TV0Vq2yI+IM0o
        GVABJ4VlFOlRZqQAdX+na6AqafARH9wODz433Cm/1O3MlqwsUZtMNtVsRvJ/klHJ8P6RLeucKNB
        rbAGoLZGF7pwyvaqY/T80D4rJURxUwuQlHBIhLUAPs86qrzBVMEVgjizJvR+42TLomHJHluEJqe
        M=
X-Received: by 2002:a5d:64ac:0:b0:20c:62a1:b4c9 with SMTP id m12-20020a5d64ac000000b0020c62a1b4c9mr15253780wrp.491.1651752267970;
        Thu, 05 May 2022 05:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKBH1eP1dtXBfBIGG5Mc+1TNDzXh/v6Q5kMSQ2I645JQ2mXPp/4I/aDUd/MM9H8r/X0NxYFg==
X-Received: by 2002:a5d:64ac:0:b0:20c:62a1:b4c9 with SMTP id m12-20020a5d64ac000000b0020c62a1b4c9mr15253754wrp.491.1651752267730;
        Thu, 05 May 2022 05:04:27 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg19-20020a05600c3c9300b003942a244edasm1267350wmb.31.2022.05.05.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:04:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: vesafb: Allow to be built if COMPILE_TEST is enabled
Date:   Thu,  5 May 2022 14:04:18 +0200
Message-Id: <20220505120419.314136-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has runtime but no build time dependency with X86, so it can
be built for testing purposes if the COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that the driver
is not affected by changes that could cause build regressions.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index f2a6b81e45c4..bd849013f16f 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -616,7 +616,7 @@ config FB_UVESA
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on (FB = y) && X86
+	depends on (FB = y) && (X86 || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.35.1

