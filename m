Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40805527780
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiEOMmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbiEOMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:42:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0561274D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ds11so392355pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZhkT/STYABSG9JFFXmVnUhiG8e1lb5tF7lB29mjolw=;
        b=HTEYr+6PFZb39JW1W9CGgOnL+UBCeh8qfaIHP9HxIb8+fup5A+23/EYQbRXR9M2ipS
         iV1IFYNfg6D72qQ0Th6GWW8Fn6IpEF6vXgfKSsquVLv7XaPL7pxuL9vGARqCDpOsyhwB
         upIXkH9tPsooCuGm+y0jYJgvjDW7pysBYvaBQ52qzT1ognIvUBd2O572jWgk8FLCSsD9
         H2W9PszQLF3DwERFaUsUm4aosAajMnAI/KzDcENl/6nncvnKkSbqfP+lXlwFV9Ml59g8
         laY4XsgWMaFS+cQ+Skq0b3oHBaavVI42dRTbx9ebIyFUl8cdUdezBXQinFto1hdsNQD4
         fm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZhkT/STYABSG9JFFXmVnUhiG8e1lb5tF7lB29mjolw=;
        b=hG4FAeFjvYEXek6lgrIgK4xc/MwGxLhgb+i1VmiB/YjO1tl2j/MBpWqUZJeFaUKNx/
         8smi+488XdIjiw6rfIAZCpFk0k8AFTYXwEq5pgc60iyZZ6x9AT0lTcIqbVy6Hfdc7jQF
         d9jcc+Lb8k6kifBjpwXkSuxW7RykljKH30oET9rcFIwVxRqhU7zE17DY2ap1Q4CebnRq
         PNH6UCvuoZY9ZvBznXQMx1DwQBARakMpYzwgANygwqvXon4NGRcc55ETg5zW12h6BYps
         lboRej7GMXi+uEu/trdT148i2BivUm4PXzo7Uub324IYATk4DB1SsSvc9BSgnwwUr+Nm
         X+FA==
X-Gm-Message-State: AOAM532noO9EdEg/lAsbTxr2Ey4Flz8McKhmMM1RqxvB7PBPRmQFaBca
        WXwJdn48RgbcU8ycfgAGlQZUw/6UfLgahg==
X-Google-Smtp-Source: ABdhPJyegSgNu3P86pqOLF041EckwBsKCfaN53VQlGxpKQyqJM4h9bAQ149bfGSkEfyYv+DRpOoQwQ==
X-Received: by 2002:a17:90b:391:b0:1df:42e2:ae17 with SMTP id ga17-20020a17090b039100b001df42e2ae17mr2312009pjb.198.1652618537439;
        Sun, 15 May 2022 05:42:17 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id p21-20020a1709028a9500b0015e8d4eb24asm5058042plo.148.2022.05.15.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:16 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 03/13] openrisc: Add support for liteuart emergency printing
Date:   Sun, 15 May 2022 21:41:48 +0900
Message-Id: <20220515124158.3167452-4-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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

This patch adds support for sending emergency print output, such as
unhandled exception details, to a liteuart serial device.  This is the
default device available on litex platforms.

If a developer want to use this they should update UART_BASE_ADD
to the address of liteuart.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index b1f3a65c271c..21db50563f97 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1555,6 +1555,17 @@ ENTRY(_emergency_putc)
 	l.movhi r4,hi(UART_BASE_ADD)
 	l.ori	r4,r4,lo(UART_BASE_ADD)
 
+#if defined(CONFIG_SERIAL_LITEUART)
+	/* Check OFF_TXFULL status */
+1:      l.lwz	r5,4(r4)
+	l.andi	r5,r5,0xff
+	l.sfnei	r5,0
+	l.bf	1b
+	 l.nop
+
+	/* Write character */
+	l.andi	r7,r7,0xff
+	l.sw	0(r4),r7
 #elif defined(CONFIG_SERIAL_8250)
 	/* Check UART LSR THRE (hold) bit */
 	l.addi  r6,r0,0x20
-- 
2.31.1

