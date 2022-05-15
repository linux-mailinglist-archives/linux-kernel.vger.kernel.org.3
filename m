Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780CB527784
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiEOMmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiEOMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:42:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C247217E00
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h186so9056459pgc.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
        b=ksSpxTNN13tMggvaejsEI+GQ4F41SIaUMtsGc/Fbqvm0NY7LV1vR2jqG1m7GoxPGku
         PhKShLPS2YaFrCkWF6qzNE5E8jWTrJU+moMax9b1xoFBY6SRdkK8bVp2Zc/G/nSySbjW
         liOdoPCmqor7GMxuSCOuApzqyuWuAqnY0sdvxKZMccFR3frD5U5yhzHbEI5vUEAwePLj
         7NigwZjZe3z2aNqzabMoA3gJKXQB748Hy11fqo1cWv8xhly2r4khbd9fxdgzD7LDLZow
         RisaBQqRaleTGpSUZAdrxcMWrZ4s18sPFISuodoVqegDk4/ERIEhkV9Mf2goI4bvRbnb
         pyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
        b=thop4apizQEV9hNUxEE6rnmvxCYs4iLDKq3E5+2Xg8f7uhzEYK2xEqm0ixYXhsJ5FS
         eO3xYju3ZZUEhFawsuc54tbC0ixE2MTso/gCCmCB9ObfZgUVH4ySBVGlF4MsGFRxUD1K
         L5d/NeXPqA6plExsgewXYI3uS5RGRNF4bmtDUG3YTlpwI9Y+TmtOverxXZYFc2mxD3w5
         FidalKtYhIwYWNQRl9MKNtdlUY5iUMSGF0Tx1xrfiqxJ0eZCOwWMJjbcQbnna03GURBL
         7zseRo+EayVZ7rxnjnAliy5i5s0HVIZElY7lKddmv/jlDCbrir0hrcoO5xq7jiC5pRfv
         0OUA==
X-Gm-Message-State: AOAM530uyOmD464HldUuu6XeSZW8BqNCcfFCZUKC1661+j4Tcx38CXGA
        lI2ipTgqnipyoVCKA+ALH4gerXregzIqyQ==
X-Google-Smtp-Source: ABdhPJwTNC03YPfYWQHf0N8lARTn79n+/NuIFfhPaElPQM+ruE5EgRmd23V1wPxuw7p6lSSipEta1Q==
X-Received: by 2002:a63:d34d:0:b0:3db:a518:1ff8 with SMTP id u13-20020a63d34d000000b003dba5181ff8mr9206517pgi.593.1652618552046;
        Sun, 15 May 2022 05:42:32 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t19-20020a170902b21300b0015ef63f2382sm5054670plr.231.2022.05.15.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:31 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 07/13] openrisc/traps: Declare file scope symbols as static
Date:   Sun, 15 May 2022 21:41:52 +0900
Message-Id: <20220515124158.3167452-8-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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

