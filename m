Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3354ACDA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353174AbiFNJGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbiFNJFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:05:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8076A3D48F;
        Tue, 14 Jun 2022 02:05:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4042D1F94F;
        Tue, 14 Jun 2022 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655197542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZZHmjhrJiQpv4SvnpRP8nBUz+8q+DKt4Vtv5xSIPMY=;
        b=W9DumSvj+Oi7kOJvwgG6i/KNHWwXVedD2tbZyLE18z5VAny6CxgQ61tXiCszHFlc+6sVDJ
        CmTPKn7AuFkkb6RZEEPBKann4kJ8pVLqzoNi4KD6gdoTOuto8N/wOiIjr9BDTiUqrROrzM
        gcjNWfGAcATzYiGJDsMBf/sQ1M3D4gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655197542;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZZHmjhrJiQpv4SvnpRP8nBUz+8q+DKt4Vtv5xSIPMY=;
        b=Upk70MvuG5Mj50kTe4qNTzNHKANEVpoyb4YpqOmWXByc72dEAW+Cnpqmxecy2TQIcm8gy7
        Msg6+Gj69HzzwSBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D6092C141;
        Tue, 14 Jun 2022 09:05:42 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 8/8] tty/vt: consolemap: use E_TABSZ for the translations size
Date:   Tue, 14 Jun 2022 11:05:37 +0200
Message-Id: <20220614090537.15557-8-jslaby@suse.cz>
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

The code expects "translations" to have 256 (E_TABSZ) values. Use the
macro instead of the constant to be explicit about this.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v2]
    - this is new in this series

 drivers/tty/vt/consolemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5f3e58165b98..f02d21e2a96e 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -38,7 +38,7 @@
 #include <linux/vt_kern.h>
 #include <linux/string.h>
 
-static unsigned short translations[][256] = {
+static unsigned short translations[][E_TABSZ] = {
   /* 8-bit Latin-1 mapped to Unicode -- trivial mapping */
   [LAT1_MAP] = {
     0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
-- 
2.36.1

