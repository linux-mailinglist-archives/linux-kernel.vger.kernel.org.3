Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60053194B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiEWUCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiEWUCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:02:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378A8AE4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:02:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j21so14358468pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0p/HAnV3FGOX2Y2wsN2FzcZNAxVKvVayMr9i19gY+0=;
        b=CoRBX36g0EGqqDlp66VpKgy5bMDWvH3Arx3I1Riykn7FrIRwfvubnSe8O7Jc68AbIU
         HynARqzTV1jaejYdFmOcWo2ABJBzqz56v5kaogvXE1ZsQc5qS6hmf8XxDtlil7IYtEYU
         Z+GcXo3sjbPSTxeUa8P28M1igkBelltpcBM1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0p/HAnV3FGOX2Y2wsN2FzcZNAxVKvVayMr9i19gY+0=;
        b=4MXyHxEf2DLq3zLMq+c7rzJJCQ0QvuypIlaXyzCWViG/93G4LZJoIhiY9IW+DJiqoL
         ANkMt0sN6b5DMq8pVcXOhVYJYIolWaSn1AIM3+YxwK2UrDTBp4NWEdewoI4V49bOl1qY
         6PubZe1mHMfua7u8GQ4mihxVFDzK2gOzBF/KL1Brh2DI0kTj+jPOdacpk1fkeGbhZ95x
         V8mBvtO7pRc+g+nLKUndQ9FWcOehskW9GH3QXIVJ6LM5lnuuqkbVlYKpehx8vLw2lpU4
         fYxI193Sewm3mtiWgQ8v3DtSAH1M0xGbV1jGaH1pV7BYJTq2h7UcacbIfUeG2q4GUKvO
         NG/g==
X-Gm-Message-State: AOAM533osYo7rHV1DGiimigX9N5oTXLUwkhVCKxBKrpNhAWr6kKLeqLN
        JCW2AykbLQlMSjupm6Fvxi7flQ==
X-Google-Smtp-Source: ABdhPJzp0Zj+BZjYXq2M1yOl1PXoJQKidljsOFtUda77UaCzrOiDDFv1NDhj0tsHeceLSXvasZBMvQ==
X-Received: by 2002:a05:6a00:1a47:b0:510:a41b:362d with SMTP id h7-20020a056a001a4700b00510a41b362dmr25180802pfv.30.1653336148332;
        Mon, 23 May 2022 13:02:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r6-20020a170903020600b0015e8d4eb269sm5538333plh.179.2022.05.23.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:02:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] gcc-plugins: Require utsrelease.h before scripts target
Date:   Mon, 23 May 2022 13:02:22 -0700
Message-Id: <20220523200222.711011-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; h=from:subject; bh=GvufeHy+78JEuMy54V3qf1lkpxWJzuF4fc5MMM9sDUA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBii+hOQgjZLcYybo6E+6fZFSNl4P6DzSRlVieoLS1c ZBk5f82JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYovoTgAKCRCJcvTf3G3AJotdD/ 9tBCJ+BAO1f0vaGeoG4fz9MdMs8860f0tO9BJ5fPPjTdsFI3/BRPuSpX3gdZlBMiqLGMqLnfftF/YK ETuHwf6csllm2QYdh/8xEKJPsE8D2l62UIG6jEcom/m+rCUEwINczP3g4XA8k128xQoLvbmgTPjJQa CckujR2b1DgTeS22cTwbQiyKJ4r1djNYnGzJHcE5lvJgjI1abmnu2XZtzq615s5LKeZgB1BYj4hGVP e1pkM9InkGT4nRqnDUaBUyTzn3rR/v0mdEbqpEbSdfhNUKyOH8zlLcpdJOP6HI9OH9eYnruOD9Q53Z ktMnUI9izbXeBZpLZ1bSsuy0YfMJeSVib9fMHq9R8lVzA4vJpEsPhv8z6DP2kLJ47OyVtbm1c36n2T X0ib7KFIYOleBWf9UyKna48h6AVPxZ+48RQqWRwF6o5VkJilsIUNAB1j0h+Pcb9J9kNzrSMPphaq9G VIVClyLJ3JAQ1ITXGvyDNGL7iXz7cba2TtZ72yUYrimv3835DK2TsbjoN7qTPhD6mstLMn2h8h2g3O +LHg572+wMEKAMGHtgdfHDhmeqvZ1pvPedEZh1MINOpoMI6pVCEM9ARC75+a3/F+ECGAzaSAq7JG9e IO3Mrjhu3sTsYMuNoEI0zXJc6wSDDnIiO2vbUP/oMBV4+iM253n+gUta+adQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "utsrelease.h" target was in parallel with the "scripts" target,
which meant -j1 or unlucky parallel builds from a distclean state would
fail to build the GCC plugins.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-mm/202205230239.EZxeZ3Fv-lkp@intel.com
Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/lkml/YouX6g1T7w3FDeM8@cmpxchg.org
Fixes: 61f60bac8c05 ("gcc-plugins: Change all version strings match kernel")
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile                     | 2 +-
 scripts/gcc-plugins/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 91c91fcf3c24..c04420d5aa3d 100644
--- a/Makefile
+++ b/Makefile
@@ -1175,7 +1175,7 @@ include/config/kernel.release: FORCE
 # Carefully list dependencies so we do not try to build scripts twice
 # in parallel
 PHONY += scripts
-scripts: scripts_basic scripts_dtc
+scripts: include/generated/utsrelease.h scripts_basic scripts_dtc
 	$(Q)$(MAKE) $(build)=$(@)
 
 # Things we need to do before we recursively start building the kernel
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 6f0aecad5d67..c29334669a16 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -64,5 +64,5 @@ $(foreach m, $(notdir $(plugin-multi)), $(eval $(obj)/$m: $(addprefix $(obj)/, $
 quiet_cmd_plugin_cxx_o_c = HOSTCXX $@
       cmd_plugin_cxx_o_c = $(HOSTCXX) $(plugin_cxxflags) -c -o $@ $<
 
-$(plugin-objs): $(obj)/%.o: $(src)/%.c FORCE
+$(plugin-objs): $(obj)/%.o: $(src)/%.c $(objdir)/include/generated/utsrelease.h FORCE
 	$(call if_changed_dep,plugin_cxx_o_c)
-- 
2.32.0

