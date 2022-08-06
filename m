Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE8F58B54D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiHFMF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiHFMFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:05:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17297678
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:05:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z187so4328078pfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vbeuqHIUa/KXXqYUj/NLMGTaRYx/rAIMle+RJ5jBKww=;
        b=US0qaNDWb4wLSHHn8QyfD78b4W5rPmfHKzl/VIUy92TBATnJj9nK9uhd5qZ2s+f8Ab
         iHMH+GVDZqbvGqBUaAkgzN51MvM8uOZxTaR3RZA109zAP7DiQ1SsKKSqqXSj2xWROELe
         oX535Ygo2zUJ5bainadO6GTIGwNLHHRdPHGNJT3r07MNsYkM+7c5Z66o+A0YV677n9aG
         zMRtiswzovT382LPrHfyEvWjLU5E1uN064fU5JqXHBDZT6cC1Om5LenK044R8sdmVb8m
         OlcMVHO7EC3MTYF0nkNY4RhAnHxM27r/ZBB5DzpcZ41E74bKTSovJRhZz8GN8Of21XhG
         lQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vbeuqHIUa/KXXqYUj/NLMGTaRYx/rAIMle+RJ5jBKww=;
        b=cjTB+NMhSKpfS35BwVGW84RAYrB2AyAxcIeluJDojIsZKCs9Jf+VIMWMpFlgPFWEu5
         vhg55XB5WeXJjQrZtwyEQa4d5OSyt2R8S2PN3YxJNzEEGNAouSgTH2E21lpdC0vaQOfW
         /HYxJBlOfcrucux2+f1qVWqLEOjuKKGo1eYf+JUEYzYZEacMDheUBUiRiSA23mZ1p5om
         t4DrzH5WABjj2K1WphsSUyhBOlZV94KMOJ/dZc3blq/D6NTnAAb35hBJFy67Sxj1vXBW
         GMJCjR3ElXKtjTGJKBQdinUKUj+/58GF7jpBLnI3CkuMlOsH8pd7Y3ZaNXq/1Hpmu290
         rzJQ==
X-Gm-Message-State: ACgBeo1cHHG7HPwPZwc2yj5h2JbQI9b7k1AnSn2cdHQmosNVxgpsuQxb
        ghEVK6bA3t1MiDaUN3VRx09X0w==
X-Google-Smtp-Source: AA6agR48VCKz83IdueqFefo0pb9JNxMyBMO34Xpn8SndgwZW9jWeog6ve9H65E8mRQ1l/nqP13nqUw==
X-Received: by 2002:a63:e4f:0:b0:41a:9472:eca0 with SMTP id 15-20020a630e4f000000b0041a9472eca0mr8998329pgo.623.1659787524427;
        Sat, 06 Aug 2022 05:05:24 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t4-20020a63eb04000000b003db7de758besm3035003pgh.5.2022.08.06.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 05:05:23 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 0/3] sched/psi: psi bug fixes and cleanups
Date:   Sat,  6 Aug 2022 20:05:07 +0800
Message-Id: <20220806120510.96131-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

These three patches are about PSI.
patch 1: Fixed PSI statistics error caused by unzeroed memory
in struct psi_group.
patch 2 and patch 3 are to clean up some unused functions
and parameters.

Hao Jia (3):
  sched/psi: Zero the memory of struct psi_group
  sched/psi: Remove unused parameter nbytes of psi_trigger_create()
  sched/psi: Remove redundant cgroup_psi() when !CONFIG_CGROUPS

 include/linux/cgroup.h |  5 -----
 include/linux/psi.h    |  2 +-
 kernel/cgroup/cgroup.c |  2 +-
 kernel/sched/psi.c     | 10 +++-------
 4 files changed, 5 insertions(+), 14 deletions(-)

-- 
2.32.0

