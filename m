Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B834509B80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387081AbiDUJBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387044AbiDUJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB620F75;
        Thu, 21 Apr 2022 01:58:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 531A51F756;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFxqjeU4CQ4uodGfjKZsgd+CH+jRLDKSG+EoVC8vwu0=;
        b=zCw/LQSI7nDAbRxTq3+Vlb9iIKEaWzDzk4vMdVrmRJCbOFN7UliYEhznxCFuaj9gVBjMYE
        Ln73FqhEqQ2Ht01cp88rchsXc0jfeq0kN7sL8CiN4d2fvX5B8eUF1iYSmhDabqNzR18RwK
        uGQVnx/hktbViMgzP2os7xxfmZIDUSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFxqjeU4CQ4uodGfjKZsgd+CH+jRLDKSG+EoVC8vwu0=;
        b=nVp7WomM9liDQ+S0ZfPyz26U7FbwsF3ULDI3d7lZO1jmyEAsyaP/4r+1V2rriOuXkCkpCa
        /aqS1+xtRJbkP1AA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2ACA92C145;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/10] serial: icom: remove to_icom_adapter() and icom_kref_release()
Date:   Thu, 21 Apr 2022 10:58:01 +0200
Message-Id: <20220421085808.24152-4-jslaby@suse.cz>
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

Integrate both the to_icom_adapter() macro and icom_kref_release()
wrapper into icom_remove_adapter(). (And keep it icom_kref_release()
name.)

It makes the code easier to follow without complex indirections.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 42ba953c697e..fa284f9cbdb0 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -47,7 +47,6 @@
 
 #define ICOM_DRIVER_NAME "icom"
 #define NR_PORTS	       128
-#define to_icom_adapter(d) container_of(d, struct icom_adapter, kref)
 
 static inline struct icom_port *to_icom_port(struct uart_port *port)
 {
@@ -1447,8 +1446,10 @@ static void icom_free_adapter(struct icom_adapter *icom_adapter)
 	kfree(icom_adapter);
 }
 
-static void icom_remove_adapter(struct icom_adapter *icom_adapter)
+static void icom_kref_release(struct kref *kref)
 {
+	struct icom_adapter *icom_adapter = container_of(kref,
+			struct icom_adapter, kref);
 	struct icom_port *icom_port;
 	int index;
 
@@ -1481,14 +1482,6 @@ static void icom_remove_adapter(struct icom_adapter *icom_adapter)
 	icom_free_adapter(icom_adapter);
 }
 
-static void icom_kref_release(struct kref *kref)
-{
-	struct icom_adapter *icom_adapter;
-
-	icom_adapter = to_icom_adapter(kref);
-	icom_remove_adapter(icom_adapter);
-}
-
 static int icom_probe(struct pci_dev *dev,
 				const struct pci_device_id *ent)
 {
-- 
2.36.0

