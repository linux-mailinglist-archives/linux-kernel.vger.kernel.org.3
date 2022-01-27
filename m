Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA149EDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiA0WIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiA0WIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:08:23 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0121C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:08:22 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g145so3949809qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thume-ca.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QkRUWEuFwRyqZcgGLF5sJwI8pKdHqXj5YUQro85YEY=;
        b=SR8erQjGlj+YDrFdaSXpZYghTgkYJUhW0FGZkqbZI6KYyaRLem4hQurYQgG+tTQG5L
         1NykbCiVpzj3hG3dqUsro6iV5t+ykgJTJcyt9bZS8uKElYG9q8T9tFRAzT+G4TtVaBt/
         a2Zt5kz3ISxZW4jwyEX1S51X2PBvCGGzxn1z+mM3zhwAoIs7UDEgRZnTfk7W70TdGQSA
         Pp/U1G4ahAGl42eUu/3LuCCamW7zzGRLMz78aB9eoIhDe71OOSUO1GAEiUXDNG6j6UVP
         TSNhaf0N/sYqqvgHQc2jwPYuDwykUGPayW8nclfGsc0vPmx/kTVVjxM+T/2SoVpvnhm0
         0/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QkRUWEuFwRyqZcgGLF5sJwI8pKdHqXj5YUQro85YEY=;
        b=dsRTfLxzIzyxMwkjFmBOX9zASoSV3NhTxz5LkERxABtdZ2MkPH73AS/ndSeo3rJ38w
         xB84WAYh04JQGo2Cy2IMwlHn4swGtnBAt4j76lmqV+r13qH62rn+OOa5uk7CzOZMrkPJ
         Vaz0sZGFO1NOByJ20J/xiAc5YsPqzc8lOgj3bXZ8y2Wk2/s7Ecy08d+n0bcyWF/4kNYK
         2l1dSeMGXLJooVW/Yw6iCJ8wWBXVT9gJIdiqHzBnfN/Jxf5LQPStu3OzvciK6GXVJ9tQ
         5q2FygSToJyELk068s5b5Ix10ZqrvdbVM4JcIHhmn40qnjAo+2OXC+UoObdvo07nsSIo
         Iw7w==
X-Gm-Message-State: AOAM530d+p/g/fvmcbc3+IEBLU3ewiY52yojwh5pfO/gUWBbTrqv7pNJ
        PzKxZH8+PBTyiKTHh5sbqeTn
X-Google-Smtp-Source: ABdhPJx8US/vK6QanW6c1TXbbSgJpBYMu9gVGzImssAfGcyX5x52669bvDjHByR7m2HYcMH4aQRB5A==
X-Received: by 2002:a05:620a:4016:: with SMTP id h22mr4162888qko.380.1643321302085;
        Thu, 27 Jan 2022 14:08:22 -0800 (PST)
Received: from localhost.localdomain (cpe-24-193-238-100.nyc.res.rr.com. [24.193.238.100])
        by smtp.googlemail.com with ESMTPSA id o22sm1881848qkl.88.2022.01.27.14.08.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 14:08:21 -0800 (PST)
From:   Tristan Hume <tristan@thume.ca>
To:     mingo@kernel.org
Cc:     Tristan Hume <tristan@thume.ca>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel/pt: Fix crash with stop filters in single-range mode
Date:   Thu, 27 Jan 2022 17:08:06 -0500
Message-Id: <20220127220806.73664-1-tristan@thume.ca>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for !buf->single before calling pt_buffer_region_size in a
place where a missing check can cause a kernel crash.

Fixes a bug introduced by 670638477aede0d7a355ced04b569214aa3feacd,
which added a support for PT single-range output mode. Since that commit
if a PT stop filter range is hit while tracing, the kernel will crash
because of a null pointer dereference in pt_handle_status due to calling
pt_buffer_region_size without a ToPA configured.

The commit which introduced single-range mode guarded almost all uses of
the ToPA buffer variables with checks of the buf->single variable, but
missed the case where tracing was stopped by the PT hardware, which
happens when execution hits a configured stop filter.

Tested that hitting a stop filter while PT recording successfully
records a trace with this patch but crashes without this patch.

Signed-off-by: Tristan Hume <tristan@thume.ca>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/pt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 7f406c14715f..2d33bba9a144 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -897,8 +897,9 @@ static void pt_handle_status(struct pt *pt)
 		 * means we are already losing data; need to let the decoder
 		 * know.
 		 */
-		if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
-		    buf->output_off == pt_buffer_region_size(buf)) {
+		if (!buf->single &&
+		    (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
+		     buf->output_off == pt_buffer_region_size(buf))) {
 			perf_aux_output_flag(&pt->handle,
 			                     PERF_AUX_FLAG_TRUNCATED);
 			advance++;
-- 
2.21.1 (Apple Git-122.3)

