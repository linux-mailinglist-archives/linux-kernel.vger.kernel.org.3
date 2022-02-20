Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38FA4BCE36
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiBTLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 06:40:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiBTLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:40:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127D33A30;
        Sun, 20 Feb 2022 03:40:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o24so22234755wro.3;
        Sun, 20 Feb 2022 03:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaEs/jN71hZeYll+tur9U96Q+2NTXlCVlLMiaYYUO5s=;
        b=MAqdQ6GhQ5ZjaCPXJmxowMvhLL6QITmXxHGes/K5j6RVUA6gnvvR9eUr8Md2zpP2/B
         +ulUv4TM9MyVDIbw/wfYkG0GS7ZNj86jxcwIO63BpGO/vwd66I7ONnGeRbqH59Phd2Dx
         dddXSwr5qmYN6s2zx/V+2CMVDa+Ctway3nsWEyWT50LK0+yeBA5SGSqnari7G8jcfzhr
         s3DA4l/gjj+30vCfDd22yC0m6VlSR4q9oHdIVI4zVrA0muDiNSAdlfYf3N4YU6GoBzk3
         xdilTeQUygq95V17kLYPWkt+awNe8tMnUzC9UYwKhz81wUTyzoa6xag5qEywyfcqvUpb
         uMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaEs/jN71hZeYll+tur9U96Q+2NTXlCVlLMiaYYUO5s=;
        b=ae0SPzQqwEHW1CTgJdyW6Sy7trZfdLSAsnPlCJ75PgsKR1dQSyiofaNJ2EMfRJGFki
         VrLe0o8yUbHEaaJYaq3hLc9iRcMHaF182g1NXW83v1CckNjgYcXuUhI9tCwQGel/c/Xc
         OBayfmyFMviquTk2b9isl9xcIK5oczCyf0KQJd0dwSvzPa/tNE8GbgQFi0SPotn5kcVf
         Lh0yWFf5QOXTWciANKqUq9ML17OsyRONvuCXMW4qud5Bf3vs3avZhBqBk68lut4hXD8l
         QwxT1GWJBdC0NY87sDO0GkbWCYyzGTkruVbqgLcK+hCMoBqWkcvdU2B4XFShRvATFOOk
         17OA==
X-Gm-Message-State: AOAM533YdrsjyAamAHy4PODVBINZJd56OjvNIGHQ2bC7o7y5LNYSQ484
        Fl4n8Pehe2q5o8tNL5xJ0Ow=
X-Google-Smtp-Source: ABdhPJwnLKujPPig2pre5dfFjnty70YOd2VPGaKifekwphhI0DwyZJd2VkaxNaOOR/OCbmh20al6VA==
X-Received: by 2002:adf:8296:0:b0:1e3:24d8:ce8b with SMTP id 22-20020adf8296000000b001e324d8ce8bmr12349614wrc.544.1645357198740;
        Sun, 20 Feb 2022 03:39:58 -0800 (PST)
Received: from nil-pc.. ([102.41.165.254])
        by smtp.gmail.com with ESMTPSA id o35-20020a05600c512300b0037df3512e9dsm4810757wms.3.2022.02.20.03.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 03:39:58 -0800 (PST)
From:   Mahmoud Abumandour <ma.mandourr@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH] perf data: don't mention --to-ctf if it's not supported
Date:   Sun, 20 Feb 2022 13:39:52 +0200
Message-Id: <20220220113952.138280-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahmoud Mandour <ma.mandourr@gmail.com>

The option `--to-ctf` is only available when perf has libbabeltrace
support. Hence, on error, we shouldn't state that user must include
`--to-ctf` unless it's supported.

The only user-visible change for this commit is that when `perf` is not
configured to support libbabeltrace, the user is only prompted to
provide the `--to-json` option instead of bothe `--to-json` and
`--to-ctf`.

Signed-off-by: Mahmoud Mandour <ma.mandourr@gmail.com>
---
 tools/perf/builtin-data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index b7f9dc85a407..c22d82d2a73c 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -62,10 +62,17 @@ static int cmd_data_convert(int argc, const char **argv)
 		pr_err("You cannot specify both --to-ctf and --to-json.\n");
 		return -1;
 	}
+#ifdef HAVE_LIBBABELTRACE_SUPPORT
 	if (!to_json && !to_ctf) {
 		pr_err("You must specify one of --to-ctf or --to-json.\n");
 		return -1;
 	}
+#else
+	if (!to_json) {
+		pr_err("You must specify --to-json.\n");
+	return -1;
+}
+#endif
 
 	if (to_json)
 		return bt_convert__perf2json(input_name, to_json, &opts);
-- 
2.30.2

