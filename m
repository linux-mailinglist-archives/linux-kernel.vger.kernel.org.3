Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244BA50A402
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390061AbiDUP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390046AbiDUP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09B011E3D5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650554721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ttMoGFApcsmXuI/gPwewnQASmEx+6ID1JuIYA9uETo=;
        b=Az1azc9Ec8egqUGBfkp9cESE7IOEMxuIlBXQhL3vhfy33vBnuI4e2fUaHeVGuYXgRS1MqI
        Ds+WpYtKxPPrVWSt0pI95qD72yBX1qxVbtwhZANUsM4yz0UODFvOxsc9uEVdoa4lHktkfx
        Y5Bgm9CIq8lgb7CgEiPB2SYDEkmp9BQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127--l_-DhqjN5aa_m-wYeEjeQ-1; Thu, 21 Apr 2022 11:25:12 -0400
X-MC-Unique: -l_-DhqjN5aa_m-wYeEjeQ-1
Received: by mail-qk1-f199.google.com with SMTP id o79-20020a374152000000b0069ee7515f53so2812949qka.14
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ttMoGFApcsmXuI/gPwewnQASmEx+6ID1JuIYA9uETo=;
        b=5VsVf+kmxWwP43gUL2VxWfFgmJvTAlZDa6iwDE1b38R0dFw9Ix5OzU0M48byG07SD9
         FmPDEJ+NZAUw/2rl4awjj/PmMSKj2zqtH/2kYucAl86Tr/W5lUkEnPBnpMc6B9dXmnES
         F6jB07UAnBxyKcG/1qk3zKSH9VRPo2ldbmWKPzlR87mtv3VzpFiyx7wscqrlUw0jRH5y
         V0Icn9FlaCTIaaSqwLoYpsB2ElFbMQn8mwCkiY7TDNLsFIV+SgyAFbPIi6+aGn+RmOWG
         ombLqd9MKzsyMjGj36c5w4PUGcXzHkmlGnySbnbFX0z3Nu1cnhh9ii7zyyoIDK88rhvG
         xzUg==
X-Gm-Message-State: AOAM533kOilxnKh6cNmazXTaMIBWXgah4I24unMDQM9NVxY5OhXbXto6
        x5AcUEe3HRenmLMEgFXbkkL+kFXUoRGVBAQPiOxz2oIOVkveAjJPn66jebKq2YSnIHHbdbeY0rm
        QeIKj7jaMOykXSRa82x6KYHcA
X-Received: by 2002:ac8:5e54:0:b0:2f1:f60d:2b3c with SMTP id i20-20020ac85e54000000b002f1f60d2b3cmr16625086qtx.667.1650554711416;
        Thu, 21 Apr 2022 08:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+P77pjFBwONc0Em0QpWeGubtnUdjANuIPyYLPcq0pQgRQocDp9HsSHlVtQWkAJm4cqwGVrA==
X-Received: by 2002:ac8:5e54:0:b0:2f1:f60d:2b3c with SMTP id i20-20020ac85e54000000b002f1f60d2b3cmr16625068qtx.667.1650554711225;
        Thu, 21 Apr 2022 08:25:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 135-20020a37078d000000b0069ea3c7513bsm3109620qkh.121.2022.04.21.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:25:10 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hammerh0314@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: sunplus-uart: change sunplus_console_ports from global to static
Date:   Thu, 21 Apr 2022 11:25:05 -0400
Message-Id: <20220421152505.1531507-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
sunplus-uart.c:501:26: warning: symbol 'sunplus_console_ports' was not declared. Should it be static?

sunplus_console_ports is only used in sunplus-uart.c so change
its storage-class specifier to static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/sunplus-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 9f15922e681b..60c73662f955 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -498,7 +498,7 @@ static const struct uart_ops sunplus_uart_ops = {
 };
 
 #ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
-struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
+static struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
 
 static void sunplus_uart_console_putchar(struct uart_port *port,
 					 unsigned char ch)
-- 
2.27.0

