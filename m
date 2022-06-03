Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC33B53D3F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349747AbiFCX5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiFCX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:57:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D162255A3;
        Fri,  3 Jun 2022 16:56:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso13219346pjf.5;
        Fri, 03 Jun 2022 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZhuzOz+fT+QhG/cfcc7HTLjqJAL63B4pq2cDp66CZZ0=;
        b=Byk9ueE4qu0M68tpvWpvtHSPB43pGa0xMXP4xKyzzM0dWuxL3RtW0QV3oA++e5xlDU
         qBEzMsJoP4dazOI7Z1U7w2jvt+qfxBf1mNWXhKkrdRpTCULT0ya+DCLtARh/s5A3WVx6
         vFFL/cZyW9oW+fK7nCkIbUAjrCUaC+zPt00vRrGD6VhAJSrkKp5lbVS3bUEoNYWmWJxE
         +3BCVjDWxti5LJbm6cbh1Qed1Nctu7iL0JtRQfz0cy4Uz9nXMb4ycWVqUWxsa4WpaHiF
         MlIe856QBljP+Y0JzwkPX9oR5TwVsTWzXsyEO5qSlNhsOWtVeZMB2kG1VavmeHPGxdSw
         5w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZhuzOz+fT+QhG/cfcc7HTLjqJAL63B4pq2cDp66CZZ0=;
        b=DolQoRff8LFV8y7PJBS/AKZe1wij8AoS9HRM4CwV//nLD6g23KetVcnXp3ZIL3a/UI
         zD1xifCvZHphxuxCVeexspWYi7+FEi4Hmd/Sqr5lF4AnYSbqBIyluC+gm5qWXxRI069i
         6swpmx3GGLWO12AjxT8A3zemG/pW8tG0+1zVV5AU740nBAv4MAx2RXxC+QmW+BLtlvcc
         5o0C4dnsIIsQzhDcTA82Ek+VLTEf/Lstias/7CsuCdcZXNGWw6EsgIygyA9LyJlfPr78
         FXSn2/xCky80YYs4QCqpLNJZbfeaJddqtlI0dTLR9iwSzvIL1EKA8xOVxAKMC7OiSzw+
         DISg==
X-Gm-Message-State: AOAM533J/SMDGF8LrkiUr6NmGJaRaUUu+3R5zHwB7rlLWeeT13ud4QMc
        J5WLW42Tq9kZWNPwh5jQLBc=
X-Google-Smtp-Source: ABdhPJxanWQs/+2slLL0Bre7HwUeitslsu8Yi3Y3UyU6cWJFronU0VtTIlZiQMSq5ZMLyscRP4329w==
X-Received: by 2002:a17:90b:4b0a:b0:1e3:1823:ca9f with SMTP id lx10-20020a17090b4b0a00b001e31823ca9fmr27942729pjb.12.1654300617959;
        Fri, 03 Jun 2022 16:56:57 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:e599:3567:7c60:5f5a])
        by smtp.gmail.com with ESMTPSA id a37-20020a631a65000000b003c14af50626sm5868289pgm.62.2022.06.03.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:56:57 -0700 (PDT)
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
Subject: [PATCHSET 0/5] perf lock: New lock contention tracepoints support (v2)
Date:   Fri,  3 Jun 2022 16:56:51 -0700
Message-Id: <20220603235656.715800-1-namhyung@kernel.org>
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

You can find the code in the 'perf/lock-contention-v2' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (5):
  perf lock: Print wait times with unit
  perf lock: Add lock contention tracepoints record support
  perf lock: Handle lock contention tracepoints
  perf record: Allow to specify max stack depth of fp callchain
  perf lock: Look up callchain for the contended locks

 tools/perf/Documentation/perf-record.txt |   5 +
 tools/perf/builtin-lock.c                | 413 ++++++++++++++++++++++-
 tools/perf/util/callchain.c              |  18 +-
 3 files changed, 414 insertions(+), 22 deletions(-)


base-commit: 1bcca2b1bd67f3c0e5c3a88ed16c6389f01a5b31
-- 
2.36.1.255.ge46751e96f-goog

