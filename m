Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580785690F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiGFRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiGFRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163F720BD4;
        Wed,  6 Jul 2022 10:43:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c13so19252849qtq.10;
        Wed, 06 Jul 2022 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+O+hqmbBhgU5CXoQtnpUr8p9FX2X6OnH2SDA7ObfOeo=;
        b=gq+fqCSXw/GUohUMhLBqsJ/JM1u38sdU3GwI6aRgpOgc3CQuezG/HVCWFZbQ13UJZA
         X2+1+qkyRtvgCdgTvjhS9mWcUr61AFuX5Gw4IwIsFZDt0ZOQxktQhKkv055IgffGsOfh
         3fLYf4ukTfrvq7GWQS8D113Ab7OshwJFQ8GFD+GcVoRbpyt2EOObpDLT4duauJJEbhX8
         /AGfKQ3OimLbTFubZg0wuGHIVCyD5yvWoqkqhFyz08C+9PtYeeD4EWFzMoNwSBPfSoVM
         EOEadaXmB9Wyb/EvNfx+/i6f2Mkv+/ezuDaNPs+P1rSNS2F7Tan1Uoe/+HQ4AXCYHQKV
         q8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+O+hqmbBhgU5CXoQtnpUr8p9FX2X6OnH2SDA7ObfOeo=;
        b=Lr3KrWsd0IsCHXh2+dRtedC47SDxCm5ZkqLaTMzoF3l1n+OCKgImcvmqBPgIVDcGeF
         hG+EPk3Gv1Tx/EqdqaGmpwRtpc1DVFi3oS2mzLosDkOhMmY/bkKmgvJwVTbqT13K3gA+
         QdXzJjRAzt+gxvS8JGqCIS66Gkx0rU3wR0njVRJcHwWq0tkqDUcbSG5lJGURDY3VznRu
         E/Mjn1RgpWH4BFlgT7Srz/p7fPbAAf6BZVdzjOH2Tg8uJdWttzNsuFSNQTL8SBanPmLl
         Sl2Xi39MI3SkyTclzZhamw70M8yJWg0uQp5aT7VitdwukP9tGKbDt2HhfT35usgqUQvi
         HRTA==
X-Gm-Message-State: AJIora/E7mdTMZtlziutbdk/CFGB/evYqwpPEfqClHID1R/9n304Qvip
        0l5CsBbh9EAHiqL0aJwWUmMYnvyCCo8dLg==
X-Google-Smtp-Source: AGRyM1umMyvm+F1pTR2SejSYHc/XeKM7uQQT5igDl0n9waYKdw5krFIk44y3ooz3s8dm/7lCFJDrbg==
X-Received: by 2002:a05:6214:27ea:b0:470:7042:3901 with SMTP id jt10-20020a05621427ea00b0047070423901mr38054881qvb.69.1657129383901;
        Wed, 06 Jul 2022 10:43:03 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id c19-20020a05622a059300b00304edcfa109sm26608392qtb.33.2022.07.06.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:43:03 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 07/10] headers/deps: mm: Optimize <linux/gfp.h> header dependencies
Date:   Wed,  6 Jul 2022 10:42:50 -0700
Message-Id: <20220706174253.4175492-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

There's a couple of superfluous inclusions here - remove them before
doing bigger changes.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/gfp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 2d2ccae933c2..52f2c873a7d4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -2,10 +2,7 @@
 #ifndef __LINUX_GFP_H
 #define __LINUX_GFP_H
 
-#include <linux/mmdebug.h>
 #include <linux/mmzone.h>
-#include <linux/stddef.h>
-#include <linux/linkage.h>
 #include <linux/topology.h>
 
 /* The typedef is in types.h but we want the documentation here */
-- 
2.34.1

