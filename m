Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B84718E6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 07:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhLLGZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 01:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhLLGZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:25:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B9C061714;
        Sat, 11 Dec 2021 22:25:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iq11so9655939pjb.3;
        Sat, 11 Dec 2021 22:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=E42zDEBHHI43u/VnmtlaEGIlOlcdDBkK8+T0r9ImGs0=;
        b=CL3CSAzm3J+rHFNPPLVJw2UG2KLLjo6bFK0Pz4AESue0sIL/fLzXazqIUQon9zWW/+
         47+WJucnPvP0ZXLZ9ojIHbPNtMWYuYXVzqOjYW+6ySTnzfrsb4+hJk0+F+vbhxoPEeFP
         Vq9ICxAiUhN9gt5Xmg4Wq/JCgEWfdhg9vJpqWN2Kf76PYaEepsEerUdUElW1F1MxfhRt
         HgVasVghxxZhdq3oOl5QdsOIU0w6JHrj3cDae4mUdLd3WyiBvjqKkQj2WNqFrsWEsUtA
         8mSKde92saIt2cCi+DrLoB2cDLuHxxf+6qs7N6ydf0+gm+0s7w0Ld5yJxuNcXhc7r/yb
         WsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E42zDEBHHI43u/VnmtlaEGIlOlcdDBkK8+T0r9ImGs0=;
        b=4BEmAQrGmUaigDHxzXbbPlcUVU4Xdq6kvBQtWi2dxXRHtNbU9UOJoTvnhFEnG5wYaz
         sB4rJAcWeVMhhg5+Mdu2bI+upaP73qDV4olx/G51yHWxYX4s9xEIbpiK4yrYXOR71+Z1
         AHxzo+E+IbiDl+X/f/JJuAm5CeAIj3GbAqRAKauq57ZVzivhKPc0Vuml6ksZMAmRUN6t
         jB59Q1q1/CLpP2s1l+JOJZUnM+wH3MDAsRcRigZACdsco9kZnqh76j+/chWwZM6E1piW
         BRl7G601Pb+osYs6yg2p4S/TxwO7TiFooPn/J3rjNyUbuYx8+SDokFZGCvtAFPSel03h
         KWbg==
X-Gm-Message-State: AOAM532O3aFYo/hU+wr2YzaKiat3cCoDEO5pneUFVQ1DKSsTZxuYjFKB
        bK53go84O1L0Ni3gSD+bzz4pRw5hvbDN+kTrleE=
X-Google-Smtp-Source: ABdhPJzdin6rH7Ej77x35b5jQQP/VMMYTiMuidzvj1ELDb29qDGqzRE6XzkqxXih3qW71mOk7BxzVw==
X-Received: by 2002:a17:902:be06:b0:142:5a21:9e8a with SMTP id r6-20020a170902be0600b001425a219e8amr86656188pls.17.1639290315314;
        Sat, 11 Dec 2021 22:25:15 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id v9sm6542900pgk.55.2021.12.11.22.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 22:25:15 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf expr: Fix missing check for return value of hashmap__new
Date:   Sun, 12 Dec 2021 06:25:02 +0000
Message-Id: <20211212062504.25841-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hashmap__new() function may return ERR_PTR(-ENOMEM) when malloc
fails, add IS_ERR checking for ctx->ids.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/expr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1d532b9fed29..c94c9ea30d1a 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -299,6 +299,10 @@ struct expr_parse_ctx *expr__ctx_new(void)
 		return NULL;
 
 	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
+	if (IS_ERR(ctx->ids)) {
+		kfree(ctx);
+		return NULL;
+	}
 	ctx->runtime = 0;
 
 	return ctx;
-- 
2.17.1

