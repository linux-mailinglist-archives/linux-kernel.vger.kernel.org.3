Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ECB5AC23F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiIDEN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiIDENM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423B4B0F0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B41160EB6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 04:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AD1C433C1;
        Sun,  4 Sep 2022 04:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662264790;
        bh=ni3Yz/4/kEi9dOdY50RYTd5QBFLAF1RixEvI/QkYAGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rwn15yEtyP36eV5ett75rLcqrTsAFJUo5xT4fCFANXauF0Ayx+jhS0jx+Cf+GjxlP
         yyzSyujB5HTSwj1n0m7I7yThkABul5jpuayfXP2Pz7TEYZIbGXv8vhX6mnYP6G+vST
         CFmwWRTWhGb8bDYoy8b/zyAAk5hGpyl/pXldPbq1mRVLxuuaoa8hk2CQvTfM9U7m6X
         fKYyftT+iiUcVDHk+4xrhrXk9f+rYVYZcS+A7i/M5Mf1X9WcVeFlVhdTABQdNf1OOh
         xiRBM6MW/jy4gSFq9CSZyj4xEFYl8iD7VRpgwTbxGknQkVu1WbBIJSgTEQsExMjhLO
         Bo0+da9Hcy4pg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] tracing: docs: Update histogram doc for .percent/.graph and 'nohitcount'
Date:   Sun,  4 Sep 2022 13:13:07 +0900
Message-Id: <166226478684.223837.9677310927556736590.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166226473132.223837.9011128463174539022.stgit@devnote2>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Update histogram document for .percent/.graph suffixes and 'nohitcount'
option.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/histogram.rst |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 859fd1b76c63..b2da4e9c62e8 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -25,7 +25,7 @@ Documentation written by Tom Zanussi
 
         hist:keys=<field1[,field2,...]>[:values=<field1[,field2,...]>]
           [:sort=<field1[,field2,...]>][:size=#entries][:pause][:continue]
-          [:clear][:name=histname1][:<handler>.<action>] [if <filter>]
+          [:clear][:name=histname1][:nohitcount][:<handler>.<action>] [if <filter>]
 
   When a matching event is hit, an entry is added to a hash table
   using the key(s) and value(s) named.  Keys and values correspond to
@@ -79,6 +79,8 @@ Documentation written by Tom Zanussi
 	.log2          display log2 value rather than raw number
 	.buckets=size  display grouping of values rather than raw number
 	.usecs         display a common_timestamp in microseconds
+        .percent       display a number of percentage value
+        .graph         display a bar-graph of a value
 	=============  =================================================
 
   Note that in general the semantics of a given field aren't
@@ -137,6 +139,12 @@ Documentation written by Tom Zanussi
   existing trigger, rather than via the '>' operator, which will cause
   the trigger to be removed through truncation.
 
+  The 'nohitcount' (or NOHC) parameter will suppress display of
+  raw hitcount in the histogram. This option requires at least one
+  value field which is not a 'raw hitcount'. For example,
+  'hist:...:vals=hitcount:nohitcount' is rejected, but
+  'hist:...:vals=hitcount.percent:nohitcount' is OK.
+
 - enable_hist/disable_hist
 
   The enable_hist and disable_hist triggers can be used to have one

