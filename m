Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70114544258
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbiFIEJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbiFIEJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:09:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A227CE9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:09:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c196so20061329pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ouk7+Ke+HW093nWEFwQ5D14yOFTrhJHXFT/fgT162bQ=;
        b=EUct5RkmkaOLADrUzrUz5MXFt81MEoAJJPQJNDRYKMCCRgMZ+kpm7cCxAhIKTHtBIy
         6Ck22WNMJHvCfqO1etE0f3llvL4v4UBLX0+xI8w0HSPYbCQcndGrC1usEzdb3gec1gDs
         r9LmND37fJbm//K7ZnhlrftOLznexRtzA4jYLPCUoSCxcaIf368C0a7TXbTzz/yjqjIF
         6HbsJ40OBeJiq2fUgVMTzVkuwMGQvFeE6Fe+9nl+54rE57gO/x3OB04MJj1SFrXgfoGL
         PrIJ06T8iIGeeI5L449Pk48yWbe7VsQBAfmkgLKjIvD3gFbxC0PQGqjE0hMxkncI/i4x
         My1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ouk7+Ke+HW093nWEFwQ5D14yOFTrhJHXFT/fgT162bQ=;
        b=rhXehw8M53oFvkwsVpVJ4KSNCKiVZ59lIY5f2HkNy/lMiaKXP85jnd91WEaOMLifoa
         mb4WzMjf+o2lMDJjCPVnqXe666fjP+esxyEkzW2cM5rwDKCg73un9ODoSj990g1DvZ7X
         ii96Z288tff4X2RpmGUJxLqI4y5RuEqX3JNjtRg4scNzZeSCXphfVhauaGCsuqO5kJkY
         QMiKXSV0ZX5+8Uhv1Od0iNTigZLj9IeWkAPlE9XggNJXDhHzaSA08MpOvv+SWMJNj8Qu
         Cm/LbakslePaslqN8Bgpi8/KXq53erqO+XG0wjTGNLzbxFomL/u/bFe3Fxij/QrXYWjv
         cZDw==
X-Gm-Message-State: AOAM5305cOxhswImCFMufnrpe42Y/4XgUPh/AyHz3uVnOFtJI94vgQ+f
        RKhEIHq8nhR6/9gqhQun/m3R6w==
X-Google-Smtp-Source: ABdhPJyRq3/5D98T+QkcS5O1SPAlo57Uw3qIqKhI1hJS+mY3bjIHB2P9+hfcTjWWZR59I3qe2NQuBA==
X-Received: by 2002:a63:5:0:b0:3fe:2558:677 with SMTP id 5-20020a630005000000b003fe25580677mr7137001pga.113.1654747776233;
        Wed, 08 Jun 2022 21:09:36 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([2404:9dc0:cd01::1c])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902759200b001624965d83bsm15592967pll.228.2022.06.08.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 21:09:35 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] perf trace: Enable ignore_missing_thread for stat
Date:   Thu,  9 Jun 2022 12:09:24 +0800
Message-Id: <20220609040924.12885-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf already support ignore_missing_thread for -p, but not yet
applied to `perf stat -p <pid>`. This patch enables ignore_missing_thread
for `perf stat -p <pid>`.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ce87a8eb7d7..d2ecd4d29624 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2586,6 +2586,8 @@ int cmd_stat(int argc, const char **argv)
 	if (evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack))
 		goto out;
 
+	/* Enable ignoring missing threads when -p option is defined. */
+	evlist__first(evsel_list)->ignore_missing_thread = target.pid;
 	status = 0;
 	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
 		if (stat_config.run_count != 1 && verbose > 0)
-- 
2.20.1

