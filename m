Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F74E5F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348467AbiCXHWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiCXHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:22:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B85A09F;
        Thu, 24 Mar 2022 00:20:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qa43so7265361ejc.12;
        Thu, 24 Mar 2022 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ30SALDCdF6ve1jmx8o4UeGTC9W1dlBNNl9mV+QfPY=;
        b=d9eKEqeBGQjuStvECA/Izr927dwj0JKnWImmODXq196m7snXz/5gmKmzjlyLT7PP++
         gZ0E5eA2KjHlqmgyA2u+VfOx38B6rl8G8Fxj8TEfMXGTQDL2ohIHGdX3bKESfod/sBdz
         Q6uA7IWNYGi765VMr4JopZUUf4RaxrnfZBi9zIrChfYIxBT3CSe742dMXej+BvUSB2xh
         sloc/H71kMmQqn24YX7kZgpO0wKoM501xH2Xk8nsKYp30iNoP3oFahrC2po9lUEX7AuL
         z4kddmMVY3upaYkbnLmcM1C5Uxdql5HYc5yVsjsgNBKAlNBhvmJ5jefo0f1NmpsRHNHY
         371Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ30SALDCdF6ve1jmx8o4UeGTC9W1dlBNNl9mV+QfPY=;
        b=MB+cfmBgxqVUk1ZK06NbSv0cPk0ikwQaTk4GsRoj2AR4RIFWVA2XUU972ndNVyw5pe
         PM7zsKDoOEwyKtDw0jROk0Rie6gvcLnzrth20R4LvA5zEOJg9MWGg0iHJNyX8WyNNZp6
         ZmeLWkKHtXmW0ZarDG7CMvpqtxtfpR9qBZzubB1vQ1A5VomgkQCGS/UQgxmHjW3NjfdG
         DbYnFODzq11db+ozOWThBJBoI4uxTyNPNZy7Mk6QdRdZbZOfhBGO3aP1JPt5KuwBMULL
         AS+OLEBYe0xJOpsHW8d7zV+9uvJ5mBpuOcrzvC+NOh/nfW9ucrnFPrHrmxptau7ZVUB9
         FrJQ==
X-Gm-Message-State: AOAM532uuAtmYYRDSOkrenR4HcLkYqjL7WofmBKrX2OuGOKklXbwrgqn
        jyGqJHkLozeD41enKZmlJek=
X-Google-Smtp-Source: ABdhPJx3JQ8gNE82asV1UbXAVUZNjIRCfJZ5V6bEHEK69fbvEF3AxeZ/p3Xr/hj8zaWnmwA/hKvHqg==
X-Received: by 2002:a17:906:174f:b0:6d0:5629:e4be with SMTP id d15-20020a170906174f00b006d05629e4bemr4152151eje.525.1648106439694;
        Thu, 24 Mar 2022 00:20:39 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id l4-20020aa7c304000000b004192b7825a2sm956913edq.12.2022.03.24.00.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:20:39 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] platform/x86: wmi: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:20:15 +0100
Message-Id: <20220324072015.62063-1-jakobkoschel@gmail.com>
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
 drivers/platform/x86/wmi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 58a23a9adbef..aed293b5af81 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1308,21 +1308,20 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
 static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 				    void *context)
 {
-	struct wmi_block *wblock;
-	bool found_it = false;
+	struct wmi_block *wblock = NULL, *iter;
 
-	list_for_each_entry(wblock, &wmi_block_list, list) {
-		struct guid_block *block = &wblock->gblock;
+	list_for_each_entry(iter, &wmi_block_list, list) {
+		struct guid_block *block = &iter->gblock;
 
-		if (wblock->acpi_device->handle == handle &&
+		if (iter->acpi_device->handle == handle &&
 		    (block->flags & ACPI_WMI_EVENT) &&
 		    (block->notify_id == event)) {
-			found_it = true;
+			wblock = iter;
 			break;
 		}
 	}
 
-	if (!found_it)
+	if (!wblock)
 		return;
 
 	/* If a driver is bound, then notify the driver. */

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

