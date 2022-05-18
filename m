Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFB52B29F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiERGni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiERGne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:43:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8791E3FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:43:32 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DECE93F1DA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652856210;
        bh=ZDcEyYuCpzXeGn1i8/JzBv261YHZYgVn9+xhRbfWJ6s=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GT3/jwl7xaBGuJwNJ8+svdfvdtbkWGsHO3frG7VxW1j5B3XI5IXwX4AZli12xxsz/
         9oB/PI9pdzlZKrUVQhk1KHeP2TAXwGB21OGvzc17P52sKwfzZtVTL2rXFYm1ObZGBM
         1zOybRevXMDhjVARlXwqY1HO7W8zlfCNzhiJcDQNMSqOyz9g53GpqrzGcyYhEkn+2T
         AoNLIN5HmSm055D0gImm4l5qJyUf5zCs6sJAquhI8D2WpTkOURzBJgO1wBCy+uc/Sc
         /S6vKjZcDcpSwWNSPXlN5Xd+mBkEA5XOhRDzZBhrcVu7NyFIYWqUJ62wjAhRWlU9lE
         PWJW9OCDeu9AA==
Received: by mail-ed1-f72.google.com with SMTP id h11-20020aa7c60b000000b0042ab2287015so974849edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDcEyYuCpzXeGn1i8/JzBv261YHZYgVn9+xhRbfWJ6s=;
        b=WU8T9QwBrfak9NJwZf9/XN5ujUwKjffXk5CVn8J1bHsh44ltEBPLn8lDHWdwgDnKRi
         ZlPuSszxbUX/tEnxdxjp39PXbV1afP8ekn8f3Y3y7x41ct6iIGo3g5DDpuQy+yE+LPsS
         IdaHVCNnDXS54iygHz/hUk9nVPeMfB1pQ36hji9CqTtyhObFxQ1BP1PmUcVDU0sWSXBS
         YcUBh4N29KbhHAZ5OYBhBHr5+k76c0uxB5Dd1qdiN2+SgoWM2hxvSJljCwEpd3ore9zb
         C+JdBh+S+VVVkbRMnP18owuOJOU9TQgtOboJj6iLiTHm/DeUlgTr8MYelE349LxbVVuG
         2UeQ==
X-Gm-Message-State: AOAM533ahkW/gcOCPrSdm/WuompLzJSe3VpRlDW+k6kH6OQnvx9P2Hqk
        i8Q0mSGrzyhe2iCbvK0pL0EYpTCoUymFWGcGqvmdobuDZyjtMmISvLX0FsNVQpWDosWhv6mkvaI
        yuVztUHXmN4KPP9YSGOnkQdNlZElevRPoJ3+EOA7IbA==
X-Received: by 2002:a17:907:3e8f:b0:6f4:4f42:a75f with SMTP id hs15-20020a1709073e8f00b006f44f42a75fmr23086302ejc.695.1652856210036;
        Tue, 17 May 2022 23:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKQoJ5rDXGpobxN5flxbIE7TLfwoxBllcLhwlfbVamKZ5GvfRasIiHknLd9MJZjAUfuvrDjg==
X-Received: by 2002:a17:907:3e8f:b0:6f4:4f42:a75f with SMTP id hs15-20020a1709073e8f00b006f44f42a75fmr23086294ejc.695.1652856209852;
        Tue, 17 May 2022 23:43:29 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ee46-20020a056402292e00b0042617ba63aesm830271edb.56.2022.05.17.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:43:29 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 1/3] ARM: Kconfig: Fix indentation
Date:   Wed, 18 May 2022 08:43:26 +0200
Message-Id: <20220518064326.366787-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YoOyKb/0Mj849mt3@shell.armlinux.org.uk>
References: <YoOyKb/0Mj849mt3@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>

---
v2:
  Drop endif/endmenu trailing comments.
---
 arch/arm/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e2d8a8..e93653709f07 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -973,14 +973,14 @@ config ARM_ERRATA_764369
 	  in the diagnostic control register of the SCU.
 
 config ARM_ERRATA_775420
-       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
-       depends on CPU_V7
-       help
-	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
-	 r2p6,r2p8,r2p10,r3p0) erratum. In case a data cache maintenance
-	 operation aborts with MMU exception, it might cause the processor
-	 to deadlock. This workaround puts DSB before executing ISB if
-	 an abort may occur on cache maintenance.
+	bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 775420 Cortex-A9 (r2p2,
+	  r2p6,r2p8,r2p10,r3p0) erratum. In case a data cache maintenance
+	  operation aborts with MMU exception, it might cause the processor
+	  to deadlock. This workaround puts DSB before executing ISB if
+	  an abort may occur on cache maintenance.
 
 config ARM_ERRATA_798181
 	bool "ARM errata: TLBI/DSB failure on Cortex-A15"
-- 
2.32.0

