Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02752A492
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348703AbiEQORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348678AbiEQORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:17:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0209027B31
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:16:57 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CE16C3FE02
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652797014;
        bh=jd0VeL2AHDg2LJ77yGx5/LqXbrOfozyrVLrb5aNQFDs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Madh/6q7XAypFTWAb+klSABjy42yRADR1g+VPB6PqR/AXJ4ZfRoKUbGsfWJy6eH/a
         33eVJfsj1FlKIpvULtS3fRv/JpU3n94iz/r2RXost2eTMXtg+VsJWyCGGR6O8mjTHz
         pG19I84vCDTR60NYPo4Gpwb57Wn+Zco0neu2UHuuOVrwB1X0UQ2wBXjZIKOcbEgYzc
         HI5wu9dQifCXc495yuybSdN3ERpb/RRIPI0YNAwu7XIicbktV8jwvrg1UDif9pOCbe
         01UsTdplLyc2s1wt2SL4GRIxRAQK+q2fIoWHHcXckz6NYbs7boNlOWv351PNYjDWjJ
         vGa6a2lhG6H4Q==
Received: by mail-ed1-f69.google.com with SMTP id s9-20020aa7c549000000b0042ab6ab62f0so3468711edr.14
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jd0VeL2AHDg2LJ77yGx5/LqXbrOfozyrVLrb5aNQFDs=;
        b=eLKn/IUe/kkNpdfUigDVPKu/demaxQYikimshl6r/nfYiR0qs8QoTYzkopg2/oHPg7
         zN+rf9O+kMfcPNbzoHToykkpW/JCNZ8ZKdos3DGI0cUxfs8BtBqCz9eyqhIYHXD+vQ+0
         X6r4YN9oaH0mzOIMv9pOklBsYXyS77B9aBLIx4kB2r6hT93qYuRCjAE816ahrGTlgubi
         ZIv1bRT3I+G4/fTfvvTCEe138dBbyqxiak7dltQO5VpBAtXEwifEJtAlXfvg9GKr2Y9W
         voMjpggr5VAliNcoO1fRQkkr3COKx7O9CiLuTzU7hw4UX1e3oy+699fdT4lYrYoclWkT
         6+Bg==
X-Gm-Message-State: AOAM532t0KH5V+6nz5jCNBqgvVX4PsM4aYn5UTSOUNOZxZAwIm5hzI5+
        KrvBpXDjk5enlQa49rIdTDdci0wryZq/ugsuZMLs+l26lMLozT5NT2/zJjwPCnsjZqDKy36R5qz
        jIBSUWerrhb4kWFW56gNHK1ggmlj1kckS+vpAc821Ow==
X-Received: by 2002:a05:6402:50d1:b0:428:1473:d173 with SMTP id h17-20020a05640250d100b004281473d173mr19483717edb.37.1652797014195;
        Tue, 17 May 2022 07:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVGQQllvDVL22W9vm1yn30AQX8KZPUMac9s5RQYuLreNrjRJi+7Mn3AHtfZi39PUoez11LEg==
X-Received: by 2002:a05:6402:50d1:b0:428:1473:d173 with SMTP id h17-20020a05640250d100b004281473d173mr19483697edb.37.1652797014057;
        Tue, 17 May 2022 07:16:54 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bo3-20020a170906d04300b006f3ef214dcesm1065035ejb.52.2022.05.17.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:16:53 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/2] arm64: Kconfig.platforms: Add comments
Date:   Tue, 17 May 2022 16:16:48 +0200
Message-Id: <20220517141648.331976-3-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517141648.331976-1-juergh@canonical.com>
References: <20220517141648.331976-1-juergh@canonical.com>
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

Add trailing comments to endmenu statements for better readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123cde02c..de9a18d3026f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -325,4 +325,4 @@ config ARCH_ZYNQMP
 	help
 	  This enables support for Xilinx ZynqMP Family
 
-endmenu
+endmenu # "Platform selection"
-- 
2.32.0

