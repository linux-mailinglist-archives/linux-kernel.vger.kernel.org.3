Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398484E5F76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348626AbiCXHeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348694AbiCXHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:33:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5399EC1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:32:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id yy13so7371486ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwARqHfBcNG+A/ztBylRd5QKvLrPJk1MiaHSLHQF1Mw=;
        b=ouWHYKVwLTHfz+/RTaOKfR2owtH6GWGi6MOzNaazzvVoauGpw/6LkQjgoV5lGO7Vp3
         NZRorMZw8KXNfDPE81jkkUxJ7wsgW66fQ0+a9VLB2xgo5CErrcINwiqSRtXek7IsnFfM
         GSSqzBvbTOccq1hu9aUMCk5MQW7/TAQKelB2VBrvlbhUB24vhN7/xbm1IDkN88eqVPcp
         ZyrFLsucC0bMib9ptb1hZxMRtdPjqzWTxQRheutxQQhOL3zrT+x+fdpfLMqUyu6XQ3Kg
         HuW5NXgRmOyihg9HGFa9HGf1siZGSACS9hLJm+5+Y1oRMqnpL+/twD6uKOscehW3Tp+g
         Sq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwARqHfBcNG+A/ztBylRd5QKvLrPJk1MiaHSLHQF1Mw=;
        b=dC5r7zdCIf+S4lcxlAs2Lol3uymSQLwmvIZMO43L6/v3I7OyqopzuzHVneNfwwDuJV
         Gbg4BsXNRZErVmv/+2xLWF3HxLZhbvoO3BosyT+YwspUdeEGk/nLcBXQe/TU1qH/38iz
         b+CtizHlsJQWNdwav1lcNo9cSLWN8r3tTwsMy8zEIeMp70YHrc2CzeNlfCP7UB58OW57
         DVtS20J6Z9/oukBfiZuvKfrGmKx2ASFEDymcHDXSImADLTx2S660ecq+jsrfwRlQG5oK
         6lbYDORE97PTzL31yUhsICe9sbC9x/8amCTC55hjzDCRRynyi15D8iW2Vi6XglqkdBcy
         iD0g==
X-Gm-Message-State: AOAM533Js7Q6NJHUPMTZ2xeP/YzR9k8w7sUhKv7qI3Zz6hSrA/TRZC79
        MbY42QNv8yX6iZM1u4cUWqGBcpXJAXpxDskx
X-Google-Smtp-Source: ABdhPJxi8ZhUXWjM2W5iRG079QUt1B59geQlxGFjwNM9YfUhNuKa2fOk4OL3NZ38Q3mDIO7Dtu66XA==
X-Received: by 2002:a17:907:6d11:b0:6df:f38b:b698 with SMTP id sa17-20020a1709076d1100b006dff38bb698mr4268310ejc.711.1648107136033;
        Thu, 24 Mar 2022 00:32:16 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id m17-20020a17090672d100b006df98bb199dsm773047ejl.129.2022.03.24.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:32:15 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] misc: vmw_vmci: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:31:51 +0100
Message-Id: <20220324073151.66305-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_context.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 6cf3e21c7604..172696abce31 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -665,9 +665,8 @@ int vmci_ctx_add_notification(u32 context_id, u32 remote_cid)
 int vmci_ctx_remove_notification(u32 context_id, u32 remote_cid)
 {
 	struct vmci_ctx *context;
-	struct vmci_handle_list *notifier, *tmp;
+	struct vmci_handle_list *notifier = NULL, *iter, *tmp;
 	struct vmci_handle handle;
-	bool found = false;
 
 	context = vmci_ctx_get(context_id);
 	if (!context)
@@ -676,23 +675,23 @@ int vmci_ctx_remove_notification(u32 context_id, u32 remote_cid)
 	handle = vmci_make_handle(remote_cid, VMCI_EVENT_HANDLER);
 
 	spin_lock(&context->lock);
-	list_for_each_entry_safe(notifier, tmp,
+	list_for_each_entry_safe(iter, tmp,
 				 &context->notifier_list, node) {
-		if (vmci_handle_is_equal(notifier->handle, handle)) {
-			list_del_rcu(&notifier->node);
+		if (vmci_handle_is_equal(iter->handle, handle)) {
+			list_del_rcu(&iter->node);
 			context->n_notifiers--;
-			found = true;
+			notifier = iter;
 			break;
 		}
 	}
 	spin_unlock(&context->lock);
 
-	if (found)
+	if (notifier)
 		kvfree_rcu(notifier);
 
 	vmci_ctx_put(context);
 
-	return found ? VMCI_SUCCESS : VMCI_ERROR_NOT_FOUND;
+	return notifier ? VMCI_SUCCESS : VMCI_ERROR_NOT_FOUND;
 }
 
 static int vmci_ctx_get_chkpt_notifiers(struct vmci_ctx *context,

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

