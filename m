Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD57851A1A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351034AbiEDOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350974AbiEDOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:02:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3D2180A;
        Wed,  4 May 2022 06:58:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso878705wml.5;
        Wed, 04 May 2022 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjx7gNEvj9OasAKbfNVg4zchWMg/Q6EBH67Oa2e8OLQ=;
        b=OdUGB1XVP71W0cC4X4Q6lqf1SU6b0l6Ls2EWYZWP4GK4EvVZiA0ptOKnxIgnuJuJkm
         eWcEB9UH13dZVCJtOPIw0kIqIR/JOuC6pj7rO8nA2fxr3ejgN7FUwh5nNKOy+77flgY7
         qLCWKnd9Jv3Tsg4ARKNL2te0UvHpQ4kxC2SeLcE18/y5d3jiDoqgoqu43QITjXR3M7zT
         4ub1lWe+D+tLpqCEuRdBTbjhPX+IkcYkVbEmRThUFgCmfHxnW+qGH3zfOEEsGz2rTfS6
         TKtcdThjM5FmEsO7/A9mSaoNZ0wlZfXSGgonTVhfoYf1IVpYjwJ2HEkLlxYlkPSbEszC
         oO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjx7gNEvj9OasAKbfNVg4zchWMg/Q6EBH67Oa2e8OLQ=;
        b=te6pQQbq3ZVwjZ3O9nafV9fnETlggVBC5aQ4F0LdlpI1SGku7HHvD/Al3rNTunMg4J
         l/VpgjWct5dXh6J8K9KwnVlpjsXCf56sZUIXH3YD92z5GLv74k93KXELSpuuJXZrXNs9
         bfBBNO6SgFpCM7gA75/S58rgz/vdlSv1X/hkUQSM/e5qfSTWwaNSeJi3U9Jmht/M0ldm
         jhVOk4PCPxb8SEfYbm3cs4EBfY4Frfq9JtkL2tLZaAU0a9G+STpLc8z6+XX4tEzz8ke1
         Q/XL84aNJWvohGehpGsKPV4mFwnx4eekJNnIznr+VgHyQ+DoP4YwgNuoLC9xJCIHyqei
         m1Cg==
X-Gm-Message-State: AOAM530y8LOP6B52gNGdcqh+DIwD3Nt4bCca72gOdIGacUVVRYcjLfaY
        32pFG4LK4ckXOcLU/4VLttE=
X-Google-Smtp-Source: ABdhPJxucinJz7AG3WirWMPy2Bpa+F0RiANyvK6kdoFCDRcm9ss19mURFInD1kiisZ60NlfKF6DOIw==
X-Received: by 2002:a05:600c:3584:b0:394:5870:2c44 with SMTP id p4-20020a05600c358400b0039458702c44mr3173325wmq.4.1651672721856;
        Wed, 04 May 2022 06:58:41 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j30-20020adfb31e000000b0020c5253d8bfsm11431814wrd.11.2022.05.04.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:58:41 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH][next] USB: gadget: Fix return of -EBUSY
Date:   Wed,  4 May 2022 14:58:40 +0100
Message-Id: <20220504135840.232209-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Currently when driver->match_existing_only is true, the error return is
set to -EBUSY however ret is then set to 0 at the end of the if/else
statement. I believe the ret = 0 statement should be set in the else
part of the if statement and not at the end to ensure -EBUSY is being
returned correctly.

Detected by clang scan:
drivers/usb/gadget/udc/core.c:1558:4: warning: Value stored to 'ret' is
never read [deadcode.DeadStores]

Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/udc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 61790592b2c8..3281d8a3dae7 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1559,8 +1559,8 @@ int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
 		} else {
 			pr_info("%s: couldn't find an available UDC\n",
 					driver->function);
+			ret = 0;
 		}
-		ret = 0;
 	}
 	mutex_unlock(&udc_lock);
 
-- 
2.35.1

