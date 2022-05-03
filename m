Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2497E517D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiECGfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiECGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:35:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34E381A9;
        Mon,  2 May 2022 23:31:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0C2BC21871;
        Tue,  3 May 2022 06:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651559488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45EEhDKBrjTEPmKWgbFN1jRDrFBIQdwsxAiwXS6CFHo=;
        b=fmnbuNyEScNKJYXEEdlTaXRVvArpltNJUc17ihA446Y6nxxAC7Qdye57UmtwBbJ18dBwIB
        FMJSXVaXJ4kBR3Pkqq/tNcTK92lapXXQlbg/oFD7mUVdAnA8Gnf8IPzfpbpRW7/Pw7NlIX
        rcL0jxu5q+MTuW/CT8VPnwOA4HmUA/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651559488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=45EEhDKBrjTEPmKWgbFN1jRDrFBIQdwsxAiwXS6CFHo=;
        b=5uTrp28+Yh6K/1uS12DgnP6p32Xz4VjrFbfmGPBAcL0D8fIUSkeKVolWA/33GQwf0KuLtM
        Ls5MMCifhC6lRaAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CA80B2C143;
        Tue,  3 May 2022 06:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/11] serial: pic32: convert to_pic32_sport() to an inline
Date:   Tue,  3 May 2022 08:31:18 +0200
Message-Id: <20220503063122.20957-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503063122.20957-1-jslaby@suse.cz>
References: <20220503063122.20957-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'c' is not in wrapped in parentheses in the to_pic32_sport() macro, so
it might be problematic wrt macro expansion. Using an inline is always
safer in these cases. Both type-wise and macro-expansion-wise. So switch
the macro to an inline.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pic32_uart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 32a86b12f203..c3b4fd0b5b76 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -72,7 +72,11 @@ struct pic32_sport {
 
 	struct device *dev;
 };
-#define to_pic32_sport(c) container_of(c, struct pic32_sport, port)
+
+static inline struct pic32_sport *to_pic32_sport(struct uart_port *port)
+{
+	return container_of(port, struct pic32_sport, port);
+}
 
 static inline void pic32_uart_writel(struct pic32_sport *sport,
 					u32 reg, u32 val)
-- 
2.36.0

