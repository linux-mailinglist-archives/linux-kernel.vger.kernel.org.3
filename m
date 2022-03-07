Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA24D0B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbiCGXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiCGXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:01:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7613D34;
        Mon,  7 Mar 2022 15:00:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j26so15306263wrb.1;
        Mon, 07 Mar 2022 15:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXb6dcYiaIaX9vW+hIgXAOrUp0mAL09kFtXf/8jaaiQ=;
        b=mCkLiR1F+3uFUHN4Cux2+9V699zxWgmjUYLh3QxL34WUQrw+14T92MMla/vjH+80f/
         NWmngOJz6CORhAQ52gzeRJEknJGUvCMFo2lY5mUBfNIx1k761D8dwepm6nB+KcTS8r29
         Z/tL8471T4EdmOur5LT0/MvjtYjU5dlT04NZIO3jsWRzYtfZk2gRGL474nJBcrAeqOHW
         PBvBIg6dtvZlqNAGWAFD+Obd03An8gMA9WnL4BzFHq4M+MltcqsinuY3fAsPawHp7R6o
         gmp4MOp1xj5bRkLarNdnDzD1aaiEhTalnZZmaSr5gNDoxZUMjq/Tan25jljU+w/4gKRS
         /bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXb6dcYiaIaX9vW+hIgXAOrUp0mAL09kFtXf/8jaaiQ=;
        b=Hn9wMl5uu/g6uZaJ9zycEHNkKM6HOubaWFA4/6jW/+3t0UDw7uIQqmKcpNuIaUABLW
         R5PE93FQwaH9YUd3cyWX5MWXOrV3ol6zUCMIMSgJMb3Yr5vSvOUfYq4gLAIluNHJNfzG
         IqJL9mc6mnLXDiwBG6j2v/AsuE0aiBviPYy7+MJZ7q05OSTNqorDly8h2t09UaIieHhE
         2EM7LDU4fri2jb/vlD1revfZ65Xp3gSIm5LlPRqJtLezgOnB3SbdHA8KV3HNGK5HgVHn
         e/NsUTMRY9EfDF7ICcO1PNQpgftAJFi/JJb/y6fQh5KhWcZo/WHAtdhkurSzS+vazYah
         tS6g==
X-Gm-Message-State: AOAM531EpH/vOnQ038Iqy8V26uZuSukbvI1BezuA9Ig1SX4iAR269KK8
        jKqPTo5RWuUhzDoQ7qF9CCaJtuxau8VvNg==
X-Google-Smtp-Source: ABdhPJzJ4l1a9rSOdkV9CuwVNPwfslbOek/f6oelAsw9LuF2HFvchYiiPxOVoaPIELc7zCRCOUd3kA==
X-Received: by 2002:adf:aadd:0:b0:1f0:4848:2748 with SMTP id i29-20020adfaadd000000b001f048482748mr10101067wrc.75.1646694056979;
        Mon, 07 Mar 2022 15:00:56 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b0038999b380e9sm538653wme.38.2022.03.07.15.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:00:56 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_mtk: make two read-only arrays static const
Date:   Mon,  7 Mar 2022 23:00:55 +0000
Message-Id: <20220307230055.168241-1-colin.i.king@gmail.com>
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

Don't populate the read-only arrays fraction_L_mapping and
fraction_M_mapping on the stack but instead make them static
const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index fb65dc601b23..f4a0caa56f84 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -289,10 +289,10 @@ static void
 mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
 {
-	unsigned short fraction_L_mapping[] = {
+	static const unsigned short fraction_L_mapping[] = {
 		0, 1, 0x5, 0x15, 0x55, 0x57, 0x57, 0x77, 0x7F, 0xFF, 0xFF
 	};
-	unsigned short fraction_M_mapping[] = {
+	static const unsigned short fraction_M_mapping[] = {
 		0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3
 	};
 	struct uart_8250_port *up = up_to_u8250p(port);
-- 
2.35.1

