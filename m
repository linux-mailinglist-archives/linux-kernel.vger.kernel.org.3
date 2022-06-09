Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA754435A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiFIF5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiFIF45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:56:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D862A961;
        Wed,  8 Jun 2022 22:56:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e9so9955882pju.5;
        Wed, 08 Jun 2022 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+ROJGR9OK4hTjnNSvuFuqvie3SGSL2fBA167xVvJow=;
        b=gxh9o2fJi/TWeT1xXEEiT1sUxaNVb29tAfiqK++XPPbeguD7H9GOTi5KTw7NaWpmVC
         1QcraRiVnWGnpjIabp32h83s/ZKV/HKYHYFIT2uExZ2SnL24LdcLVbp09icxSRc1uyKh
         0+z/8KH5XMlM1u5051ZTU7R+eOgG5t8mqw/3wu9lejJKjw/X9qDRu+rCIyi6wGVeqOOQ
         iEbNnOMD4mIW9q5F2exUd8G3zhLuSssDp/llNnsrU2oHQhAmNpZ7ILvT1HMtimtHk1sW
         HhPQJHE56NartfjzNsC88Pg0TsGucP3eHtm/cv1qBDE0wMj2covktdGkEOFfrAUkWh/X
         KbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=J+ROJGR9OK4hTjnNSvuFuqvie3SGSL2fBA167xVvJow=;
        b=VZKa+C/6BJvJiA77eAOo86BskRHF95apadYcsbYve9Zrjpe9R6bMaJOxkpO4nVxOOl
         caVdORwOVjITIVEILkZ3Np4R/sjwY6hP1MUMRqN8Y/TytLCgTPp7dBwFER6dscMCUxm+
         GGSxykKO0FTypTSAjGviY9S/iGL984KBDu5ZA4PxLDiLCoNvXGJpxEBxdAn5JxiIwTTq
         pxol0SuQ74NETYaQDI9OEp9krAWUMtTWDbjkvBacIESpvXTKDgGqWzH2efiq6yGPcD9E
         tEDUBlKcl6Ls9jLy5kQ39q9OZugztcF/7u/APQ0seXZmNBPozJx7D4JZUlLzazw6dW46
         DvOg==
X-Gm-Message-State: AOAM530R0ELEZ0HBc2I58XqsO13yUOEFMy36zm7e5ZzXKM29Oy3H3P4X
        Eb13ojSS2/gUIRMDz6pr1lU=
X-Google-Smtp-Source: ABdhPJx2abu+SabfDP763NsyMx1+0YDbgDvFz6gDRt9Qsfn2nZSRd2OII12rYUqiik6ZoAWgQMyfQg==
X-Received: by 2002:a17:90a:de15:b0:1df:63dd:9cfc with SMTP id m21-20020a17090ade1500b001df63dd9cfcmr1785230pjv.200.1654754214499;
        Wed, 08 Jun 2022 22:56:54 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:2c32:ceaf:ea06:c5de])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm9502413plk.275.2022.06.08.22.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:56:54 -0700 (PDT)
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
Subject: [PATCHSET 0/7] perf lock: New lock contention tracepoints support (v3)
Date:   Wed,  8 Jun 2022 22:56:45 -0700
Message-Id: <20220609055652.938821-1-namhyung@kernel.org>
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

You can find the code in the 'perf/lock-contention-v3' branch at

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
 tools/perf/builtin-lock.c                | 424 ++++++++++++++++++++++-
 tools/perf/util/callchain.c              |  18 +-
 4 files changed, 432 insertions(+), 22 deletions(-)


base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
-- 
2.36.1.255.ge46751e96f-goog

