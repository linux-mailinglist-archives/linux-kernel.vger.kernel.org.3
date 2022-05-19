Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8D52CDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiESH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiESH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:56:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198637A14;
        Thu, 19 May 2022 00:56:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4056A1F922;
        Thu, 19 May 2022 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652947014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvhlCqMgMMqPTQI307mBlnv9mUG/0UToOCB3paXTgc4=;
        b=A5BdEhVfB5dRtt5UtguiegnKZWBUkRFEBn0Zi82HS+mOBDnGoGQfdE4721w4mShBo6IXba
        DWd2+M/jYePWQ07wAUepGGmi2/4FbJWIKytUPfvM23TouT5CcVEldPbfJkGGYz3WnuH+Ci
        sViIxJIgxpLVgUOTo0DL8kVU2HWzRtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652947014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvhlCqMgMMqPTQI307mBlnv9mUG/0UToOCB3paXTgc4=;
        b=CNjTjRylL0oWvo/aunp938eQMv/Q7WYjEOWvjo7bHIQbJdG7t7TMXz+wNKLEov8GWF9Vya
        COuJxTVz0zB5MQCw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 04D5D2C142;
        Thu, 19 May 2022 07:56:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/4] serial: pmac_zilog: remove unused uart_pmac_port::termios_cache
Date:   Thu, 19 May 2022 09:56:51 +0200
Message-Id: <20220519075653.31356-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519075653.31356-1-jslaby@suse.cz>
References: <20220519075653.31356-1-jslaby@suse.cz>
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

struct uart_pmac_port contains termios_cache. It is only written and
never read. Remove it as it only occupies space.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pmac_zilog.c | 2 --
 drivers/tty/serial/pmac_zilog.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 2953ff64a892..9a2150bf477a 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1231,8 +1231,6 @@ static void __pmz_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	pmz_debug("pmz: set_termios()\n");
 
-	memcpy(&uap->termios_cache, termios, sizeof(struct ktermios));
-
 	/* XXX Check which revs of machines actually allow 1 and 4Mb speeds
 	 * on the IR dongle. Note that the IRTTY driver currently doesn't know
 	 * about the FIR mode and high speed modes. So these are unused. For
diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
index 87337b748d6d..837b97ca0a90 100644
--- a/drivers/tty/serial/pmac_zilog.h
+++ b/drivers/tty/serial/pmac_zilog.h
@@ -55,8 +55,6 @@ struct uart_pmac_port {
 	volatile u8			__iomem *data_reg;
 
 	unsigned char			irq_name[8];
-
-	struct ktermios			termios_cache;
 };
 
 #define to_pmz(p) ((struct uart_pmac_port *)(p))
-- 
2.36.1

