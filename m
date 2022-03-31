Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373554EDB7B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiCaOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiCaOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F296F1A5D4D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648735859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+4so6aFuDRRvDSwPLBC1SYqRreDKMfHkuu+cZnQ7gCc=;
        b=PyvFjTBHo0fvKm57DAHEQe3WiD2sObNt++MdaV8QwGU9w49HuvtZZwHsMP7YWaoqDrnn0Q
        48HY0LEsgw6b5mm4a9QSP+uLZKNDuvNYyjAgMF7f9JHDHByjOjhE6MVz0a4Bksp/gsLuDA
        PPwKNOj1IXiJpMANYgoCwISpZ2ei/CA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-BYIqwxrhNRu9CGhhjptmAw-1; Thu, 31 Mar 2022 10:10:57 -0400
X-MC-Unique: BYIqwxrhNRu9CGhhjptmAw-1
Received: by mail-wm1-f70.google.com with SMTP id q186-20020a1c43c3000000b0038ce534d9e2so7754712wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4so6aFuDRRvDSwPLBC1SYqRreDKMfHkuu+cZnQ7gCc=;
        b=ACXKUKu+GgKby80c41XA/l3J6c/Ibcv4uDyySc8YuqCIRrfwNTAo/vPdZosoO8VhO4
         KqIa32q/Cq+Z5i86ZQcW2OAy/i4i4OnU9a6YZ9d21u03TZSmhnCY8s8a2gBZ0EguaHnm
         V0IVG4Un9xI+wQD/J6aFBpvHXNpglLO3gXqQZ1qwYTWcAuJLPzQkn6caJc8l9DvqSHda
         sWfliAUZIsGgVD1YEvAPZijHI5/Nqa7L/jywNDr7VY2Mg8yj0D/XuivCyBJHsyXsOFFd
         MdNbmMF2gu2yhylhE7YOVPuoWlwL87yQ4Q5exO0SkgN86Nu8q6QIc0tXRif5TP9JZR/J
         tUzQ==
X-Gm-Message-State: AOAM5302m5y/wyoejR6yh0Auj70IBzzG1I4Kv53c475ltkZB3PmYF5jD
        8aj+8S/7J/tuUOA/qtSsBOlzT4wq3WAx9fO0Tbd9VGBQOk5SSijDNYs+N0S8Rc8r5RAj7QOTbqh
        s34sdbReHOGCMaU/Wr0bFk0HSg/2qFL/gFZuU/ZeQnaLkyFuO4dsFQta4wz0KfoOrv335ODWg/t
        Y=
X-Received: by 2002:a5d:6041:0:b0:204:1c96:c04d with SMTP id j1-20020a5d6041000000b002041c96c04dmr4302141wrt.541.1648735856259;
        Thu, 31 Mar 2022 07:10:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysM97+fkPHW/+UC3JXm8yYSTlzHvNluGBBf4OE1SLeaKKiEhxH6c0r2GhUn3IXB8B2cvSV5A==
X-Received: by 2002:a5d:6041:0:b0:204:1c96:c04d with SMTP id j1-20020a5d6041000000b002041c96c04dmr4302113wrt.541.1648735855979;
        Thu, 31 Mar 2022 07:10:55 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00203fb5dcf29sm19537626wrx.40.2022.03.31.07.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:10:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Larsson <alexl@redhat.com>,
        Al Stone <ahs3@redhat.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] efi: Allow to enable EFI runtime services with PREEMPT_RT
Date:   Thu, 31 Mar 2022 16:10:38 +0200
Message-Id: <20220331141038.171204-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d9f283ae71af ("efi: Disable runtime services on RT") disabled EFI
runtime services when the CONFIG_PREEMPT_RT option is enabled.

The rationale for the change is that some EFI calls could take too much
time, leading to large latencies which are an issue for RT kernels.

But a side effect of that commit is that now is not possible anymore to
enable the EFI runtime services by default when CONFIG_PREEMPT_RT is set
to y, even for platforms that could guarantee bounded time for EFI calls.

Instead, let's add a new EFI_DISABLE_RUNTIME boolean Kconfig option, that
would be set to n by default but to y if CONFIG_PREEMPT_RT is enabled.

That way, the current behaviour is preserved but gives users a mechanism
to enable the EFI runtimes services in their kernels if that is required.

Reported-by: Alexander Larsson <alexl@redhat.com>
Fixes: d9f283ae71af ("efi: Disable runtime services on RT")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/efi/Kconfig | 15 +++++++++++++++
 drivers/firmware/efi/efi.c   |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..3c5373de86fc 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -284,3 +284,18 @@ config EFI_CUSTOM_SSDT_OVERLAYS
 
 	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
 	  information.
+
+config EFI_DISABLE_RUNTIME
+	bool "Disable EFI runtime services support by default"
+	default y if PREEMPT_RT
+	help
+	  Allow to disable the EFI runtime services support by default. This can
+	  already be achieved by using the efi=noruntime option, but it could be
+	  useful to have this default without any kernel command line parameter.
+
+	  The EFI runtime services are disabled by default when PREEMPT_RT is
+	  enabled, because measurements have shown that some EFI functions calls
+	  might take too much time to complete, causing large latencies which are
+	  an issue for RT.
+
+	  This default can be overridden by using the efi=runtime option.
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5502e176d51b..ff57db8f8d05 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -66,7 +66,7 @@ struct mm_struct efi_mm = {
 
 struct workqueue_struct *efi_rts_wq;
 
-static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT);
+static bool disable_runtime = IS_ENABLED(CONFIG_EFI_DISABLE_RUNTIME);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;
-- 
2.35.1

