Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3943758B7E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiHFTKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiHFTKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:10:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565FCE29;
        Sat,  6 Aug 2022 12:10:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dc19so10097832ejb.12;
        Sat, 06 Aug 2022 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=X+RUlnK1eQo3sW/X+9F8SKrpxqJLZraFpOTVGpOtH+U=;
        b=FAmbe5GFHQ/8g3C2PwAYnfd+fZUkQanSKQPwmWCFbVDbrWSZIwZ85gt+zXL2a4EqbW
         0IRimdM+FCCUjM9e7SS/l7ez33dkyWFkTO/YHc/ESkrncywrp++XyBh0dRSwyYaxUsm5
         jGhpDVKPWv7luXfgF94xoKdlsEEr3o0p2kFulPuoQohio5uOPf/GGvxHlVTgTOrWaiDz
         U/lUwbauHQ6uw3ULh0rtSOpf3+tw0JrW1CR1gxN+SWKt/V/sRSKbLdcYDchVLIZy5CNd
         GVVaItERJVUXL6aae2TyYnd4c9zzCBpTZFEkqhu61AAC3W+0DthZHPZ/vxRs/kd3o41W
         8cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=X+RUlnK1eQo3sW/X+9F8SKrpxqJLZraFpOTVGpOtH+U=;
        b=Drti2Dp8L6IZWZ4UPlCaV14ltkLmzLVBVxomqZz76DkbR4u3xuMuIb59j7l9ehYr0z
         saGobw4o6ILpGng+XCEujGKIwBzFTtGG8LHESsj1FEOR9Ny9nHbP3fIjd7r5FUpjqeOA
         /xOzq2cBPfI8AF2Op5CZliNB5Wcj+6yoZgehw1ZY3PGTu0S6Xy83/p5g53gpMmmTUkP7
         bV5X9k/G8eKl83FHTa6kyv853JbPX1lktaWd6JNe+M5K70PVB7XdCGwi0KYouU6X+m8C
         rgIUpkrHK/gQOlWDV41+6ZZFxFZdet7BYJMu/vBSs96Flf2z4j6H+7AWEE2QnCwxRpzM
         0efA==
X-Gm-Message-State: ACgBeo2D88DzHDAUYCfAdu8D4RxJbwFA2ifQ3zzsnGyv8jtJBHQ0+e3d
        4j6d7M8ys8PmlJfKem+TxFU=
X-Google-Smtp-Source: AA6agR5iQsegzTpNhE0SKB0loxYaXoyQsFhN21vQ+89p7jJ8OJb8LZzV6xB3Gdzh5FuS5cSr2PdxyA==
X-Received: by 2002:a17:907:948e:b0:72d:3fd2:5da0 with SMTP id dm14-20020a170907948e00b0072d3fd25da0mr8656300ejc.225.1659813039480;
        Sat, 06 Aug 2022 12:10:39 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b0072af92fa086sm2986604ejt.32.2022.08.06.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 12:10:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 21:10:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <Yu68rPjbQXEJlrdj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2022-08-06

   # HEAD: 99643bab36b642be10bf09cd3285c37c9e5b597f perf/core: Fix ';;' typo

Misc fixes to kprobes and the faddr2line script, plus a cleanup.

 Thanks,

	Ingo

------------------>
Chen Zhongjin (1):
      kprobes: Forbid probing on trampoline and BPF code areas

Josh Poimboeuf (2):
      scripts/faddr2line: Fix vmlinux detection on arm64
      scripts/faddr2line: Add CONFIG_DEBUG_INFO check

Masami Hiramatsu (Google) (1):
      x86/kprobes: Update kcb status flag after singlestepping

Slark Xiao (1):
      perf/core: Fix ';;' typo


 arch/x86/kernel/kprobes/core.c | 18 +++++++++++-------
 kernel/events/core.c           |  2 +-
 kernel/kprobes.c               |  3 ++-
 scripts/faddr2line             |  7 ++++++-
 4 files changed, 20 insertions(+), 10 deletions(-)
