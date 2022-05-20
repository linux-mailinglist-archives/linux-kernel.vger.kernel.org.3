Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193E252EB35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348755AbiETLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbiETLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:52:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365B15E48F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:52:34 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 318013F1BA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047553;
        bh=F3uWhU19tqPSpilnTv06Sntkt3xu6QI1J2QyXbNwKXI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dUz4r1cF3cM71ujz2lj/GKq0UlmDbaUTQZF8swsdfTA2wKp/AGLrISyZkQlumCFGm
         J4Cpg6P89/blJey1h0WxuKh4ALETLiFbaDmND9LS2/ipBsiDlXMJ6HfzSLUNNWQNzN
         gVfPL6soXyYx3HFQ9XbST6i3fKFcAG6N7KlOpoRcMDTnMKGZ83AB5ipa4IF1GQeyF3
         7ntCoye35WpHR6/fp7t89G0t77g+kpuxFLabOwWG/QfYOd2OfTIay08UpWMgQxhk3X
         Z6KnORqyaouduIKn6wKNKTfpHkJCzz5xMLT2BBRUKsG/MiW11Ijr3UBt32milnrm65
         c5G+sk2ibTkOw==
Received: by mail-ej1-f70.google.com with SMTP id l18-20020a1709066b9200b006fe40aaf3bbso3931986ejr.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3uWhU19tqPSpilnTv06Sntkt3xu6QI1J2QyXbNwKXI=;
        b=C/KuOKZo3Ey7f2BYlYcFqPtcF8YFVgeLGBDmN1TRj7y2UlVr7YLinzqvWNYOzGLbYy
         oPPEh7b7v1rYqTuVwfZrIAJELFbL489xLbS1mVU7Yj8kL/YcvCvYXpktjNdZ713FDNVI
         +lumRBH1VzFkf4hopPBW1QOBkb09yHZ2wDMWew7EQlJ/mUntTlzV9JdqJe/ChGBo/Dr8
         82Hxf4yxAS51WXsF6ULt8iJ3VVBMeKVPnROrsuPRc1x9d29qHuXq/ntg6dIowCD1/gp5
         N4MdBqDBaBUDi4iIU0osklO6bC9NmAwb+vBlYq9BPKYGzaD+ADhQcA1AwQMMdNRJDtvm
         oMOQ==
X-Gm-Message-State: AOAM5332wif/RvCewhXO1bT4RRT/PKi/gTR6JiJ5sh2POiytqChmyz5V
        H1YTQc0/uvVXoOXgtp2EWdprcc6W15tv/v5fpi4axbJOykSysw07NHzr13+sP/bpHIgRHI0l+v4
        yB2r07LbeK2nDnBR611KVN/g2SD6hcxaOoU/qfOL9Rg==
X-Received: by 2002:aa7:cf83:0:b0:42a:c73e:6d86 with SMTP id z3-20020aa7cf83000000b0042ac73e6d86mr10481226edx.251.1653047552916;
        Fri, 20 May 2022 04:52:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6JwgyP43Z2fUOMqs72r04gqZu8vQTIl8anLwpcnAq693ZcuMztCwn/3EFf3TvpdllczP3eQ==
X-Received: by 2002:aa7:cf83:0:b0:42a:c73e:6d86 with SMTP id z3-20020aa7cf83000000b0042ac73e6d86mr10481208edx.251.1653047552783;
        Fri, 20 May 2022 04:52:32 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id d24-20020a056402145800b0042aa5a74598sm4186088edx.52.2022.05.20.04.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:52:32 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] powerpc/powernv: Kconfig: Replace single quotes
Date:   Fri, 20 May 2022 13:52:29 +0200
Message-Id: <20220520115229.147368-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace single quotes with double quotes which seems to be the convention
for strings.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/powerpc/platforms/powernv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 161dfe024085..ecc4a5806b42 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -20,7 +20,7 @@ config PPC_POWERNV
 	default y
 
 config OPAL_PRD
-	tristate 'OPAL PRD driver'
+	tristate "OPAL PRD driver"
 	depends on PPC_POWERNV
 	help
 	  This enables the opal-prd driver, a facility to run processor
-- 
2.32.0

