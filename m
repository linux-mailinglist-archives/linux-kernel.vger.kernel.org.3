Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445F85B02C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIGLU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGLUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:20:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89357DF4A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:20:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 145so14310348pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QLuLshytts26uxx4LPc9x0XvXsx+AD+5YRiNufR40K8=;
        b=XcAUHTKYki6aL1hpezJlYdZigySeU6y2P0DYvtUVLhJk6XVZwVwxLXJQ6xr34uAjz4
         fI9rtgDOtRiaSNCJ77eGEOC7astbLt0EpgL9e1a2+xSeRnD4ileRSfKInpzoCyWaBNQ4
         WuyX19uQ/gPxizH9bI2lj+CT6yumRLutDEHLS4WK7MZ8jp3nKxZDzbYaXi5VQn9Rg3fy
         LfAVRGPS99CJeNiTAFXe01/JU1FH27FfW5sd42h8tQyj0aaBnis/l1ZgoLSL78hFkJVw
         AQorqhcp2nSCPsHORodi8Uq859xy+DXXDEeMWYHEcydYJYPxJd1SGl79oTYr19trUyGY
         WWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QLuLshytts26uxx4LPc9x0XvXsx+AD+5YRiNufR40K8=;
        b=myk0DMTU7it+mEndnsTrfEH3HKfjf2rSPpBbRzpvB2V4s27vfgpU9niz9gHENHWfjS
         5chRAHmmR4F8zDMp7CfsvwsikcyMzEWwfi17TyN3bCrVKBZ0Dcf/9MQlCV+4fQBEP8Jm
         Bi3AFC5mD1jtDdCQ+o/bCeBE8eai960UPtBRkkrwk4CFoolRLHC+k0NWJelqZhu0ycoq
         YGvbEQga4ih3aAwbUP5P5eGkYO1EB/NE2uVHPJILF0LzsgELKjZIelFm+sYAV0h1RDPU
         ZVaJc3vV6MD1BajVxhjKiQGH+C8Jv735qtu/4WTWPaZim/U0TpkiQ6XLfKC0gepPQGM0
         KVFQ==
X-Gm-Message-State: ACgBeo0pB2kI3nUNeScdwBVuV72Ax/IL9kJMAY5i37qdGBerkWDtpJSY
        oZSY8zkQoUWBoy5r2Xa1mCBlCA==
X-Google-Smtp-Source: AA6agR4REBMM7Gmsw2ce0mTAGU2grjGk/MjGyGP4uXqlEUExsVKAmmyhozlacTRGuqoo4R7pAApXJQ==
X-Received: by 2002:a63:225c:0:b0:42c:3811:93fb with SMTP id t28-20020a63225c000000b0042c381193fbmr2823098pgm.543.1662549617513;
        Wed, 07 Sep 2022 04:20:17 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d12-20020a63f24c000000b0042ba0a822cbsm10334731pgk.8.2022.09.07.04.20.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:20:17 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 0/5] sched/fair: Minor SIS optimizations
Date:   Wed,  7 Sep 2022 19:19:55 +0800
Message-Id: <20220907112000.1854-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
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

v4:
 - Fomat fixes
 - Collect Acked-Bys from Mel

v3:
 - Fix an uninitialised memory access issue which can happen when switching SIS_PROP

v2:
 - Removed the part ignoring SIS_UTIL when overloaded
 - Make SIS_PROP cleanup a separate patch
 - Collect Acked-Bys from Mel

Abel Wu (5):
  sched/fair: Remove redundant check in select_idle_smt()
  sched/fair: Avoid double search on same cpu
  sched/fair: Remove useless check in select_idle_core()
  sched/fair: Default to false in test_idle_cores()
  sched/fair: Cleanup for SIS_PROP

 kernel/sched/fair.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

-- 
2.37.3

