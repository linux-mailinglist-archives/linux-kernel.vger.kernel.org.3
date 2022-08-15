Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8E593CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbiHOUad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347335AbiHOUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:22:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935C033E2E;
        Mon, 15 Aug 2022 12:02:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so12221211pjz.1;
        Mon, 15 Aug 2022 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=Mfaz1LfXGr/UvNceveiY5fzXa9npXeyxxs1DRSGlQXM=;
        b=TJdHQlV13t5HaX6d59FUc8yeKaJbrW/xMo+z1XHIGdY7INXEbXfmYAMK8eywuM6ZDL
         viQ7G5tjLNHqug/kuwOV28/G71gB7DJhEQ+od6NH+H1cKKhAkwiQx8fP8GcNrjDcP4L7
         qoWsKGYKoz9X7HQj593QzsA/DnCMhn8w3CqijHLm8bYWeQvGD1+nhWmSd+4MAXMPn1hi
         p7ItCQDUWPLdrn5DYKcOkCgiDQpP8Sh54XWLTKCPFVT3Ayc/OzWHg4qOfTVPnAwlJ5EH
         K9Vd5GrPag980at0QRUDL7piVmgD38pB2hGAZFSls1FyIFz/eYWxXb4CGTpmE1Z3NBRm
         y8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=Mfaz1LfXGr/UvNceveiY5fzXa9npXeyxxs1DRSGlQXM=;
        b=TWa4B+DbVsNEkd+/ufxBNQrg+xJjHA+sJLLIztTzB2GJQTaqPjBT07wwGT8SjO0HX1
         LCQiYR8KvRNG9uxuVw7I9WoTkHirORrQgjXpJTzxjIQKqCBM9WyWPdnkdDnKZBWqt5rx
         TfkgmiSHaR/3tsGBjEOYDe6sa8vbkg/yPfdU9Q6jQeiAEyKFlVumChJXTctrwv6TguKD
         NIYW8WlgiubUybmoRMx//pAeD7gpPhP+DcaMuTDembscPBYjyT/0uoyESLTbCmVYG7N5
         d7W6Jhnp6Ux2kUJumBaeuxss49liLU26j47d8dO0KV1345exshnmB6CUZW/0CGRtoy7E
         WbxQ==
X-Gm-Message-State: ACgBeo0R614fqF4xpMmgZgq6cR+64FIYc/GTnSI/bZRAJ16ose150BNx
        WbAjYl/EiOBJksgozVnoS3kqR8G5Wc04JQ==
X-Google-Smtp-Source: AA6agR40RmTIFkna2ofomi+uvVaNt6zWBUj5/bra+glY6LQazm5zkKj+fzOFrggoGaTxiIwUA4OLCg==
X-Received: by 2002:a17:902:c406:b0:16e:df76:5267 with SMTP id k6-20020a170902c40600b0016edf765267mr18295281plk.8.1660590159240;
        Mon, 15 Aug 2022 12:02:39 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:df3e:22e0:b905:822b])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0016a4db13429sm7266926plb.192.2022.08.15.12.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:01:25 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf tools: Support reading PERF_FORMAT_LOST
Date:   Mon, 15 Aug 2022 12:01:02 -0700
Message-Id: <20220815190106.1293082-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
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

The kernel v6.0 added PERF_FORMAT_LOST which can read a number of lost
samples for the given event.  As it can change the output format of
read(2) and perf sample data, it needs to access them carefully.

You can get the code from 'perf/read-lost-v1' brach on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  tools headers UAPI: Sync linux/perf_event.h with the kernel sources
  tools lib perf: Handle read format in perf_evsel__read()
  tools lib perf: Add a test case for read formats
  perf tools: Support reading PERF_FORMAT_LOST

 tools/include/uapi/linux/perf_event.h         |   5 +-
 tools/lib/perf/evsel.c                        |  72 ++++++++
 tools/lib/perf/include/perf/event.h           |   3 +-
 tools/lib/perf/include/perf/evsel.h           |   4 +-
 tools/lib/perf/tests/test-evsel.c             | 161 ++++++++++++++++++
 tools/perf/tests/sample-parsing.c             |  14 +-
 tools/perf/util/event.h                       |  18 +-
 tools/perf/util/evsel.c                       |  33 +++-
 .../scripting-engines/trace-event-python.c    |  16 +-
 tools/perf/util/session.c                     |  32 ++--
 tools/perf/util/synthetic-events.c            |  34 +++-
 11 files changed, 354 insertions(+), 38 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.1.595.g718a3a8f04-goog

