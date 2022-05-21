Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94EC52FCAE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354918AbiEUNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243648AbiEUNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:13:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468339B80
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q4so9411051plr.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egjC6NgwBLWYIyKnRSW+X/wYthcyg40wdtxiZu51vtc=;
        b=Eri97N4csdJvg9j8fzgy7MS1YyQ+NxThLJw+0XcBkwt0rJ1Yl0MhA7CKtyi3sFq4/3
         ULDf/1UNk03mIhAcJHfX7ygdKGmgIuMQCynaG7TnOKget9/Bz3FkKGmA7RcApHDDfMn0
         ruE2gs/UdKz88zxVSTbSzTgfIUVN4tHFGwD49EwfHsRcBRj+NrUV9EoNwsyyd2ptsFeU
         F688McRuRwqfX7YU3NsutYHF3bkqt6xMcDnzCunYHdsYLrYcJMocb5VV4TEB94yz2SJ/
         5JOgRW0ngIxg/Aj0RLNItndbolIiTuDWWUJmCgV+xXtd5fse1Jw4rouMplXomwJKTVOs
         WwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egjC6NgwBLWYIyKnRSW+X/wYthcyg40wdtxiZu51vtc=;
        b=5B6uyoVPF9uvRnGOBDWo8xpswkIneYnXh4B65s2Zk7RX/hKWdnCzci0f5wQNFqeTLf
         Pjexsug9E5qkfX4yRbnJrYDHGnr/WLVYlejWD3JSHLo69cSG/Np7n/Vph5iLm3R8VQoQ
         AbZT2b56RkxNDIUrZLf3m61gdARQSRU9POqPw52UQ76D0mf2yKtWw34OIbKCpVeWEkL/
         NlFhiEaTet11zwZfrABJ7LYqRxWcTbg9gYcUUR8P/Eiwu6nKb/0oPu1KKT/AbWt6S0s8
         3HfOO1k9ynYUIC0d9ScLEY++9Db34bJJrYf5gsxnuwbaWiOFWz8MvMfRfemUQ7dyWWx/
         cNdA==
X-Gm-Message-State: AOAM5314BtdtQYoQStgfnys5PdZ9ch8xZFLocn/Eu5qW/m3yhP30ZDWd
        u6a9qMjihQZerobYBjEeS7He7DhMXko=
X-Google-Smtp-Source: ABdhPJxkPxXSelXTcn/TSy5d8joziO5MtffGIlNjryF2zLVJkVfnQdR0EZUMgSBwiqMSUdHFgvcSmQ==
X-Received: by 2002:a17:90b:1482:b0:1df:5b39:8a4 with SMTP id js2-20020a17090b148200b001df5b3908a4mr17034745pjb.233.1653138826467;
        Sat, 21 May 2022 06:13:46 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id p19-20020a1709028a9300b00161a9df4de8sm1566514plo.145.2022.05.21.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:13:45 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 03/13] openrisc: Add support for liteuart emergency printing
Date:   Sat, 21 May 2022 22:13:13 +0900
Message-Id: <20220521131323.631209-4-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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
 arch/openrisc/kernel/head.S | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 7bfa6e4b60c5..21db50563f97 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1555,7 +1555,18 @@ ENTRY(_emergency_putc)
 	l.movhi r4,hi(UART_BASE_ADD)
 	l.ori	r4,r4,lo(UART_BASE_ADD)
 
-#if defined(CONFIG_SERIAL_8250)
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
+#elif defined(CONFIG_SERIAL_8250)
 	/* Check UART LSR THRE (hold) bit */
 	l.addi  r6,r0,0x20
 1:      l.lbz   r5,5(r4)
-- 
2.31.1

