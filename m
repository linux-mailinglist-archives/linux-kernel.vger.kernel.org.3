Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80C5324AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiEXH7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiEXH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:58:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878D87A30
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:54 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9DC703F1D3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653379133;
        bh=YkatYCWfKUD+dq0NatM3KdWafpq2eW34NVcfW4Rx/e4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DDfDtfBIlO6PaYlF/P/fyMTHce1sJrx+zD6csTuBFECfJBjLhXHYujYBkNWPLqmnp
         876WvEjgCNC8P+IXvefpMSy6jCStzfnumAn5g67b4BwujFllJ1wvx6XBjR24Zj9EYw
         7WdoDk8xYQG7Ni8dPiYBfkna3xQkCVb/bdtaEA57ou0M1rAVYWChgtBXv3oBJa9Y6z
         VBctrMtjGHCCQa9Sr/g5fmMgrdQdOV6UJSTBgiBizf1TJrnNoBklQaOX7B3HvSyzsR
         azpNMgt9yLShOtZQps8k1bY8ikJuCOsyy+exSrwx92P2yb76GSYMlqbla6CrIfvejO
         3v6HRKMbwBkEQ==
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a50d554000000b0042abba35e60so12238754edj.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkatYCWfKUD+dq0NatM3KdWafpq2eW34NVcfW4Rx/e4=;
        b=MTEslN6jlMmagtyBT/cqqiUbtTQOgMPz/zpllDOriFdOmOHNS7kF+JUPrMKL6H9qF3
         YD04tj5FQ6PLNolGa7bRVzoFrPtgnsAyYp5TCHTiHaYgPDNrGjy2S0sqQ2IL7l25Qq7v
         PGjWqRqMcxFRzpSs8OkPByuygJx+KjYkwpjRzRe6IGFk1QvCynJKArQRf0Km1kqe2TZt
         17tB1aNeZEtXoh/PSicawgRPJaupKdLZldPo7asd8z7LBjGfeAmm7/mR+m9uIkNfSVne
         WCeBiH0xigtBpG5k+CxZO52xbloAm3uW/tk+vmB270J5MU4fyaHeAG8o5BnMFztDPw6i
         EgVw==
X-Gm-Message-State: AOAM5312c25rvwDylMGM4ZVThLH2fZxlqRN68p/YquH7FmXqX4GZtl9W
        qPsZQ7HPisZt2W0BuIGTokMBoL3iWhmXqbKe4iyS29qb0qlcCl8KejSsJFAShoBQo5FFR+yphe4
        D+Pq6PtBjK9/vdKuKv6IvuT3MUofdZW++bsuqu5AIZw==
X-Received: by 2002:a17:907:948c:b0:6f5:183f:eb6 with SMTP id dm12-20020a170907948c00b006f5183f0eb6mr22333659ejc.112.1653379133411;
        Tue, 24 May 2022 00:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycn4+bffJu0IMZGuyBrDA4LtHrGYk2owpnSRt1Zex59BQpLb1KRtxI2BxfHOZVe908GghDIw==
X-Received: by 2002:a17:907:948c:b0:6f5:183f:eb6 with SMTP id dm12-20020a170907948c00b006f5183f0eb6mr22333652ejc.112.1653379133273;
        Tue, 24 May 2022 00:58:53 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0042abf2affebsm9142442edv.67.2022.05.24.00.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:58:52 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/3] m68k: Kconfig.debug: Replace single quotes
Date:   Tue, 24 May 2022 09:58:47 +0200
Message-Id: <20220524075848.21684-3-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220524075848.21684-1-juergh@canonical.com>
References: <20220524075848.21684-1-juergh@canonical.com>
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

Replace single quotes in strings with double quotes to match the majority
of the rest of the kernel's Kconfig files.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/m68k/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/Kconfig.debug b/arch/m68k/Kconfig.debug
index 11b306bdd788..465e28be0ce4 100644
--- a/arch/m68k/Kconfig.debug
+++ b/arch/m68k/Kconfig.debug
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 config BOOTPARAM
-	bool 'Compiled-in Kernel Boot Parameter'
+	bool "Compiled-in Kernel Boot Parameter"
 
 config BOOTPARAM_STRING
-	string 'Kernel Boot Parameter'
-	default 'console=ttyS0,19200'
+	string "Kernel Boot Parameter"
+	default "console=ttyS0,19200"
 	depends on BOOTPARAM
 
 config EARLY_PRINTK
-- 
2.32.0

