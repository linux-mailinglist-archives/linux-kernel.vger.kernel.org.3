Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E0D4AF376
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiBIOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiBIOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:00:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3434C0613CA;
        Wed,  9 Feb 2022 06:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644415215; x=1675951215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LTbCfpgirvkiiJVXS3/W8u/E1X2goTKOFUcS9d7EBkM=;
  b=PJhwBJlts/W1pEilta32d+zV2310fWCR+h3BkwXwj5+VHsYxmkyd/1Yb
   XiocS0NTnlwIDERuN7lEq0grC5qGjeO8Rh30i/503wNEIsGrnjvAWlzkq
   peoMtP5BnDlkVNTvtSOYIXs07QNJYAv2934VsDNRyIVms9gPg3pWNPDTg
   AvT2Tn6DwdXutUlnpKn2iWgeR82QFrOi628kAUbhqLwg8CaD8ww7OSMDX
   KV1r+nGmBcxj2B1iYXJLMJmnivoLUL9qyO67mWTS4+lG8YGBFJYhMOFHV
   Z3Kny5WqN763YNKtRUswa+PN3cAQ7ZPTTSyKPum8qlXkdqHtMuRmSSFa/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229855628"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229855628"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678598062"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 06:00:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 16:00:09 +0200
Date:   Wed, 9 Feb 2022 16:00:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: core: Unregister device on component_add() failure
Message-ID: <YgPI6RQd/9I4/51p@kuha.fi.intel.com>
References: <20220208170048.24718-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208170048.24718-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:00:48PM +0100, Fabio M. De Francesco wrote:
> Commit 8c67d06f3fd9 ("usb: Link the ports to the connectors they are
> attached to") creates a link to the USB Type-C connector for every new
> port that is added when possible. If component_add() fails,
> usb_hub_create_port_device() prints a warning but does not unregister
> the device and does not return errors to the callers.
> 
> Syzbot reported a "WARNING in component_del()".
> 
> Fix this issue in usb_hub_create_port_device by calling device_unregister()
> and returning the errors from component_add().
> 
> Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
> Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/usb/core/port.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index c2bbf97a79be..8455b235976a 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -605,8 +605,11 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
>  	find_and_link_peer(hub, port1);
>  
>  	retval = component_add(&port_dev->dev, &connector_ops);
> -	if (retval)
> +	if (retval) {
>  		dev_warn(&port_dev->dev, "failed to add component\n");
> +		device_unregister(&port_dev->dev);
> +		return retval;

You didn't remove the peer links. Either remove them here separately,
or alternatively you can also just shuffle the code so that you only
create those links after the component_add() call:

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c2bbf97a79bec..d5bc36ca5b1f7 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -602,11 +602,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
                return retval;
        }
 
-       find_and_link_peer(hub, port1);
-
        retval = component_add(&port_dev->dev, &connector_ops);
-       if (retval)
+       if (retval) {
                dev_warn(&port_dev->dev, "failed to add component\n");
+               device_unregister(&port_dev->dev);
+               return retval;
+       }
+
+       find_and_link_peer(hub, port1);
 
        /*
         * Enable runtime pm and hold a refernce that hub_configure()

thanks,

-- 
heikki
