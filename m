Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2649EDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbiA0Vok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:44:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47392 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbiA0Vof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B3261B1F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 21:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10803C340E4;
        Thu, 27 Jan 2022 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643319874;
        bh=TY2/eIey3Ob7eTs/QussZy9ldJo+Y1IYYRhYib8jcMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=QY2Xc54siv4n688VwfapexPI28URXmmZqPHEHaqmKDDBjoFOkrJf6EFTCbBSTrCK4
         ZLL4XEPAG+enXJJtPiGD4SnlVSoWh3cG2y/0q5Ci3d/n020iVN8/YGvbmr28riXzSf
         t0V5cFXKSGCNu2aoTVh63u1fBEun3iTJrU+H8ARLDUIDLERBPN+H9TWSGEFgv4rdwN
         lN/sakSXakVhhwGVwURUAEjwnLDIxGvwxrKpl9n5Nif+NqjlDPsSb1HM5/7Wyi9QbP
         iFLYcdtmregOcVH+7C/L3AKRinfx4qO2cAsrUCUKpRq8HJGqc7pDWSnyJJBqlqngsK
         ixFbHEeAF7iJg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 4/7] tracing: Don't inc err_log entry count if entry allocation fails
Date:   Thu, 27 Jan 2022 15:44:18 -0600
Message-Id: <cad1ab28f75968db0f466925e7cba5970cec6c29.1643319703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tr->n_err_log_entries should only be increased if entry allocation
succeeds.

Doing it when it fails won't cause any problems other than wasting an
entry, but should be fixed anyway.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a73d78dcda2c..addd8297874e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7740,7 +7740,8 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
 		err = kzalloc(sizeof(*err), GFP_KERNEL);
 		if (!err)
 			err = ERR_PTR(-ENOMEM);
-		tr->n_err_log_entries++;
+		else
+			tr->n_err_log_entries++;
 
 		return err;
 	}
-- 
2.17.1

