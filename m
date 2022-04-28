Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2107151386C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349206AbiD1PgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiD1PgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:36:03 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769291581D;
        Thu, 28 Apr 2022 08:32:48 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id w17so9661431ybh.9;
        Thu, 28 Apr 2022 08:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mMNUjnjGG7SrMlJQo1Ic0BhZHfgvVdrNAaWUcA3R734=;
        b=R6HFZHpnnj36hYbBVQp7YrQfj3npRMysGDB6qMPM3YQgq/61ri4iewjbRbBLHWD1BX
         +8jxOKib9wa23SfOhoFIW5CpwO55vkUxmOfFowJYgr8OrRodvOexYHhY/zATa1aHHMo9
         exEFy301Cg/xwUnct4VpsKmgoAZ6RpBey6DxYxdliiMJzITWBGi/i6sXurjlksdgUbkj
         h4/zZMIA/pohPN2WFZsbkEw2lTtm2n+Vf9y7RujThy5DC86pLdp9LQEEIGksW7eZRsWV
         N14FDCjdlClcYjC5Tg/ecKKxbvXL8yuPfqZgLpVOwpQvyunJn2zylBYjaxe2ijQhfBoP
         b6wQ==
X-Gm-Message-State: AOAM532x1YNQ2OYrWRWtgwx7Nq+i8EFsfCddkt8n/dY2p+IwEMIv9hZR
        /hj7HokS9Xo3NI3w/g0Cm0efcHZmgMWlXhLrjfuVo7+cSzM=
X-Google-Smtp-Source: ABdhPJy5IgU/m4oXH2zS6SAs5w14hm7kmIxgu4stYNMijsd4nD+qDfQOs47Y18LdyMBX5WCKzx8hfg7bArn/HwwOIVI=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr31497076ybh.482.1651159967717; Thu, 28
 Apr 2022 08:32:47 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Apr 2022 17:32:36 +0200
Message-ID: <CAJZ5v0jaMoSXJ-Q7w8Pduk9=3NyaWakdvQU2mBOPMM2vE9dTjQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.18-rc5

with top-most commit edbd9772cc9d8af6c136d01d8b9402f6ab767e9b

 Merge branch 'pm-cpuidle'

on top of commit af2d861d4cd2a4da5137f795ee3509e6f944a25b

 Linux 5.18-rc4

to receive power management fixes for 5.18-rc5.

These fix up recent intel_idle driver changes and fix some ARM
cpufreq driver issues.

Specifics:

 - Fix issues with the Qualcomm's cpufreq driver (Dmitry Baryshkov,
   Vladimir Zapolskiy).

 - Fix memory leak in the Sun501 driver (Xiaobing Luo).

 - Make intel_idle enable C1E promotion on all CPUs when C1E is
   preferred to C1 (Artem Bityutskiy).

 - Make C6 optimization on Sapphire Rapids added recently work as
   expected if both C1E and C1 are "preferred" (Artem Bityutskiy).

Thanks!


---------------

Artem Bityutskiy (2):
      intel_idle: Fix the 'preferred_cstates' module parameter
      intel_idle: Fix SPR C6 optimization

Dmitry Baryshkov (4):
      cpufreq: qcom-hw: drop affinity hint before freeing the IRQ
      cpufreq: qcom-hw: fix the race between LMH worker and cpuhp
      cpufreq: qcom-hw: fix the opp entries refcounting
      cpufreq: qcom-hw: provide online/offline operations

Vladimir Zapolskiy (2):
      cpufreq: qcom-cpufreq-hw: Fix throttle frequency value on EPSS platforms
      cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts

Xiaobing Luo (1):
      cpufreq: fix memory leak in sun50i_cpufreq_nvmem_probe

---------------

 drivers/cpufreq/qcom-cpufreq-hw.c      | 70 +++++++++++++++++++++++++++-------
 drivers/cpufreq/sun50i-cpufreq-nvmem.c |  4 +-
 drivers/idle/intel_idle.c              | 27 +++++++------
 3 files changed, 75 insertions(+), 26 deletions(-)
