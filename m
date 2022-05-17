Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4760B529652
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiEQA6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiEQAzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D91408B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x23-20020a17090a789700b001df763d4ed0so1059549pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
        b=lolJi/grF0XlxD0r+TbFled81nc41kCjirhMSf0FXwqJhgcA8wkMXF7orqRsYZ4O8K
         HGYSFBCi8BY43TfxB2xjssMePXmxTLaSehRbu64Z9Osgx/XCY0VqetZzjwV5MiOlVfOY
         JgOqIIahzEqUFFqnxRATc+KX0bd4/2F0mGu1iu9jOpImzUOhHcTquEk2rrPwb/uDFN5C
         V3w+3hYVC4/yqYcG/G/AI0HThbrMZlky4kg0uIDDYfun/gSr1lY/xw3U/sjDm7M7O1JH
         29ctNIXRq6FYVn3IxBOqGVS6RlE2PPiP6VuUVXvvcnOf1y0Nr07UYEGMKjQ0qVhFwaNc
         +2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
        b=Ilcl90R8VGYY+glp5hNQOg51oypoCcjn18u918UHzRB3UJgUWuqTB2Rgxc498vBUsq
         gdnuEyWC+PKmu7Kb2BJ7F5Gg5q9p0qze0KU7aNFMkITKGw/nHpUBVvUu1CNsHPkI9Igw
         ahASjYQlqn4Jfvakzoh1b2xYMMjLzBdAVpO5h6qeADYcajIFO1A3X799ikjeSq0Gjtsz
         fvugEHBFXRJw9NP/8v7KghmZsoHA2v7M426UJLPMxxDwRgFkNhBF+/bRjpFD9Gho7jpE
         n+bKvxHIgAAWJJLQFwSXYXWc+J75mgZY1mQjGzOPr4xgqmAYUX07Xxc7/73Qo5yTZCC8
         HA8Q==
X-Gm-Message-State: AOAM530dGtQtE89XA24MAmYSAPyds97Xm6KIl5haRgHVlrUbpwCN/F1C
        HX/BsLnkkqZVRFh8kkp8crMOY8z7J/zdfg==
X-Google-Smtp-Source: ABdhPJzHJQEjBCfKJWcGHDyr9TTDGKtZomcGfjSzIvd4OX6WWrNI7QdR0unRWlq3+NmORDe+a0HdLg==
X-Received: by 2002:a17:902:d191:b0:161:5c4f:ce9e with SMTP id m17-20020a170902d19100b001615c4fce9emr11941745plb.159.1652748948956;
        Mon, 16 May 2022 17:55:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 13-20020a630e4d000000b003c14af50626sm7084057pgo.62.2022.05.16.17.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:48 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 07/13] openrisc/traps: Declare file scope symbols as static
Date:   Tue, 17 May 2022 09:55:04 +0900
Message-Id: <20220517005510.3500105-8-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

Sparse was reporting the following warnings:

    arch/openrisc/kernel/traps.c:37:5: warning: symbol 'kstack_depth_to_print' was not declared. Should it be static?
    arch/openrisc/kernel/traps.c:39:22: warning: symbol 'lwa_addr' was not declared. Should it be static?
    arch/openrisc/kernel/traps.c:41:6: warning: symbol 'print_trace' was not declared. Should it be static?

The function print_trace and local variables kstack_depth_to_print and
lwa_addr are not used outside of this file.  This patch marks them as
static.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index f2478bba77b9..9e0937eb31ca 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -34,11 +34,11 @@
 #include <asm/unwinder.h>
 #include <asm/sections.h>
 
-int kstack_depth_to_print = 0x180;
+static int kstack_depth_to_print = 0x180;
 int lwa_flag;
-unsigned long __user *lwa_addr;
+static unsigned long __user *lwa_addr;
 
-void print_trace(void *data, unsigned long addr, int reliable)
+static void print_trace(void *data, unsigned long addr, int reliable)
 {
 	const char *loglvl = data;
 
-- 
2.31.1

