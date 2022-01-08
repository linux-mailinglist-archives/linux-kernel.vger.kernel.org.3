Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFBA488428
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiAHPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:10:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbiAHPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641654601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U169cYgO0bm4HCQJMyoMslqnpI+Gi+7C/va2IkqTrGk=;
        b=TQwGlg6TmbMqkrtYjwgOxzSa4FX1pjk/TPLareW6KQrWwtX2KC98PG4JqRY6KifkLoS8lq
        Qmm/6u5nDSbMdlBptIg/yesC4xqi3HrqkCI3jm+Y5WV8/7BGx9s36fsg98iMyFPE/xZmRl
        KpeYQf8zPit26W8dxFvrXmG+qOR+4jU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-F1iTXCtOOzyY2Ppm2wExnw-1; Sat, 08 Jan 2022 10:10:00 -0500
X-MC-Unique: F1iTXCtOOzyY2Ppm2wExnw-1
Received: by mail-oi1-f200.google.com with SMTP id r65-20020aca4444000000b002bce52a8122so6264165oia.14
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 07:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U169cYgO0bm4HCQJMyoMslqnpI+Gi+7C/va2IkqTrGk=;
        b=2eqpalhr9LvxuAdSjv0ht2VduoRBRppGLhJXvy22lLRO4BusemOIzg93/kbwpuvgpl
         hBADI2WYqKD5qoxA3UYVSFyBjdvWmWis3rEu9uQ2Ug/3UwFpDYmWj162gVnh4SMDIANc
         FPojzYPSAwXgsteZawnIuyNA3ctQMQb4XC6F8uIlDtgKcmWcEHutAfc+DQbvJCdpdRDs
         7N+S9lpuo7slkrv60ys7bG6nZZO1G2Wv6XK1MeQVoU5TYHQ5iEdox6gUQc/dY2Mr3W8i
         jMFP0RELDzv+qpramstTQ/n/AsbR+jQZTeoojz4G57vlScEDlJSLsMxoCy3ANY+FjbD8
         OxDg==
X-Gm-Message-State: AOAM532IQg2NzzEi7nd4s5J+aUh1l4nF8/fiOKZAVpeh11Mkx88Q7MNa
        waBlJqPSZbyqDnE5NsabNIIEGlVptUZSGxQlwp325TQvQIGByrkRkJ8dlM0sAqZvyP6LuPApxok
        p9tNn0vLaDotOEuaGOPaahEY9
X-Received: by 2002:a9d:d67:: with SMTP id 94mr47473297oti.156.1641654599569;
        Sat, 08 Jan 2022 07:09:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRTLAixm2+kpq1Ek12ZorOxtE4fuJpDVvDT4q2xl3gRi5czVDxU4IDwGgLDNGQUDPeCsGqYg==
X-Received: by 2002:a9d:d67:: with SMTP id 94mr47473290oti.156.1641654599386;
        Sat, 08 Jan 2022 07:09:59 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c10sm371225ots.73.2022.01.08.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 07:09:58 -0800 (PST)
From:   trix@redhat.com
To:     vitor.soares@synopsys.com, alexandre.belloni@bootlin.com,
        nathan@kernel.org, ndesaulniers@google.com, bbrezillon@kernel.org
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] i3c: master: dw: check return of dw_i3c_master_get_free_pos()
Date:   Sat,  8 Jan 2022 07:09:48 -0800
Message-Id: <20220108150948.3988790-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
dw-i3c-master.c:799:9: warning: The result of the left shift is
  undefined because the left operand is negative
                      COMMAND_PORT_DEV_INDEX(pos) |
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~

pos can be negative because dw_i3c_master_get_free_pos() can return an
error.  So check for an error.

Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/i3c/master/dw-i3c-master.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 03a368da51b95..51a8608203de7 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -793,6 +793,10 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 		return -ENOMEM;
 
 	pos = dw_i3c_master_get_free_pos(master);
+	if (pos < 0) {
+		dw_i3c_master_free_xfer(xfer);
+		return pos;
+	}
 	cmd = &xfer->cmds[0];
 	cmd->cmd_hi = 0x1;
 	cmd->cmd_lo = COMMAND_PORT_DEV_COUNT(master->maxdevs - pos) |
-- 
2.26.3

