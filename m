Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F850332B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiDPCcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiDPCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:32:14 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE7E5E16E;
        Fri, 15 Apr 2022 19:29:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id hu11so7501669qvb.7;
        Fri, 15 Apr 2022 19:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWFJae0wB3i/+AjUHp0kgcY6gHCBjSvEexFbtOZL7cw=;
        b=N1gzaNMpjSVHF43xt8VTC6Pq6l2GGjFsGQ2QmCg0hWKpuUjwH6vK2ITiQVZ/tbemQ6
         qTh57IrnV2xB7nCCB1+4ZkXhgIjGuXRLEAc7THqwNOEjvZGrbASW0kHxuNjZqxNE1dys
         9BJc/J77Ux1wsq0Y6ot5Ue0Nhymb+lTik1oXUfm6SRUKGu9FvUny3MNn5TXgmQbLlgQw
         cUHoYnw/bOS0YKjN9PTgYjtVl1DedARYXGIVXk0OYIZGJm4EIw2LP3n60vQaBcQJodmD
         FoOjiZdxyr/vyroCOZRG8JtnGDIKfP44EVw/uKWZXBA+EPPv9krPQ5Jq4nggSsYucc4N
         +dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=UWFJae0wB3i/+AjUHp0kgcY6gHCBjSvEexFbtOZL7cw=;
        b=qpGN5Z4ivIf6dAdpS80CxL4/Ke8aMJySlD8RxhxnvecrUngPALwpfMU6UcPe4uevuf
         aNolPcTv8uF1yw7W6O6yPQ03STZYb/tP3MsYy5ReOCfELJoJULo1NRV9xsJ+JcPIqraF
         SJr4dcfoiNPQyymioQf0Qvm2z3n/MvF1UhPx0vyyNy4PPoytSc2DKpN8fJ8M1ZTnoZpP
         PRCJGWzT9vQFkNLFQOcEL00fXvJaOFifBKJzphrZPmmQuep0UH3kAD5VlNy0cRRevqvI
         vW+18Zj5770NNSIeSdVniA8VXvWD5gZiv5vYek06YkDzGxF+JrGYfWTrgO+4+gj1qG2u
         t7WQ==
X-Gm-Message-State: AOAM531MJemXTDIiAqr/Z4TM5mvC/d8XwnZVGOJPCw/VyJxSyatztETJ
        JTUGd1mbW0r6YMhymuCSizMGuPO2lRA=
X-Google-Smtp-Source: ABdhPJy7+O0d1TAWEptQEO1FaQlgJslFZTjGjF/ZuzHuNoQrVP6vRz/HM02MSWZFO67NeYN6B+T6Aw==
X-Received: by 2002:a05:6a00:14d2:b0:50a:48f0:881a with SMTP id w18-20020a056a0014d200b0050a48f0881amr1390703pfu.36.1650069653526;
        Fri, 15 Apr 2022 17:40:53 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:461:36d2:dba1:7530:2cda:19b1])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm3913537pfu.82.2022.04.15.17.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:40:52 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/3] perf tools: Tidy up symbol end fixup (v3)
Date:   Fri, 15 Apr 2022 17:40:45 -0700
Message-Id: <20220416004048.1514900-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
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

Hello,

This work is a follow-up of Ian's previous one at
  https://lore.kernel.org/all/20220412154817.2728324-1-irogers@google.com/

Fixing up more symbol ends as introduced in:
  https://lore.kernel.org/lkml/20220317135536.805-1-mpetlan@redhat.com/

it caused perf annotate to run into memory limits - every symbol holds
all the disassembled code in the annotation, and so making symbols
ends further away dramatically increased memory usage (40MB to >1GB).

Modify the symbol end fixup logic so that special kernel cases aren't
applied in the common case.

v3 changes)
 * rename is_kernel to is_kallsyms
 * move the logic to generic function
 * remove arch-specific functions

Thanks,
Namhyung


Namhyung Kim (3):
  perf symbol: Pass is_kallsyms to symbols__fixup_end()
  perf symbol: Update symbols__fixup_end()
  perf symbol: Remove arch__symbols__fixup_end()

 tools/perf/arch/arm64/util/machine.c   | 21 ---------------
 tools/perf/arch/powerpc/util/Build     |  1 -
 tools/perf/arch/powerpc/util/machine.c | 25 -----------------
 tools/perf/arch/s390/util/machine.c    | 16 -----------
 tools/perf/util/symbol-elf.c           |  2 +-
 tools/perf/util/symbol.c               | 37 +++++++++++++++++++-------
 tools/perf/util/symbol.h               |  3 +--
 7 files changed, 29 insertions(+), 76 deletions(-)
 delete mode 100644 tools/perf/arch/powerpc/util/machine.c


base-commit: 41204da4c16071be9090940b18f566832d46becc
-- 
2.36.0.rc0.470.gd361397f0d-goog

