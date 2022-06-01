Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED305539D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiFAG64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350046AbiFAG6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:58:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56C28E3B;
        Tue, 31 May 2022 23:58:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x12so1054600pgj.7;
        Tue, 31 May 2022 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZlhNhz/TCvzULnkKwCUIM+LX24oR54eteKzGDWd7nw=;
        b=I/T+oNhe0uGdEuggQYwCVXaS4L3h9iHEHdCWNdlpnt55zQGOY5S5nwDADJtWsjytpx
         WbrRClSZGhs/zL9NecVAJHYda6sEtsvTtP4CPuUpH8Jxp0FpA/WFhlskaLyovDEYVKAV
         RaBdHpQK4iCTJ63V07/1ZW0/SYp2F14yKhsgllg88JMdR8L1MyqoUObzTU72npL0oUe3
         KnBE4aI5w153bhlXbngTh1uXp/o1K/qsoP6Q4mX15bCBmDuocreR42T1OLosajSB+P1H
         H+ggLOyXzxqs1SJ0+fEi1oceWEwU8GHJBa5ZtAYib4epBliDc1mUPhk/84qlytfDzxbI
         L7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JZlhNhz/TCvzULnkKwCUIM+LX24oR54eteKzGDWd7nw=;
        b=sEAaGKcJiWUmSpRjMUvgAni9o3C5DJMDUIBJiUnV9TMzEY7cfS6HiH77AQ78H2N6/9
         gsgSzvPL4xVFEQKyEkOmSx3IwLwx9lgEiGWS6F9hXDi6McGMgP+nplxpSGJXsn1ayNGJ
         tdTxrBSyFbpTkkVYcJxGl5pPL635SPasa4M/JUasfs4H4cV1APQZi7PHmGuI/JVX69xb
         UtrAZALQQJssWXPUCzqzPVVOmhy2yT3WjUoXiSU9fbyYAwDoq/UMpOXU2p7t2Xnje1HI
         2inWbWzpKSZCUOjWKwQpvMRwuP6ZOFDxU0QJrbPDW1xLiyhVNMTADwV8kwfmxtcd6Ra1
         56Hw==
X-Gm-Message-State: AOAM530qfw2cEGnM7kZbwRoCjL0r4FRLzpxnFRcAsZebtYyu5db/jC02
        sd5BKIHKN3RVNZ6At/gfsP0=
X-Google-Smtp-Source: ABdhPJzer0OJBnQUKHRhqiyNT4MlgFmlhN/Gf4Ck2k9RpwWh//6Bfm3CQy8eLxKl4DLsGJBXLzMpdw==
X-Received: by 2002:a62:d15c:0:b0:51b:b64d:fc69 with SMTP id t28-20020a62d15c000000b0051bb64dfc69mr914931pfl.7.1654066730165;
        Tue, 31 May 2022 23:58:50 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:82d7:adf7:b62d:6020])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a5a0a00b001cd4989febcsm3207271pjd.8.2022.05.31.23.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:58:49 -0700 (PDT)
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
Subject: [PATCH 1/5] perf lock: Change to synthesize task events
Date:   Tue, 31 May 2022 23:58:42 -0700
Message-Id: <20220601065846.456965-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601065846.456965-1-namhyung@kernel.org>
References: <20220601065846.456965-1-namhyung@kernel.org>
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

With -t/--threads option, it needs to display task names so synthesize
task related events at the beginning.

Fixes: 7c3bcbdf449f ("perf lock: Add -t/--thread option for report")
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b1200b7340a6..23a33ac15e68 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1083,7 +1083,7 @@ static int __cmd_report(bool display_info)
 static int __cmd_record(int argc, const char **argv)
 {
 	const char *record_args[] = {
-		"record", "-R", "-m", "1024", "-c", "1", "--synth", "no",
+		"record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
 	};
 	unsigned int rec_argc, i, j, ret;
 	const char **rec_argv;

base-commit: 9dde6cadb92b5670b23b97ec53091df0530ec38b
-- 
2.36.1.255.ge46751e96f-goog

