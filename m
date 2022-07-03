Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B49564851
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiGCPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiGCPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C55F51
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0305660FF0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 15:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D981C341C6;
        Sun,  3 Jul 2022 15:18:10 +0000 (UTC)
Date:   Sun, 3 Jul 2022 11:18:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] tracing: devlink: Use dynamic size for string in
 devlink_trap_report event
Message-ID: <20220703111809.40cd1c3f@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The trace event devlink_trap_report uses the __dynamic_array() macro to
determine the size of the input_dev_name field. This is because it needs
to test the dev field for NULL, and will use "NULL" if it is. But it also
has the size of the dynamic array as a fixed IFNAMSIZ bytes. This defeats
the purpose of the dynamic array, as this will reserve that amount of
bytes on the ring buffer, and to make matters worse, it will even save
that size in the event as the event expects it to be dynamic (for which it
is not).

Instead, add the logic to calculate the size needed to save the
input_dev_name field and only allocate that on the ring buffer.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/devlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index 2814f188d98c..93c2783609de 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -186,7 +186,7 @@ TRACE_EVENT(devlink_trap_report,
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
-		__dynamic_array(char, input_dev_name, IFNAMSIZ)
+		__dynamic_array(char, input_dev_name, input_dev ? strlen(input_dev->name) + 1 : sizeof("NULL"))
 	),
 
 	TP_fast_assign(
-- 
2.35.1

