Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724604E5F22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348415AbiCXHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiCXHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:12:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D950985A5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:11:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dr20so7270607ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0TKyRRyasBlRl7/S8dZGTjcoSJS62R91ivStapMPWY=;
        b=EllCSYlG1r+Ax169Is9zyo8MY3QlyQf8CLMF1RgC0Ht/rQN/5ThZ/m/yoHj1xst9zz
         eXdKEC8LXFTR4mV5whqje7ZHLNpiNMsYWEsi5esT6jlnF7vCLbohVbUCtQHMO58ND/l8
         E8d8izGVHM4ipCcuIu6DfaxVmFL2Vl9mvzzXL9WB6P39BktDTEt3IWV/uaQNNbY/LUbv
         5oGSWToEAckJhYlAmZl42SzDFyIfjsf4IlD5hUdQdXZXV+SACp74CbtqV+fXKFyzjgO5
         7WBhiebIGcw2xLm1YonXPx3cJC3oZv+kQdqK8JoFamtGfoU/bc8QCKB2fp8IJv52rQLa
         Z0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0TKyRRyasBlRl7/S8dZGTjcoSJS62R91ivStapMPWY=;
        b=15kjz9Y7iSzs215M4BD/SFIE1X/YlH6aKuVxzIczJS2kuw849AURa4qc5cw/EGsweM
         bmR3ljjJJ0nUjYAamBPUrmnLaooyktLmnNo14JqMY+iCtNqKwy8tKVIgKfWn9nTZLuBL
         Iy5mok3nl+Onl89KLxXOfEW/kM7uSs7+IcqXG6iv2ptBRHxkAqWio9FEdPN0u53swBsr
         OYPewg59+2N4u6sxtrOI65g3d0CPG/O4kzvIlTg9e+0fp3bil1TH2BVIue4virGULlEx
         FXJ+Fyy04eAGHgEJBcAmsMJ7Lw00eescF1Pov+POuop0vEB5h/tShaIypVhS/z8dOkdm
         A4GA==
X-Gm-Message-State: AOAM533dZRf3txr8Xj9QdGavI1nsZBXhHDe+TdCLOO+I0EIpctUHHazq
        ZC0K5e6T6IME64iytWbUQXc=
X-Google-Smtp-Source: ABdhPJzI0rSinnIvcZhWT0K6K5CxfNcQqamxoPm3FxEoeXOz4JhA9qzn79ORAUp7A38b6Gmy30dEhQ==
X-Received: by 2002:a17:907:c018:b0:6df:fb9b:e6f8 with SMTP id ss24-20020a170907c01800b006dffb9be6f8mr4026860ejc.495.1648105870759;
        Thu, 24 Mar 2022 00:11:10 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id di6-20020a170906730600b006df8831ec5asm769937ejc.114.2022.03.24.00.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:11:10 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Ohad Sharabi <osharabi@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] habanalabs: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:10:48 +0100
Message-Id: <20220324071048.59659-1-jakobkoschel@gmail.com>
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
 drivers/misc/habanalabs/common/command_submission.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 0a4ef13d9ac4..4927749e439c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -405,8 +405,7 @@ static void staged_cs_put(struct hl_device *hdev, struct hl_cs *cs)
 
 static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
 {
-	bool next_entry_found = false;
-	struct hl_cs *next, *first_cs;
+	struct hl_cs *next = NULL, *iter, *first_cs;
 
 	if (!cs_needs_timeout(cs))
 		return;
@@ -441,13 +440,13 @@ static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
 	spin_lock(&hdev->cs_mirror_lock);
 
 	/* queue TDR for next CS */
-	list_for_each_entry(next, &hdev->cs_mirror_list, mirror_node)
-		if (cs_needs_timeout(next)) {
-			next_entry_found = true;
+	list_for_each_entry(iter, &hdev->cs_mirror_list, mirror_node)
+		if (cs_needs_timeout(iter)) {
+			next = iter;
 			break;
 		}
 
-	if (next_entry_found && !next->tdr_active) {
+	if (next && !next->tdr_active) {
 		next->tdr_active = true;
 		schedule_delayed_work(&next->work_tdr, next->timeout_jiffies);
 	}

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

