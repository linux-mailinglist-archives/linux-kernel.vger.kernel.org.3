Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA553B52F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiFBIbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiFBIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:31:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1F138B70;
        Thu,  2 Jun 2022 01:31:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F7501F8FC;
        Thu,  2 Jun 2022 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654158689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10nDheyhogOFP2uFxXcHKhtZwoVGn9GsYK9dDFZMoaM=;
        b=HC7xUygIWp+T73nNV+0m1gBlgIBcBmJ7nzi3+ybZ7omLCV9HQUDXOdyvvk00JxLjeljH2V
        LvI2tlCHebSzeNgLUcOYe+8oKhh+yPilEphIw15ds2nFFMmNg8gOAchncDXX+ZsdMfZkBz
        I7HOlkJO+msX/eNH7M2qqbxMAy4I5ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654158689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10nDheyhogOFP2uFxXcHKhtZwoVGn9GsYK9dDFZMoaM=;
        b=ZFRJ0ioP6HjarEV646iDz8nnsmhYrf2itlS35bnb/81vxfbqymBjFmawCXBZe5qLYpaU4L
        VVu3VIJ2NuWCVlDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3B4412C142;
        Thu,  2 Jun 2022 08:31:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] tty/vt: Makefile, add --unicode for loadkeys invocation
Date:   Thu,  2 Jun 2022 10:31:28 +0200
Message-Id: <20220602083128.22540-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602083128.22540-1-jslaby@suse.cz>
References: <20220602083128.22540-1-jslaby@suse.cz>
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

For a long time, we generate unicode tables using loadkeys. So fix
Makefile to use that flag too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
index fe30ce512819..b3dfe9d5717e 100644
--- a/drivers/tty/vt/Makefile
+++ b/drivers/tty/vt/Makefile
@@ -30,6 +30,6 @@ $(obj)/defkeymap.o:  $(obj)/defkeymap.c
 ifdef GENERATE_KEYMAP
 
 $(obj)/defkeymap.c: $(obj)/%.c: $(src)/%.map
-	loadkeys --mktable $< > $@
+	loadkeys --mktable --unicode $< > $@
 
 endif
-- 
2.36.1

