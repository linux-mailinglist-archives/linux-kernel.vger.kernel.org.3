Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EBA4636CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbhK3Oha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbhK3Oh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:37:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73907C061748;
        Tue, 30 Nov 2021 06:34:08 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so17374547pjb.4;
        Tue, 30 Nov 2021 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nI09cHf/+y4lo36dgdKC6tVwpfKRfVYZgz3UvdRv02o=;
        b=RdM3IT6RS86lIYyvU6h8yyWp1NpIVs/EpG/1iqov7qgHkRVArVMBTidNBUscrNeRdZ
         rLBoOjJ+ZNKsZufC/oVS+seA1iIRIHJq4vX9FuXehH2fe4rykc4zhesvBa3v+XPOTgwd
         r2+DEdtpqZ4RhsuakbSorAAa7rCW8jPFj/CNthn46CJxO1MC3utX+DVPJf0EfqxsE+Lr
         t3R7RyKsRWPlkG6T1nKjtOR0T29laSKvEp6vLWu+MeSgeY8G+X5l9I9xlU9Wj37mJUgm
         FTq3wj7dEeQnz+3LLeqr72Qo/MYMZ2xQdt4FBt6g8RO9zpZEKUzGtqwwY2vPLRgleyNU
         XXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nI09cHf/+y4lo36dgdKC6tVwpfKRfVYZgz3UvdRv02o=;
        b=VpoBRrjX5bMUl+B24j8ll4tw3jR1asBXvDRlcVWeImlLaE+zyqJnxml+iys0aOK4Qq
         DpKPHrmu5h5bvCn7Qhr5yIqiP3cmEgUaGUpoTk7AYRh13oBVm6bYN9BFq5uTIyAVQaoB
         Qo2ak2teIUyP+gjDx6Cer8vZXWl+qrDBHTVSNrQqead4NuR0GLLblS4bSZ1ZfjZJfN5q
         K0Wa/XprnboTAnp+0Gr3YecQgGImNAuJwouOXcV3XwqYIrQZRR97B3vU1m0TqzTUbrqd
         Jjle5H9GRd73WBQa+0GqYZigjnwer+vLPoHMDv3J2t/eZKlhrGSG8srzzNpUn1f7jNmy
         uJGA==
X-Gm-Message-State: AOAM5337noOlEQSy8pvdxoPKbXtsbvsG4qhf0W9G1olVNyFQo6coXQDw
        2nhpP+puxGgWnL5Zq69TIIAOf7rNHdsp3A==
X-Google-Smtp-Source: ABdhPJytUUdFxvd6jbvUOLc0ssw+FLHvfAgdhioOinyUHPm/lyN1IcU8+4FoFdnk3D/v+sMlRf8auw==
X-Received: by 2002:a17:903:2093:b0:142:7dff:f7de with SMTP id d19-20020a170903209300b001427dfff7demr68979059plc.75.1638282847912;
        Tue, 30 Nov 2021 06:34:07 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.4])
        by smtp.gmail.com with ESMTPSA id g9sm22811975pfc.182.2021.11.30.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:34:07 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Al Cooper <alcooperx@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: bdc: fix error handling code in bdc_resume
Date:   Tue, 30 Nov 2021 22:33:53 +0800
Message-Id: <20211130143354.1820111-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bdc_reinit in bdc_resume fails, it forgets to deallocate the
bdc->clk.

Fix this by adding clk_disable_unprepare(bdc->clk).

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index fa1a3908ec3b..9849e0c86e23 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -623,6 +623,7 @@ static int bdc_resume(struct device *dev)
 	ret = bdc_reinit(bdc);
 	if (ret) {
 		dev_err(bdc->dev, "err in bdc reinit\n");
+		clk_disable_unprepare(bdc->clk);
 		return ret;
 	}
 
-- 
2.25.1

