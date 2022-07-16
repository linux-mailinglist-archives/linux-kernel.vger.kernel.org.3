Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD4576CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiGPJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiGPJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:33:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C06FA;
        Sat, 16 Jul 2022 02:33:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so13722438pjn.0;
        Sat, 16 Jul 2022 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fh2I3zFG2OZMmMkmKH7k0vizel0bjDcR+C76uNSPeM=;
        b=f5et3aXcLrNcjOQX9XRxzKgeB+MVoosIhCD7Hz5hRSWonkeoEhaSfDi2VqsfyWj8TS
         QzRMYninq3yqZMom4HcLSNylpadYUlpNLWdob3GW8QrMEoBALoO5YQt24fbeAUyYJch+
         M4VV50AimgfGGUw+B6Vls/cvXIQFVh1Bo2GbX+OFJVeTBiEko6BnLSCAKcEl9fLuyJiz
         wwIwxlwFA7m97KXjj+shAGAV87dwZTNrhJk7dfB6bew9gbd44z1pq/V5GePOp9ZqwHzX
         Oh1Mlro7h380cZQCyZaqQt4Qd9OH/lgFM6L6kT2OU1AFGH1kn0GAANH2w5C/K/HIdwXO
         rGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fh2I3zFG2OZMmMkmKH7k0vizel0bjDcR+C76uNSPeM=;
        b=hfxAiCqeUVlts0YV18JI5X6sKuq5yXO6LeNRXm/wYckHYGnBe2H5bV7AB44BQhldaJ
         2ATEaph2f7bKobhc3uhMvDSNasF0vOTecxAHOK/87b9ToAbksI/u9CaiV64bPSn6e5xK
         k2GvXEghkomzd9qT+z0gvHKkG2jq2VgI1EqfXRPn2OJxg8U1X1gptau3a8zak9etTIFi
         xli6p847F35Xc2Ae8QDMVbNpgeeS+5EggfZIdZftAy1+1qz5+z0swJ0+Q6KUjA/+ipLr
         iwIrrT7EGfBjYNXPR3XhQEe6MDfGzC65BlxPxTGFnTBaB65cDUyFsu2eH9ELLNSrL9ke
         2rxw==
X-Gm-Message-State: AJIora/RZH1zHokM2qza+0MjRPDrgdzw9ROxeXkhA6l7xNjogiXBhuvm
        pA8j4fA5I04sIOpsj0VBtz2u9RROfLU=
X-Google-Smtp-Source: AGRyM1vsiQur0jUyLPbcXsLNvZ3hMHk0z/lt7blHCOpVqSPB8w0ejJATF984vpwY3YU/UvBaGew6cw==
X-Received: by 2002:a17:90a:be0c:b0:1ef:accb:23a5 with SMTP id a12-20020a17090abe0c00b001efaccb23a5mr20576181pjs.113.1657964019667;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b0016c0080df84sm5115147plf.254.2022.07.16.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 02:33:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3674910383F; Sat, 16 Jul 2022 16:33:33 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kbuild@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/4] Documentation: lto: add blank line padding before single requirement list
Date:   Sat, 16 Jul 2022 16:32:47 +0700
Message-Id: <20220716093249.19326-2-bagasdotme@gmail.com>
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

kernel test robot reported a warning on LTO requirements list:

Documentation/kbuild/lto-build.rst:40: WARNING: Bullet list ends without a blank line; unexpected unindent.

The warning is caused by missing padding between the subheading and the list.

Add blank line padding to fix the warning.

Link: https://lore.kernel.org/linux-doc/202207161100.lCdR6Unx-lkp@intel.com/
Fixes: 0350b4dd55922f ("Kbuild, lto: Add Link Time Optimization support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kbuild/lto-build.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/lto-build.rst b/Documentation/kbuild/lto-build.rst
index e8a0f149e8ceaf..39cbdb12295051 100644
--- a/Documentation/kbuild/lto-build.rst
+++ b/Documentation/kbuild/lto-build.rst
@@ -36,9 +36,10 @@ the compiler version.
 
 Requirements:
 -------------
+
 - Enough memory: 4GB for a standard build, more for allyesconfig
-The peak memory usage happens single threaded (when lto-wpa merges types),
-so dialing back -j options will not help much.
+  The peak memory usage happens single threaded (when lto-wpa merges types),
+  so dialing back -j options will not help much.
 
 A 32bit hosted compiler is unlikely to work due to the memory requirements.
 You can however build a kernel targeted at 32bit on a 64bit host.
-- 
An old man doll... just what I always wanted! - Clara

