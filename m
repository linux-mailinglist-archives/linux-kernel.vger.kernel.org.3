Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D3849EDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344491AbiA0Voj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbiA0Voe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601AAC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:44:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A21EB821D8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD29C340E4;
        Thu, 27 Jan 2022 21:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319872;
        bh=eqIY/p2JsHWz+a3b8tVHnFVm3Fi/G+8oFQo0afV+PmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XTSllgX2C96iME5mnaMGWx3yvsDhJSpXQDY7tR7aDiVd01tXrdCXRXI50qp0V88r6
         1dfmLR5TVhV4McRGVPLVcIKldW5WSBr0oWuDIco/pPcnh92WFZGwh8sHVQ86MB96+A
         TmIBrsVWwlE4LzlJ8hAA+mGV1Vgvd9VyXnKaEBRWlteBHOFYVdmQXL8yYmP3rlDo5h
         5bMx/4S+y4KYDwDziD99Ki5HoW1dn1fDzjH2FlUTV0FS0Rgz6+40e9R1LrRFKgNAia
         GL5NwqOeM0LByjaHS57dXud9wp4q4wQRpUwA2VY/lPQ1xx33QUheQ2i7Khy0jICb+I
         xNY3jm4ERIBLw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/7] tracing: Propagate is_signed to expression
Date:   Thu, 27 Jan 2022 15:44:17 -0600
Message-Id: <f4dac08742fd7a0920bf80a73c6c44042f5eaa40.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During expression parsing, a new expression field is created which
should inherit the properties of the operands, such as size and
is_signed.

is_signed propagation was missing, causing spurious errors with signed
operands.  Add it in parse_expr() and parse_unary() to fix the problem.

Reported-by: Yordan Karadzhov <ykaradzhov@vmware.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215513
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b894d68082ea..ada87bfb5bb8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2503,6 +2503,8 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
 	expr->fn = hist_field_unary_minus;
 	expr->operands[0] = operand1;
+	expr->size = operand1->size;
+	expr->is_signed = operand1->is_signed;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
 	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
@@ -2719,6 +2721,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 		/* The operand sizes should be the same, so just pick one */
 		expr->size = operand1->size;
+		expr->is_signed = operand1->is_signed;
 
 		expr->operator = field_op;
 		expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
-- 
2.17.1

