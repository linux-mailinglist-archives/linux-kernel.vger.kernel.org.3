Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD74D596EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiHQM6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbiHQM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C7108C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9603D6121D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0D3C433D6;
        Wed, 17 Aug 2022 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660741108;
        bh=KA0LJwCDv/yxojW8VK/ZAfUNP0t0xoJuytxNFbEZiR8=;
        h=Date:From:To:Cc:Subject:From;
        b=BEAu7ogEtiN47eJmaowJL4LAKBhvhMKSCKVO7c40lRGJNF3xiRzChOyBHmJaXxKlV
         D5T+3iza+H2Kw8se8O2TJIzxeXLGUBCQk5F9MeOOfmgYk0kuJDz7LMGHNiFYXwnuwQ
         WPtjxBEjzGXneHml2S4MAUF9Nnb/S0FcihsK4swmej11q8ya9yclPaMvQmMsUeqJVO
         0q+1BTVb+wCPjEiAYtv55yXR39GKTmWoIrj4KWDFxytiiMER6CmFlPi/EBovzfpKXF
         0gsnGZmlDhcbHbaPlzOO1OUtpr+Xcjhsp/LdJaLwKL5OtIJDkA1DSEzQQgBCYGVk9t
         q6exS/7I146Jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B41EF4035A; Wed, 17 Aug 2022 09:58:24 -0300 (-03)
Date:   Wed, 17 Aug 2022 09:58:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Subject: [PATCH FYI 1/1] tools headers UAPI: Sync linux/fscrypt.h with the
 kernel sources
Message-ID: <Yvzl8C7O1b+hf9GS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $
  $ tools/perf/trace/beauty/sync_file_range.sh
  static const char *sync_file_range_flags[] = {
	  [ilog2(1) + 1] = "WAIT_BEFORE",
	  [ilog2(2) + 1] = "WRITE",
	  [ilog2(4) + 1] = "WAIT_AFTER",
  };

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes from:

  6b2a51ff03bf0c54 ("fscrypt: Add HCTR2 support for filename encryption")

That don't result in any changes in tooling, just causes this to be
rebuilt:

  CC      /tmp/build/perf-urgent/trace/beauty/sync_file_range.o
  LD      /tmp/build/perf-urgent/trace/beauty/perf-in.o

addressing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from latest version at 'include/uapi/linux/fscrypt.h'
  diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Huckleberry <nhuck@google.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fscrypt.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 9f4428be3e362668..a756b29afcc23749 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -27,7 +27,8 @@
 #define FSCRYPT_MODE_AES_128_CBC		5
 #define FSCRYPT_MODE_AES_128_CTS		6
 #define FSCRYPT_MODE_ADIANTUM			9
-/* If adding a mode number > 9, update FSCRYPT_MODE_MAX in fscrypt_private.h */
+#define FSCRYPT_MODE_AES_256_HCTR2		10
+/* If adding a mode number > 10, update FSCRYPT_MODE_MAX in fscrypt_private.h */
 
 /*
  * Legacy policy version; ad-hoc KDF and no key verification.
-- 
2.37.1

