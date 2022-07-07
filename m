Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16E256AA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiGGS1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiGGS1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:16 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A245A445
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:27:15 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id g1so16574588edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=pfx1nhZRFJd2pn0JeiqJxpeFaccnacgeVbyuvYlXCkA=;
        b=1OIZ2kcau+30gloMmWPAHATGW7uuk5FxTbGA6XiAJwat8uBVHCCju3ebrfpIgQQJxW
         BZf52C+TjTAj3TT5IDoUvD3eS1cR9wxQ5EULAEy/yHYv6QCoYvl3H1vditiJb4zpR1yi
         uHzFTLpUMiKd7F/J4kB20QTZSBesg2k79yCVyLqew1NRAaR0WtMwJHFSquznyF6F1dAH
         vXyZiX9QptPIrYHxM9bAdShqCrnYcE/kgjXBuiZcqgeufHQN/v/whBl8n72ITA6AzlgI
         asWv6FrXNXYeu/t+dgHga4yUM07ItMhWUxJ85DcWD1p/bOmr8uTwtqH3Of+oS9FSp2a5
         mRDA==
X-Gm-Message-State: AJIora/kHxvaWWhTIEjUW10bNTb+Qbyfcfd7+AbX2QIxS04VjDMTILqg
        hD3bVvGK4+bk+WxdwZ4mSojEcLJ40ko6KWi1Kkg=
X-Google-Smtp-Source: AGRyM1vPQlfazhY3o3EK5xIq8fwoSIy+aI1rtaTsMAdg9o4Toc2blkMRyQHaS6DVSsWxcvXXZv6DPg==
X-Received: by 2002:a05:6402:1844:b0:43a:7c15:c626 with SMTP id v4-20020a056402184400b0043a7c15c626mr20068919edy.17.1657218433888;
        Thu, 07 Jul 2022 11:27:13 -0700 (PDT)
Received: from [192.168.1.15] (178-222-165-43.dynamic.isp.telekom.rs. [178.222.165.43])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b006fe8b456672sm12861790ejt.3.2022.07.07.11.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 11:27:13 -0700 (PDT)
Message-ID: <fc2a1d53-afe6-d496-ddcd-8ee35102ccd8@pionir.org>
Date:   Thu, 7 Jul 2022 20:27:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Content-Language: en-US
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Ognjen_Jovandi=c4=87?= <ognjen.jovandic.5@pionir.org>
Subject: [PATCH] arch/i386: Fix the AMD Elan SC520 PIT clock source to
 1.18920MHz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ognjen Jovandić <ognjen.jovandic.5@pionir.org>

x86/i386: Fix the AMD Elan SC520 PIT clock source to 1.18920MHz, which deviates from
standard PC/AT clones.
Signed-off-by: Ognjen Jovandić <ognjen.jovandic.5@pionir.org>
---
Changed PIT_TICK_RATE to 1189200ul which i found in Élan™SC520
Microcontroller User’s Manual Chapter 5 CLOCK GENERATION AND CONTROL.
Found problem while trying to port OpeWrt 21.04 to Soekris net4501.
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -5,9 +5,19 @@
 #include <asm/processor.h>
 #include <asm/tsc.h>
 
+
+#ifdef CONFIG_MELAN
+
+#define CLOCK_TICK_RATE     1189200ul
+
+#else
+
 /* Assume we use the PIT time source for the clock tick */
 #define CLOCK_TICK_RATE		PIT_TICK_RATE
 
+#endif
+
+
 #define ARCH_HAS_READ_CURRENT_TIMER
 
 #endif /* _ASM_X86_TIMEX_H */

