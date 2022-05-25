Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9460F5342FE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiEYSby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243318AbiEYSbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:31:50 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667B0B2242
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:31:48 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2A0863F5EE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653503507;
        bh=5tNUlUVpdULW1mlAGUWuXCcSV4iIrGrel9EcAzu6+B4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Nduy37e/5l2XnDMt5arq/ZzYZb6c0hYMGFxVRuwNN2S+94j90Weutfi8vuMTf9+NU
         jM0L4CvhAJbPkD0rCDmxJsU0h2J1rB12R/DMHPVZ8vEZmu8PyLGfnNxz3GhohctAS0
         UkHcXmJAbJ6XgHd4KQCq4Zp5kQkIVkla/Z6AWSwIRxcpFh+cVFBIa+Om5CESW2Ho5n
         AeOM79Qq6p28yt1k/u39cPtIldbRl2Vwa7apzw6woNgAVSvvZIwLwSSVSX9fD9tfaE
         XKKz3AOLOuONhggxiRFozfkEOxdXBqqjo2U/9zMpqDGn7EUMQVVwM/YK52+yGJmNOV
         zPbGXDUrcMtfg==
Received: by mail-ej1-f69.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso9942148ejs.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tNUlUVpdULW1mlAGUWuXCcSV4iIrGrel9EcAzu6+B4=;
        b=YzBBZpXKbShheVY4+hphGbYpjvHkz+RtTblHEV8JDpbte64AW5KcdewaWOCCbZCTJ8
         izmp1+SFzy4sbhxoDkj1pXOh9Gl1jGIVz62eBNvx9jbExVg7lKP1zz7f0U/MKXy1qlBx
         5Kdtr6bHzwM7ZJ7erLyKs7QcWyRLGI3aiWYhzNxgK95S0WG5GvxeQI5eK2Qdq87BGx2e
         DbLEUXUeFfndQ2d9rraSiWpOX7ZkfxkDZ8xVNf2kJFgKINs0qYJi3kHN+HA6DXnd1Ttm
         Eu+umCTmKDixHipsyV15A9VAB8l9Oj5ZnKa3MaDxpZbAOzVLf6eqmZWd7EIIX1jvLQyP
         B/JQ==
X-Gm-Message-State: AOAM532JVGOwW1IwcEE+reKt1kaS8MmYEGydLBJ/eZLO3shdjop7cRcb
        pcFaU3i+cscPJxsWvjmPK0oSqOAHQm30c/NAgXCf8VigEmS4jzKHRawJf/JNbHnBxNrdD3N8d1/
        f0XRwRWfCWu82hTI2S45BEMciG1EufIxonfSIAR7sJA==
X-Received: by 2002:a17:907:72c1:b0:6ff:c5f:6b7d with SMTP id du1-20020a17090772c100b006ff0c5f6b7dmr5744762ejc.676.1653503506886;
        Wed, 25 May 2022 11:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysyVgERCvAJ0QRPxB7iHXO2O/vKYKmVAbpc8ojL3ige/psMupEER5vWokV9iKl86T06Ea0pg==
X-Received: by 2002:a17:907:72c1:b0:6ff:c5f:6b7d with SMTP id du1-20020a17090772c100b006ff0c5f6b7dmr5744744ejc.676.1653503506687;
        Wed, 25 May 2022 11:31:46 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7d641000000b0042acd78014esm10847985edr.11.2022.05.25.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 11:31:46 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/4 v2] sh: Kconfig.cpu: Remove trailing whitespace
Date:   Wed, 25 May 2022 20:31:33 +0200
Message-Id: <20220525183133.71044-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <0ef0b83b-64d5-82fa-0b31-fbf714c75470@gmail.com>
References: <0ef0b83b-64d5-82fa-0b31-fbf714c75470@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a stray whitespace from the end of a line.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Fix commit subject and message.
---
 arch/sh/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
index fff419f3d757..7b0bea483eab 100644
--- a/arch/sh/Kconfig.cpu
+++ b/arch/sh/Kconfig.cpu
@@ -2,7 +2,7 @@
 menu "Processor features"
 
 choice
-	prompt "Endianness selection" 
+	prompt "Endianness selection"
 	default CPU_LITTLE_ENDIAN
 	help
 	  Some SuperH machines can be configured for either little or big
-- 
2.32.0

