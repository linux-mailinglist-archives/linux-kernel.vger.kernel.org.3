Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27503535581
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbiEZVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343961AbiEZVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:31:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63F24944;
        Thu, 26 May 2022 14:31:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gz24so2887694pjb.2;
        Thu, 26 May 2022 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j/7R+PthyozzamuAqsEUO5VCuwfiwSzmVT0OGkIwQMc=;
        b=bpaiz1RGINdcmnpjdAdTbXp+C6hZolOK/zPlFCtVQ+NdHVmH+NcZ/ez1NJv8MzH3WU
         8t2lt2a26LiDifD/l+q8u9aRTTFZvAnqWnDWLvoQEpDLlcSkO4AMB77qibaibTHAMUNH
         XQhUbbYtWurK3nERnvIxn+iGYBGcAmpZZWwdfkgyDJVEAvDyn+5kJBOXQnBqGfWyG7Oo
         4uOKi4tjKOjX3iqPY/pprD0MA32NOyed2ZKyq25VMBg0CEWau9tqO1x1mQjCxL/S0UNf
         CknTxKyqmSRwNTiljkOm3ry/GXSKa9f3+57YAa024urqSTntyPGhHRSXUpFPr5q8y3TE
         sr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=j/7R+PthyozzamuAqsEUO5VCuwfiwSzmVT0OGkIwQMc=;
        b=ykkV6+S1ixlsOad5oDg+NRpIbJ7AZ2HdJcM1DuqihSHk41dCqE8CAJLnROxo6Gkiuf
         OZdbaGw5oq3s3CItuy2xBEJnpba08p32KrOn2AApl25PhTLexNsWtPwpnHHosdZs2l4+
         +WiS7aORvgzZ+4QE98OWpED50+QjU52QmgChWGMqUptMfRv1unHcbJ7rzigsPITlqie6
         Gdwa8172j+FyHg1Pi50fTezYHCxd8uV0aKkMQwcaiYwvs/SgnrOcWlegCXil6LOg6GNT
         /jJt8Ap8jlQ9D29dg9XeBM2V+zUu8RD3aA+s7JjRJK0aceDsrZgMzWfc5xPleIC4VUM0
         rVmQ==
X-Gm-Message-State: AOAM532L8t2XlAH8qKNcxSYZ83ZQZWa0dmPGKlrZF2HdzkIkY43uQJ2a
        HzWX342tRo5EfN+pZgr3y6+aK0o+vHY=
X-Google-Smtp-Source: ABdhPJwOXWTyblKXkeHjLXylOYxCOSxWDiQEs2WhItgVts21pzqyKomhesilocGD/9/CW4gcr7+TdQ==
X-Received: by 2002:a17:90a:55cc:b0:1e0:c4a7:4a59 with SMTP id o12-20020a17090a55cc00b001e0c4a74a59mr4713529pjm.127.1653600698104;
        Thu, 26 May 2022 14:31:38 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:3dcf:1644:75fb:c00])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902ef4900b0015e8d4eb1c1sm2021328plx.11.2022.05.26.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:31:37 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf lock: Change to synthesize task events
Date:   Thu, 26 May 2022 14:31:36 -0700
Message-Id: <20220526213136.193404-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
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
-- 
2.36.1.124.g0e6072fb45-goog

