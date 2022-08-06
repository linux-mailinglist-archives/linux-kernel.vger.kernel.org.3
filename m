Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8558B389
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 05:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiHFDeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 23:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiHFDeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 23:34:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA0F1A067
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 20:34:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l64so4188258pge.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 20:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjmY93vwKN6ewHYAmQktkwj7uBOKnaFWrnxh8EnqjEs=;
        b=kmAcIxuOUF9I4GsRQlhWha0RfvSluB/OpM2MxoAK5SLNiWdVnRYmXyGyXG0yO89OKQ
         ZozNjuSRkzix35oHvTOD4keZJth5WtT5oQ8zGC9WA0/1sO7ntBJunRlfEEUwbpB9qrCS
         /nJxHSa7NtrWZvryILjhpnUHP0LUjKplykrR4TnExd7pIM9iIYRCYf1k1xMkvBkoJiqQ
         iKdbP4jlUutEzpiReneGU/jhEWEK/6M0HkAWoJSMWm7fh62itc1Q/I/mmyE3AIgNBVBC
         asj5BAYFsFno4IILy8XJNQTNaQC6uRaaw0lL9o52SmoFNeLYYtFqVGZnUjEzzwFBTdHW
         V/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjmY93vwKN6ewHYAmQktkwj7uBOKnaFWrnxh8EnqjEs=;
        b=TAbMsQqC15/UGGAJE40hJXZpM2vQmZJqwNVzF6eaLIHde3qCKnX0bua1XMm6F4+tUB
         LBHqZzUvMdww+NAcBB8WzICFlDMQRVoozmHsikDfG+RzjZboTsZ9lUzNSstMs6KpiT+p
         befuYsqo6AdSPq3yz6MXPCUS1Ox2MFbOrh8HCFeMuN6cu0uKzhLxBoIJ9+bZxUL5IWfN
         ckG7SFOlVuTYc0bs4c07hp5X2xzw0NPlER1vzPsVVG5LuIUbgOF4xE/EYeR9xarvemhA
         aTkvqyybwFdTM9shwWdBqZwwvFRQEBHz7wT7NsLug+lYNY1PLUjimM9ENft1TcHRvBn6
         5EbQ==
X-Gm-Message-State: ACgBeo2TCdk5I7QYwXbYIPOTLIKgIXP3stxKaRzCAkbPMxnmPW0JItYe
        YW17vqLyXBWB/uvMsbYncpt7hg==
X-Google-Smtp-Source: AA6agR4wDZh582ooPNMr+avvYBgS2vdRupsrL1CrPa8BtyQXwz0ymGt5F0rEwnr+jvm+Lof/mbjCQQ==
X-Received: by 2002:a63:5665:0:b0:41d:1b8f:75a9 with SMTP id g37-20020a635665000000b0041d1b8f75a9mr3135238pgm.22.1659756884713;
        Fri, 05 Aug 2022 20:34:44 -0700 (PDT)
Received: from localhost (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b0016bd8fb1fafsm3668891plb.307.2022.08.05.20.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 20:34:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] perf subcmd: Set environment variable "PREFIX"
Date:   Sat,  6 Aug 2022 11:34:33 +0800
Message-Id: <20220806033434.121908-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220806033434.121908-1-leo.yan@linaro.org>
References: <20220806033434.121908-1-leo.yan@linaro.org>
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

Set environment variable "PREFIX", it will be used by invoked shell
script, e.g. the shell script uses it to find lib paths.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/subcmd/exec-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
index 33e94fb83986..5dbea456973e 100644
--- a/tools/lib/subcmd/exec-cmd.c
+++ b/tools/lib/subcmd/exec-cmd.c
@@ -24,6 +24,9 @@ void exec_cmd_init(const char *exec_name, const char *prefix,
 	subcmd_config.prefix		= prefix;
 	subcmd_config.exec_path		= exec_path;
 	subcmd_config.exec_path_env	= exec_path_env;
+
+	/* Setup environment variable for invoked shell script. */
+	setenv("PREFIX", prefix, 1);
 }
 
 #define is_dir_sep(c) ((c) == '/')
-- 
2.25.1

