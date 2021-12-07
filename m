Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDE46C754
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhLGWVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhLGWVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:21:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440AC061574;
        Tue,  7 Dec 2021 14:18:19 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id j11so346495pgs.2;
        Tue, 07 Dec 2021 14:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OLslRKYs3DoB0QbfX4PRYRIKyCinBx1NgHO/uw8ZVw=;
        b=dymXRFQ6A00bVEIuvR7GYzuvZs4/X2covxGGnHpmuyqb5eJ/pj7rJlfj3lv3O5xhBJ
         VfZmrdTtuUIpdOJbhquxnVVGLUqE5IwJtfpwUz3ybZRx5slp+FRFfGuwX4dvj2zqVxpA
         zWGBRYC4z50ZcCpKYEE6cWvvT9uadqwuJ35/fKjiPlu480rKNg6yuZLXl0JANr1s8yVH
         zm2eIR1BldsFMYqECF7Ayo/uhJec+6KbcYMsQmaLFhNwzaC10ChWXYQr6rAM22fCMdXT
         kqBhx2qRUx8wkQtwwU4jzHA44a4ngFyroMFjfq/6mh3pdCQhi67Ok3U4iyViKWX96ahY
         eD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OLslRKYs3DoB0QbfX4PRYRIKyCinBx1NgHO/uw8ZVw=;
        b=W2Oj18b/dijhUHd0TwcfPi0ysYezcaQTdQ7cibmQhpkywsPV5/vY0V8QQvdIgodetF
         YtHx4NyetJg+EBk0DUbRP23eItoWjM2y1kMVLwlbq8aX5GcbiM8SqIU/gsuDDYt1ZUE7
         TMleQqiVXMybzhyt4AevjDa9wFA5blK8aT3M0w+kkJ5/L7E2u/QJ5IKquH7dy/kuQyJp
         0xWCq5Emn5no+pffltaR2zzqUopWAeWVetlou8mBDwCw6FUbMKGEeDR47q71wQH1aQxx
         Y3OJcl9AzqjMvxTX3OJ+C79wbl/fOmId+h+jB02qrFm4OOMFshvu6ltZa7JjdNaS9qhG
         XVkg==
X-Gm-Message-State: AOAM533554Ux3FEf0BwfWIIlX5QwVWzxf/yqIn3JCb8F1YxnX42k3dk4
        Aqtz1wM9haRm2OhZBrOLO7M=
X-Google-Smtp-Source: ABdhPJy8pEh7udQe8vFhOWAhI8Wo0P7fZi40t67T4notOuuNlQ6quLbxfQZB7FouKWrILssSlMQlwQ==
X-Received: by 2002:a05:6a00:b83:b0:49f:b555:1183 with SMTP id g3-20020a056a000b8300b0049fb5551183mr2042539pfj.32.1638915498838;
        Tue, 07 Dec 2021 14:18:18 -0800 (PST)
Received: from localhost.localdomain ([103.85.9.78])
        by smtp.gmail.com with ESMTPSA id y130sm697832pfg.202.2021.12.07.14.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:18:17 -0800 (PST)
From:   Vihas Mak <makvihas@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vihas Mak <makvihas@gmail.com>
Subject: [PATCH] tty: serial: return appropriate error on failure
Date:   Wed,  8 Dec 2021 03:47:41 +0530
Message-Id: <20211207221741.50422-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when a user with CAP_SYS_ADMIN disabled calls ioctl (TIOCSSERIAL),
uart_set_info() returns 0 instead of -EPERM and the user remains unware
about what went wrong. Fix this.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215205

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 61e3dd022..c204bdecc 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -960,7 +960,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		uport->fifosize = new_info->xmit_fifo_size;
 
  check_and_exit:
-	retval = 0;
+	retval = retval < 0 ? retval : 0;
 	if (uport->type == PORT_UNKNOWN)
 		goto exit;
 	if (tty_port_initialized(port)) {
-- 
2.30.2

