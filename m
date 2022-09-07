Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028FA5AFCC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIGGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIGGqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:46:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D08088DE4;
        Tue,  6 Sep 2022 23:46:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 123so4269921pfy.2;
        Tue, 06 Sep 2022 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=TAgE+DopD0k76ZbmjU7ki7QQZAUIb8aDW+PneSXnwhE=;
        b=pbNxJyZEIbdSxt7dsVYwJ3hnJ7j8+TzhSV1I6XWTGqNpZTbHXaWT7/4QIorGxCh1ua
         da0+q08l4wiF4LW45+TApNU40gR56JxN2/8k+2TLP2vGcTgvN40eNR99eKJspoBu1iCP
         46KAozl+fv0IYAWP7+BRzdDzeWPgGVosC09UXBaRQKVAGlvRSOaRilS2Vl+t0H2BRlzC
         i+y+Ev/9SmKxseu4DWeKjY8E092ASzCLRg+qeiEGJy+kF+eKqIoqsUMm54kHgxPDzmmR
         tIGEbtFtMj3BwMSjWJLx2bkI+LkSHEn+T2+knaj+nPX3PxWN/3wOqWq83OSXkl8SL2Ok
         UwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=TAgE+DopD0k76ZbmjU7ki7QQZAUIb8aDW+PneSXnwhE=;
        b=SkxVAnQH1iDKUtLTAvJEpYNLpQvzQWRGTgvXsMnPE0Q+7FbCzCM7a1gXNOLqut6VHo
         mUmFzLOdcaQP82nnBsJryhVByl5BqqvTskec4b0YaIFhE7Pf0GDxQ2M8qaUR7N6CesyB
         KN+t9Dfe99D6mSpvJ1TNpouEepUY9+IKhPji0gDxt9eB1ISNnUHyTFTnt6VAUx/Xk4dN
         QvaWxGs4BziYRgYPdL7ReguA8sHm01abmjNiS5zuTPW5g0cm6qvghYAgMmcjeer3IR8h
         SJ0MTYkYp8njTa1YgWiTnZZF0+kf41QlzEHy78CpDCrIyTlFgitDvz6yHiPh64jsnOFg
         lMhA==
X-Gm-Message-State: ACgBeo1k0RqE00Iun83uBnv9umnkJoG/w+PWITLMEk5UN/7/Dow64Pms
        choeR0GPr/zCp/VjWpU6nuc=
X-Google-Smtp-Source: AA6agR4txIIizra8AUArJC8JSwsl1B6f0AqUn8Q1ckoB8c4W7/XpPv4Mf1cvDSXUcWGu9dJ7KtOlzw==
X-Received: by 2002:a63:804a:0:b0:42b:8b81:72c9 with SMTP id j71-20020a63804a000000b0042b8b8172c9mr2184797pgd.355.1662533214748;
        Tue, 06 Sep 2022 23:46:54 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:f249:9066:7da7:4a37])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm11192192ple.48.2022.09.06.23.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:46:53 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/6] perf test: Test record with --threads option
Date:   Tue,  6 Sep 2022 23:46:42 -0700
Message-Id: <20220907064645.1197894-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220907064645.1197894-1-namhyung@kernel.org>
References: <20220907064645.1197894-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To verify per-thread mode is working with multi-thread recording.
Use two software events for testing to check event set-output handling.
Also update the cleanup routine because threads recording produces data
in a directory.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index cea3c7b7e2cd..3331fb092654 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -11,8 +11,8 @@ testsym="test_loop"
 testopt="-D 3"
 
 cleanup() {
-  rm -f ${perfdata}
-  rm -f ${perfdata}.old
+  rm -rf ${perfdata}
+  rm -rf ${perfdata}.old
 
   if [ "${testprog}" != "true" ]; then
     rm -f ${testprog}
@@ -90,6 +90,19 @@ test_per_thread() {
     err=1
     return
   fi
+  if ! perf record -e cpu-clock,cs --per-thread --threads=core ${testopt} \
+    -o ${perfdata} ${testprog} 2> /dev/null
+  then
+    echo "Per-thread record with --threads [Failed]"
+    err=1
+    return
+  fi
+  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
+  then
+    echo "Per-thread record with --threads [Failed missing output]"
+    err=1
+    return
+  fi
   echo "Basic --per-thread mode test [Success]"
 }
 
-- 
2.37.2.789.g6183377224-goog

