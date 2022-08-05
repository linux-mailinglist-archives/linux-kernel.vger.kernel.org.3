Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC97658AA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiHELpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiHELpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7553AE5C;
        Fri,  5 Aug 2022 04:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE7761994;
        Fri,  5 Aug 2022 11:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE00C433C1;
        Fri,  5 Aug 2022 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659699934;
        bh=/zyKKjMtOQHTvwxqMWAg9TgodqQqDfbE4hEe3BkPqnA=;
        h=From:To:Cc:Subject:Date:From;
        b=MfNsottNE6gf1062vbRy9pjkRO5XedDXmRne4I22XI2ArMkSBfMl98efwRhYNKFIw
         LqvRjMhGysOKVUMvGOgioUshU3f94MMTkCbdZpeXrr8CO2JpDb8kGEKv9uoQ75xxit
         FKKEIwUsWsYTbkl/8aaIKCHpdkbLRBsT8niJNz8hgJKu7ehO27UkiJ5l2B3BDBOEu3
         lv6XU/8wML8P45Ii9R8aM46bFmJbbvoqFksFh23lbfwJmkOShfGS0LDZHwQcuCs/1+
         +xYN9WryCzUnwfMT8PysDMCZZWMWnwUBxVX76zUaHZ+AgrR8jedQXXwcWL3OIGtz2u
         b6wXLqBO/Cxtg==
From:   broonie@kernel.org
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andres Freund <andres@anarazel.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: linux-next: manual merge of the perf tree with the origin tree
Date:   Fri,  5 Aug 2022 12:45:29 +0100
Message-Id: <20220805114529.33777-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the perf tree got a conflict in:

  tools/bpf/bpftool/Makefile

between commit:

  450a8dcb8c7f8 ("bpftool: Remove zlib feature test from Makefile")

from the origin tree and commit:

  1e1613f64cc8a ("tools bpftool: Don't display disassembler-four-args feature test")

from the perf tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/bpf/bpftool/Makefile
index 6b5b3a99f79d4,517df016d54a2..0000000000000
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@@ -93,8 -93,9 +93,8 @@@ INSTALL ?= instal
  RM ?= rm -f
  
  FEATURE_USER = .bpftool
 -FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
 -	clang-bpf-co-re
 -FEATURE_DISPLAY = libbfd zlib libcap clang-bpf-co-re
 +FEATURE_TESTS = libbfd disassembler-four-args libcap clang-bpf-co-re
- FEATURE_DISPLAY = libbfd disassembler-four-args libcap clang-bpf-co-re
++FEATURE_DISPLAY = libbfd libcap clang-bpf-co-re
  
  check_feat := 1
  NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
