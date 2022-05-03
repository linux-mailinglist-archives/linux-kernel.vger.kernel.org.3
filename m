Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA72518655
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiECOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiECOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9463DD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA54617B5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE84C385A4;
        Tue,  3 May 2022 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651587335;
        bh=BjIlCIdIz0a22rxEtanqh/DpwYmaky6CKKbSs9D0ylw=;
        h=Date:From:To:Cc:Subject:From;
        b=QohHo6+/NpdbZjGSaUH5y8YcP8JP0lCSrSD5HspEwaJZYuhCRAARdBcS1zaoKw9TL
         HnpjWPucVk6M3h3xXipvYCYuI0EQSsI0N0l7/5Vbz6ZeUd5YFah25DcaX/7pn1BK0Y
         qSA7jvtctrwIbo/4wOZ2dfJL+DCL/Y0lhKYebdo5b3mwWPdQNqkkTtAtAP+trIhiWJ
         Kx3wW3lC72VCFH2SCIrlTWd3qT235xHNnNEA6Tcn3SLySz2tiBnTbCV8c8mRVj8uKo
         be9kQ68xrYRaE5mhI2NZFeolGYWN+W3CS4rDNv49gL2XTmtsz68Po9zjMUdHXCouwc
         M+tYN+tjQcaxQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39472400B1; Tue,  3 May 2022 11:15:32 -0300 (-03)
Date:   Tue, 3 May 2022 11:15:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <YnE5BIweGmCkpOTN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the changes in:

  d495f942f40aa412 ("KVM: fix bad user ABI for KVM_EXIT_SYSTEM_EVENT")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This is also by now used by tools/testing/selftests/kvm/, a simple test
build succeeded.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 91a6fe4e02c08c4b..6a184d260c7f2e17 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -445,7 +445,13 @@ struct kvm_run {
 #define KVM_SYSTEM_EVENT_RESET          2
 #define KVM_SYSTEM_EVENT_CRASH          3
 			__u32 type;
-			__u64 flags;
+			__u32 ndata;
+			union {
+#ifndef __KERNEL__
+				__u64 flags;
+#endif
+				__u64 data[16];
+			};
 		} system_event;
 		/* KVM_EXIT_S390_STSI */
 		struct {
@@ -1144,6 +1150,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_MEM_OP_EXTENSION 211
 #define KVM_CAP_PMU_CAPABILITY 212
 #define KVM_CAP_DISABLE_QUIRKS2 213
+/* #define KVM_CAP_VM_TSC_CONTROL 214 */
+#define KVM_CAP_SYSTEM_EVENT_DATA 215
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.35.1

