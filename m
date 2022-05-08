Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7B751ECD1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiEHKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiEHKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:13:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF914BC3C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 03:09:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o69so10749815pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSXBdCfSJMUAzkCp0XgpODL0mMmWwO1EAq44H3Cblg0=;
        b=mglVmfeTg0pzwWVMCUWGwdca84a/kjm+FXJqipUXuDy0u76MlYb5qA7l+XZIedmSbT
         LZAWhZsw40kpYTeQZe5D8yMnk/1Sf54xOfWKCDVoyJZ/BV3uDLDpz9/QcyiLWesaDkc4
         p0oaOsz3gXKnCW/vMxoFbl5WQZh+Hkx7KDblpM/glKaraMvm3U+ATeoiFX/nZ6XjLbb+
         Ypb3ahmqd48VX7zhhnR5wZTm6U9Wi07b/YF6Do0e2dZ5iA753q7xzeKk8rlWm87PnLDL
         Pv/LLudCdJ5X7U69EU4yg977bCN9sD5+nGvWim6jaAmrh2h3vMUwmSxp+eQsGAb7B2sr
         faPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OSXBdCfSJMUAzkCp0XgpODL0mMmWwO1EAq44H3Cblg0=;
        b=j6Sn+N0asBUkYXk0RtJvCMm5SrcWwnxWyC17LpL+g40hj67kc5M0lh53wM3rfDfV52
         YfhstIIziT5YtEAW40uRvvQhYLQd0QarTi+nzeRWYNnGtOcVGPp24exAuySs6ADGP7Gt
         3KA+nWgOrHk3qJKVqEfC+BV92v2A0SbR/7TCXZrSQlbKjJGykNSg3ZBxoTChjJ8atHhj
         ap7z0E6xHVUZlesiJCXftaaM6VfAGVI0qJ3ndJDaY9JVLSrGTxd/mFZ8GXrcK+uaQdBN
         MkvZrPHGrQRIsqfu1HhyONT5lJwIkldlShzx2Zvn930MAwGMoN9c5PWiCsmbdxm6GBJc
         MDJw==
X-Gm-Message-State: AOAM533qRfIJIghc7RqPUt4mqMDmHjI3PgX2T8ceb5GsufrXDllQrHSA
        j4HcJEOHPDIW+1I3c0qky1w=
X-Google-Smtp-Source: ABdhPJxsKgMiOiA7kLB7ubRPN9bd4LR5Vy/V7fwjoIFlrIMTkjTJPa+lB7UhERPH7RFe2rpEEhiMwQ==
X-Received: by 2002:a17:902:e841:b0:15e:b10a:9f40 with SMTP id t1-20020a170902e84100b0015eb10a9f40mr11270415plg.128.1652004595294;
        Sun, 08 May 2022 03:09:55 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id v10-20020aa799ca000000b0050dc7628166sm6417093pfi.64.2022.05.08.03.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:09:54 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent shadowing
Date:   Sun,  8 May 2022 19:09:07 +0900
Message-Id: <20220508100907.61231-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside of the __builtin_foo() ones, x86 does not directly rely on any
builtin functions.

However, such builtin functions are not explicitly deactivated,
creating some collisions, concrete example being ffs() from bitops.h,
c.f.:

| ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
|   283 | static __always_inline int ffs(int x)

This patch adds -fno-builtin to KBUILD_CFLAGS for the x86
architectures in order to prevent shadowing of builtin functions.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
FYI, I tested this patch on a "make allyesconfig" for both x86_32 and
x86_64.

This is a resend. Only difference is that I dropped the RFC flag and
added Arnd in CC because he did a similar patch to fix ffs shadow
warnings in the past:

https://lore.kernel.org/all/20201026160006.3704027-1-arnd@kernel.org/
---
 arch/x86/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index e84cdd409b64..5ff7b6571dd2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -53,6 +53,8 @@ export REALMODE_CFLAGS
 # e.g.: obj-y += foo_$(BITS).o
 export BITS
 
+KBUILD_CFLAGS += -fno-builtin
+
 #
 # Prevent GCC from generating any FP code by mistake.
 #
-- 
2.34.1

