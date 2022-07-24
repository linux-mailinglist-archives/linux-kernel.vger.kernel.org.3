Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFA57F2AD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 04:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiGXC32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXC3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:29:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B861758F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:29:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id os14so14769864ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfMO/BGX2+jJxfN9ahYbmi/+LL8s/bQoBxmXikSDXCk=;
        b=afRW92YaBcZT+SnGG0a9yWoGr0mPAyyhrSY/yxzjFDRcCO0HuWxrgam/ZR2Qozj5uL
         DZ9KCBVwzbe+s+OBey5IG2kwx2/Ma6ltJUK+0N9pYYB9zJB3LCRk2HOTIW2rCtHGUsXy
         0smLXXaZZrjCqM13byw8vWPv8tyE8WbsqcRJDlOSh6CRaolMs4reaXrSd1yV7i+4GnCE
         YNV1ZYm0Scrv8Pqj4HfMfFzkaWdJvpr42sWmGwJSUXHBEkgwJS7ZjtelCeT2y13MJ/rf
         WMdvPhvaTxWtYZeXoy//hmgq7bfZsNSc1ag7xexoFHl7Ty6hxnhBKFR4ZBXnF6LM/6T/
         QB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfMO/BGX2+jJxfN9ahYbmi/+LL8s/bQoBxmXikSDXCk=;
        b=1rLavudzo+OWDJvFCSuwX+IjkEdcgNivksdOoCxxkDhdxmIevoD757YQft6Rh70LQ2
         AmwwiDXOKAdTECY2rIFnC8ya6UP2jObhmo4j49r5uDBuZpBwXUYIOGoRLAa4sP2T12zV
         FgKHkbELO2JI17ksbzAWBR2xrjbrtJTmodINDlRrOOPq2esUWtmi+PgP8Gbe5Vbb31/J
         NBIaLsL38ITlsWHWxB5vgi4D96CYYX3ZI+jj5YVIOz9zpWliu5HTASxF3ielTSbWvg9T
         ZeFf6uJrcC/hDtmFd9klDWGT0nqQJKZrM+1t3JXDg6wSiCAZAk6XRaxQ7DBOIxchsUAq
         5rUQ==
X-Gm-Message-State: AJIora8ZwR8WcB8FtT/YVsKTzSTcx3pyqr5KiUSndatKzpuN5frcHjYt
        d/jrxgNHSVk37LYvBYOEqD6INg==
X-Google-Smtp-Source: AGRyM1t1qvJDy/VhgGyRy+o0TM8z1YHIOxx+yvx2j34wNXfDx6shWP3Xxbi6F+KsHZfvjhVgk22O9A==
X-Received: by 2002:a17:906:ef8b:b0:72b:45a2:2232 with SMTP id ze11-20020a170906ef8b00b0072b45a22232mr5009261ejb.484.1658629762151;
        Sat, 23 Jul 2022 19:29:22 -0700 (PDT)
Received: from leo-build-box.lan (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b0072b31307a79sm3741524ejy.60.2022.07.23.19.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 19:29:21 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/2] perf symbol: Skip recording symbols in '.gnu.warning.*' sections
Date:   Sun, 24 Jul 2022 10:28:57 +0800
Message-Id: <20220724022857.2621520-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220724022857.2621520-1-leo.yan@linaro.org>
References: <20220724022857.2621520-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some symbols are observed their 'st_value' field are zeros.  E.g.
libc.so.6 in Ubuntu contains a symbol '__evoke_link_warning_getwd' which
resides in the '.gnu.warning.getwd' section, unlike normal symbols, this
kind of symbols are only used for linker warning.

This patch skips to record symbols from '.gnu.warning.*' sections by
detecting the sub string '.gnu.warning' is contained in section name.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/symbol-elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ef6ced5c5746..4b621e355c0e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1277,6 +1277,14 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		section_name = elf_sec__name(&shdr, secstrs);
 
+		/*
+		 * A symbol coming from ".gnu.warning.*" sections is used to
+		 * generate linker warnings, its 'sym.st_value' field usually
+		 * is zero, skip to record it.
+		 */
+		if (strstr(section_name, ".gnu.warning"))
+			continue;
+
 		/* On ARM, symbols for thumb functions have 1 added to
 		 * the symbol address as a flag - remove it */
 		if ((ehdr.e_machine == EM_ARM) &&
-- 
2.25.1

