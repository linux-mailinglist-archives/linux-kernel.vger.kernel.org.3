Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978DE47E3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbhLWMxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348321AbhLWMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:53:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51193C061401;
        Thu, 23 Dec 2021 04:53:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q14so13449924edi.3;
        Thu, 23 Dec 2021 04:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5IhcIiQyVUKu9L30Vg5+RpyU7OW/xb9Dw8MgAKsUEjk=;
        b=mwUBnMelq83wCnTnDoClQVq2L2qe26xnPznhGvDGH11V5/RF9FSrS9ipjHARyx4gZs
         wHQrtZCdlCxwg6ULpTBy/ovF/aVcLInz6axTCu48yprWzoMjISczJ7lA2EkAoMTUNEgI
         vmMsf/Yr9lvNFeTyhJya5x/7hmS8y5gm1IoTu0Eajz1lyDKj1y9GHgE67Ck2ilTivwoH
         nEmdPr/Ny3XSAM7JZ50b06Cg9iLgW5typ9TErvhY5GX/GzwxSTYFQeuU3z0cdhNsReyy
         xju5qQ5Qo9zzBSwA+VsvEvU4X8Kq5TgKHm47qZAPk7b76pWwuonTCTqooTcjqMl6078p
         9Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5IhcIiQyVUKu9L30Vg5+RpyU7OW/xb9Dw8MgAKsUEjk=;
        b=wF8wPktCGrl/H749NYhTC38jt6OaZE8juOq5RQ+tbukp9nPjlcFxw4zyxmGm0YBode
         vOuMl6yebAfWvL8ilhgbjJfnXnu7AcO430x0ctO/GKLHBf7YxUek8xMjydriwBGbak1C
         eQ8YNiMCiU+EiP5njTfaE0o4MSEq6Oo2rtL4uPfYuBtMhiiTiAk0O7l3o8m9U3vyf9xW
         BAfC1HIsHzX+Kouygagz9tXUub+ImsSHXYUEGW7i6TUFaTV3RDlTAH3+I74NG3YBYEg0
         uLhipWzmDFia/0JLAI9WtD7UiM1wNo0INqXJsm4k1RtWhjYMub9YnmjdLP+iogewi3zd
         mlXw==
X-Gm-Message-State: AOAM533jYMCewOZ1N2fKeoCdIgJkzf62kyY6bPSuZ13VoFGCRzHC97i+
        HvEpdob2Ax+gaacIT17Xk3o=
X-Google-Smtp-Source: ABdhPJxTMr/s3T6yhgpP4siJZageNjtMVxnC1LixKDvJXv7VwSEQjKmQCpp0A6bcOp/C6pG/gceXOg==
X-Received: by 2002:a17:906:af19:: with SMTP id lx25mr1832627ejb.338.1640263991848;
        Thu, 23 Dec 2021 04:53:11 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2606:5e00:3112:93fc:fc68:4d9e])
        by smtp.gmail.com with ESMTPSA id ho14sm1728852ejc.73.2021.12.23.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 04:53:11 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] block: drop needless assignment in set_task_ioprio()
Date:   Thu, 23 Dec 2021 13:53:00 +0100
Message-Id: <20211223125300.20691-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5fc11eebb4a9 ("block: open code create_task_io_context in
set_task_ioprio") introduces a needless assignment
'ioc = task->io_context', as the local variable ioc is not further
used before returning.

Even after the further fix, commit a957b61254a7 ("block: fix error in
handling dead task for ioprio setting"), the assignment still remains
needless.

Drop this needless assignment in set_task_ioprio().

This code smell was identified with 'make clang-analyzer'.

Fixes: 5fc11eebb4a9 ("block: open code create_task_io_context in set_task_ioprio")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 block/blk-ioc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 71c3a933cf16..11f49f78db32 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -284,12 +284,10 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 			kmem_cache_free(iocontext_cachep, ioc);
 			goto out;
 		}
-		if (task->io_context) {
+		if (task->io_context)
 			kmem_cache_free(iocontext_cachep, ioc);
-			ioc = task->io_context;
-		} else {
+		else
 			task->io_context = ioc;
-		}
 	}
 	task->io_context->ioprio = ioprio;
 out:
-- 
2.17.1

