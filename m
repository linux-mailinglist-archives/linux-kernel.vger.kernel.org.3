Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77A458ACEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbiHEPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiHEPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEF19C03
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D49E614B5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F404EC433C1;
        Fri,  5 Aug 2022 15:07:43 +0000 (UTC)
Date:   Fri, 5 Aug 2022 11:07:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH] rv: Unlock on error path in
 rv_unregister_reactor()
Message-ID: <20220805110742.7a6d55c1@gandalf.local.home>
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



Dan Carpenter (1):
      rv: Unlock on error path in rv_unregister_reactor()

----
 kernel/trace/rv/rv_reactors.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---------------------------
commit f1a15b977ff864513133ecb611eb28603d32c1b4
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu Aug 4 17:33:48 2022 +0300

    rv: Unlock on error path in rv_unregister_reactor()
    
    Unlock the "rv_interface_lock" mutex before returning.
    
    Link: https://lkml.kernel.org/r/YuvYzNfGMgV+PIhd@kili
    
    Fixes: 04acadcb4453 ("rv: Add runtime reactors interface")
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index a6522c196382..6aae106695b6 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -329,6 +329,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
 int rv_unregister_reactor(struct rv_reactor *reactor)
 {
 	struct rv_reactor_def *ptr, *next;
+	int ret = 0;
 
 	mutex_lock(&rv_interface_lock);
 
@@ -343,13 +344,14 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
 				       ptr->reactor->name, ptr->counter);
 				printk(KERN_WARNING "rv: the rv_reactor %s cannot be removed\n",
 				       ptr->reactor->name);
-				return -EBUSY;
+				ret = -EBUSY;
+				break;
 			}
 		}
 	}
 
 	mutex_unlock(&rv_interface_lock);
-	return 0;
+	return ret;
 }
 
 /*
