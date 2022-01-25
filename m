Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58E549B3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445425AbiAYMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354562AbiAYMMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:12:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F9C061744;
        Tue, 25 Jan 2022 04:11:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jx6so30423912ejb.0;
        Tue, 25 Jan 2022 04:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKnKru+rLN7ZmClVqR3FLwKLuS+kqBx+yEtQ0RgrvIA=;
        b=VPa/38D/iK8xrFFQOve/ExPTwb19OvH5pPB6z5zWJZAIB6pB6SaGw2TSgaCRaEU6zv
         dEqDeApRwCvHWRMT3k2BbiLO1A+2UvBa+HaC7E4pEFTg5KAa0wpcs6U7u7kX6m5NZ+Hw
         Aw7S8YmfTH7/Kol1uaooN3y6Lxgoyu37pdsZ1bABwt2Nm77yolvsfddTL1lxHB2qD8F3
         1nKUaWyWpkhPATIxKkvOmzo3FVqlwxWKQgo5A84x4RuaePjGCiZQH0lTi8BWg93ghdnE
         B1zUq3UWRv0ggvRi1YMsXlpzkTAu+OnQpDhXRAxD5GjeCZR8gJphsJzE5lR64vTFbKEa
         jm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKnKru+rLN7ZmClVqR3FLwKLuS+kqBx+yEtQ0RgrvIA=;
        b=QoNcKY3QmdYLUrfeoeu+NB5QOEe9Ub5I3dKTyE+z+O8HzYXjsD82g8BO49z0JsTBQg
         zzO42UeuG9nemyLoYfDopaQVGCCqb8SNx+FZ1xmY4opbqnzmk+ylThXCTMxSHiw0xVqq
         T6YGydUYm9xWHMr+QrCd/CzxizozCQQMul+W85+1nDliIxG/4asdzKNlcf23lay1ZFbA
         c3YXlb8NYRGJFkv4nC4/NsJSnZfRHwVbx6eOLmnf9kn87Ep2BMT1C/636NNotFDwp4Hp
         zt/eS/kJ8mwd5F7RBUx3UjcV7PlCM+WSE+tspr8TYQqFsYzJ3yXS8XJMR5/wK/OiV1l7
         T4UQ==
X-Gm-Message-State: AOAM533im1YO4seiuEjBLjqpkdk6a8fZIEGJvIl5wBewW9TXeg2MrMOX
        GEa9jwowDf7/bCxCS0yywaPEfYE58EtqwQ==
X-Google-Smtp-Source: ABdhPJwIKrUuoxJSLy8gQcb9j6ZO/rW71Z0XB/m9qkB9e/u2qYE377DjXFlkbEwQhA2bGtQkrOqFsg==
X-Received: by 2002:a17:906:f19a:: with SMTP id gs26mr15841159ejb.106.1643112716207;
        Tue, 25 Jan 2022 04:11:56 -0800 (PST)
Received: from localhost.localdomain ([39.48.168.136])
        by smtp.gmail.com with ESMTPSA id qf6sm6107334ejc.49.2022.01.25.04.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 04:11:55 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        rickyman7@gmail.com, alexey.v.bayduraev@linux.intel.com,
        adrian.hunter@intel.com, leo.yan@linaro.org, german.gomez@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        amhamza.mgc@gmail.com, James Clark <james.clark@arm.com>
Subject: [PATCH v2] perf session: check for null pointer before derefernce
Date:   Tue, 25 Jan 2022 17:11:41 +0500
Message-Id: <20220125121141.18347-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8983b963-2139-ecb3-3a31-b5e225db389c@arm.com>
References: <8983b963-2139-ecb3-3a31-b5e225db389c@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move null pointer check before dereferncing the variable

Addresses-Coverity: 1497622 ("Derereference before null check")

Reviewed-by: James Clark <james.clark@arm.com>

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>

---
v1 -> v2: It should be possible to dump stuff if machine is NULL.
---
 tools/perf/util/session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f19348dddd55..210eeee3dd70 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1503,11 +1503,12 @@ static int machines__deliver_event(struct machines *machines,
 			++evlist->stats.nr_unknown_id;
 			return 0;
 		}
-		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
 		if (machine == NULL) {
 			++evlist->stats.nr_unprocessable_samples;
+			dump_sample(evsel, event, sample, perf_env__arch(NULL));
 			return 0;
 		}
+		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
 		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
 	case PERF_RECORD_MMAP:
 		return tool->mmap(tool, event, sample, machine);
-- 
2.25.1

