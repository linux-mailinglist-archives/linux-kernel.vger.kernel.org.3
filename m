Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FFD576CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiGPJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiGPJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:33:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B746326AEF;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so13665984pjm.2;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcGMxSsIcN9kL146zuaiczusg14msCwCUfXlQG72sVI=;
        b=NGLeXJduQSC7uUrFYkfvAPJXznPSlYlPc0hXIW/ZDq7Aa5SpDQNX7MzaY6Jdr14Eac
         FpylrvJk+kGoCzriN1Iwk2oWATCqFQ9SfSgSXlxRSmRfquVS70PY3OxPCOcpebEqRIOs
         i+fa6gL9v4jt2YYq+0Rr4tDxnS8s03bi2cS8JSAUvh7AOV5QMe0Hc7CgEN4+66kNELEd
         PFXnJMlEPk0cFYoMhlo6ilztkL/8aBebrV3CWC4CzmV/oliGF24RU+5Ss7bgDkBvj+Zc
         rXeT1yAibSrzWqpJD/kqdT+vEpKC1OuZzKmJkmJ+2W68BLikxQdTlSb1u6GZS+XlXyE+
         ohMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcGMxSsIcN9kL146zuaiczusg14msCwCUfXlQG72sVI=;
        b=NiyjqshE5JFSf4s2TdwoxqnYks25ozGt4x0P2CzHG2sfr3x7PaN7vJxP3bnERIb5AB
         6z7pnTqm9qHyVv8xeK/maqEguJP5uRpeRqBFwOHIHmV8nY52svRdnbfV6VcDOAdHwm2G
         Z4TFNuo2fTtUw2Y8FVcT5cB/9wcqD3WmCQehNw7pwhwEohQuJ9II9YUFAMtuUrdjmPHj
         QTWWANiJnJGqp772cOn8WkDXibLKjm6tRk9KsBKE7tNcUbHMfr+j7zP8cCQwMnvQACZI
         8bT72aoV/2+CfrFm6+nwTrXBvwovT0GsDsvNlWNRg5ak5o2R4oTzLK/8Hs2TTb9FwbTq
         30+g==
X-Gm-Message-State: AJIora9XTNLLEnTcJX8XW7OIWpmxPztcuG8QunlEzHrDKR6Qs6bzJwUg
        RkZsDa6Y5x3W/lcNLJZm8hg=
X-Google-Smtp-Source: AGRyM1sw20g7aXB3IjmaVmevRm9S5IvX5TlR+DA2DWp3H00fxSQ4LgwWkL7panc5EVUBCB7Z5S7/Uw==
X-Received: by 2002:a17:902:8e84:b0:16c:dfce:f579 with SMTP id bg4-20020a1709028e8400b0016cdfcef579mr943549plb.170.1657964019154;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id y17-20020aa79e11000000b0052ab5d2d398sm5331521pfq.47.2022.07.16.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 02:33:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 794FE103853; Sat, 16 Jul 2022 16:33:33 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kbuild@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/4] Documentation: lto: use bullet list for FAQ
Date:   Sat, 16 Jul 2022 16:32:48 +0700
Message-Id: <20220716093249.19326-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220716093249.19326-1-bagasdotme@gmail.com>
References: <20220716093249.19326-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only FAQ item is rendered as a continuous paragraph, although it is
formatted as Q&A field pair. Use bullet list instead, as in other FAQs
in kernel documentation.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kbuild/lto-build.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/kbuild/lto-build.rst b/Documentation/kbuild/lto-build.rst
index 39cbdb12295051..9e3e14042dda4c 100644
--- a/Documentation/kbuild/lto-build.rst
+++ b/Documentation/kbuild/lto-build.rst
@@ -46,10 +46,12 @@ You can however build a kernel targeted at 32bit on a 64bit host.
 
 FAQs:
 -----
-Q: I get a section type attribute conflict
-A: Usually because of someone doing
-const __initdata (should be const __initconst) or const __read_mostly
-(should be just const). Check both symbols reported by gcc.
+
+* I get a section type attribute conflict
+
+  Usually because of someone doing const __initdata (should be
+  const __initconst) or const __read_mostly (should be just const). Check
+  both symbols reported by gcc.
 
 References:
 -----------
-- 
An old man doll... just what I always wanted! - Clara

