Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829F14CFCA7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbiCGLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiCGLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:24:33 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30641C921;
        Mon,  7 Mar 2022 02:51:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b8so13018300pjb.4;
        Mon, 07 Mar 2022 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=j8mgW2tireVLaFShl52ji4HfOgeZjBRmsgnOuKcFd2U=;
        b=iZkGKeV7nAWcmc5MQ6oH1nL1eOx2fyL3qHrKtLlW2TiU8yYpwHdJSluLmnDFPHA5P3
         YEmTWTDKLDkQP+aJPfDPuUqq24X/b2CS6+bDSP+PXDUoNv37AGwjBRsX5+mL2EX386az
         WF6okfVboABcIyulNol9DXK6ybW90GHTmGdKMAMX9aQIuXOdInXMxY6iOGoZDxFbTu9k
         PThuffnNj+E3o6Ha/xUh24D4SxBnPAlTd1nTDRqZ7zfNrG9CeWgXZADTYqyveDAroxCE
         gUWpRyPuSgJnPqs1yvBnziqm8u5FIQWUfU23ct2sN7/rI6ebHHWTEXL22pu6eiolmBk3
         2HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j8mgW2tireVLaFShl52ji4HfOgeZjBRmsgnOuKcFd2U=;
        b=ZUyY2MgM18F/EYF/sXsyoxigXZJw7OphC1v9kM2680dDe+h1r5gCmPfGs7j91QLuGu
         GvTQGvadAS7jGcmU0pXEh0xaVSLn5qZMPcNDgFg+ZSAy8Kk+NyT+L66xP/G1cJn6lugG
         VJWrOI1+JUWrTjXzRjmcFMJ/rG7CXx8ix8KyQIjjMo/wV/HrVnPU2YZXtUJTpAJol6oP
         Sliy2tsZQSGKvrQqkE/FVESaRTZvAHGUBFoUAXkyO9kPqB3IG4rBCLb2KcCSeq8DuwPw
         ADeyp5ExgdOX0ZJL+fc0xB5wU/GRtuW9/8hAVtFQadpdXxlEKtf/dj9kcrZMsY6vt/w2
         sEag==
X-Gm-Message-State: AOAM531HEk12GFx3Pm9lW/x0/XB52ujCLmUrojNo/f8Ll5rsD2/BJ/WH
        GqIehKnZS9RTi8hA86cRtD8=
X-Google-Smtp-Source: ABdhPJxlWUg0FoiPrnYPoA2ku5qK/koaaqDT8mnDf0zPlnYQ36GpgzCPkzrnnv3qsGnGe6xThjT7yA==
X-Received: by 2002:a17:902:6f0f:b0:151:3f2d:8b21 with SMTP id w15-20020a1709026f0f00b001513f2d8b21mr11613033plk.123.1646650306160;
        Mon, 07 Mar 2022 02:51:46 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id y39-20020a056a00182700b004e19980d6cbsm15619619pfa.210.2022.03.07.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 02:51:45 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amit Singh Tomar <amittomer25@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] tty: serial: owl: Fix missing clk_disable_unprepare() in owl_uart_probe
Date:   Mon,  7 Mar 2022 10:51:35 +0000
Message-Id: <20220307105135.11698-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return
from owl_uart_probe() in the error handling case.

Fixes: abf42d2f333b ("tty: serial: owl: add "much needed" clk_prepare_enable()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/tty/serial/owl-uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 91f1eb0058d7..9a6611cfc18e 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -731,6 +731,7 @@ static int owl_uart_probe(struct platform_device *pdev)
 	owl_port->port.uartclk = clk_get_rate(owl_port->clk);
 	if (owl_port->port.uartclk == 0) {
 		dev_err(&pdev->dev, "clock rate is zero\n");
+		clk_disable_unprepare(owl_port->clk);
 		return -EINVAL;
 	}
 	owl_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
-- 
2.17.1

