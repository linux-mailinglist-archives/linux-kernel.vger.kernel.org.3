Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB92509BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387119AbiDUJBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387055AbiDUJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7C220F75;
        Thu, 21 Apr 2022 01:58:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 71AB52129B;
        Thu, 21 Apr 2022 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/9irgCCWI7KgQDtWmFEKD70fZ4JynU21uK/zUgv17s=;
        b=BZ4yImvZ+qTzxbwjenSkfkcQ9L7WRpr27wEm+DjJK/6fKOjEv3qDoDWZIjZ5W8fky83Lhu
        3LuDK/rnB7ANS6J3rw1ZgZmYY2s98CIASkzqAAggeIGuUJWJhlmOb/MIPXRGaKcE5KayJ6
        750S6O+dyX9YRYNz72Qy1SWOliD3aRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/9irgCCWI7KgQDtWmFEKD70fZ4JynU21uK/zUgv17s=;
        b=Z6Y2wW/uLWFCfZnozGoZxodFvjQN/9H6lSqPmRDYmBl5Q9rCb/9yY62DqDRQykVKkA4C0d
        Pz+XxN1SXaPyW7Dw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4046E2C149;
        Thu, 21 Apr 2022 08:58:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/10] serial: icom: make icom_acfg_baud const and unsigned
Date:   Thu, 21 Apr 2022 10:58:05 +0200
Message-Id: <20220421085808.24152-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421085808.24152-1-jslaby@suse.cz>
References: <20220421085808.24152-1-jslaby@suse.cz>
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

The baud rates are unsigned constants. So mark them as such.

Not only it makes sense, but they are passed also to
uart_get_baud_rate() and that expects unsigned int as baud rates on
input.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 34e716cadb28..85ecc7dfac72 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -47,7 +47,7 @@
 #define ICOM_DRIVER_NAME "icom"
 #define NR_PORTS	       128
 
-static int icom_acfg_baud[] = {
+static const unsigned int icom_acfg_baud[] = {
 	300,
 	600,
 	900,
-- 
2.36.0

