Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98D571461
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiGLIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiGLIVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:21:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDBA44D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id o12so6873276pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbzHie68FH1OCk5XI3JI2kXhxMNGKdCr7rQlk5i/b3o=;
        b=BH8cbi4ZGzuWP6MGR0wn4P9anzCCuz8MOUVnq6wf7iOXOLbpKKcYaXRtQUT68+q4rJ
         7X8nUsdc/jhxEBwmXbUA41HxJXVJhfXPy5AhXYvK5pABE/3SlgTnK2oMo4ltIGZvDkGt
         DBlHKpyraRDvRcrZ0CCeYC1NGEPV6pTdrkrYOpuVbaDXRW69BIuf7llOBm6+t0srAvDW
         1rWhWALOse2AjfKn8T1NYPkEW+M6MXcUzTMC31L6wzTg+e8MWqTxmRyzHIJ3NIuqvmb7
         XszcHUoIN48Hx4fZdpox8fhhRGKUam7cjT/6fBK2xavrKsKZ91AzwyguWqTz3BiMZRxn
         /KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbzHie68FH1OCk5XI3JI2kXhxMNGKdCr7rQlk5i/b3o=;
        b=AoGktIBmFzcEqDnsuBBKgR163R9ZZZfopZwapgE+p7XfC80WIO6/+6ADDPASZ+9tBq
         WzMcOL7RHWpjHwSoskQFkIWCtxA3zZP/L9ZWoVZb7AKsJ94i3jGcnxU5X5lMKhz70qG2
         xE56UeC4WN7gcwHUsC5vG92umykoa25OheReZ+MjwzAiZOxY+INyIiIM2roDOS2SKuMt
         8V433DRHGMaYwyThMKn9v/IBdgv9qoaoXLFsNin/QKaoemVEtJuAcUKJZ5Nx/bUbshmF
         sFfYQA+u1z26uvMXck+3D/OrFpK+9FIM873nfPNIZmqbE4ka4bkXLdvbZiFB+A4cJSS/
         Y0Qg==
X-Gm-Message-State: AJIora9zDssLI6p2TVbkzKnqFawfG4OT4czjRa3Zc0DEgrb4fODRUaCL
        G55oMo+aKAdDXOlTFQwjUBodbg==
X-Google-Smtp-Source: AGRyM1uMZzk2fDy+gca+/7WDBT2Bv14yaaw/ATsujScVvvKfTUOqdPXBp6/ZyqjoTXs1cC4oeUVtgw==
X-Received: by 2002:a05:6a00:1a86:b0:52a:d419:9552 with SMTP id e6-20020a056a001a8600b0052ad4199552mr8295632pfv.70.1657614064864;
        Tue, 12 Jul 2022 01:21:04 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78bcd000000b0050dc762816dsm6114428pfd.71.2022.07.12.01.21.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:21:04 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 0/5] sched/fair: SIS improvements and cleanups
Date:   Tue, 12 Jul 2022 16:20:31 +0800
Message-Id: <20220712082036.5130-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch ignores the new sched_feat SIS_UTIL when
there are idle cores available to make full use of cpus
as possible.

The other patches come from the SIS filter patchset [1],
since they are irrelevant to the filter.

[1] https://lore.kernel.org/lkml/20220619120451.95251-1-wuyun.abel@bytedance.com/

Abel Wu (5):
  sched/fair: ignore SIS_UTIL when has idle core
  sched/fair: default to false in test_idle_cores
  sched/fair: remove redundant check in select_idle_smt
  sched/fair: avoid double search on same cpu
  sched/fair: remove useless check in select_idle_core

 kernel/sched/fair.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

-- 
2.31.1

