Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780214FBA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbiDKK6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245016AbiDKK6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:58:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CF3B2B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:55:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f3so14291604pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxc4olMcFemhUosxpLZMJRYJVIAs9QLO7H3uZTwv/Ug=;
        b=fggUObJo9DosRdizR6rxqIHDU+ijm4JyvHLzSkknOhcGpXc5MnKgFTISpxN14REZ5l
         3rqgkxaunu41WZ9TSKUuGCQfmKe3AArxukPB/zKzyKp/9sbljUy3bkwhw9R8lPtUIKOH
         7iYB7iiC+38TLGq5mFfcKo6QUymU5FacvYe0m2VUDZAoEoBLJ48k4z737tIdDSxky3yq
         2e6j4G9O+i+qgAD1+2t+RwhYp7tIlXoRDJ6ctxSkXeDIdbckE1Rl82cJzCSEcLwDL4IW
         nXMNkGBtYOroCd2HprdC8m3GiJZp7YPEZXLbojNUtX5o8yJXcd6s46NUByTFUwhCKWbZ
         f3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxc4olMcFemhUosxpLZMJRYJVIAs9QLO7H3uZTwv/Ug=;
        b=HYS5LLDisOGPUDO6A4Bad/4fTr1I2v26VW/atJKOBDjxfnXtta5y7eWU0FFjd9QoMx
         J/1N7CDJZf6fMOkttTYYJNRy0yvtPrp1+5dNNqGPsnyQgynF70lE+QxLoSjB7UkPmr83
         jSBWKSj1Xxd3Arp/Kyl1yikHIP3j98z2gC1EOPz4OSy2HgtR86VU2DRxpUIdUWEFmtaW
         PN53YQD5tgFxIKTm/P6OmgF02FXzEchriMt3+BxAiQHfelJ3A8VUZCcr3OIBYeBHVYmG
         tAdk/vxWegwK1Xya+WuU3Xw0Xaory9BryiC6gqKLuNvheChXwNKyHTFT/phU1kGeG1P/
         3Ffg==
X-Gm-Message-State: AOAM530jqt0kKqpFVTgFo/qhxfeC6AX51hs9fs9lpGfyFWzdR33blgHH
        kxL4h132zfotQp+3njwZQ7gi7w==
X-Google-Smtp-Source: ABdhPJzCtBj8rSkS+qm9FKi7AHijI3tgutZHUHzS/kDYuq6jWXP1aJGRoPV+d7oQftSywD3LHuzP8A==
X-Received: by 2002:a05:6a00:174f:b0:4fd:aed5:b5e4 with SMTP id j15-20020a056a00174f00b004fdaed5b5e4mr32119192pfc.39.1649674550954;
        Mon, 11 Apr 2022 03:55:50 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7809a000000b00505bf88a17bsm3496127pff.214.2022.04.11.03.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:55:50 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, iii@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, Eric Lin <eric.lin@sifive.com>
Subject: [PATCH v2 1/1] perf jitdump: Add riscv64 support.
Date:   Mon, 11 Apr 2022 18:54:38 +0800
Message-Id: <20220411105438.21366-2-eric.lin@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411105438.21366-1-eric.lin@sifive.com>
References: <20220411105438.21366-1-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable perf jitdump for riscv64 and it tested with V8 on qemu rv64.

Qemu rv64:
$ perf record -e cpu-clock -c 1000 -g -k mono ./d8_rv64 --perf-prof --no-write-protect-code-memory test.js
$ perf inject -j -i perf.data -o perf.data.jitted
$ perf report -i perf.data.jitted

Output:
 To display the perf.data header info, please use --header/--header-only options.

 Total Lost Samples: 0

 Samples: 87K of event 'cpu-clock'
 Event count (approx.): 87974000

 Children      Self  Command          Shared Object                Symbol

....
     0.28%     0.06%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal6WasmJs7InstallEPNS0_7IsolateEb
     0.28%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal10ParserBaseINS0_6ParserEE22ParseLogicalExpressionEv
     0.28%     0.03%  d8_rv64          jitted-112-76.so             [.] Builtin:
InterpreterEntryTrampoline
     0.12%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal19ContextDeserializer11DeserializeEPNS0_7IsolateENS0_6HandleINS0_13JSGlob
alProxyEEENS_33DeserializeInternalFieldsCallbackE
     0.12%     0.01%  d8_rv64          jitted-112-651.so            [.] Builtin:
CEntry_Return1_DontSaveFPRegs_ArgvOnStack_NoBuiltinExit
....

Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 tools/perf/arch/riscv/Makefile | 1 +
 tools/perf/util/genelf.h       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 1aa9dd772489..a8d25d005207 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -2,3 +2,4 @@ ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
+PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 3db3293213a9..ae138afe6c56 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -38,6 +38,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__s390x__)
 #define GEN_ELF_ARCH	EM_S390
 #define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__riscv) && __riscv_xlen == 64
+#define GEN_ELF_ARCH	EM_RISCV
+#define GEN_ELF_CLASS	ELFCLASS64
 #else
 #error "unsupported architecture"
 #endif
-- 
2.35.1

