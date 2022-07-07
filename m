Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B7569D68
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiGGI0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiGGI0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:26:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3BED71;
        Thu,  7 Jul 2022 01:26:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 219342213F;
        Thu,  7 Jul 2022 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657182359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pYwmRRg7eGUVB9X6ETHvQJVSYSeBW9rbFkpr5PWBwpw=;
        b=a1p1U5swMwJtFSIUvTUuSO1x+1vQpSecRO2PFWL9247nh5WXprYdlam8guhhQ7vVc7SI8B
        6BtDBsLKb5CcUoZNz/AVE+UAKGscjL5ZCHgZVNJLCFkVYignBptU1IOIIIFafR2f60wgEy
        LDQMg9nrLsRh0JefH2LPTaQNTQJ2P+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657182359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pYwmRRg7eGUVB9X6ETHvQJVSYSeBW9rbFkpr5PWBwpw=;
        b=P62H+CS1g00JjMXvwcUMJ3qUm6Bsp2FiDsdvNQ3EHngHfdlWw/C9IiivCanbGurdcZlo0G
        4Lv4S0ab/agWr0DQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC6052C141;
        Thu,  7 Jul 2022 08:25:58 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Hillf Danton <hdanton@sina.com>,
        =?UTF-8?q?=E4=B8=80=E5=8F=AA=E7=8B=97?= <chennbnbnb@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] tty: extract tty_flip_buffer_commit() from tty_flip_buffer_push()
Date:   Thu,  7 Jul 2022 10:25:57 +0200
Message-Id: <20220707082558.9250-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We will need this new helper in the next patch.

Cc: Hillf Danton <hdanton@sina.com>
Cc: 一只狗 <chennbnbnb@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_buffer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 754fa43670cc..ea630ceda009 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -573,6 +573,15 @@ static void flush_to_ldisc(struct work_struct *work)
 
 }
 
+static inline void tty_flip_buffer_commit(struct tty_buffer *tail)
+{
+	/*
+	 * Paired w/ acquire in flush_to_ldisc(); ensures flush_to_ldisc() sees
+	 * buffer data.
+	 */
+	smp_store_release(&tail->commit, tail->used);
+}
+
 /**
  * tty_flip_buffer_push		-	push terminal buffers
  * @port: tty port to push
@@ -587,11 +596,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
 
-	/*
-	 * Paired w/ acquire in flush_to_ldisc(); ensures flush_to_ldisc() sees
-	 * buffer data.
-	 */
-	smp_store_release(&buf->tail->commit, buf->tail->used);
+	tty_flip_buffer_commit(buf->tail);
 	queue_work(system_unbound_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
-- 
2.36.1

