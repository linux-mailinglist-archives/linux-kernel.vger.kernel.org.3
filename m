Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6765B530A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiEWHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiEWHXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:23:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E95140D2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:14:50 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4A5C83F1FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653287449;
        bh=C4unRTV41Zt0Ep2OyMd9Pp0aJxn+OBEIvDBNhczjUyA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Nn76aX3CMRS26du2tqi4+uu5k2toSssJb57j/OFFmQuNKlfs2ffw67VnHy4m3JF3Z
         lnl67MZd+bqntWCuHt9k8mZbRThilUlIZSRLgs5BAQAWbPeDGJ3NvM1FZBYgkQ6E9L
         6EhGixl015e1MVxrDFyhg2qJ7u4+x/BIyuWz4kvEA5UzIj7gvnHY6kUuhn5jEWfyUH
         VYdxRa3CyWe93S14XD4vcCbNRcJZVfs95Za3JK2DpEg/4xp2qAA8SsYwL8kBIxoOe4
         IlzaVLLK3aYPSVXVCJ4BtfT5ZRjvx/hHPEe1GRvKmQjS9j9khTa0VgGxnauH2tcUPz
         tNKBRiy7nwbrg==
Received: by mail-ej1-f69.google.com with SMTP id oz9-20020a1709077d8900b006f3d9488090so5446424ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4unRTV41Zt0Ep2OyMd9Pp0aJxn+OBEIvDBNhczjUyA=;
        b=TBPLQgSVHGlp2oSwmqg6yd+zMbYZ8z6TptZGrwMOPRORfQvDWA8l+oOb04G102t0ed
         UshikI4NzWm6Yluxtf4aUoCZXjqcCxo8Ci9VG3UTFC/eLZNwVMKmOzQWkCuJgRl3iMU9
         sXi4XP6rdYikLvZP1Ryh1dGwPDDDFOsAh+GYWZ2K0hZEwTmFMGs7M6hgBbIXPE66CXi3
         k/kZwR23+Wy6sWkHDO54q8OIlNhVOKTTMWuk7tRBoIDCo5qZuzK0HmAXUxZCVdLhQZ5N
         o9H+iRlJYOcTHg0cABOT5+a3/tz3Rncb69js4gpcjyc+Tv6q2DRfwq13sNjbgcMe1qqv
         riFA==
X-Gm-Message-State: AOAM533XAG9U9BqNudzTCNv99e3pSPkpnTUPRGgW25GgU7GyjgGWuFsG
        +17IJTzSP+ISC9ZctcGfIQI1VL8TDRL+swJNQ7oOtuS1D8KHb2293ec9cWisov8YRHZt34rzIEb
        7poULMWBpeM/9JNENVC824th23ms5lZc4hPfzMjQqTA==
X-Received: by 2002:a17:907:a428:b0:6fa:9253:6f88 with SMTP id sg40-20020a170907a42800b006fa92536f88mr19086674ejc.518.1653287449044;
        Sun, 22 May 2022 23:30:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz5H5Dw8ITnQEI3JZXa1Lb+5tIXG5TbEd0PyYgZOvxcLOU1BT1mcXRA/Ezr8NdgUKeIjlWmA==
X-Received: by 2002:a17:907:a428:b0:6fa:9253:6f88 with SMTP id sg40-20020a170907a42800b006fa92536f88mr19086659ejc.518.1653287448847;
        Sun, 22 May 2022 23:30:48 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id g6-20020a056402114600b0042617ba6396sm7737934edw.32.2022.05.22.23.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:30:48 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     tony@atomide.com, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: omap2: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:30:40 +0200
Message-Id: <20220523063040.10991-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While at it, remove an extra empty line.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-omap2/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 02c253de9b6e..596918fd103c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -122,7 +122,6 @@ config ARCH_OMAP2PLUS
 config OMAP_INTERCONNECT_BARRIER
 	bool
 	select ARM_HEAVY_MB
-	
 
 if ARCH_OMAP2PLUS
 
@@ -192,10 +191,10 @@ config MACH_OMAP2_TUSB6010
 	default y if MACH_NOKIA_N8X0
 
 config MACH_NOKIA_N810
-       bool
+	bool
 
 config MACH_NOKIA_N810_WIMAX
-       bool
+	bool
 
 config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
-- 
2.32.0

