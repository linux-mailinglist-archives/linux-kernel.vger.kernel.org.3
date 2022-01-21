Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD966495D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349872AbiAUJ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349787AbiAUJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:56:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51386C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:56:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso13299005pjh.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/47DffcE+c3jCAlwDovIS7aShnFPAcgmE0Cy5Af+sM=;
        b=GfzXzlpcW7AKcVRUxF87xbg2Ci6kIiXy4dlvZd1G5MefdT5pGLTz7lXZ1xY/Dv1avS
         XMRSrMTG4dxH4oB02PFc2sXQGWXqXVLznCIy3js4Wm07gitZNpDLe8nsTy6sbSQgjOJ7
         O8rf2wKVksUoPHlIpGaiUz0AcFXgDFNI3rChgrgBpeA4RxtD/OLlNUFkitdrWUPeZDsc
         F3M+OTZgIy/aaFgSuJDhVZgfCcGUKI5UiC+ofwLE7VZ4uVlZO76VWLO1N19ai4UN1AxI
         cdwQnKj56rsymd4k3xTxkvUg0yKIFPt61Frat6ofUdOunI/3ddfqZOHZY/Ufb5+s4qou
         FlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/47DffcE+c3jCAlwDovIS7aShnFPAcgmE0Cy5Af+sM=;
        b=NuMZVbtWKnbnTbkBU43cejvaRkA0SzDVmqd3MHddZaU9a0xuqTDH5VEo/iZvrSHVuo
         3Et1vwHzTVWsswI1R+cHeGYvurXccD7h/+nZ/1WAgp4fPg2e2rUTW4r89bMZ7wA3kwSj
         AqlX8/fuiHPCyQIEjq3BsbMakmt3/PoyzFq6S/dhSOhrqeKD7NsEBs5636RsY9FhON0S
         f9YV2WXHghDGMNkjZlgUB1Pe43Mo+faKy/tKAJ1/YBYaeksL5klj0nQcfqDhcn3tn8Ad
         cH2nadrnMyoNDMO0guowqSxtP6MMmLsJRMKCO+5arBVSForMinlaB+2SHsAC3/aiUbV8
         Uyjw==
X-Gm-Message-State: AOAM5325LatBdwRpUzm8iwmGcRA/1R+SLqlmw4SGvKX0eMZaibmArCMP
        bNtAs2u358YaeaiCAAKOn18=
X-Google-Smtp-Source: ABdhPJyg1B3e0pwxGq2QGKT5u3wkuMfPond86NBDkcSZXSd1h6hVndqYThYV0xzAhD2mV0KmJyRkgg==
X-Received: by 2002:a17:902:da8c:b0:14a:909b:c911 with SMTP id j12-20020a170902da8c00b0014a909bc911mr3224302plx.103.1642759017887;
        Fri, 21 Jan 2022 01:56:57 -0800 (PST)
Received: from vultr.guest ([141.164.42.249])
        by smtp.gmail.com with ESMTPSA id c2sm4623661pgj.63.2022.01.21.01.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 01:56:57 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] tracing: Use strim() to remove whitespace instead of doing it manually
Date:   Fri, 21 Jan 2022 09:56:23 +0000
Message-Id: <20220121095623.1826679-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracing_set_trace_write() function just removes the trailing whitespace
from the user supplied tracer name, but the leading whitespace should also
be removed.

In addition, if the user supplied tracer name contains only a few
whitespace characters, the first one will not be removed using the current
method, which results it a single whitespace character left in the buf.

To fix all of these issues, we use strim() to correctly remove both the
leading and trailing whitespace.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/trace/trace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a569a0cb81ee..a6e77db764cf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6433,7 +6433,7 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	char buf[MAX_TRACER_SIZE+1];
-	int i;
+	char *name;
 	size_t ret;
 	int err;
 
@@ -6447,11 +6447,9 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 
 	buf[cnt] = 0;
 
-	/* strip ending whitespace. */
-	for (i = cnt - 1; i > 0 && isspace(buf[i]); i--)
-		buf[i] = 0;
+	name = strim(buf);
 
-	err = tracing_set_tracer(tr, buf);
+	err = tracing_set_tracer(tr, name);
 	if (err)
 		return err;
 
-- 
2.35.0.rc2

