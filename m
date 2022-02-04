Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111774A947C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351512AbiBDHXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350564AbiBDHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:22:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F579C06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:22:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h14so4426881plf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 23:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NAuZUPwGF81ONxppx1B9B6iTuR1QuOpDIcTSst0sx0=;
        b=HmUyqiwJMKWnR7xJD07p4oXeNj9NB7fxabIkBU7eUvnS7cgvXWWegTDLLCfxRsQO0L
         bDTv0BDUlmGtIsho04tQU1mS+fFZs0lOi4IXKWd4u4jiaFmxFO1v6Uy5ykagjn1FfFkY
         ooJR2M+k3Ad2jnFTbCJzpLDQLmy8ctJ0d1cZASvSOVAMPqBYsT2rx6OIq8Wo+L3yZXJf
         HEE14JFihc1dS7hY07KRN2s3iv0iSOkvaS4TEAAjSULEjOuf0sbT8DSwqrP2AhTpoFoP
         li3jYYBBInfYPeEGtJS1Y8Q88AslwT6YmvKI7otNQFTjM30Mr1y/Cw8CixxwV40SbOoD
         cVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3NAuZUPwGF81ONxppx1B9B6iTuR1QuOpDIcTSst0sx0=;
        b=02EjOrL/onTJI29nvAav1upg/jNY+sBP1SxG1/MJcxgoVgKW6LdSmqb/Q9D4w3whXR
         jcNxuK1K7BC4kUrN0uqhMTb5Yu/H9OyiEnlGo5i9/cBtBR76DS6ZGSEenleMiXXjf4yu
         j/4ZH4ncWLIObPLSbTshpOrzjOcIVz8fkx1EYrrgymtdxsTEjL24z8uj3JRchtpF78x2
         B5D83GWm9FpNm6PSO1MiTW3Oi0u/JhFFhLgCaJNVvxp+ELKhuQCTUVbtd4CwnqFoh3E5
         Q5Nsk6NTIYn1X6WS2dE4vOcUlqLeHUqePoj3HbGs2MlKCCVUYeiuV/y2ZX2TpRH6FPzY
         8ZWA==
X-Gm-Message-State: AOAM532qX9nmeQQmn9XmXp1krW6L+LZPk/NBpRoKHnOfMzOJFcGZc52I
        kjn/S8lD0AjU0ZAWnn2fFGkgA7D+uIM=
X-Google-Smtp-Source: ABdhPJyVz5qfJzssRkzORV9t582XmgGtNGjvXlTFsPohRi5IjyDvNmGF+qtghzsEor7vO69s2ZW/Fg==
X-Received: by 2002:a17:90a:6a4e:: with SMTP id d14mr1695587pjm.177.1643959375746;
        Thu, 03 Feb 2022 23:22:55 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id t14sm11665328pjd.6.2022.02.03.23.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 23:22:54 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3 3/3] x86/setup: Populate bootinfo with secure boot status
Date:   Fri,  4 Feb 2022 17:52:34 +1030
Message-Id: <20220204072234.304543-4-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204072234.304543-1-joel@jms.id.au>
References: <20220204072234.304543-1-joel@jms.id.au>
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
v3: no change
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

