Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5954B7E36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbiBPDIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:08:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiBPDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:08:18 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C59A994;
        Tue, 15 Feb 2022 19:08:06 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id g24so654026qkl.3;
        Tue, 15 Feb 2022 19:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIE0Izbh9CwLFYpchTer+Bxxv7Md5jVRn5sGjgstL6s=;
        b=MZMRcETkkIkyTNGCOxnG5mHkgMIpGdQxIMbLccGCcWtZDo+OHc1NUu4+nsmfjtqpcC
         zqdBbkhar5/XBh/+qb4ChDQ2aXIOJ696r6+DUa6ZgVBhDq2IQJmaQNM31vuv2+vWHoKU
         gDLrgNYT5AivhBKptqoq8LfawnOi1+feZ69N5Nq49WBZQfqzyFeFfXBtEqG9Zv2Up7/i
         iZN6tvBq9qpFf3VY8zJyzFPDwysYu3NgwqP5hu5T0ygv81gX/g6l2cCFCgXv4fE3MLY7
         4Dx5tsXfiy7szMZMNRAVQ59T3Xh3EyK5Kh4G9amEE8sJG4gvaKgnmXbYbWppJ1nRE7bB
         FS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIE0Izbh9CwLFYpchTer+Bxxv7Md5jVRn5sGjgstL6s=;
        b=obPD2mREG/TSK5G0nLfRwjAatFh1VWjerDOEptCJ2zLm/hobkvgRCZGWYOOmxc7B3F
         87wmZGXgCdL0cJtvTqQ96ysHohOQbZXL8zP9h//K0dmayE3h4BIMihqN8ECKGAucPTFA
         f3HUhaSXMZrEY/+aUgGgLrAQ3EgOXE8n7xR8AS2wdrV4VrWGZ2YD/SDw6DOjstF3pLai
         BN45m2hGmLrCgAMDFW2SAM7w7jqcdSs/2xAvIZzbf4PlV3VphTP7k2PhPxqymLam3lUg
         3tgHOnTzcCuJqXhsL509Za/Wz/T0jbqR4OlaivtapV71P02OVJN7IMp5QfKCBUdCPppM
         dnzQ==
X-Gm-Message-State: AOAM5320lGuqcR1Tj8hOYzyFtARdLa2fr7tnwctuGV0Yd+tjw84dozB9
        0RmlYENJ/faG1SOFVYHgmV0=
X-Google-Smtp-Source: ABdhPJxEVNCkpcWgbfXh/7WBA6twoGsjSe1NCVHH+26p8DPZx7adBZFbzUb2YWEP5yv3HAOhzB6vCQ==
X-Received: by 2002:a05:620a:152a:b0:46d:5918:e7cd with SMTP id n10-20020a05620a152a00b0046d5918e7cdmr418881qkk.494.1644980886019;
        Tue, 15 Feb 2022 19:08:06 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w19sm15781791qkp.6.2022.02.15.19.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:08:05 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc/qcom: use struct_size over open coded arithmetic
Date:   Wed, 16 Feb 2022 03:07:59 +0000
Message-Id: <20220216030759.1839582-1-chi.minghao@zte.com.cn>
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

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kzalloc(). For example:

struct apr_rx_buf {
	struct list_head node;
	int len;
	uint8_t buf[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/soc/qcom/apr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 82ca12c9328a..0813dbc5e462 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -171,7 +171,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 		return -EINVAL;
 	}
 
-	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
+	abuf = kzalloc((struct_size(abuf, buf, len), GFP_ATOMIC);
 	if (!abuf)
 		return -ENOMEM;
 
-- 
2.25.1

