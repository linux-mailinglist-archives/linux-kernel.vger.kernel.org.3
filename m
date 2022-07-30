Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C15585A83
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiG3NJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3NJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 09:09:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0715739;
        Sat, 30 Jul 2022 06:09:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso3606557wms.2;
        Sat, 30 Jul 2022 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kagw9dls/BgBWBfIvyxUVIiQ8+9cpfChvpk4Mixp24=;
        b=X5kN8s41pxbwVzxYvhnojQZzQOY2OAe0kJWaI9I4Nr3Dp5Rpv9VjXOyW5CbXErckw5
         eYtLaGA4x4Ibpgtz/s3VqhPRTuhff1+h4k0KrVWpsPMaeR0tuw+4uLZp4wN2MRmdJAli
         hSvEal/3aqpursRYrdNkVKZsgJpAN3s3pfFsAIHAnVDpdL4cq+bo9EmUh1eCcE4fBVVm
         sAIuGfaRd2mW/sM5m7J3LDxDSZ2i/wxX7ue/T6ycUZOqUB5rutBtX8mWeFVdtp3nEE2c
         r8h8EzS/2u+HdBSLwJGVj9XQ3+uu8PwBTBLOIoc1wX0XJrmOKJ3r0QgHSudAYz2jKpN+
         pQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kagw9dls/BgBWBfIvyxUVIiQ8+9cpfChvpk4Mixp24=;
        b=IQ6pyL6fTzgDFQJ5KHNGJNdvNR49EBOuWNkaECP1mGWC6T0gvU7ZzrU4K4N+eo7HLT
         UiwEm8GuVPz2iDk4Ut2/PpZryHPs6//n2jC/b9/AXUVv1cD0eJZZi+/fLXMcrsbppvmN
         M5nwvwYyf8vNu++nszabnsGtBtWdaFjSPVNer8IcUAWIvdDXqM0rIY7KfHvyxGLJ3NE3
         XjXdlye71iFN9Ce86dJq6JH5LwqN0rFj1773cfVH87MgAS+rNG9kPkRo3xsuNUZ6EOHX
         K4wrvs2oDq27IKodjsDgRkiQPE03JEmyDsc6Uew+uzJD8Oz3i48EgParH+7/Jk85Y1Kz
         S/SQ==
X-Gm-Message-State: AJIora/ixhkWKotTzgnQuTSvw/vA7xCM+5icoHf3TC5jvNFKmBCqqSMh
        zD4KW9YNOwE/U8Pb5tdsRu2Zq8uIgi/jBg==
X-Google-Smtp-Source: AGRyM1uP23E0LunR8ANvqJ2/vYfQxzFydvP8EbwxwCuzVZi+Q5/CO7PbbJmGoxJRM3Nv2QUwmiAfFg==
X-Received: by 2002:a1c:4444:0:b0:3a2:fe56:e8ca with SMTP id r65-20020a1c4444000000b003a2fe56e8camr5255656wma.21.1659186566406;
        Sat, 30 Jul 2022 06:09:26 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b003a17ab4e7c8sm13076172wmq.39.2022.07.30.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 06:09:25 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mxser: remove redundant assignment to hwid
Date:   Sat, 30 Jul 2022 14:09:25 +0100
Message-Id: <20220730130925.150018-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable hwid is assigned a value but it is never read. The
assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/tty/mxser.c:401:7: warning: Although the value stored to 'hwid'
is used in the enclosing expression, the value is never actually read
from 'hwid' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/mxser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 70b982b2c6b2..600c71e5eebc 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -398,7 +398,7 @@ static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
 	oldmcr = inb(io + UART_MCR);
 	outb(0, io + UART_MCR);
 	mxser_set_must_xon1_value(io, 0x11);
-	if ((hwid = inb(io + UART_MCR)) != 0) {
+	if (inb(io + UART_MCR) != 0) {
 		outb(oldmcr, io + UART_MCR);
 		return MOXA_OTHER_UART;
 	}
-- 
2.35.3

