Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82BD500A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiDNJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbiDNJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:14 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:50 PDT
Received: from mta-64-227.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718E6EC7F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:49 -0700 (PDT)
Received: by mta-64-227.flowmailer.net with ESMTPSA id 20220414094239e7bbd67e61380eda71
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jqY7wrxDvYGbT9RkRCrN/ea0DRB7hop/p6EzvqDyB0g=;
 b=c6eWv1y/xwUKqTwdibfmCwGNo7e5Kcqsm4N+tlhKQaTRFfiawl0mUUPxLkGmsbKnM7HJ99
 cwcThCoETZPRbtWx8V3zuxvxsIefD7mzXAffqwwwWcsrD6TY/IP0fsh8J7iBWGrEJzMTovqs
 PJ9DdS7UuhDZJnMyJ6swZDhzfVosE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 01/20] tty: n_gsm: fix missing mux reset on config change at responder
Date:   Thu, 14 Apr 2022 02:42:06 -0700
Message-Id: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, only the initiator resets the mux protocol if the user requests
new parameters that are incompatible to those of the current connection.
The responder also needs to reset the multiplexer if the new parameter set
requires this. Otherwise, we end up with an inconsistent parameter set
between initiator and responder.
Revert the old behavior to inform the peer upon an incompatible parameter
set change from the user on the responder side by re-establishing the mux
protocol in such case.

Fixes: 509067bbd264 ("tty: n_gsm: Delete gsm_disconnect when config requester")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fa92f727fdf8..3d28ecebd473 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2373,7 +2373,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	 * configuration
 	 */
 
-	if (gsm->initiator && (need_close || need_restart)) {
+	if (need_close || need_restart) {
 		int ret;
 
 		ret = gsm_disconnect(gsm);
-- 
2.25.1

