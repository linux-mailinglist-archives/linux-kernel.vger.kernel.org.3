Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DC5A1859
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiHYSIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbiHYSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:08:10 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B93BD14A;
        Thu, 25 Aug 2022 11:08:09 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11d7a859b3aso14694814fac.4;
        Thu, 25 Aug 2022 11:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc;
        bh=01rEmmNrDVKSyl8VLDT9G5HuxPTw6FkrMpKcesbH32I=;
        b=wXeNhxJmfWj0VmyGJI5n3FE/ZZdx4P4m4L2uJzqBXNQPYltYgdY2xipA/m8mbHeBIz
         fma4rUWQAB3o1rsn6BORHDwuaNeX7Rmdv7R5/wEGTZEbBdN21P3TL2JxOLisNS05IHsu
         YEEm1AWdSNGefaRl+4agJg3PeCmws3VbIfD4Cxgj9QhJjJ6Xqe6gI3/XBvVJmPIaUtXg
         dm1m83ecXz9/Dut45WmDnhzQDUlmNfnrFiBJpaPLzdVzdFNrBdutoVldOAjzaUYoOknl
         95ifGyRfWzcvLQYlaKn/A78Vlte7jrZO8Fs1gZZo5SH82rpjfCtPHaiZnWjaE1itzi0y
         YjFg==
X-Gm-Message-State: ACgBeo3jzTHc0qgztVtJA0qEbaWCJuzTQuGAqM/+nSy4YTBQBEt0nPmp
        GeZoiopl+Z1O16qUACRWPg==
X-Google-Smtp-Source: AA6agR69ouslPscBnnihLnHTVesjlGc7oGHvQng69WDQdJq7kDlyfdLirsSr+DvtWdQiBSUROGhT4w==
X-Received: by 2002:a05:6870:d69e:b0:10e:3b6e:b0a5 with SMTP id z30-20020a056870d69e00b0010e3b6eb0a5mr172499oap.200.1661450888384;
        Thu, 25 Aug 2022 11:08:08 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t26-20020a0568080b3a00b003434b221a17sm5000231oij.52.2022.08.25.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:08:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 13:08:01 -0500
Subject: [PATCH RFC v1 2/3] perf: Add perf_event_attr::config3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.2 adds another 64-bits of event filtering control. As the
existing perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config3' field.

Signed-off-by: Rob Herring <robh@kernel.org>

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 03b370062741..b53f9b958235 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -333,6 +333,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
+#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -474,6 +475,8 @@ struct perf_event_attr {
 	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
+
+	__u64	config3; /* extension of config2 */
 };
 
 /*
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 581ed4bdc062..7fad17853310 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -333,6 +333,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
+#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -474,6 +475,8 @@ struct perf_event_attr {
 	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
+
+	__u64	config3; /* extension of config2 */
 };
 
 /*

-- 
b4 0.10.0-dev
