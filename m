Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA733530964
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiEWGMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 02:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiEWGLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 02:11:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475D1EACC
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:11:42 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA1E8402E2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653286255;
        bh=sp9B06jvIyEUEn93KrwOb3wB36HiwdmoPpXKJ1JybwY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kpiczi5fd/hUdXQede+yislIxYGsEQtC0uwAKGrHQx/GETNuNtFiBbbcD7ZBirGt0
         kbqPzOFBDGbcm71eJIvJNlDh4FhIXVkWCQ8WcFUgn0goMm+8jerKWiAhusFAfAzkOU
         +Jn3N45GCWu/noWSS+VBWCJb34Gm/T571jK8Aw4mURcvR69lTPpxoZE4JjM8kfLR2C
         EtNBHPqVCSKdK5MmDKrRu1Pw5/fr5CjYPU7/0zk4X35F6VXRbjdodpa3xr3lqXWxLL
         HVuMhkhpKfrKVqupf0UeEWK2ZhKn7k+ZHvqZGd74cAS6lRXa6zOnbGkjscLjX2NiHF
         COY8Ia3KiCrBQ==
Received: by mail-ej1-f70.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso5430185ejc.18
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sp9B06jvIyEUEn93KrwOb3wB36HiwdmoPpXKJ1JybwY=;
        b=A5T2WklCkYXSmpgWWASWZbyQ6+XaSz70IumNof2buw40SqeLC/RzuGYBBccXEdaHOY
         VGw57lDxRpX+WLxuZCF9tEeDT2E52gcwXj/rBu74T4vLdVPSHn6OcaYHCQSL4nlMHjZL
         u5EEYQM2twzLEiIfBFr7iM68IoolJyb0EqWsAax6jPNmLs7zxsM3JsxMsnBdxeGwXTWm
         0gdE2/xDRzWnghFXYAy3j3msa1ClpiDZkTs4NS7gfXPfxv2l6VSmgE4n02VXmeiFLltK
         NYZnCkkarJQ/B5KKtQ9GzpMOhEj5v4IBTaDn8RVSk9mfCGmEzW1JQCrAkzRSgasqPte9
         VeGA==
X-Gm-Message-State: AOAM533k1lOtbw6KvkT9jSpi5Lh++szm98Yy0vJzpC5noa0A7fVbGPXz
        rRrPmqigXHP3wWBfwa/EPWeT/o7OaJl0JVImbvi30DAFNYS3hEQjmFRF7DJje2jKczsPGq8XtcP
        DhKNx2SwTLexuiyKMTeEMxeCD6iWBbj/jaBhHsLoopA==
X-Received: by 2002:aa7:c50d:0:b0:42a:aece:6241 with SMTP id o13-20020aa7c50d000000b0042aaece6241mr22385598edq.32.1653286255633;
        Sun, 22 May 2022 23:10:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzLfWnbPEmHzJy0GMu6eh7GiUVIy0LwhBJMU5xO9MNZatTlknQybUPzgCRZkuLymcbwwmoyQ==
X-Received: by 2002:aa7:c50d:0:b0:42a:aece:6241 with SMTP id o13-20020aa7c50d000000b0042aaece6241mr22385589edq.32.1653286255460;
        Sun, 22 May 2022 23:10:55 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709060bf200b006feed200464sm448374ejg.131.2022.05.22.23.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:10:55 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: ep93xx: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:10:51 +0200
Message-Id: <20220523061051.8668-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/arm/mach-ep93xx/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 15c68a646d51..cd94079ce095 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -121,10 +121,10 @@ config MACH_MICRO9S
 	  Contec Micro9-Slim board.
 
 config MACH_SIM_ONE
-        bool "Support Simplemachines Sim.One board"
-        help
-          Say 'Y' here if you want your kernel to support the
-          Simplemachines Sim.One board.
+	bool "Support Simplemachines Sim.One board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Simplemachines Sim.One board.
 
 config MACH_SNAPPER_CL15
 	bool "Support Bluewater Systems Snapper CL15 Module"
-- 
2.32.0

