Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7544A8687
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbiBCOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351316AbiBCOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFEDC061759;
        Thu,  3 Feb 2022 06:33:33 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUieBjPAjigjONKTAJDQBNIgs0qLYIuK8USmxllI2tI=;
        b=OmGvdtubOQzc7W42ldtjPB26bEeyESlMwyXZ3BDh1hT7EJADlcreJPaVqUk0zHJSMpYEXA
        GpN/wQG7v6ny96lBivG+OXQnDD5Q7kCtne58SyHrnnsWs0knGTyeFRFZgC2S5rVxQpXt51
        Ll3sif/3bJLd+uKa1JtMTNl6bYpiEJiKkdxoec62ygiCC2z+/y+GHfYo5/zfpgBcUlnF+E
        V9MdQ/T72CheighAiG0kVmXCdO7/alpTksnv0YdUgvTdBV4uwhf/Id5CTnNe8WhxhEil59
        tpZIxN8Oy9ECDmGhmVxBtHU9JqX8+HDEQa8QuFumj9zOuCEY3s4BgvCx7YlSJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUieBjPAjigjONKTAJDQBNIgs0qLYIuK8USmxllI2tI=;
        b=ioqv1fZggJB6/elCEP4zSbbiL+kn2FEY41wxf/vJq5f7suSGcR+NajZzwWMsZDvkQ3W0po
        iBbg6eftXolhSrAQ==
From:   "tip-bot2 for Tristan Hume" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/pt: Fix crash with stop filters in
 single-range mode
Cc:     Tristan Hume <tristan@thume.ca>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>, stable@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220127220806.73664-1-tristan@thume.ca>
References: <20220127220806.73664-1-tristan@thume.ca>
MIME-Version: 1.0
Message-ID: <164389881167.16921.8753176904617913417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1d9093457b243061a9bba23543c38726e864a643
Gitweb:        https://git.kernel.org/tip/1d9093457b243061a9bba23543c38726e864a643
Author:        Tristan Hume <tristan@thume.ca>
AuthorDate:    Thu, 27 Jan 2022 17:08:06 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:40 +01:00

perf/x86/intel/pt: Fix crash with stop filters in single-range mode

Add a check for !buf->single before calling pt_buffer_region_size in a
place where a missing check can cause a kernel crash.

Fixes a bug introduced by commit 670638477aed ("perf/x86/intel/pt:
Opportunistically use single range output mode"), which added a
support for PT single-range output mode. Since that commit if a PT
stop filter range is hit while tracing, the kernel will crash because
of a null pointer dereference in pt_handle_status due to calling
pt_buffer_region_size without a ToPA configured.

The commit which introduced single-range mode guarded almost all uses of
the ToPA buffer variables with checks of the buf->single variable, but
missed the case where tracing was stopped by the PT hardware, which
happens when execution hits a configured stop filter.

Tested that hitting a stop filter while PT recording successfully
records a trace with this patch but crashes without this patch.

Fixes: 670638477aed ("perf/x86/intel/pt: Opportunistically use single range output mode")
Signed-off-by: Tristan Hume <tristan@thume.ca>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@kernel.org
Link: https://lkml.kernel.org/r/20220127220806.73664-1-tristan@thume.ca
---
 arch/x86/events/intel/pt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 7f406c1..2d33bba 100644
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
