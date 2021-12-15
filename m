Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA5475ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhLORYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245495AbhLORX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:23:58 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC77C061747
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:23:55 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e10-20020a17090301ca00b00141fbe2569dso6734140plh.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iGbvXQdkxYPoygjkM3JM9RpVpo+BIs+MXjiiOrhhuyA=;
        b=B03ht7PY4Fjl7Z7WQAU3hcdcDr2OYcC9DC/4P4ahXm7bv1hzPXN1T2n7+txvRmbOhC
         YATe4MzbArKiHdTr/399Ibo4g8EinaAxpLgDHRtnqLMh84cASaMCyP4roVhvRQmnYu1u
         /3McHgmT3oCLSVPl2v+vdK209GH63GtZJ2yGMk/Uhthl7YBbmAFQkiAgrJS7fKOvCkth
         Bx70CZS6bqkrkrUSjoUuhJ0H4eH2cQm8GpJvmgzNq6wYkU8kdVP3K2aYMZPwa7LfKPpE
         hSIZZ1WedIEp5G4oSzPNUlBrt+RPs96n7UpeWfVUuGeQXaXb3uB0fhEoMUjkl3kgJuNn
         U2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iGbvXQdkxYPoygjkM3JM9RpVpo+BIs+MXjiiOrhhuyA=;
        b=qV81zz+FTbcMTW9bkj0PD//812C4OEkOIzVo+Dwqo4iA4RaKILi+5Bm2PxaoH4PSIM
         r9GaA7Eb9BB3890FG2tVpsnWnCLuBA5QQGyGDSy1KfFbqdEXGmcAKtgY0Eymszkd9lyb
         i6r+FvyGtnlrwYaq25Q063ttfcLEygXgu+TWphcnGVTWcpW0f8wpHtdgg/GxiOL3aoMX
         s1iiPO/YEbIs7PeFFrK6uiCK0UK6mYAqkDAl5+ZHguWuCX5wCmoMWjH9wb1cD9R2aXzw
         0rhsEksza8NNhaL5NJ/nUsHKlBT/VviOXMNiTbBxduajnkz6X05ui4qeTSIewoKP61vG
         XrEw==
X-Gm-Message-State: AOAM533Hoq3kXHtwXXLqU7unfx51d4GmigHJp3aA6zdQ1N3SW399a6Ra
        B0qEgb+tXZ8I3lAm3htw3d3g6JCSFEOIcjBnmUE=
X-Google-Smtp-Source: ABdhPJw+10CLUnkffKKUBEF/3CRyQuvMh1K1OdfusYdAAHxAwz6xoyzTP2Kabcx8WsFsESUd5WB6dAzMDD6UmftSCk8=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:aa7:9416:0:b0:4a8:3012:80b6 with SMTP
 id x22-20020aa79416000000b004a8301280b6mr9943495pfo.6.1639589034973; Wed, 15
 Dec 2021 09:23:54 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:23:49 +0000
Message-Id: <20211215172349.388497-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 1/1] kbuild: install the modules.order for external modules
From:   Will McVicker <willmcvicker@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel-team@android.com, Will McVicker <willmcvicker@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to install the modules.order file for external modules
during module_install in order to retain the Makefile ordering
of external modules. This helps reduce the extra steps necessary to
properly order loading of external modules when there are multiple
kernel modules compiled within a given KBUILD_EXTMOD directory.

To handle compiling multiple external modules within the same
INSTALL_MOD_DIR, kbuild will append a suffix to the installed
modules.order file defined like so:

  echo ${KBUILD_EXTMOD} | sed 's:[./_]:_:g'

Ex:
  KBUILD_EXTMOD=/mnt/a.b/c-d/my_driver results in:
  modules.order._mnt_a_b_c_d_my_driver

The installed module.order.$(extmod_suffix) files can then be cat'd
together to create a single modules.order file which would define the
order to load all of the modules during boot.

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 scripts/Makefile.modinst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ff9b09e4cfca..2e2e31696fd6 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -24,6 +24,10 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
 suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
 
 modules := $(patsubst $(extmod_prefix)%, $(dst)/%$(suffix-y), $(modules))
+ifneq ($(KBUILD_EXTMOD),)
+extmod_suffix := $(subst /,_,$(subst .,_,$(subst -,_,$(KBUILD_EXTMOD))))
+modules += $(dst)/modules.order.$(extmod_suffix)
+endif
 
 __modinst: $(modules)
 	@:
@@ -82,6 +86,12 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
 	$(call cmd,strip)
 	$(call cmd,sign)
 
+ifneq ($(KBUILD_EXTMOD),)
+$(dst)/modules.order.$(extmod_suffix): $(MODORDER) FORCE
+	$(call cmd,install)
+	@sed -i "s:^$(KBUILD_EXTMOD):$(INSTALL_MOD_DIR):g" $@
+endif
+
 else
 
 $(dst)/%.ko: FORCE
-- 
2.34.1.173.g76aa8bc2d0-goog

