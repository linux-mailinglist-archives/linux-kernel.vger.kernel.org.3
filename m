Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CBC509D67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388333AbiDUKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388124AbiDUKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:20:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC622B12;
        Thu, 21 Apr 2022 03:17:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4BB201F755;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650536230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NF+UmkqumeY0pckDNhK2uWzgueOaF+BJbbY4k3pIt1k=;
        b=jykvhSaXeT7d/16BWZwwf8Hy93G+2JZ20H3coVDtYZ5mXH1xNrgle4PBNWzr2wM6GDBxx3
        reOsbbTbWPhr9SZKtxTYFUCO+v3RvyqZg9FpM1TlxIbqNxQIm58ucZpScJGx5vzWR1RGJL
        AWZTgpWaG6FMTRBp7v88tDKih/+tO4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650536230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NF+UmkqumeY0pckDNhK2uWzgueOaF+BJbbY4k3pIt1k=;
        b=r8KEOduRgvrxhQRRDK32mMYaxb3BWijDb/FVb3KuYn676AstyrmI4celzE5YZBve/PUgR6
        y9ECwomqls6s7ZBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A47A2C142;
        Thu, 21 Apr 2022 10:17:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/7] serial: zs: use NULL as a pointer, not 0
Date:   Thu, 21 Apr 2022 12:17:05 +0200
Message-Id: <20220421101708.5640-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421101708.5640-1-jslaby@suse.cz>
References: <20220421101708.5640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct uart_port::membase is declared as a pointer. So it should be
initialized by NULL, not zero constant.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/zs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 70969bf9d82c..5bc58591665a 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -981,7 +981,7 @@ static const char *zs_type(struct uart_port *uport)
 static void zs_release_port(struct uart_port *uport)
 {
 	iounmap(uport->membase);
-	uport->membase = 0;
+	uport->membase = NULL;
 	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
 }
 
-- 
2.36.0

