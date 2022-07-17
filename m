Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6074577656
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiGQNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGQNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9211471
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79095611C2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE66DC3411E;
        Sun, 17 Jul 2022 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658063632;
        bh=SR/Q//g0+IKlH01K4dfCTow+zKGYw1O92eh3yDYcL5o=;
        h=Date:From:To:Cc:Subject:From;
        b=bcE7kt8syQ1eVlw+BrSP7lCbkS/gSf4zYl8ScBoTHXFEFQmhoxPCxY3XaxrkmFn7E
         BR6sFvkw50CpZHasD59Vla1x0nPFUHXx13wB+1WCEmCnSn9OIvYtehTxrEUJB3qc6u
         YHuKXd4yPGfwH4q6ZKemSewvj7nQ+WMfvwVLb37ODOClTRcT7/v7PxqxvY41X0tt1U
         nr/N/03hZv1EL4hDvnLNkFp9FCNDqLnJxjrp7BDiseeOw/s0fNCBkMYniRneRPcEYh
         WzH9ZIryvkigX8/aF/VucOHpnGqhSFWX9LItVxlg6jOcGRjpSH3T0aYkJkYy8Bix6r
         AkI6SGKVYPnuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 60F5B40374; Sun, 17 Jul 2022 10:13:50 -0300 (-03)
Date:   Sun, 17 Jul 2022 10:13:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <YtQLDvQrBhJNl3n5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
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

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in:

  1b870fa5573e260b ("kvm: stats: tell userspace which values are boolean")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This is also by now used by tools/testing/selftests/kvm/, a simple test
build succeeded.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: http://lore.kernel.org/lkml/YnE5BIweGmCkpOTN@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 5088bd9f1922851f..811897dadcae259f 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -2083,6 +2083,7 @@ struct kvm_stats_header {
 #define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
 #define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
 #define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_BOOLEAN		(0x4 << KVM_STATS_UNIT_SHIFT)
 #define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
 
 #define KVM_STATS_BASE_SHIFT		8
-- 
2.36.1

