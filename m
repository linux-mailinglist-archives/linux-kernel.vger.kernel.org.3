Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9758D26D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiHIDpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIDp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:45:29 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0509ED93
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:45:24 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id b7so7756507qvq.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMFSm9fzlCqsL9Wl8knZNV1YuIRXh8vZL0+Qm4vwsdw=;
        b=gaoDGtT7P0PU1txGGwS6nqQwoWr78izFFV6nTSD+0uArCjjTELeFzv4pJTMgIi4CUg
         dJF1ysNQ6QnohyA+3U3h/jN1J71OFQYnx7/71j67phYLsv/ZLJHN67fkMPWHMJH0gjRP
         rc/i/d6KbRdYsO25gle/h6TDQQ7XrXuwf/z+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMFSm9fzlCqsL9Wl8knZNV1YuIRXh8vZL0+Qm4vwsdw=;
        b=VCHl5cjfrTT6UNeqywmuRc9cSAjxe8kfwTFm6nOzuFxoCVJxrCuJQOVVTltzGaHpag
         jooqosCELG/mVXv900paE6oHWafufNY7pbinUfskYk/UBHBZ8DXfaSVIylZi7is6oYRa
         cGxHtRyArssvkPWU8AbI7SvjPp12C5MZI4JoqIUuXfSdm259cC76ihhpEwDbhyFPA+ZW
         qEPbvGfTQeeYCrxJVx8FMf3VB6fkqsgaRaIrpjHoHH1td/bfMJILH5y96qV17gdf9aY2
         ywlyohd0ptGrX/bjRWJ1PadFDYYijlJqlXqa/iONSRWx93Ut6UIe0f6+1LLtaGBlBSt9
         dGng==
X-Gm-Message-State: ACgBeo2CLdRs9PiLJUzNtBlmMJey2RKvNq0yKOjM12378Ow5+mu3vnK5
        yPBf25Ln6Fore3Bg13rGYotpiCgz9g+EEw==
X-Google-Smtp-Source: AA6agR42ATZ3/Jp8DA3RUD+VOOvGOfBuGXIMPL7I8s6nqNQ/UchL90HMU28gDJB8NvjnTAuNxW2KPw==
X-Received: by 2002:a05:6214:19e8:b0:478:89de:9d4f with SMTP id q8-20020a05621419e800b0047889de9d4fmr17590523qvc.126.1660016722922;
        Mon, 08 Aug 2022 20:45:22 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b0031f0b43629dsm9170979qtb.23.2022.08.08.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:45:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: [PATCH v3 resend 0/6] Implement call_rcu_lazy() and miscellaneous fixes
Date:   Tue,  9 Aug 2022 03:45:11 +0000
Message-Id: <20220809034517.3867176-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a refresh of v3 with one additional debug patch. v3's cover letter is here:
 https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/

I just started working on this again while I have some time during paternity
leave ;-) So I thought I'll just send it out again. No other changes other
than that 1 debug patch I added on the top.

Next I am going to go refine the power results as mentioned in Paul's comments
on the last cover letter.

Joel Fernandes (Google) (5):
rcu: Introduce call_rcu_lazy() API implementation
rcuscale: Add laziness and kfree tests
fs: Move call_rcu() to call_rcu_lazy() in some paths
rcutorture: Add test code for call_rcu_lazy()
debug: Toggle lazy at runtime and change flush jiffies

Vineeth Pillai (1):
rcu: shrinker for lazy rcu

fs/dcache.c                                   |   4 +-
fs/eventpoll.c                                |   2 +-
fs/file_table.c                               |   2 +-
fs/inode.c                                    |   2 +-
include/linux/rcu_segcblist.h                 |   1 +
include/linux/rcupdate.h                      |   6 +
include/linux/sched/sysctl.h                  |   3 +
kernel/rcu/Kconfig                            |   8 +
kernel/rcu/rcu.h                              |  12 +
kernel/rcu/rcu_segcblist.c                    |  15 +-
kernel/rcu/rcu_segcblist.h                    |  20 +-
kernel/rcu/rcuscale.c                         |  74 +++++-
kernel/rcu/rcutorture.c                       |  60 ++++-
kernel/rcu/tree.c                             | 131 ++++++----
kernel/rcu/tree.h                             |  10 +-
kernel/rcu/tree_nocb.h                        | 246 +++++++++++++++---
kernel/sysctl.c                               |  17 ++
.../selftests/rcutorture/configs/rcu/CFLIST   |   1 +
.../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
.../rcutorture/configs/rcu/TREE11.boot        |   8 +
20 files changed, 536 insertions(+), 104 deletions(-)
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

--
2.37.1.559.g78731f0fdb-goog

