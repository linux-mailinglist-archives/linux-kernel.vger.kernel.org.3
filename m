Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D44E449E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiCVRBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCVRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:01:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD83B56C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:59:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p8so18655027pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9V08emtzkrbxJ6gZRfNtyxL8tVY2bsKr9QgiiYp8F1g=;
        b=MO3NYGVPByTiBy2+caT//tCFb+hvOK08xo1jAuTUF33EejAobr7BvRG+9/M4w12p+1
         +rTRevwMA2wQ4w53L5osnmBY0lGe1kqo2KyqDJrq1pdYIM0Nf8mjHLv2S660ss78H9+u
         GuYFzsth8a+eLtHSqQhJZeGZx+4p+aN/Q2PzuA53G5VRUXYWN4vbNYGJOLAbRxXmOYwh
         jc+cFYt2P6Mx1tmwQ9BhkQKuTDYWsO0zu+jM2q/QP6PAvyPm2LgjNSaobY4j1bjigP68
         qubGWKzN6l4zFHtUs1C9n5vPxe086jug5Ra+0olSaTGL4WdJmLnK0rMQCi3gJ4croCjM
         n6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9V08emtzkrbxJ6gZRfNtyxL8tVY2bsKr9QgiiYp8F1g=;
        b=XEkbEevMtzUCo5dzk/hMVJ936t44Wd7phbi+bPZ2zkIVbV03CxXsHA6AFlo9uf7NVq
         eToF8skbn0hYEAMEAjOPs1MMSO1blbhOORepbnwwFeNl9seM03ri/jhb8w7kdwrWG6ra
         4xJ+uHcPV17JMfFSk779LvPtVEbxSW8755QQyWSL0BX2EEvjogQVy08uQRM893NZI6uz
         sQct3MnTjCZcKea6EVwbqYVsc1FZjvq4+z189RogAhtFlR4o2hsaguwyGfDOzoK2mMhH
         Vbkvc/hDdzusebYE0T0uEYSv8neg4UgYO6DlgT7I7d95C8hVzsWJ0nilD38juWYfbXeP
         KUbQ==
X-Gm-Message-State: AOAM532ALLW1qbcCwpv63h3INbX4yEHUofjyMsxnLbzaVGZAOZ24LpDB
        +NPkrfb61tOR8OCltYRMP9U=
X-Google-Smtp-Source: ABdhPJyhaDYG3ymG29ji1Jfzss4XHhdvXAGQw6HIUKzEmD6mGABwlUBwK5+knnyKfdv0NYePL04Zkw==
X-Received: by 2002:a63:5f4e:0:b0:382:3b02:a4a with SMTP id t75-20020a635f4e000000b003823b020a4amr16164246pgb.451.1647968379727;
        Tue, 22 Mar 2022 09:59:39 -0700 (PDT)
Received: from sc2-hs2-b1628.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 124-20020a621682000000b004f6a2e59a4dsm22416771pfw.121.2022.03.22.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 09:59:39 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH] vmw_balloon: Print errors on reset only once
Date:   Tue, 22 Mar 2022 17:00:52 +0000
Message-Id: <20220322170052.6351-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The VMware balloon might be reset multiple times during execution. Print
errors only once to avoid filling the log unnecessarily.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index f1d8ba6d4857..086ce77d9074 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1452,10 +1452,10 @@ static void vmballoon_reset(struct vmballoon *b)
 
 	error = vmballoon_vmci_init(b);
 	if (error)
-		pr_err("failed to initialize vmci doorbell\n");
+		pr_err_once("failed to initialize vmci doorbell\n");
 
 	if (vmballoon_send_guest_id(b))
-		pr_err("failed to send guest ID to the host\n");
+		pr_err_once("failed to send guest ID to the host\n");
 
 unlock:
 	up_write(&b->conf_sem);
-- 
2.25.1

