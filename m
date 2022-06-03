Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E953CB42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245050AbiFCODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244772AbiFCOC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:02:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352EF25C65;
        Fri,  3 Jun 2022 07:02:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so7308267pgc.1;
        Fri, 03 Jun 2022 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lISSvWak6FLRrO5psSLs6i76bhB1ZmPsSb/17A5+cjY=;
        b=hTSUCHd4eqE/1RDHL5S1oKpSN5h9bqgrO29tfXVGaKvp9x1/Z4ByT9XMzKKptzqGLY
         oyfY0K1HQZX2lVTpm57VOYoOoipmY+D536vd5rWWB9+5ew2w2modqlK6G4bT3y/GErbB
         qZ/KeSFbiQZra88y6VdoUUkkOAQBCCYBVh0nuvZ3N1v0IkBFz6xawSjJj7Zgb1obJ8V1
         5qkoNXvybmeuS/QZwnjGcpYQ9TuVJlgnEm25XqK19WndRB4dIcJgZ6qEYrbcrAiw8OQ+
         k/RQnYB44SZxrUuwbjif6AUTBco2HS7QNQR1N60WNVM4bLtpFzmJChEO7SqlRHZpHYp4
         N55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lISSvWak6FLRrO5psSLs6i76bhB1ZmPsSb/17A5+cjY=;
        b=Y6sZapYOPHdWvCl+wpJSCDyG/TegVZbywcMyFfDbt8c/L9CMyIEy2w+/WISVz0rxZL
         84AAg8PK9XTpMZdpjKUjgbFG8RvyLqQtTh/IUbCle88QZi5GacTKfcjcp/a6Oo45iKPy
         w5/lALaAgpkNmcrKqsF7am5lXoX0UYpNGH69EyqPkN1IW+YMisEHZtIOewgr2asKVzci
         l+5kSY6fiaqas50mdAYTI6n1/54QQr5YVkQwoSIyQhThIv5arBglEdsg1501GDM8tbR0
         39qaQ3DIYQGC7wWm3y0XWKWXrF+brUa8LzIZymqEH4klKagOwkhz0EliPeXOaO23yfsF
         QqfQ==
X-Gm-Message-State: AOAM531m9Dym9q8LRh91AF/WYK/GhLZI0PTOeC5rAxiFyskgZa1bnqwB
        riMCD6j9VCKYp4seAnqORBaBGF7ZJR6Ceer/GxY=
X-Google-Smtp-Source: ABdhPJwF39VJUjteEaNSomtjgRS2NA4E8u+f699LKEL1nW4tuICTZMM2rpl0BX0JHb6OmDIb7bRmvw==
X-Received: by 2002:a05:6a00:2396:b0:51b:de97:7efe with SMTP id f22-20020a056a00239600b0051bde977efemr4521830pfc.8.1654264976753;
        Fri, 03 Jun 2022 07:02:56 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id n36-20020a635924000000b003faebbb772esm5663265pgb.25.2022.06.03.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:02:56 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Roland Stigge <stigge@antcom.de>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe
Date:   Fri,  3 Jun 2022 18:02:44 +0400
Message-Id: <20220603140246.64529-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.
of_node_put() will check NULL pointer.

Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 6117ae8e7242..cea10cdb83ae 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3016,6 +3016,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	}
 
 	udc->isp1301_i2c_client = isp1301_get_client(isp1301_node);
+	of_node_put(isp1301_node);
 	if (!udc->isp1301_i2c_client) {
 		return -EPROBE_DEFER;
 	}
-- 
2.25.1

