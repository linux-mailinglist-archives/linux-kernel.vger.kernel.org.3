Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039F5B28D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIHV5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIHV4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:56:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CFD923DD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a056902038300b00696588a0e87so28753ybs.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=yl11LIApBFscsnI+fScXVW015zNFVVk9U+TQyeaAxKE=;
        b=GneJREjJ6ADU4W7/ReKz/IuR9lVLfatPLfDz2sHd3Z0TSlegPeJdDw7OSG8XNao9Cc
         XClfbsayKVd0y+X+4JXAICNqa2OmvX2ENIWqoO6k+faEZ++p7TFHmvVIzScdINlVq34F
         FN9jeMDz1qOKCPO1TOf5xFWdwH0Q9N4CA8VT14OghYhxjRIAqYYgPoFwiKHkJJO8faXR
         5pKZIxZYHX87ntAT+fga2CjaHC54Aq6tAB4RyMWklOlrc6Vy1C3SjghwdOmNw+THrcgT
         /og9oY6PpFsR6SL7WBqBv9KsZq6cMPm7WIn8a+QGZzkpgDzvQXJVjquHzJpUkRz4PCME
         GBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=yl11LIApBFscsnI+fScXVW015zNFVVk9U+TQyeaAxKE=;
        b=ZubfKHdOiSQPowdergVLUsxhbPV8jJwYpv+kJVTrLpSXG/W14Zglzsyif0NWkkfEk6
         Ky5u9LIHtHqNJ6c7DvA3z7mQzLcFkqs7ajKvjcuaBQMu5etRJykB+A02Te1VHU0AmCxB
         go9iHVkAWqJkI5SOBsV9Lg0zBENGz/Hyh2iTVcZtdSnVlUFj/vTAT+Hv3RCkxma4t9Cn
         JIFTxDU7Kwk4DvcgFLeN0dYrQu9IV64w1TPZz4m1L45BILD/9NgnVyAwZyLAzFyCytU5
         cVuwBmYNQ/lrP2ZHp67Ct5ZxUjHKm9qWsu+CbaG28hzzbuhZlhgBluN50nNanIXQ5q2h
         cPIw==
X-Gm-Message-State: ACgBeo1lbwCPCbl+G9CojoXYOhF/DWSMHTLTOyPioAS8KIq/X5CeqZSq
        Qs9ne8SDkcO053CNseCRPfzkd9thgkPrU0p5TruoebyluqXf/ORAdfDYVo87qbRFbo/tPSjvZW1
        RUXgsR9H4EGsAfYMGvcNFxuffSbNQcWniC1XE+ocOa18GeqnDoQJaMxwuKYpzJ3J7eWPPv1RNRQ
        mPec7h5t4uJw==
X-Google-Smtp-Source: AA6agR4ULRG2fn/4MvHB7Upa4n4ytCQI8NCVc7O2QP5EfzzC8LFh7M6fWp3jHy5tpAo982OuvoU6oY8hq/cyyMrvUpE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:1453:0:b0:345:5b61:d495 with SMTP
 id 80-20020a811453000000b003455b61d495mr9322121ywu.261.1662674157100; Thu, 08
 Sep 2022 14:55:57 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:55:01 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=samitolvanen@google.com;
 h=from:subject; bh=8UKd2RwBqIGRpxvWBctEPftksuo7xy3etrWY4ppBfO4=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2DEX9D50vsIuHptb4slNB2Z5bL4svRnxLqioZ
 ax2niESJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7gaHC/
 4mJOr67kF8bJ5ApvzJHi00OaK7Hya3xvWpMQ1V8eIEgWBZngw8eWVT15v70FQgGT6QtYYPXLn1tAg0
 fm5a0oS5rhFD8zNfE8d1wnHg+N1ATc0YkU8K/cUqrt/GTaIVPEiSpEAttdBYmLoeQN+pqgbN/oWl0J
 eYEh65EgL1UUMwLkDYkIGmuJfmeirnJ/Z45+IAbPrkI66qz5DtAZWu+EdRSBVn8FQ6CIo5Fl1P9fEr
 DXNtA4y61L6ed+iwmnYG8KMu2ytOV1PxpyBxjtrpvoPUZpp2iqjQUiVpZ5xNFm3IO85ZsmgHL8EEdL
 3uUTCKAVxd+5SuiSx7S93dcY08+rV38yOAADTl4j5NhZLaYP9Br1LxwrbOF2GZ8dbIEOigx00ihAIx
 S/Lqi3OGZb9xvPNrL7JsuqhpGNIpnFxka61Wfyxxn09x5v7r5nrWooRTunJGxtvMCeIl7PMifw1TSJ
 OUz+6dT2Vz2mrA6hAhSFQR+ArqVExBMkQSPubSrVGgvQk=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 19/22] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be
referenced in assembly code and are resolved by the linker. Ignore
them in relocs.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..2925074b9a58 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__kcfi_typeid_|"
 	"__crc_)",
 
 /*
-- 
2.37.2.789.g6183377224-goog

