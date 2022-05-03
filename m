Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBFC517F83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiECIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiECIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:14:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9155C48
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:11:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so14139695pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ingImJTtvFfkp4DYljnLHHv+bSfMJ3n+N1up5cyEBc=;
        b=ZKtbZh0ltnirTiWTEfFYomv04BeAehvM0gAet6KiXZjvLCZ1xaCyGJuzxXHjOj6eMv
         uSPyMlfeC4XREadNu3xH4/sYr7OCt7jGLoM69eiZrrRYPK87w7As3TcdcpWApU73U0zU
         i8STlqQ8eKen0nwNe25dmuiLfI6EKt7ooWMn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ingImJTtvFfkp4DYljnLHHv+bSfMJ3n+N1up5cyEBc=;
        b=UcZrLk4Iu0V76IW4u5mCG0KjNxNFvscieY67kDnG8e5sfMgcxjuqo0cZh8QpEPC/4U
         ChfmMYzmeZD/D9b7SYHArxYccud6U9qCwq6MOBMkkS2G5dN8u2pMD/IN6kZGDR2WGSFj
         8jJypziMh6gWCnP/fwloEyzAume7bF6O+mPc6GiWiYpEAdmWy5WiPyODdutu43M/WYkv
         +s1xb5tSrfS08VsbP2kXpLBlBTtVJ22hk7bNH3/vrYATkv+nut8pEkKri6Tu7q7dJiir
         s4rcexV2KBo262tnt6Udpn3sdhX2WW3WcSYd9oLwKo/qdlfDARl4bFByjdGyLMY173Pb
         N/Jg==
X-Gm-Message-State: AOAM530Rm3KQFZFGVmYyLlM8X1QDMTZd+dbfo4HqejWcMqw+IOEPSXEE
        N+wlv6q7EEIDJ/06MDfV3/Q1hw==
X-Google-Smtp-Source: ABdhPJwCOmpDNmkh3bQetCNPZEgNRPP1XjypzwvoCv3dojW+WgrUkn7VTYGM3DW50Wva/2hftaA3MA==
X-Received: by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id h16-20020a056a00231000b004fa7eb1e855mr14855919pfh.14.1651565470059;
        Tue, 03 May 2022 01:11:10 -0700 (PDT)
Received: from localhost.localdomain (99-0-82-137.lightspeed.sntcca.sbcglobal.net. [99.0.82.137])
        by smtp.gmail.com with ESMTPSA id h2-20020aa786c2000000b0050dc762815dsm5821069pfo.55.2022.05.03.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 01:11:08 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tycho Andersen <tycho@tycho.pizza>,
        Alban Crequy <alban@kinvolk.io>
Subject: [PATCH v4 0/3] Handle seccomp notification preemption
Date:   Tue,  3 May 2022 01:09:55 -0700
Message-Id: <20220503080958.20220-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses a race condition we've dealt with recently with
seccomp. Specifically programs interrupting syscalls while they're in
progress. This was exacerbated by Golang's[1] recent adoption of
"Non-cooperative goroutine preemption", in which they try to interrupt any
syscall that's been running for more than 10ms. During certain syscalls,
it's non-trivial to write them in a reetrant manner in userspace (mount).

It allows a per-filter flag to be set that makes it so that the notifying
process will switch to "TASK_KILLABLE" as opposed to returning to userspace
on non-fatal signals.

Changes since v3[4]:
 * Clean up tests
   * Split out helper function (dedupe code)
   * Add some explanation about whats going on
 * Small documentation edit

Changes since v2[3]:
 * Split out addfd patches
 * Move the flag to be per-filter (as opposed to per notification)

Changes since v1[2]:
 * Fix some documentation
 * Add Rata's patches to allow for direct return from addfd

[1]: https://github.com/golang/proposal/blob/master/design/24543-non-cooperative-preemption.md
[2]: https://lore.kernel.org/lkml/20210220090502.7202-1-sargun@sargun.me/
[3]: https://lore.kernel.org/all/20210426180610.2363-1-sargun@sargun.me/
[4]: https://lore.kernel.org/lkml/20220429023113.74993-1-sargun@sargun.me/

Sargun Dhillon (3):
  seccomp: Add wait_killable semantic to seccomp user notifier
  selftests/seccomp: Refactor get_proc_stat to split out file reading
    code
  selftests/seccomp: Add test for wait killable notifier

 .../userspace-api/seccomp_filter.rst          |  10 +
 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/seccomp.h                  |   2 +
 kernel/seccomp.c                              |  42 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 282 +++++++++++++++++-
 5 files changed, 320 insertions(+), 19 deletions(-)

-- 
2.25.1

