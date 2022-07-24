Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0908357F36D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiGXGAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXGAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 02:00:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC4510FF0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:00:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o12so7730039pfp.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMKdwBG848qBHhNARCtBeFqUtsE99EGKMgpSlGcHe0g=;
        b=Gz5KEwpuisNA2ho8J2DzD8NshjTqDEC5OI20qOEFygh8H6ta4drpmRwmeiaty9faVC
         B+HEnpHtekw8KjrQ2+KNFiYlklC10NNiyYhcThERGjySadyzsM/l0qt+0MC7vfeDjuAW
         YdameMlwDgf8dfcag3ihuxaKJMb3k7uQ0TW55dqdKZgaP3/UuNWYFwiqBvx0BdHogMi4
         Waj1zxhKUblfXgGwt14RmUV5qp3N1RrPfT8fr45wSDgAg4rJTx0jAbPlVe+yY1IPIAlp
         /BWEKLIQqk4BRN4RqvzXUV3VryCRlF9x6sLmgTr/c8WWcVqdLWGhIggl82C4YJOK470N
         Znhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMKdwBG848qBHhNARCtBeFqUtsE99EGKMgpSlGcHe0g=;
        b=h981KRt7+cOwp1jMlYnO/SxNYFPJYTDvQJ94r3xBo84Xo3TwsJ6chw8Ey6qIGFBzDz
         XSMrCjxEG+7oHhj1G4Cpux7UyXed0SxD04kvIhuwe7WEXgZI0XWMoN5ng9MSX1oRo/1w
         jMR40iX+dlQiL1CH+3eUE7fyzp5HIXQYGv1E394YnwtHZ01NSSHT+BYBAI40/XeBzp2W
         u3i9OB8knYlQF2z7+d2KpkgY6S7bPu4PgLxM0NbtZMhkBkpHWG52oxHtJOuUg2KxHCia
         3I5Y74YJDYTdkdoFU7POiNwfWZpo7vwA1aoNsp1H66ca/nvWJTWRCY1q81VBhUPkH0YI
         D8ww==
X-Gm-Message-State: AJIora8oFAJ03U4vSsLaGyXIw6d3YQnLWIFXWNpeXlVqrN+zl4GHSfz8
        kv+Z9LROAd3G4iVDew2k0XS9+Q==
X-Google-Smtp-Source: AGRyM1t1ae4LtipmS2FroS284T8+XN+ltj1IyuZuCCM0EEjjeucPZpN9EAW07a+Joh3AXazDwyFT1A==
X-Received: by 2002:a63:3181:0:b0:417:b4b5:df09 with SMTP id x123-20020a633181000000b00417b4b5df09mr6438567pgx.398.1658642418418;
        Sat, 23 Jul 2022 23:00:18 -0700 (PDT)
Received: from localhost (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016a7b9558f7sm6543219pln.136.2022.07.23.23.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 23:00:18 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/2] perf symbol: Minor fixing
Date:   Sun, 24 Jul 2022 14:00:11 +0800
Message-Id: <20220724060013.171050-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch set contains two minor fixing for parsing symbols.

The first patch changes to use program header for parsing symbols of
user space executable and shared objects.  Since kernel's symbol parsing
is more complex than userspace for support both kernel symbols and module
symbols, this is why this patch set uses conservative way and doesn't
change kernel symbols parsing.

The second patch is to detect symbols from sections without setting
attribute flag SHF_ALLOC, these symbols are used for linker warning,
skip to record them to avoid spurious symbols.

Changes from v2:
- Changed to use more gernal way to check the attribute bit SHF_ALLOC
  for sections rather than check the section string name (Fangrui).

Changes from v1:
- Changed to use program header / PT_LOAD segments to parse symbols for
  userspace executable and shared object files (Fangrui).


Leo Yan (2):
  perf symbol: Correct address for bss symbols
  perf symbol: Skip symbols if SHF_ALLOC flag is not set

 tools/perf/util/symbol-elf.c | 56 +++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
2.25.1

