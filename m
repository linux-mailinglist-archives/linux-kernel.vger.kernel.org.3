Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86124480123
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhL0Pxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbhL0Pty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:49:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6EC0698D5;
        Mon, 27 Dec 2021 07:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73A5DB80E5A;
        Mon, 27 Dec 2021 15:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2F7C36AE7;
        Mon, 27 Dec 2021 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640619910;
        bh=P/GlImAElvMrHu+2/rB8kFl8MrpdDxgIsIPQBpkxr+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3NCjH3meHCFEq+qVJmafDDN4YK1gZlTgHWEDkBYMu5SUh7pEmjHLaQYtm8/5tCD2
         SJMW1WlnMCk9jPxUZJkPok8q+hNFdZRedpdvSgXHbc/CHQ09y5bCxkr2sN6SZHagoJ
         OPRStOg9y/AZB+LealDmJ9230FFDck1edJ+YWllo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.15 112/128] Input: iqs626a - prohibit inlining of channel parsing functions
Date:   Mon, 27 Dec 2021 16:31:27 +0100
Message-Id: <20211227151335.257912129@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227151331.502501367@linuxfoundation.org>
References: <20211227151331.502501367@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff LaBundy <jeff@labundy.com>

commit e1f5e848209a1b51ccae50721b27684c6f9d978f upstream.

Some automated builds report a stack frame size in excess of 2 kB for
iqs626_probe(); the culprit appears to be the call to iqs626_parse_prop().

To solve this problem, specify noinline_for_stack for all of the
iqs626_parse_*() helper functions which are called inside a for loop
within iqs626_parse_prop().

As a result, a build with '-Wframe-larger-than' as low as 512 is free of
any such warnings.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Link: https://lore.kernel.org/r/20211129004104.453930-1-jeff@labundy.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/iqs626a.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/input/misc/iqs626a.c
+++ b/drivers/input/misc/iqs626a.c
@@ -456,9 +456,10 @@ struct iqs626_private {
 	unsigned int suspend_mode;
 };
 
-static int iqs626_parse_events(struct iqs626_private *iqs626,
-			       const struct fwnode_handle *ch_node,
-			       enum iqs626_ch_id ch_id)
+static noinline_for_stack int
+iqs626_parse_events(struct iqs626_private *iqs626,
+		    const struct fwnode_handle *ch_node,
+		    enum iqs626_ch_id ch_id)
 {
 	struct iqs626_sys_reg *sys_reg = &iqs626->sys_reg;
 	struct i2c_client *client = iqs626->client;
@@ -604,9 +605,10 @@ static int iqs626_parse_events(struct iq
 	return 0;
 }
 
-static int iqs626_parse_ati_target(struct iqs626_private *iqs626,
-				   const struct fwnode_handle *ch_node,
-				   enum iqs626_ch_id ch_id)
+static noinline_for_stack int
+iqs626_parse_ati_target(struct iqs626_private *iqs626,
+			const struct fwnode_handle *ch_node,
+			enum iqs626_ch_id ch_id)
 {
 	struct iqs626_sys_reg *sys_reg = &iqs626->sys_reg;
 	struct i2c_client *client = iqs626->client;
@@ -885,9 +887,10 @@ static int iqs626_parse_trackpad(struct
 	return 0;
 }
 
-static int iqs626_parse_channel(struct iqs626_private *iqs626,
-				const struct fwnode_handle *ch_node,
-				enum iqs626_ch_id ch_id)
+static noinline_for_stack int
+iqs626_parse_channel(struct iqs626_private *iqs626,
+		     const struct fwnode_handle *ch_node,
+		     enum iqs626_ch_id ch_id)
 {
 	struct iqs626_sys_reg *sys_reg = &iqs626->sys_reg;
 	struct i2c_client *client = iqs626->client;


