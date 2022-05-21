Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6C52FCAB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349882AbiEUNOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354788AbiEUNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:14:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2D3981C
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x143so9854145pfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
        b=EhoD7jpbnPzy8VdYE6Da9KaxEBcK5nlsjBo0jRUA7SnJIr9x2+QTmjnPEitkOsnQ82
         FDg2A+qg3UXTXaiArxi5X5eEPUV5aJSNtwPRJeehjHA3VGR1mkM9C5CY4mJPLzuL4F36
         lqOE23I4trR2zVBpBXiZ5DkATI9lNLbE/tpWLwCOkotOq/WoEN9czrR+EXYnsoQuNu2w
         yxdEtbAxWmMD7yCjDPmH3Ww2RpP2+fVInj4SdXpr3CinpsbcVyd28TsoBVrWFzp4PAJp
         piHHvviLyVYDKifOMHwjHo7umj0r/4EWj26lF67JrSC0X5NwZNYtWiE0GvlBsNS72TI1
         KU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikZ+PR/EklJmOrxEmrNGimc9Z26aJRLTxGu7euJ5K94=;
        b=SIS0BLEE8KvwsRwig91ZiflbaQ3vV6OUXWBJM8aArVKnMccUamryP5s2CXY2teA9hs
         PWuTddT9ujY3r7HqhrLgG8G5/1SKQDSKOIPgf+TkzvvHu8f7y04HTwYvbBHYbH5UjOut
         HM5WRTQAxa/9O5dsr9zzxHx6PWFET+QHD0R/pfZW1LfvHI/X42Gzb7j6/DWKmDqsl6Um
         amOu+7lriqdnxGiWyPRuD5xT/eNRCQ/FjdYnImdWFsFKYkgZK2qQz1Nxn/cMNT+CAgL2
         C4CPv0CvGVlJ0UNWwVz41rchJ48Z62zxynnhmzCXYU99XfcBQ+g61uRwzSURtGyAZv0J
         J5yQ==
X-Gm-Message-State: AOAM5311z/SDETgxdlnJyPAQNOtmLeb4ixkOyeVkY0ckShb55y4zudtj
        R4stjd7+bhw2fk4i03H8QwjzOAZfx9l97Q==
X-Google-Smtp-Source: ABdhPJyKIW3WotfnL1yeSTCYDA2WB1z5y39r22s9dVdmWhEmBH6WpFdAXpzN0ZhCDdIOGpKXR7st3Q==
X-Received: by 2002:a05:6a00:b94:b0:50f:2255:ae03 with SMTP id g20-20020a056a000b9400b0050f2255ae03mr14833395pfj.74.1653138840676;
        Sat, 21 May 2022 06:14:00 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 190-20020a6204c7000000b0050dc76281basm3740557pfe.148.2022.05.21.06.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:14:00 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 07/13] openrisc/traps: Declare file scope symbols as static
Date:   Sat, 21 May 2022 22:13:17 +0900
Message-Id: <20220521131323.631209-8-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

