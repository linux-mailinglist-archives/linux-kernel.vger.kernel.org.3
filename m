Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38154ACDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352804AbiFNJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiFNJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:05:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2A63E5F5;
        Tue, 14 Jun 2022 02:05:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 06F5921AF6;
        Tue, 14 Jun 2022 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655197542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aJUUWhtSMEqiKUiJXbZqYTMlQNrO13UAYQJXLB/zTQ=;
        b=mQalSBD8ti7+HqE6QvGbZyNwm/6JbR7tR1T472mmQnVmDE/p6HnHeo48lejuQDVnTisN3k
        Izq+G2QB1RGnRsYR6FThH/XyzHmHgj+qIhiGC5BcvmaHY6dJP6eqNWz6ou+DM9UYXZeY4T
        Wg3W7Tr9et1sOuXMfvcvW4TkqJxM230=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655197542;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aJUUWhtSMEqiKUiJXbZqYTMlQNrO13UAYQJXLB/zTQ=;
        b=zbo62cHPxH7GlTz6N3kb1h+EZxxtPYqdvzFvUSPXJZ+3wLTc2qJWAPZpY2c5kO6FJmkqQd
        05rV4U2w2yoHpjBw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CA19E2C142;
        Tue, 14 Jun 2022 09:05:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 7/8] tty/vt: consolemap: remove dflt reset from con_do_clear_unimap()
Date:   Tue, 14 Jun 2022 11:05:36 +0200
Message-Id: <20220614090537.15557-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614090537.15557-1-jslaby@suse.cz>
References: <20220614075713.32767-1-jslaby@suse.cz>
 <20220614090537.15557-1-jslaby@suse.cz>
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

con_do_clear_unimap() sets dflt to NULL and then calls
con_release_unimap() which does the very same as the first thing. So
remove the former as it is apparently superfluous.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 9e94ec0e0f83..5f3e58165b98 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -563,8 +563,6 @@ static int con_do_clear_unimap(struct vc_data *vc)
 	if (!old || old->refcount > 1)
 		return con_allocate_new(vc);
 
-	if (old == dflt)
-		dflt = NULL;
 	old->sum = 0;
 	con_release_unimap(old);
 
-- 
2.36.1

