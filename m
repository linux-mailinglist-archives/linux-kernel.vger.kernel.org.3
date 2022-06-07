Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB69853FC6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbiFGKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269CF5D30;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D48B61F956;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ylR8gEPv9+sbmm8xmTf7sNjlAWN+CDbPDj3WUo/8Yw=;
        b=EKpxbYu3qEIyx8gNYstl4FecfjhZ3lBWR/GoBNQdRyfNqTcvFQFM8qvg2UGOFutiuBfaF5
        7n/rYBb779YiKMjNg1xhEsU06pTT1tBEl/X/LU7BPv7JWicRnP3XbQqWHVgNDMq2j7bDvB
        PfrVOVL3fGfe8BYtOKoU/aRhEHqUycI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ylR8gEPv9+sbmm8xmTf7sNjlAWN+CDbPDj3WUo/8Yw=;
        b=b+fPPXvpD36YG/goYeExAj8Kui0ElJlK7AweXOcRHdzc38KqwC/gG9A8u1iKyYdE0eo8Ya
        vb8FkZWE22uNTzAw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC6F62C143;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/36] tty/vt: consolemap: check put_user() in con_get_unimap()
Date:   Tue,  7 Jun 2022 12:49:26 +0200
Message-Id: <20220607104946.18710-16-jslaby@suse.cz>
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

Only the return value of copy_to_user() is checked in con_get_unimap().
Do the same for put_user() of the count too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 831450f2bfd1..92b5dddb00d9 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -813,7 +813,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
 	console_unlock();
 	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
 		ret = -EFAULT;
-	put_user(ect, uct);
+	if (put_user(ect, uct))
+		ret = -EFAULT;
 	kvfree(unilist);
 	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
 }
-- 
2.36.1

