Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2AA4A6C19
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiBBHIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiBBHIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:08:32 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975EFC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 23:08:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso5126231pjt.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isRldP9fFyPZZ4AnoT4OlDoHYssmiFfl/ObaGaQurAg=;
        b=nS16NWpCQJ0kR87VFI43GxIKH09pjmc9NbU1DK7DjTHpNbKPvk7/eqQ+DiCtOL+Fm5
         z2T1Sf5yPHE6qYUhqi9M2ajk5qXbx2CRKQWCmZnkhQ0U7QoBPSZmtHW9wcadkKxnqBT1
         SSuzROuRnHWwueUEEKF0Ed7VeUqb44i55cQnFNF+02Gh/r3WCF5lnaGvS3XTOcTwDOdq
         9Jv1sIZf+qY2AyLS0VwBT9uAZbNuUh/i0GAsWhiqcXEgn3bl2vTkpnx/lDuaGUwlGEWV
         cS2DYhxgXYhv4qhjfNVyJiRuniGca/Uwk+g7SM4Z9oYUrMvpqU+3h8uCSoST8keQC5R/
         eyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=isRldP9fFyPZZ4AnoT4OlDoHYssmiFfl/ObaGaQurAg=;
        b=Wt7VFW9Nb0W/wiBTKVi2e+dNJVpOqZtwr4grbJbaJDDspuNRuXNEdlEKrT3DAuJqaF
         XZV/oJuc9F+YJsAYwkbG7Ysn2UXFol+qEfNEEPmgjqfc4jjwVUcx65sNtWAlo/UNiUtF
         VlUdZ+jLIup6td1DcjwrGZghsE0rkk6ix9GrUE5nB6yCZlxlATsKJn0N0BvbE9SUG1jL
         opzxA52BKahi/ArhW6vebeomD2ZnltiAgA/BfuJ+Yo2vQrSfWvuOyNPC3eAShZK5L1yi
         JveY3GGASUXsUZaQNnf4SFboDeZ95y0aryBlv8pizn/3lt/xONJTLSwKA7Igk8bj/Soz
         zghA==
X-Gm-Message-State: AOAM532uvXbO9NqW6g93L9bXsNBAHoQOj3v6BK4PW9pRr9Mg4S/JoGGT
        PlC/riY77I9NLhONB8PAYIY=
X-Google-Smtp-Source: ABdhPJxXVQqKJwLjCW5ETn9ZwYT2Pam5UB89A0RLxhwDvwKr1k/zRFgQswDhtml75VqfPmcauazf8w==
X-Received: by 2002:a17:902:70ca:: with SMTP id l10mr29535064plt.121.1643785712164;
        Tue, 01 Feb 2022 23:08:32 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:9c9f:e426:5704:d42b])
        by smtp.gmail.com with ESMTPSA id e15sm4936879pjd.52.2022.02.01.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:08:31 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/4] perf annotate: Set error stream of objdump process for TUI
Date:   Tue,  1 Feb 2022 23:08:25 -0800
Message-Id: <20220202070828.143303-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202070828.143303-1-namhyung@kernel.org>
References: <20220202070828.143303-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stderr should be set to a pipe when using TUI.  Otherwise it'd
print to stdout and break TUI windows with an error message.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 01900689dc00..8190a124b99d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2036,6 +2036,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	memset(&objdump_process, 0, sizeof(objdump_process));
 	objdump_process.argv = objdump_argv;
 	objdump_process.out = -1;
+	objdump_process.err = -1;
 	if (start_command(&objdump_process)) {
 		pr_err("Failure starting to run %s\n", command);
 		err = -1;
-- 
2.35.0.rc2.247.g8bbb082509-goog

