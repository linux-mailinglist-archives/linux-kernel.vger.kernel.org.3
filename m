Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950C14AF420
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiBIOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiBIOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:30:34 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EA4C0613C9;
        Wed,  9 Feb 2022 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644417037; x=1675953037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JN0xlf+7SwfocC10ULLvpqebae/Mg6iq3gz8bo8oEj8=;
  b=Ef0C2WcvGUMIFoyRHOnC1aaXG3Ftk9YU43gYBwWhWj8TtPiZe6lGK2+D
   NqZsjGDUNZAUzlIK1Ix622cymB8BeRH90KF33iJxgPljzuQtiM5ZcBKNI
   1S/ejvWZxucK6o7y1hA+61SK7dEr+QNJ5+VgUFsx391fQIuYckKtR4nKV
   6f//X4bJzykkSAeGlBNzGlGQvm0kE3GN1GNlD29RD1W7KjVu5/Cs3C/CI
   lZPbMIo8dxFuyWd3GWy8R3FiaRRXTOi0bCnjJEM96MEYXExUP21hP1VnQ
   izsmy8+8Os3VcM4CMP+GoLFWi+v06TYh4cyfvhxlg91UrZHeKNTZfywn8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309958356"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208,223";a="309958356"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208,223";a="678608906"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 06:30:32 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 16:30:31 +0200
Date:   Wed, 9 Feb 2022 16:30:31 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, kyletso@google.com,
        jackp@codeaurora.org, andy.shevchenko@gmail.com,
        unixbhaskar@gmail.com, subbaram@codeaurora.org,
        mrana@codeaurora.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] usb: typec: ucsi: possible deadlock in ucsi_pr_swap() and
 ucsi_handle_connector_change()
Message-ID: <YgPQB9BYJcDzbd02@kuha.fi.intel.com>
References: <037de7ac-e210-bdf5-ec7a-8c0c88a0be20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DBjLCJp5eah5t2cJ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <037de7ac-e210-bdf5-ec7a-8c0c88a0be20@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DBjLCJp5eah5t2cJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 09, 2022 at 11:50:57AM +0800, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports a possible deadlock in the ucsi driver in
> Linux 5.16:
> 
> ucsi_pr_swap()
>   mutex_lock(&con->lock); --> Line 962 (Lock A)
>   wait_for_completion_timeout(&con->complete, ...) --> Line 981 (Wait X)
> 
> ucsi_handle_connector_change()
>   mutex_lock(&con->lock); --> Line 763 (Lock A)
>   complete(&con->complete); --> Line 782 (Wake X)
>   complete(&con->complete); --> Line 807 (Wake X)
> 
> When ucsi_pr_swap() is executed, "Wait X" is performed by holding "Lock A".
> If ucsi_handle_connector_change() is executed at this time, "Wake X" cannot
> be performed to wake up "Wait X" in ucsi_handle_connector_change(), because
> "Lock A" has been already held by ucsi_handle_connector_change(), causing a
> possible deadlock.
> I find that "Wait X" is performed with a timeout, to relieve the possible
> deadlock; but I think this timeout can cause inefficient execution.
> 
> I am not quite sure whether this possible problem is real.
> Any feedback would be appreciated, thanks :)

This is probable a regression from commit ad74b8649bea ("usb: typec:
ucsi: Preliminary support for alternate modes"). Can you test does
this patch fix the issue (attached)?

thanks,

-- 
heikki

--DBjLCJp5eah5t2cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-typec-ucsi-Test-fix.patch"

From 2ad06425a3df7be656f8a5b3c202aab45554fd17 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Wed, 9 Feb 2022 17:27:19 +0300
Subject: [PATCH] usb: typec: ucsi: Test fix

Interim.

Not-Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f0c2fa19f3e0f..225104beda8be 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -956,14 +956,18 @@ static int ucsi_dr_swap(struct typec_port *port, enum typec_data_role role)
 	if (ret < 0)
 		goto out_unlock;
 
+	mutex_unlock(&con->lock);
+
 	if (!wait_for_completion_timeout(&con->complete,
 					msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
-		ret = -ETIMEDOUT;
+		return -ETIMEDOUT;
+
+	return 0;
 
 out_unlock:
 	mutex_unlock(&con->lock);
 
-	return ret < 0 ? ret : 0;
+	return ret;
 }
 
 static int ucsi_pr_swap(struct typec_port *port, enum typec_role role)
@@ -992,11 +996,13 @@ static int ucsi_pr_swap(struct typec_port *port, enum typec_role role)
 	if (ret < 0)
 		goto out_unlock;
 
+	mutex_unlock(&con->lock);
+
 	if (!wait_for_completion_timeout(&con->complete,
-				msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS))) {
-		ret = -ETIMEDOUT;
-		goto out_unlock;
-	}
+				msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
+		return -ETIMEDOUT;
+
+	mutex_lock(&con->lock);
 
 	/* Something has gone wrong while swapping the role */
 	if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) !=
@@ -1372,6 +1378,7 @@ void ucsi_unregister(struct ucsi *ucsi)
 	ucsi->ops->async_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
+		complete(&ucsi->connector[i].complete);
 		cancel_work_sync(&ucsi->connector[i].work);
 		ucsi_unregister_partner(&ucsi->connector[i]);
 		ucsi_unregister_altmodes(&ucsi->connector[i],
-- 
2.34.1


--DBjLCJp5eah5t2cJ--
