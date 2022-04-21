Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147D6509B95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387127AbiDUJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbiDUJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AD20F73;
        Thu, 21 Apr 2022 01:58:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2CA781F758;
        Thu, 21 Apr 2022 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79nd/iPdqLV+axSNwBVTh85Rla2fHQ9vKLGrQW44PTg=;
        b=Yk4lxSN+NcY7N+2Qf3gj0iQqaCoIIScfxO83IHKasaMkf0YDofrDmkg4QHI/dp0sWGoLsk
        FLL5NZchx6u8NhOMg/QOJekPMH3yIu0yBkoQ52+BjKQSTRXGhFY2GsslsURMPAPfrRyVcM
        ZT6ZwL06PcRP8GgyJEFypVGxhX7bRzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79nd/iPdqLV+axSNwBVTh85Rla2fHQ9vKLGrQW44PTg=;
        b=qG9Vd3kZEObHG/Zp5XnJk4c7Fki7kp5xxTur9sUDzLui75D6nhG0i31hRn8N6/JldSWZbq
        at0BayD8U/+m7/CA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F01332C141;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/10] serial: icom: use ARRAY_SIZE
Date:   Thu, 21 Apr 2022 10:58:04 +0200
Message-Id: <20220421085808.24152-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421085808.24152-1-jslaby@suse.cz>
References: <20220421085808.24152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 083c00aced07..34e716cadb28 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -47,7 +47,6 @@
 #define ICOM_DRIVER_NAME "icom"
 #define NR_PORTS	       128
 
-#define BAUD_TABLE_LIMIT	((sizeof(icom_acfg_baud)/sizeof(int)) - 1)
 static int icom_acfg_baud[] = {
 	300,
 	600,
@@ -71,6 +70,7 @@ static int icom_acfg_baud[] = {
 	307200,
 	460800,
 };
+#define BAUD_TABLE_LIMIT	(ARRAY_SIZE(icom_acfg_baud) - 1)
 
 struct icom_regs {
 	u32 control;		/* Adapter Control Register     */
-- 
2.36.0

