Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6294711FF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhLKFmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLKFmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:42:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B58C061714;
        Fri, 10 Dec 2021 21:39:07 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y7so7683035plp.0;
        Fri, 10 Dec 2021 21:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gExo+9LSOFvzelbVI7aRCNITnFhUMkz0yaY6vF4ivZQ=;
        b=Hld5XYcBIvQIljYeR5tpN530Ni6TuiHQEQFvlzcvNf2CPbKh3XGH19+s/Zc3uEoTIG
         pJ9uCJVqMu9H5VO2HTbqZvTmBhB0JwJ+WEduaAM5kVYookb3uShBj0Fp76FN3cGBqu5+
         WPIICHpuLNuUSHtxC3e17S5gdbaF826Nz1hucIgD+OAxm5C2UgIdtAvErWgeL3joHEr2
         qt6udC5lmhDXR0REXqao3I4t4/J9Pzy3Q3lgb/sVT9J6AoVU9NjYcWYgDcmeKl7kZS7F
         EcbhZjNfe3H0nYRmOnTN69vu7IXVJRCqAzyYyo/lxdS5JHLUo/blf19jqNeOEYP+EkoH
         60Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gExo+9LSOFvzelbVI7aRCNITnFhUMkz0yaY6vF4ivZQ=;
        b=tPHZGr6SMUHUjmFRV/ZfLFkVOmVQLQNny3DOfHgJ3XbaisnHqBwuogS+pezo2zYI9Y
         QwZolNQgkEjaC484+RtClzqS/8RNIftWTw4wR131raQzXFzIgn3Im7bwcm7s+4QsIVzc
         Cvw+TNoEEKaHcII8tfjRu+KRT7dgX7sXetmzrBM2lxPoawC6odYBSWI1Ue+RAKNGQPx4
         OzP2YbiEo76X3TnVf+WwCCfcxnKcYjv7K9rFQ/bJnuAbz5JBhH0aRNMe/4LfrPJhjC+P
         UugSV5g8G9sans4CUVye91cIzPD30CHeWo0qetgY6+AjWrP0/9vGMdqoXnOsEmUxbYsE
         Zy6Q==
X-Gm-Message-State: AOAM532gjyTxKpozBCQDa3LU8VDQ/5AugFkUtJnvRVfLlx4n1xQJtNVh
        3Amly4Pv6JUjUQdlE3FgyveFK3+Mtn3eLjop9hE=
X-Google-Smtp-Source: ABdhPJzdxEGZHm8N7MwTO8Cv/wiv+u9jOP8jZeKzRGU8ON6S106Cwb6ByNe7ysBfKXmb6z6Q5JRV6A==
X-Received: by 2002:a17:90a:e2c3:: with SMTP id fr3mr28792182pjb.187.1639201146893;
        Fri, 10 Dec 2021 21:39:06 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id y37sm4113997pga.78.2021.12.10.21.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 21:39:06 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix NULL vs IS_ERR_OR_NULL() checking
Date:   Sat, 11 Dec 2021 05:38:53 +0000
Message-Id: <20211211053856.19827-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function trace_event__tp_format_id may return ERR_PTR(-ENOMEM).
Use IS_ERR_OR_NULL to check tp_format.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 563a9ba8954f..7f782a31bda3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -461,7 +461,7 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 		struct tep_event *tp_format;
 
 		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
-		if (!tp_format)
+		if (IS_ERR_OR_NULL(tp_format))
 			return NULL;
 
 		evsel->tp_format = tp_format;
-- 
2.17.1

