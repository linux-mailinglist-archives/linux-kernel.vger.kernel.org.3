Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082A459827B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbiHRLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiHRLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:50:31 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C378231
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660823430;
  x=1692359430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q08MakHc5eVvdV/G/8qb/f8/XhiABt+m4SYHF2LmOHM=;
  b=OoQrmgt6diNPu3sNH74OKyJQlXJJVrUGEEn078OqSrsh9YmAk0fiSeXp
   aXVPrZFa6pGxbz3D498MGO3AqloUstuvQKEQuS/2Vphv402a363sNfo39
   W3XQiJJ0ZditNYHkNx8ClQQx90n47UQOb337kYjztr0HFIeYts3ShH3V9
   BxDAnCWTw6ogEu7sh1BneUwxyma0AYm6SYCsr3BbzRP06KLDccqqSTA88
   EJ1/pBdAYH2yPIfAlITXSzSh45uBqxRYvtdW6TNDTbymDRok7pNSfxoD5
   mvZpO8He3hyl7wKtp8xhkuB6vO81c3pOR8L4flGcEEfWriioqikJn6CSS
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tty: Fix lookahead_buf crash with serdev
Date:   Thu, 18 Aug 2022 13:50:26 +0200
Message-ID: <20220818115026.2237893-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not follow a NULL pointer if the tty_port_client_operations does not
implement the ->lookahead_buf() callback, which is the case with
serdev's ttyport.

Fixes: 6bb6fa6908ebd3 ("tty: Implement lookahead to process XON/XOFF timely")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2: Move more stuff into if block.

 drivers/tty/tty_buffer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 9fdecc795b6b..5e287dedce01 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -470,7 +470,6 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 
 	while (head) {
 		struct tty_buffer *next;
-		unsigned char *p, *f = NULL;
 		unsigned int count;
 
 		/*
@@ -489,11 +488,16 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 			continue;
 		}
 
-		p = char_buf_ptr(head, head->lookahead);
-		if (~head->flags & TTYB_NORMAL)
-			f = flag_buf_ptr(head, head->lookahead);
+		if (port->client_ops->lookahead_buf) {
+			unsigned char *p, *f = NULL;
+
+			p = char_buf_ptr(head, head->lookahead);
+			if (~head->flags & TTYB_NORMAL)
+				f = flag_buf_ptr(head, head->lookahead);
+
+			port->client_ops->lookahead_buf(port, p, f, count);
+		}
 
-		port->client_ops->lookahead_buf(port, p, f, count);
 		head->lookahead += count;
 	}
 }
-- 
2.34.1

