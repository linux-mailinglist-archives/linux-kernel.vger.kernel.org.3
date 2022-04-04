Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124424F1771
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378190AbiDDOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378920AbiDDOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:44:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CA6448;
        Mon,  4 Apr 2022 07:38:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso2097379pjj.1;
        Mon, 04 Apr 2022 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=/OOC2V7xZiaknaBKj4i3q7VnOh6KcuMP7wXUOuaSHIk=;
        b=XbFFVR/b5q9T/ccQwMNV7oS8jmz/8ydhO2wbuZ4dnTMtjIzB6jdnZMtjVA+gVPOlNi
         Fh3L/YtSRG0H+pWEhoLWfqjheiDJivSt2rc02u/dwUeHsKoBGABxJRp9Jbb48MYAIpim
         O64PfE/ok5JMyRZ3CQZiEICQ5VUUxCnwUPfrsPhqA1dALFfBxFleTbQd5I0odX5BNO59
         lKbzkBuY3TkjHZXaiTT997YZJcB8tyMTKt+oGo6mJ+/QS2cIoRy8bam9Qw/r6vdNGJhI
         sSITUz76YsxGcaKHQZJ+gQ3pAf+eeVfQMh7bey9qc6JpwoJpJoEYlSE3bBgYBWIehayO
         Q7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/OOC2V7xZiaknaBKj4i3q7VnOh6KcuMP7wXUOuaSHIk=;
        b=BoydGO77atrjfF2zcrlWfOxz4jHY7/z1y0+TejU4z15VG817H8yF+f9YNTmaSDazEl
         j0RCnMfoZ6EVrAUqtcIwT/CgQwdrStcWLHqH2wRLM4Hs67i2iHTHwnci3Icon0+nxyfa
         kSVLJJAS5d1eEbHWlJsWNl+UOl/Rue7K7hN8qnKUZkBH53Q02VgqNNyYfuUSPzU5MfaR
         PVYG8GvoR/Pppfjz7X4uN28SLgVgj7zbgaAAmh1eBWAsOHi0csIUuxEZXVI4/tFsEU9D
         7wlgmB8asKAJTW5h7yZ/2vbVTRUkyyYGhcNu7fLV5T3N0UAt3zEH7vX0MbA5HjUWSt8/
         qD9g==
X-Gm-Message-State: AOAM53364hQU/fJaYqKwG6wXB177NjAOCu446Wf+E7TfOFXZguvkOUhe
        dAgbMnNR8itbPBUU4uq2UyM=
X-Google-Smtp-Source: ABdhPJyhtOBPPj1peqOQfSYtTssZudXWivrHTu/PMrPp1u6em61raME54CbKsHs/3PFKQmSppHnJWA==
X-Received: by 2002:a17:90b:4d85:b0:1c7:3933:d810 with SMTP id oj5-20020a17090b4d8500b001c73933d810mr27001609pjb.129.1649083128678;
        Mon, 04 Apr 2022 07:38:48 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a11-20020a056a000c8b00b004fade889fb3sm13135860pfv.18.2022.04.04.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:38:48 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Johan Hovold <johan@kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_aspeed_vuart: Fix potential NULL dereference in aspeed_vuart_probe
Date:   Mon,  4 Apr 2022 14:38:40 +0000
Message-Id: <20220404143842.16960-1-linmq006@gmail.com>
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

platform_get_resource() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference.

Fixes: 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 93fe10c680fb..9d2a7856784f 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -429,6 +429,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	timer_setup(&vuart->unthrottle_timer, aspeed_vuart_unthrottle_exp, 0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 
 	memset(&port, 0, sizeof(port));
 	port.port.private_data = vuart;
-- 
2.17.1

