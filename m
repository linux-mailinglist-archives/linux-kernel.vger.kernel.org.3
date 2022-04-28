Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC9D513CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351823AbiD1Ucf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351813AbiD1Ucd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:32:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AEAC0D2F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:29:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f825f8c944so56790297b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=34jLRM4+BwEIYs9x6hhJ6ygHReUU/x5ddmg6oDAk/hE=;
        b=UY/OX2HTHXKOWNH/Vf+H9JXdTZgn2Yvyfurn3OjW1bzs55mQRh2aFHzvFQTzEDUZHw
         cLoJVm9KJGp+kjJRaOIe0FbY06ycLWn/8x0bmFbaIht1VuNn10xbCPfd+AdXcylCjJLp
         UF+IKMTpHR/gDIZY+ZZ3Qel96ZYSHDwrAbjepbEUBIMDcL6oMe7DUCQSA/ZFVwt0omPS
         DoNB+qt4bsTnioNsremEo+5SN9rZ4F/QXFyXYMhovVphuJmSfAgUuH9qDPn5ofs4wNma
         XMnejXGNOcwpVj3fBQMGwobKZRmuaYaYCAXebRq6l1IOdjvB5HWSIW++jXBADcGXRdx2
         OsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to
         :content-transfer-encoding;
        bh=34jLRM4+BwEIYs9x6hhJ6ygHReUU/x5ddmg6oDAk/hE=;
        b=IjvWlIrPQay8z5o9xdEVD7tU3oqkUSgt28pyp9QwUMS1LgmYQN2IzFIHd4NMoNuHKf
         WurmTYf4FWLCQxz+m385g8LNILB40A3YKQamA9zbVCJW6Za3BX31Y4TwTHRgs8anZlOX
         HhJxSOC9fgi1b4ASKJyUXVZ0QNQw1H9Oj4kRDkjdnxcVD0oimv51XWsk/ZVeYCTmBqaf
         LIVsEoctfVMlYo9bviXUlDo5ApokTmtbSThRthO8tcutrrRrJKhIhK7xfcFuitIJSeeJ
         jsz+db4vPyItMV5EwRixRakpKQgtoiaLXBwjWMkGtdL+T5lPokU/15a0p9+r3SftQT7R
         VZ1A==
X-Gm-Message-State: AOAM532s1Rf62ROR7WzKJC11N7rQqdUHzyi8ZPELg7zRwtkrT/o+3Rmz
        vCBh54hUTEhN50L4cJehlLTQnsMn4wwc
X-Google-Smtp-Source: ABdhPJzPL028BTxJjC5e27Kddm/2Qp03nvzJZwIvl2B7mfBm3/Opb5+4zY6BSgpwSpZmbN1h4ZVsBKPiETAU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3c33:ed69:1770:973e])
 (user=irogers job=sendgmr) by 2002:a25:ec0d:0:b0:648:480d:7c08 with SMTP id
 j13-20020a25ec0d000000b00648480d7c08mr23981521ybh.206.1651177756844; Thu, 28
 Apr 2022 13:29:16 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:29:11 -0700
Message-Id: <20220428202912.1056444-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 1/2] perf bench: Fix two numa NDEBUG warnings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON is a no-op if NDEBUG is defined, otherwise it is an assert.
Compiling with NDEBUG yields:

bench/numa.c: In function =E2=80=98bind_to_cpu=E2=80=99:
bench/numa.c:314:1: error: control reaches end of non-void function [-Werro=
r=3Dreturn-type]
  314 | }
      | ^
bench/numa.c: In function =E2=80=98bind_to_node=E2=80=99:
bench/numa.c:367:1: error: control reaches end of non-void function [-Werro=
r=3Dreturn-type]
  367 | }
      | ^

Add return statements to cover this case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 44e1f8a44087..d5289fa58a4f 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -311,6 +311,7 @@ static cpu_set_t *bind_to_cpu(int target_cpu)
=20
 	/* BUG_ON due to failure in allocation of orig_mask/mask */
 	BUG_ON(-1);
+	return NULL;
 }
=20
 static cpu_set_t *bind_to_node(int target_node)
@@ -364,6 +365,7 @@ static cpu_set_t *bind_to_node(int target_node)
=20
 	/* BUG_ON due to failure in allocation of orig_mask/mask */
 	BUG_ON(-1);
+	return NULL;
 }
=20
 static void bind_to_cpumask(cpu_set_t *mask)
--=20
2.36.0.464.gb9c8b46e94-goog

