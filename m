Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A465884CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiHBXjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiHBXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:38:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9A3DBC6;
        Tue,  2 Aug 2022 16:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED5BA60DDD;
        Tue,  2 Aug 2022 23:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3DEC433D6;
        Tue,  2 Aug 2022 23:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659483537;
        bh=kE1gCYFgEihzpK3jhHTawC8I47E1q9R6kltPrsYq80w=;
        h=From:To:Cc:Subject:Date:From;
        b=j1/6I2sWf3sQdLxAFvIV6/Vxf37JTNlTXC1DTgkjJ6okwN15VUKctFDeDUPvMWC9w
         vKvbpPncM4pr2oI4xnOOJx+iIyrUBlHXlWnjB+TVnFKL/8VEJ0fNQi5+/x+kJiX8w2
         LzzWI72v/MURZ87qamD81fmnQl4HHwy45RVfkllkYNNHUJZfs+wQXeQNUOjNg07dTZ
         KS6s/oPUKxdN7ED5fzmW8ESIvUgnqUgEn0L/2Vfo11jEQkP9/6zYuG5gCIf6ioxknY
         eKLT0U+ygQ1/8PtYGEt8LzaXjUn/9eUr+XCIvT4r9k3eBtiFJCZC3/Wx4ijvkcRT7c
         4MJ45p3pM14dQ==
From:   broonie@kernel.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Date:   Wed,  3 Aug 2022 00:38:44 +0100
Message-Id: <20220802233844.2613013-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commit:

  a6036a41bffba ("kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3")

from the kbuild tree and commit:

  fe24902ba8765 ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Makefile
index 60a7e3e8b4787,cd1d545f316bc..0000000000000
--- a/Makefile
+++ b/Makefile
@@@ -758,10 -819,20 +822,17 @@@ KBUILD_CFLAGS	+= $(call cc-disable-warn
  
  ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
  KBUILD_CFLAGS += -O2
+ KBUILD_RUSTFLAGS += -Copt-level=2
 -else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
 -KBUILD_CFLAGS += -O3
 -KBUILD_RUSTFLAGS += -Copt-level=3
  else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
  KBUILD_CFLAGS += -Os
+ KBUILD_RUSTFLAGS += -Copt-level=s
  endif
  
+ # Always set `debug-assertions` and `overflow-checks` because their default
+ # depends on `opt-level` and `debug-assertions`, respectively.
+ KBUILD_RUSTFLAGS += -Cdebug-assertions=$(if $(CONFIG_RUST_DEBUG_ASSERTIONS),y,n)
+ KBUILD_RUSTFLAGS += -Coverflow-checks=$(if $(CONFIG_RUST_OVERFLOW_CHECKS),y,n)
+ 
  # Tell gcc to never replace conditional load with a non-conditional one
  ifdef CONFIG_CC_IS_GCC
  # gcc-10 renamed --param=allow-store-data-races=0 to
@@@ -1098,7 -1178,7 +1178,8 @@@ export MODULES_NSDEPS := $(extmod_prefi
  ifeq ($(KBUILD_EXTMOD),)
  core-y			+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
  core-$(CONFIG_BLOCK)	+= block/
 +core-$(CONFIG_IO_URING)	+= io_uring/
+ core-$(CONFIG_RUST)	+= rust/
  
  vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
