Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B37539D9E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbiFAG6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiFAG6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:58:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86428E3B;
        Tue, 31 May 2022 23:58:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so934123plg.5;
        Tue, 31 May 2022 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVs1vEJDTJ/i+IqBDUowDRvWGpTnBwZvyuJEkNB3FYc=;
        b=iIQvYV9Y/2tVxTj7MpmzOPtWPi+bBoX5tq1M+rq5ylw1/rWq+KH7Yt5NwYrF7z9DwK
         tsdap1vleIYYzjcM0BcOpGjkIWgHldrle5HD/nd8Z2dQW2jIJ3bIxPtDPEEz4mMrC0Xm
         4I6en8eSgms2XPGRQAe6WWWUdCoqlrGg94mTA7Kh6RvkmWuZIsChb2w7kfd0Rd4DSW+Y
         j3dRrm/ZXCqiY/W1ON7YmBOSiTvkeTHi1MfS9mPJmosX0vIjDmoNxG3m28WgyvnsYKX2
         n9JcW3a40oF6WNFPlT6qkNBUTfAkyW8ApqMesRCya54+2Gu7I+R62vg0Uff+cKeECYXr
         XU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kVs1vEJDTJ/i+IqBDUowDRvWGpTnBwZvyuJEkNB3FYc=;
        b=M0r1Tj2W2mwaYNDJgCjrhPODReM1aTx0BkWh+hyZPQ/MLBTEr7iIdnk6X8zvxaPRHB
         yYG3V/xJkaFwHBzezb7824/4vUriL3xB2duIGn03BbQmRfj8cOFsn0/O3PdoztVIvfft
         E93Lsc1p3WvzR1KbAqQ6/X+jsZA///UdX47isAbf9aXcH+/y2f0IKwGOvOSolDmRkdNB
         fZqxRZuGIi0zlYvHrhljdjK+ljLZCLZRTwxx1VLTgnKN4vEzWoa7GL5y0E8ts1KyfAdS
         ShE5jTuXqR4w78pt2CIf0rxh2qp/VaYzWOWj7EkboFq0zncrvKZkQnHiah3KAbWhZP7o
         43KQ==
X-Gm-Message-State: AOAM5321XhJBDUbb6OlsSA9wqMCoN5IuhSO5orQV9a0UQBQHoKRyTihQ
        r3UBW7WVFe7+4lmDbRcjAGMK99ghB5Y=
X-Google-Smtp-Source: ABdhPJx8D9xZeRqTL7LAcpKAitPiC+cUILfYGY/uudbRjtBdhXETNfARkC/GjCsaOS7x66vGN1RtMw==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr63818869plh.136.1654066728755;
        Tue, 31 May 2022 23:58:48 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:82d7:adf7:b62d:6020])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a5a0a00b001cd4989febcsm3207271pjd.8.2022.05.31.23.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:58:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCHSET 0/5] perf lock: New lock contention tracepoints support (v1)
Date:   Tue, 31 May 2022 23:58:41 -0700
Message-Id: <20220601065846.456965-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
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

Kernel v5.19 will have a new set of tracepoints to track lock
contentions for various lock types.  Unlike tracepoints in LOCKDEP and
LOCK_STAT, it's hit only for contended locks and lock names are not
available.  So it needs to collect stack traces and display the caller
function instead.

This patchset merely adds support for the new tracepoints to the
existing perf lock commands.  So there's no change to the user.  Later
I'll add new a sub-command dedicated to the tracepoints to make use of
the additional information.

Example output:

  $ sudo perf lock record -a sleep 3
  
  $ sudo perf lock report -F acquired,contended,avg_wait

                  Name   acquired  contended   avg wait (ns)

   update_blocked_a...         40         40            3611
   kernfs_fop_open+...          5          5            3636
    _nohz_idle_balance          3          3            2650
   tick_do_update_j...          1          1            6041
    ep_scan_ready_list          1          1            3930
  ...

You can find the code in the 'perf/lock-contention-v1' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (5):
  perf lock: Change to synthesize task events
  perf lock: Add lock contention tracepoints record support
  perf lock: Handle lock contention tracepoints
  perf record: Allow to specify max stack depth of fp callchain
  perf lock: Look up callchain for the contended locks

 tools/perf/Documentation/perf-record.txt |   5 +
 tools/perf/builtin-lock.c                | 356 ++++++++++++++++++++++-
 tools/perf/util/callchain.c              |  18 +-
 3 files changed, 364 insertions(+), 15 deletions(-)


base-commit: 9dde6cadb92b5670b23b97ec53091df0530ec38b
-- 
2.36.1.255.ge46751e96f-goog

