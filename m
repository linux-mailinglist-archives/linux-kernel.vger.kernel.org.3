Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6453FC74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiFGKyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D161F68A3;
        Tue,  7 Jun 2022 03:49:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF41121B93;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxfDBAgi69FElAJX6xHFHK0QPcV+HFrww8/3OsIBWws=;
        b=Z4c+8OHvothVmvfxoFSDrr2RUl53zgBADzkttHeEqCQVD9ASCh7h/5VrdZcGEk0+OZXfbR
        k1EYsYy5V2AvQftpAifI2XYkVy+1DAiSU4h64os9h56+ligqHUD1AlzfEWQqmtZR9w7bQR
        LnlHxa54V7V2C1WPyfdLcbX71urBneE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxfDBAgi69FElAJX6xHFHK0QPcV+HFrww8/3OsIBWws=;
        b=Vb1TKNBJsdej5vIOcecPdYpThyfgyrBPdv+tRx9cjk/D7YNY9BBtaMDI5V4YaMNExmlDKD
        iKqCchpOxgSCeCCg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97A2F2C142;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 35/36] tty/vt: consolemap: use con_allocate_new() in con_unshare_unimap()
Date:   Tue,  7 Jun 2022 12:49:45 +0200
Message-Id: <20220607104946.18710-35-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607104946.18710-1-jslaby@suse.cz>
References: <20220607104946.18710-1-jslaby@suse.cz>
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

The old->refcount is guaranteed to be > 1, so we can directly call
con_allocate_new() to make the code more obvious.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 14d3fbff015c..f97f7ee6268b 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -580,14 +580,10 @@ static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
 	int ret;
 	u16 uni = 0;
 
-	ret = con_do_clear_unimap(vc);
+	ret = con_allocate_new(vc);
 	if (ret)
 		return ERR_PTR(ret);
 
-	/*
-	 * Since refcount was > 1, con_clear_unimap() allocated a new
-	 * uni_pagedict for this vc.  Re: old != new
-	 */
 	new = *vc->vc_uni_pagedir_loc;
 
 	/*
-- 
2.36.1

