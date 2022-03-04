Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F347B4CCC44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiCDD0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiCDDZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:25:59 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE417F683
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:25:12 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q8so8180454iod.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 19:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xdoric3RTXYKwt8RzxRE1iq6shIZZ4Zbnw0lFh9QTVo=;
        b=jeaZuKcsBmQce6PQhFrYx4iFqsn3He+X6muOBJ200kVs09Zu3QRdyk624e3vxeZghv
         u7vWIXZMzrebbTRdroLdnGa1hv9tt+n6IIyb6Rif4Ry8k7MWhPsRumdFWgxEVE/uPI5D
         TQwWRHLfih2vxL3zgCRca5/f7tYptB2hwsBE1tnbdpbdNAEbzzK6tzCZLTt05RwoUttZ
         hZORyRZCSrHXm/cuMN9JJhjPjXgK8U1e/PIdLnFEXAWU/giF4Bm4a8WbeDoHKZf6xhsy
         vk/JPVaLxDmcJMr9nbKr44RJkw9hl/fH+W53dpsXtqaH52UkbzxCZg232iWUXS8wYqu/
         BF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xdoric3RTXYKwt8RzxRE1iq6shIZZ4Zbnw0lFh9QTVo=;
        b=TfcVQSNnDdrq34kXSZ6Om6vdLxPdfV7OCqNimrg4OiEqCoFKoeC2OMuYEUXsSKENu7
         0eUnErjU1N7gg7bisqVOpXgIZgzKHAPdtTstEr71CWRn80/ZJdgs7QzZa3TLb4sHuD+A
         dUpqYnT8aHehV6tg1Tkb1Z9ZfNtWpHpAdSff7czrRebHns9JYjvfLnICysVgJN1vIemE
         UrL8ipwCFrIdGxH7kWaNw5Z0U8llYhpoDgsha+qdrYTK6uwNFe1cnssPx/NSv6SXtt+5
         +jMJD3wCLIbp+daObG8GJQkuvrpgp2wOctPjgUbHKc+vp6SpxvYabdpGdDBM+xzgpbLh
         xQZA==
X-Gm-Message-State: AOAM533gku+hz4pLJfdPEwI9J5+2Pciv9WahXD+hli3PNBYkSh3w+rpX
        E2QeIEa0INFc5sLge3RjmTg=
X-Google-Smtp-Source: ABdhPJwczl11AmL9YsZuJB7WvjCsPze/5RxIoLnjktu+CCtjBpHKnTXGmtaIq3m4efV1wMbl4R5ZMg==
X-Received: by 2002:a05:6638:1514:b0:317:738a:8418 with SMTP id b20-20020a056638151400b00317738a8418mr4836433jat.71.1646364312169;
        Thu, 03 Mar 2022 19:25:12 -0800 (PST)
Received: from localhost.localdomain (118-208-215-36.tpgi.com.au. [118.208.215.36])
        by smtp.gmail.com with ESMTPSA id a13-20020a056e02180d00b002c25b51d5ecsm4114751ilv.55.2022.03.03.19.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 19:25:11 -0800 (PST)
From:   Sam Zeter <samuelzeter@gmail.com>
To:     mhiramat@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Samuel Zeter <samuelzeter@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 1/2] arch/x86/tools/objdump_reformat.awk: Ensure regex matches fwait
Date:   Fri,  4 Mar 2022 14:16:10 +1100
Message-Id: <20220304031611.5763-2-samuelzeter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304031611.5763-1-samuelzeter@gmail.com>
References: <YdeGWyzvsXxntcAT@archlinux-ax161>
 <20220304031611.5763-1-samuelzeter@gmail.com>
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

From: Samuel Zeter <samuelzeter@gmail.com>

If there is "wait" mnemonic in the line being parsed, it is incorrectly
handled by the script, and an extra line of "fwait" in
objdump_reformat's output is inserted. As insn_decoder_test relies
upon the formatted output, the test fails.

This is reproducible when disassembling with llvm-objdump:

Pre-processed lines:
ffffffff81033e72: 9b                    wait
ffffffff81033e73: 48 c7 c7 89 50 42 82  movq

After objdump_reformat.awk:
ffffffff81033e72:       9b      fwait
ffffffff81033e72:                               wait
ffffffff81033e73:       48 c7 c7 89 50 42 82    movq

The regex match now accepts spaces or tabs, along with the "fwait"
instruction.

Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index f418c91b7..276e572a6 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -12,7 +12,7 @@ BEGIN {
 	prev_hex = ""
 	prev_mnemonic = ""
 	bad_expr = "(\\(bad\\)|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
-	fwait_expr = "^9b "
+	fwait_expr = "^9b[ \t]*fwait"
 	fwait_str="9b\tfwait"
 }
 
-- 
2.35.1

