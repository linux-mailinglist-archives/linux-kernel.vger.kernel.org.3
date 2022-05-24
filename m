Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68945324A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiEXH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbiEXH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:58:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1787229
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:54 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ECF583F221
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653379132;
        bh=KqPEz/cb0PgfDboCOUqKrulSScR7EnJ4x+RLTF0OlLc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PFd8IXSqQNE0qmEmIMAojH2uAeq4XkJO5D3V3uqWaD5f8QLvUTK8Hsl52IjuIMOWB
         a9otbZUkiRFCi3ifSxMJgZ/k6D2k78EN5M9UQaaYdxHu/pD/cGcGHQso+aOyZhAaPe
         VVlKTWM5w6NzpEQl6hTPR2QEfOj5ggYwTVLLHRQio4op1o31ivX0CVnnJWhyw0uDZv
         uYfnnl1fCnJ4Rhhw3+QS7DQUa3jW1NqB8TbqBLvN15lcx2WRRjSyvd9gol0gbOn90X
         QyuRCPumUiI1/SXW9An2bNj9MwIlrckKzzS7U/XGrNUugsnxUeydzbJFO8sUY367BV
         i9wGCh/rl13BA==
Received: by mail-ed1-f70.google.com with SMTP id w23-20020aa7da57000000b0042acd76347bso12179882eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqPEz/cb0PgfDboCOUqKrulSScR7EnJ4x+RLTF0OlLc=;
        b=yEb73A7tjYBLGg9U4dpGhN8lJk2b5AqKL8BOzEYCBeEHKA1XlNoYCxSUdkyrFmzTFp
         HpYlvXkQK1KCN09/gc2QDr4ajUmnItbqsChogug/wp9IUJMJVD0WzHt1OfggmedIju50
         u3QyRmbDRYaLFX1PVVqFOiCsM1kj2K4ZciiJGdQ7XPVk/1tJE/9rPvW4eYnWIUDX2TRC
         lpi4j4aAs+15qHHir1DGeryJaLkdG8amBHTLzAQPuhv/5gVNiVOoYmHLfgKfidwOSWY5
         8YNozg/mR8E75w9tReqiwC3ZhVL0kRGtDhmB7BeBNLeVyFCpPXsORAHmdv5Y2pWlHyxC
         fNoA==
X-Gm-Message-State: AOAM530G3mJSozx1qHcTfRstPWdJ9qd0VPhPpeYY6/f1ncVKf1Ojn2Q6
        8SUBEtOdenLdAd/k/pr4w7HjaFSRWAu+B56Z6uiV4CiTHNmUnMzvnR/ooSo3JEFpgCQqSSPdrd6
        a8KkCZiV/l7pR4cavZNvqjtWkVMh2dIpa3WJi1D/IRA==
X-Received: by 2002:a17:907:60cf:b0:6f4:4240:849 with SMTP id hv15-20020a17090760cf00b006f442400849mr24064762ejc.566.1653379132598;
        Tue, 24 May 2022 00:58:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzab5I+L4D1VCmrKk/hMk+0LVcWlgoH6zQPNB5toxX1/vqvgTzC/mMfYpUMFmZxRqH/bwzTmA==
X-Received: by 2002:a17:907:60cf:b0:6f4:4240:849 with SMTP id hv15-20020a17090760cf00b006f442400849mr24064756ejc.566.1653379132439;
        Tue, 24 May 2022 00:58:52 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0042abf2affebsm9142442edv.67.2022.05.24.00.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:58:52 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/3] m68k: Kconfig.cpu: Fix indentation and add endif comments
Date:   Tue, 24 May 2022 09:58:46 +0200
Message-Id: <20220524075848.21684-2-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220524075848.21684-1-juergh@canonical.com>
References: <20220524075848.21684-1-juergh@canonical.com>
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

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add missing trailing endif comments and squeeze multiple
empty lines.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/m68k/Kconfig.cpu | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 16ea9a67723c..6f2ec6f07897 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -155,7 +155,7 @@ config M520x
 	select COLDFIRE_PIT_TIMER
 	select HAVE_CACHE_SPLIT
 	help
-	   Freescale Coldfire 5207/5208 processor support.
+	  Freescale Coldfire 5207/5208 processor support.
 
 config M523x
 	bool "MCF523x"
@@ -322,7 +322,6 @@ config COLDFIRE_SLTIMERS
 
 endif # COLDFIRE
 
-
 comment "Processor Specific Options"
 
 config M68KFPU_EMU
@@ -522,7 +521,7 @@ config CACHE_BOTH
 	  Split the ColdFire CPU cache, and use half as an instruction cache
 	  and half as a data cache.
 endchoice
-endif
+endif # HAVE_CACHE_SPLIT
 
 if HAVE_CACHE_CB
 choice
@@ -539,4 +538,4 @@ config CACHE_COPYBACK
 	help
 	  The ColdFire CPU cache is set into Copy-back mode.
 endchoice
-endif
+endif # HAVE_CACHE_CB
-- 
2.32.0

