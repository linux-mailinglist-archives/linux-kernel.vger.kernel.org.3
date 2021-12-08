Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7146D94D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhLHRPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhLHRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:15:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE9BC061746;
        Wed,  8 Dec 2021 09:11:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2250778wmc.2;
        Wed, 08 Dec 2021 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxVAPKYsTcOcslHUBIs4NmVmCnEOU4UXVolRlRZG2D0=;
        b=Lei62emZnhZk6JiogaT460xQ9SVE67RI2fh1G6BTxik+QwHLoRH0Ca1bVVJjCey1EB
         p+UuuL0fFsLHbjHckgqEqVQ0BK791+CYxcTzXF2E4AuE08E+r8ye0XlgjXDXUuVW8CNR
         A4sP40D1V9t3BTs1V9gSkngH5W+3RFKUBBthYfTgnp5wkeHRQx+6ka7yoWKVN7+yubvX
         bJFj992LF2VlPJX9i1pMQBqg/WYrwGn73DO2dvcZoX/11DNY5jmVq1tNdJ1S92i/qWoo
         SemJHfTIayvejCw38Dxii9sg8VOpisLFLJAgysN3gcLgGOG+c2SxSmeMoJnOzRscu/4J
         8llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxVAPKYsTcOcslHUBIs4NmVmCnEOU4UXVolRlRZG2D0=;
        b=ETezGhje+oHNlUG4sxrkp47YYnZusiDQgX1mWrzKtUH8wv9IfeGaOJwRP4gjpv0sq1
         WzYokg/NghbjI22h75Ui4JKpFkKXIh+6IPN6IhrzYgUWvvd1MO+bZ+3WEhHQStAox10C
         ILj9jzQF+FYeduHpqzZeHY/lispXYyS9Dhk+DkTvfdFRuLO6nyHDX+FpXzYK/mr59T27
         KfcOoPSYOTAFMjLd2OJYPFwV8Mc4pV4wbMiU4Y3EZn43i8ghracQ0dJRrrpmMYKTsAFH
         IQXQntbEd6rBNHvgQ/w54A8dGh4sfrvQLdE1hsIROHRmOCWLx2lMupRxzUXd3CtXbkc/
         36Bg==
X-Gm-Message-State: AOAM533lFUBgM7Bu6aISUQatt5rZ8bXeRzuwYv3O4SpCPTadDuf0D3Os
        LzQkvXTHTXky7clFMgwMzF4=
X-Google-Smtp-Source: ABdhPJx8PkSp7b8YjFdeUth4hCMLI8vYeP/HBkVPmGJiHD7IaTalA5SdXuaodo1kXbHH2bBpnJZbtQ==
X-Received: by 2002:a05:600c:3486:: with SMTP id a6mr17604580wmq.32.1638983486700;
        Wed, 08 Dec 2021 09:11:26 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id e12sm4481332wrq.20.2021.12.08.09.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:11:26 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, ak@linux.intel.com,
        john.garry@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] perf util: Fix use after free in metric__new
Date:   Wed,  8 Dec 2021 18:11:13 +0100
Message-Id: <20211208171113.22089-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses-Coverity-ID: 1494000
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fffe02aae3ed..4d2fed3aefd1 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -209,8 +209,8 @@ static struct metric *metric__new(const struct pmu_event *pe,
 	m->metric_name = pe->metric_name;
 	m->modifier = modifier ? strdup(modifier) : NULL;
 	if (modifier && !m->modifier) {
-		free(m);
 		expr__ctx_free(m->pctx);
+		free(m);
 		return NULL;
 	}
 	m->metric_expr = pe->metric_expr;
-- 
2.25.1

