Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6774CCC45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiCDD0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbiCDD0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:26:08 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F349517F692
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:25:21 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q8so8180701iod.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 19:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=riAePIdOHWyX+kWI5kEIlQkDYdGowAInsgUw4gn0/e4=;
        b=BlrpAc0LSalr08lxLvWHUF9xqsdrYeT/1mov5HdmySdHvY7zpjGGpvRBzSVE7uyStd
         RFfWon9VgWK3xggfoUkXejf4U8sLAeW88vzXIDjUl4CZZ63tpT4qE6fUpp5hRy5ZbDrt
         nV+6kcnrv5q7GtjDy8B4cuC/te60S6o70rBXya6sDNs0UKra6WerMmeR5cPU5qB4Yn7K
         Zr+hE8G4Zd67A2sks8WC/4yo6JcqOJvYva1NS8pJKDTSj4Ln2MgUpNcvSXvHCgd6yfHw
         dBnvBaKOXYA3nV5h24Uy8mbxbdXBqVBFiOe45hX4Q/scfBbfLF16+Gi4pk+w2DDsMGpJ
         T5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=riAePIdOHWyX+kWI5kEIlQkDYdGowAInsgUw4gn0/e4=;
        b=sxKzrNOL4bm9/0b0BpWujVDZKMZqNUCOH3QvWP1EaATG/tmy8/UKF9BI3sDMhkcgPd
         oghIIqha0CaNMKinz/ehkBt27a+fsxgTy7ky2stziuwpQDlmcFvOvfAyu93rr7/1sRSM
         56DfywEeSOmCD+BpnvsS3Z+/r2QwPnlTfifiAFpS3OZ34kVBB212HMfA8MGfkTDFaqmC
         2+jAj0B7nxZ/T1diS7oU7OKu6zu85wFN0I7g25rGWWydHajnh3vatymXM45pfkwQnJjb
         YFtzKql3lYjcwVsuBDThmSZoAJesgBE/LX+soukVeBXQN4xu5Y35IOTxKk+3rG7ikqRH
         fgvw==
X-Gm-Message-State: AOAM532WBy6/WY9gdBgyQemoLowwvg5RpoqH2TBT+LXl8kX+29uBRiXb
        PfcMsd2VUq5jy0xNBWFlI0Q=
X-Google-Smtp-Source: ABdhPJz78E3vx6SBHXiEi1GHfCNZ5vzWX8+ufbWBvKEaxufsqAfodAKhOc+yxeeg/AGwmU7KQpmD/Q==
X-Received: by 2002:a02:ccea:0:b0:314:8504:cdd8 with SMTP id l10-20020a02ccea000000b003148504cdd8mr32604002jaq.117.1646364321340;
        Thu, 03 Mar 2022 19:25:21 -0800 (PST)
Received: from localhost.localdomain (118-208-215-36.tpgi.com.au. [118.208.215.36])
        by smtp.gmail.com with ESMTPSA id a13-20020a056e02180d00b002c25b51d5ecsm4114751ilv.55.2022.03.03.19.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 19:25:21 -0800 (PST)
From:   Sam Zeter <samuelzeter@gmail.com>
To:     mhiramat@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Samuel Zeter <samuelzeter@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 2/2] arch/x86/tools/objdump_reformat.awk: Allow for spaces
Date:   Fri,  4 Mar 2022 14:16:11 +1100
Message-Id: <20220304031611.5763-3-samuelzeter@gmail.com>
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

objdump and llvm-objdump have differing output formats. Specifically,
objump will format its output as: address:<tab>hex, whereas
llvm-objdump displays its output as address:<space>hex.

objdump_reformat.awk incorrectly handles this discrepancy due to
the unexpected space and as a result insn_decoder_test fails, as
its input is garbled.

The instruction line being tokenized now handles a space and colon,
or tab delimiter.

Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index 276e572a6..a4120d907 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -22,7 +22,7 @@ BEGIN {
 }
 
 /^ *[0-9a-f]+:/ {
-	if (split($0, field, "\t") < 3) {
+	if (split($0, field, /: |\t/) < 3) {
 		# This is a continuation of the same insn.
 		prev_hex = prev_hex field[2]
 	} else {
-- 
2.35.1

