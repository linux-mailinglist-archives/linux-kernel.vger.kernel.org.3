Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383FB536289
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355460AbiE0M1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343897AbiE0MXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:23:13 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7A17064E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:03:03 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A99F33F1DD
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653652981;
        bh=BkCOp4tVpeV9PMtuyS95bXY8E1w+xk5Ztl83CleBuR0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Hm9Epu+umu/XsJgij0G2XD7RSd6uzZP5w2U+Df5g1jCjGQ/ax/9o/arjVe+jX1/m9
         tspQ6wMc5Q79XZlLBqSXDAf6LI2QBEpxMJft6+DLd4kFf6tOhhBMyK6AbhCncU9MvL
         DaYaXnqAbI/mC4O0WjRltoj2nYAlkybIb3sXSdc5K+dZr+obEpkzWkapSedkoAMxB8
         PfNannZvyLdCeTJI0qoQnZku9fXS75/q2N9kWEUVaCQuEDpxiGY1o20tOFWIoMWGDN
         TIZJadhWpXmwxkxzKc6k22huOxxvLTAXzlRkB2GPZveI3z/N8AK+5ntoO8Vrg5BEW4
         hcplPNRlE24nA==
Received: by mail-ed1-f69.google.com with SMTP id a20-20020aa7d754000000b0042d52bce846so473220eds.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkCOp4tVpeV9PMtuyS95bXY8E1w+xk5Ztl83CleBuR0=;
        b=mFxwSOKoQx5CT0/WJYydJRvHAIKYTajvrCmRmIvHv6iftkNmgBVUqABYJKL3Kg+IeZ
         WFGwVTvneAedv0g95GCHTmFKLc+zToEYL/Cto1crhGo+3oNUrj/KSfEHOK5szyG1ALot
         ZplD3OTdhMT/bb7MFw3cTUVyOv5KYWo5q/0thhZ7KIduTRCcJ5PQpNsQ1e+DWB48iT7Q
         slWN5OWlwjuxFnYnmKlbZDUjsTyn/cZhGbbe/Y4SxspiSiBlIgHbPA93AdZfLTcwCAAB
         bFC378KjXeK8+o1d3nD21MQymJA0hleI4w09NxSrtyKSl6kQZUt7CiVsK044gVKYJfSy
         wagg==
X-Gm-Message-State: AOAM5305XvT0ytELxPLFP+7dLAuXnqLVU6ovfX2jnUcJRdZ5GrEwHeZC
        Lv7LhKaqyGGot2isa9xiK1936e++a5T2NxDi6gxWuRiT6cNKAMpXcuQbvUoLAXC/iWHaFu1PUyZ
        4SYY1ULDr0mLSuUFbVfHva7i0/jpkki7Ds0IdexUrmw==
X-Received: by 2002:aa7:cacd:0:b0:42b:b1b6:e054 with SMTP id l13-20020aa7cacd000000b0042bb1b6e054mr15390293edt.281.1653652981295;
        Fri, 27 May 2022 05:03:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRnXq7jWUrcCmZLYsRNc7Xxu7Z3WvvC7roh4JAteb5lincMrIi20bIz83Lx5oUjeZ1Ox2TCg==
X-Received: by 2002:aa7:cacd:0:b0:42b:b1b6:e054 with SMTP id l13-20020aa7cacd000000b0042bb1b6e054mr15390273edt.281.1653652981060;
        Fri, 27 May 2022 05:03:01 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q9-20020a50cc89000000b0042ac2705444sm2016808edi.58.2022.05.27.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:03:00 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/4 v2] sh: Kconfig: Fix indentation and remove trailing whitespaces
Date:   Fri, 27 May 2022 14:02:54 +0200
Message-Id: <20220527120254.458949-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <0f0c5ce5-3845-c4b4-180e-380dec53b525@gmail.com>
References: <0f0c5ce5-3845-c4b4-180e-380dec53b525@gmail.com>
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
further indented by an additional two spaces. Fix the lines that violate
these rules.

While at it, remove trailing whitespaces.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Update commit message and subject per review comments.
---
 arch/sh/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..fc15fd6b719e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -200,9 +200,9 @@ config ARCH_SHMOBILE
 	select PM
 
 config CPU_HAS_PMU
-       depends on CPU_SH4 || CPU_SH4A
-       default y
-       bool
+	depends on CPU_SH4 || CPU_SH4A
+	default y
+	bool
 
 choice
 	prompt "Processor sub-type selection"
@@ -231,7 +231,7 @@ config CPU_SUBTYPE_SH7201
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_SH_MTU2
- 
+
 config CPU_SUBTYPE_SH7203
 	bool "Support SH7203 processor"
 	select CPU_SH2A
@@ -493,7 +493,7 @@ config CPU_SUBTYPE_SH7366
 endchoice
 
 source "arch/sh/mm/Kconfig"
- 
+
 source "arch/sh/Kconfig.cpu"
 
 source "arch/sh/boards/Kconfig"
@@ -644,7 +644,7 @@ config GUSA
 	  This is the default implementation for both UP and non-ll/sc
 	  CPUs, and is used by the libc, amongst others.
 
-	  For additional information, design information can be found 
+	  For additional information, design information can be found
 	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
 
 	  This should only be disabled for special cases where alternate
@@ -775,12 +775,12 @@ config MAPLE
 	bool "Maple Bus support"
 	depends on SH_DREAMCAST
 	help
-	 The Maple Bus is SEGA's serial communication bus for peripherals
-	 on the Dreamcast. Without this bus support you won't be able to
-	 get your Dreamcast keyboard etc to work, so most users
-	 probably want to say 'Y' here, unless you are only using the
-	 Dreamcast with a serial line terminal or a remote network
-	 connection.
+	  The Maple Bus is SEGA's serial communication bus for peripherals
+	  on the Dreamcast. Without this bus support you won't be able to
+	  get your Dreamcast keyboard etc to work, so most users
+	  probably want to say 'Y' here, unless you are only using the
+	  Dreamcast with a serial line terminal or a remote network
+	  connection.
 
 endmenu
 
-- 
2.32.0

