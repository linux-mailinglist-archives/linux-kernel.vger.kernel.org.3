Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473174A835D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350361AbiBCLyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350358AbiBCLyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:54:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B33C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:54:07 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z131so2050807pgz.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYksfqXaPV/dh2hqgLls7NY6zYw6qDongmSSBZKsfsc=;
        b=BjG3aUuaDcR15UUUbWnRHZMmAfImhR37OOfIAEbDVyEBG3bMLKPk0AMcZE709hkDmC
         wrCKej65+toxCE+wJdzgUF5XTyrA748FK9AxG2OmmfbOTDcv5Bhyzovi2BmsPUHYKRle
         ggzENsYakkmYRtuxOc1oxcGJDkIZJfXdRmjJM1/F0+G16m7/X3TuYo5cyWYFyIfduX4N
         /K0S7U+/BiohQf4LLkUZnMhwEfP3FkpZTn1JJe+lzi5wdvazzZf49aLs7CKPfH7tdI/4
         WtOUGysft1QKT8VES0RtPg0l9QTamPNmFOJ7a4zQ+5PTu441LZBfHrAIwyAa1sS9pV/0
         Zn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GYksfqXaPV/dh2hqgLls7NY6zYw6qDongmSSBZKsfsc=;
        b=QLHAT3l7Cl3CYCxn8C001RBypEiZN6odS9KKZoG/mh1njOtlZupTSxEEIq3XGvMX5G
         Z46iwnaFbtwBBOFC1MNqzOp6KykyLY4nJrR2RUucvOwU9rB22sN94fFRvqehz7s8Lgg2
         qm1XA4q7X0kh9dm+SAE9A6uU+JXt7fMtfmM45kB1x/jTdVPeGBzCUvmnjhOiKPTv1ty8
         IScoS3z6W3HVAIzgNr58Mq78g4gQcItaQ0/TWc6r7eMKLU5oSjq/SJEd7/P4Kwb2taxX
         nNbbg3yq+FN/z9mCMrzaMzQZZH15F8KFujaeBFoBM2/jKB2mx4+UHYNpYXL38nwVwD31
         AhIQ==
X-Gm-Message-State: AOAM533/LEAYbEzUgVWbn2c+xVhgvWn7NiVQdEzZPXop6UZ3MbxL8eKu
        MMzwz4VXeuIhXsa83ORQzM0=
X-Google-Smtp-Source: ABdhPJypXHtSz1IUsmMH9S/+owRsut30+8ayH1fpDzvTpQE50paUnOxndIO3XEwgBjUCoguuAArtmg==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr20235458pgd.8.1643889247028;
        Thu, 03 Feb 2022 03:54:07 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id mp22sm9586389pjb.28.2022.02.03.03.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 03:54:06 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 3/3] x86/setup: Populate bootinfo with secure boot status
Date:   Thu,  3 Feb 2022 22:23:44 +1030
Message-Id: <20220203115344.267159-4-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203115344.267159-1-joel@jms.id.au>
References: <20220203115344.267159-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bootinfo indicates to userspace that firmware is configured to boot with
secure boot.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: new
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f7a132eb794d..b805b758478f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
+#include <linux/firmware_bootinfo.h>
 
 #include <uapi/linux/mount.h>
 
@@ -1100,17 +1101,22 @@ void __init setup_arch(char **cmdline_p)
 	setup_log_buf(1);
 
 	if (efi_enabled(EFI_BOOT)) {
+		struct bootinfo bootinfo = {};
+
 		switch (boot_params.secure_boot) {
 		case efi_secureboot_mode_disabled:
 			pr_info("Secure boot disabled\n");
+			BOOTINFO_SET(bootinfo, secure_boot, false);
 			break;
 		case efi_secureboot_mode_enabled:
 			pr_info("Secure boot enabled\n");
+			BOOTINFO_SET(bootinfo, secure_boot, true);
 			break;
 		default:
 			pr_info("Secure boot could not be determined\n");
 			break;
 		}
+		firmware_bootinfo_init(&bootinfo);
 	}
 
 	reserve_initrd();
-- 
2.34.1

