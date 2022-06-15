Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF27C54CEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiFOQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiFOQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1016041312;
        Wed, 15 Jun 2022 09:32:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z14so6953382pjb.4;
        Wed, 15 Jun 2022 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=To6GanTQ5VDmwkEDfHH2NW2hi0lID+6OMpi9DEy3e74=;
        b=DDfgjPyMURfBUxUYPp/+3LhkxhS7i2Dk0U/oK9GPpGePs16u226NB+gY7wDXybBmvH
         IihEuZeumLhhSWVqC8ETEwUp6JAH1bBoWrd1QifK4DdijIl2UXi+KbvABB4B5ByzoaX+
         BKaHQEJ20jAjx16ugn+9ZHGZOP6oo1AIcCZKj7WKuHmn5DPjj2M1AQAU3F2BsbJ57YJ+
         4tNbhubED4tPo5zbxC52E5+wA0J59hbb7XN24I/4EAIOs0qXBbOPaKN/sDWYgnxX2hv6
         jcJJh6l3KxyesgiANyGgrbW5idouCfGbtLkc/nx+Um/4lBVC88scTQN8+892ap9oh88E
         XKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=To6GanTQ5VDmwkEDfHH2NW2hi0lID+6OMpi9DEy3e74=;
        b=MfHrQUbG1wxiPew3SVrPZJOcrJUBZpIUUAY3qbgsev+TFyxCXYKAbrEWn6eI0gCYf2
         8n12W4Tiv5oro9fXzqWyPTUsmIBfpf8HXAJ54KQSf1zLH0cJCpPfceK7EZ+IUeX2kfaA
         jB9Wot4Kku3N1F7vL1pOFsx4lubbIhkJjPFQid3nOOwA/lB2qVZ1r0P8+KRgrvGzrwj2
         I1CEZWF846hJgoO4RpPSHDSxMfP4SeGQOfPxTu5x2WisnXO55XXdv8R3anP1ierI6c0K
         cT7Vn/s5OHlX3gAl7Ll4kDVA3R4eZSkSj4LxbI0rZedGj5Lf/cf/SR/iBv+IjoBSYSbQ
         zfrQ==
X-Gm-Message-State: AJIora+gt5YNwDQoRPxxs7waEf3u2cL6qpHs7kOZFVKPFRMdw7psb5Og
        8Aeb3tRycAj0h6YiuaeTvl4=
X-Google-Smtp-Source: AGRyM1vWmD6AXjiwt2vRM4rwafHcK3gqHCqcaDI392vDshYl2I5ADwds+Pr5RhsVmqjl54qTJv+zVA==
X-Received: by 2002:a17:903:25d6:b0:168:a88f:44ea with SMTP id jc22-20020a17090325d600b00168a88f44eamr520994plb.28.1655310745481;
        Wed, 15 Jun 2022 09:32:25 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:24 -0700 (PDT)
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
Subject: [PATCHSET 0/7] perf lock: New lock contention tracepoints support (v4)
Date:   Wed, 15 Jun 2022 09:32:15 -0700
Message-Id: <20220615163222.1275500-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

Changes in v4)
 * add Acked-by from Ian
 * more comments on trace_lock_handler
 * don't create stats in the contention_end handler
 
Changes in v3)
 * fix build error
 * support data from different kernels/machines
 * skip bad stat unless there's actual bad ones
 
Changes in v2)
 * add Acked-by from Ian
 * print time with a unit for compact output
 * add some comments  (Ian)
 * remove already applied patch
 
This patchset merely adds support for the new tracepoints to the
existing perf lock commands.  So there's no change to the user.  Later
I'll add new a sub-command dedicated to the tracepoints to make use of
the additional information.

Example output:

  $ sudo perf lock record -a sleep 3

  $ perf lock report -F acquired,contended,avg_wait,wait_total

                  Name   acquired  contended     avg wait    total wait

   update_blocked_a...         40         40      3.61 us     144.45 us
   kernfs_fop_open+...          5          5      3.64 us      18.18 us
    _nohz_idle_balance          3          3      2.65 us       7.95 us
   tick_do_update_j...          1          1      6.04 us       6.04 us
    ep_scan_ready_list          1          1      3.93 us       3.93 us
  ...

You can find the code in the 'perf/lock-contention-v4' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (7):
  perf lock: Print wait times with unit
  perf lock: Allow to use different kernel symbols
  perf lock: Skip print_bad_events() if nothing bad
  perf lock: Add lock contention tracepoints record support
  perf lock: Handle lock contention tracepoints
  perf record: Allow to specify max stack depth of fp callchain
  perf lock: Look up callchain for the contended locks

 tools/perf/Documentation/perf-lock.txt   |   7 +
 tools/perf/Documentation/perf-record.txt |   5 +
 tools/perf/builtin-lock.c                | 426 ++++++++++++++++++++++-
 tools/perf/util/callchain.c              |  18 +-
 4 files changed, 434 insertions(+), 22 deletions(-)


base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
-- 
2.36.1.476.g0c4daa206d-goog

