Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C504D02E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbiCGPbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiCGPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:31:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123075749E;
        Mon,  7 Mar 2022 07:30:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e24so10921233wrc.10;
        Mon, 07 Mar 2022 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEUtjRWw8hcXPx8ISHtvMs+ktqj0awQxQ1FmrJuTsp0=;
        b=MNpHF7Pxg9BKJiM7fXtwr+H0qiQHTO5YaiWRpoj8JeGPvWbNy27/PM68jvK4QSBRoS
         eJV84YLL7LY0Kx+2dttq4o8BSGVJnTkTkSVrSQ6jqym1hnTU/KN1tiaQ4HT3YxHnGaep
         l/BgDYpY9h1dRuCJcH3/sPXiySIO+U6vefOR+F4+6/wYeky7WPYEoZhJjDMIx0OvJUnr
         rJpIGYuHLOeHT93rWf+ikiIQTOzZMcEJeJjTV+qPGfz/r4iAqH5VCVB98b/FMsXQJZQT
         bPAklAmCoO81z7iPKi3IVku0QUFChskh487B2KlaehvDU0EI0uy5Gq33vkGC5FnOYU2C
         YW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEUtjRWw8hcXPx8ISHtvMs+ktqj0awQxQ1FmrJuTsp0=;
        b=6gCUcgdLxzXXsPIx7rX6oQXVwrtHf7Hlt32yokXmdktU9yWzLXYX2eZh5F6xTfmdV1
         LttieduH0Yo7DZB7Fc1jFUvQQLcxETn1Sy0N695ei9ijYFXGbAavTkaK1raBtJie65eu
         ox8MDb1FSWYDbJCKny5vL7Gvd6r9dxxtl/gC2bugoDSDb0bccTY+XPNtRs6Ge9LoZ7At
         mVJEzOiRw/6YoZEIbA2FM8pBW+ia0n2bL0rCtXrGXfCzjqBnvTjLa1J/2QmlX47wfkXr
         vXBOAcpL7zcd4Sqf5lGi1wF/V7YnRoSQu8tt8SFTOZetr7aYtS9Cyqdqbn0+KHz9g97Q
         hkBQ==
X-Gm-Message-State: AOAM532CuK1t3+xGdeBRu5I7Sm/3tqzsZ61CPbl3u34VURz7OFURYs1W
        lyaEBRETQ6Ps/yeLAqpDtAM=
X-Google-Smtp-Source: ABdhPJybfHSo0eCkjaEOHXAgaY8b9TUr8U9Fg4tG5GiMhl+kF2PHHrRNJApWZg0ccl+N6LMTkzuvSA==
X-Received: by 2002:a5d:64ac:0:b0:1e7:1415:2548 with SMTP id m12-20020a5d64ac000000b001e714152548mr8834834wrp.267.1646667048657;
        Mon, 07 Mar 2022 07:30:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm15673525wmq.35.2022.03.07.07.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:30:48 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] tty: serial: jsm: remove redundant assignments to variable linestatus
Date:   Mon,  7 Mar 2022 15:30:47 +0000
Message-Id: <20220307153047.139639-1-colin.i.king@gmail.com>
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

Variable linestatus is being assigned values that are never read, the
assignments are redundant and can be removed.

Cleans up clang scan warnings:
drivers/tty/serial/jsm/jsm_cls.c:369:2: warning: Value stored to
'linestatus' is never read [deadcode.DeadStores]
drivers/tty/serial/jsm/jsm_cls.c:400:4: warning: Value stored to
'linestatus' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/serial/jsm/jsm_cls.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index b280da50290c..444f233ebd1f 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -350,7 +350,7 @@ static void cls_assert_modem_signals(struct jsm_channel *ch)
 static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 {
 	int qleft = 0;
-	u8 linestatus = 0;
+	u8 linestatus;
 	u8 error_mask = 0;
 	u16 head;
 	u16 tail;
@@ -365,8 +365,6 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 	head = ch->ch_r_head & RQUEUEMASK;
 	tail = ch->ch_r_tail & RQUEUEMASK;
 
-	/* Get our cached LSR */
-	linestatus = ch->ch_cached_lsr;
 	ch->ch_cached_lsr = 0;
 
 	/* Store how much space we have left in the queue */
-- 
2.35.1

