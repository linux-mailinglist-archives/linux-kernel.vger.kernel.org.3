Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EE74BF76D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiBVLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiBVLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:46:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9342D13D57D;
        Tue, 22 Feb 2022 03:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29CF3B818F0;
        Tue, 22 Feb 2022 11:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DF4C340E8;
        Tue, 22 Feb 2022 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645530339;
        bh=pzXQp3gLZJn/et9RYHZDznc/NFxqsdIZIn4P2XMVLMA=;
        h=From:To:Cc:Subject:Date:From;
        b=V5wzeJJA2HiAP0VEAVbEMHnIWmw7AIfzO20Tsm71orbxgvTLZRCBFh9Bc4Ed6vLLh
         zFDYcNho8lbjOOastBzOJF4z4m/7vgNnyzNs9OwJ6w46tj01R84rkk6wiUPEN8Vjni
         qZaMUzRVGHEv7DxGNCtIub+JNWFfrF7s2KP9FNKyk1RxFsAMzTzjAkjvaOe2y9ZGN6
         00m+czw578lA4ZwQHOlg48lY5V9YPNJWvO56TbBS0ZH0IdEc79mi/WFg6UjnzL5lj9
         Y6rAodJlSD7OP+9oifG+ZI+sPLCPJHcJIm7Ibol1uFF1DWKgVIKR9AuJfvoNswuvdR
         yzOYHFasaJWRw==
From:   broonie@kernel.org
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: linux-next: manual merge of the nds32 tree with the kbuild tree
Date:   Tue, 22 Feb 2022 11:45:36 +0000
Message-Id: <20220222114536.743705-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the nds32 tree got a conflict in:

  arch/nds32/Kbuild

between commit:

  8212f8986d311 ("kbuild: use more subdir- for visiting subdirectories while cleaning")

from the kbuild tree and commit:

  37160f01e8ea6 ("nds32: move core-y in arch/nds32/Makefile to arch/nds32/Kbuild")

from the nds32 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/nds32/Kbuild
index ac127371afa47,565b9bc3c9db4..0000000000000
--- a/arch/nds32/Kbuild
+++ b/arch/nds32/Kbuild
diff --cc arch/nds32/Kconfig
index 013249430fa3d,a20b42d4bdb6e..0000000000000
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@@ -61,6 -63,12 +60,9 @@@ config GENERIC_LOCKBREA
  	def_bool y
  	depends on PREEMPTION
  
+ config LOCKDEP_SUPPORT
+ 	def_bool y
+ 
 -config TRACE_IRQFLAGS_SUPPORT
 -	def_bool y
 -
  config STACKTRACE_SUPPORT
  	def_bool y
  
