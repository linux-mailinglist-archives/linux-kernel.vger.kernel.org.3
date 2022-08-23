Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7099A59D1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiHWHW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiHWHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:22:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3F62A8F;
        Tue, 23 Aug 2022 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661239374; x=1692775374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AzPYmIPZtD1JvbSXtVX52/XXpr/9wjE58l7zlYzU37o=;
  b=cPM5qRG6zw6TO+aBM8Q4i/eQB6pT39Qtm9nCZMRDoCX9DTi/THK/rsLP
   F3GJfKZJRD5b/cmhVLvXdJvAbz/yk5Sx5+ULQ8L7+R32xZEd5YRCGe9k3
   pnhbwOnkJ4JnhfwNsG9E3DupncWItAEjIlaAdddsXjHGmCW4ZkMR967CJ
   CS4r8BXWMA9PzKQxytU8fA3cioRRNXTz7cMbiI4UDEaV6KytGdsTFFrl4
   oYJsj/S+AdZaNv7xIBuVIoze2s3KzEGjkX36UO6nxgwE0djTUpY0EKKrI
   Z5ehOBNk71k9wlY2MjIsFl7/zo4U9YgvAkxXz5eIhVrQc5cgjLXEkP8SJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379903853"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="379903853"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="751591494"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2022 00:22:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 23 Aug 2022 10:22:51 +0300
Date:   Tue, 23 Aug 2022 10:22:50 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "usb: typec: ucsi: add a common function
 ucsi_unregister_connectors()"
Message-ID: <YwSASgRk8ypl0YgC@kuha.fi.intel.com>
References: <20220823065455.32579-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823065455.32579-1-tiwai@suse.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 08:54:55AM +0200, Takashi Iwai wrote:
> The recent commit 87d0e2f41b8c ("usb: typec: ucsi: add a common
> function ucsi_unregister_connectors()") introduced a regression that
> caused NULL dereference at reading the power supply sysfs.  It's a
> stale sysfs entry that should have been removed but remains with NULL
> ops.  The commit changed the error handling to skip the entries after
> a NULL con->wq, and this leaves the power device unreleased.
> 
> For addressing the regression, the straight revert is applied here.
> Further code improvements can be done from the scratch again.
> 
> Fixes: 87d0e2f41b8c ("usb: typec: ucsi: add a common function ucsi_unregister_connectors()")
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1202386
> Link: https://lore.kernel.org/r/87r11cmbx0.wl-tiwai@suse.de
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 53 ++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 1aea46493b85..7f2624f42724 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1200,32 +1200,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  	return ret;
>  }
>  
> -static void ucsi_unregister_connectors(struct ucsi *ucsi)
> -{
> -	struct ucsi_connector *con;
> -	int i;
> -
> -	if (!ucsi->connector)
> -		return;
> -
> -	for (i = 0; i < ucsi->cap.num_connectors; i++) {
> -		con = &ucsi->connector[i];
> -
> -		if (!con->wq)
> -			break;
> -
> -		cancel_work_sync(&con->work);
> -		ucsi_unregister_partner(con);
> -		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(con);
> -		destroy_workqueue(con->wq);
> -		typec_unregister_port(con->port);
> -	}
> -
> -	kfree(ucsi->connector);
> -	ucsi->connector = NULL;
> -}
> -
>  /**
>   * ucsi_init - Initialize UCSI interface
>   * @ucsi: UCSI to be initialized
> @@ -1234,6 +1208,7 @@ static void ucsi_unregister_connectors(struct ucsi *ucsi)
>   */
>  static int ucsi_init(struct ucsi *ucsi)
>  {
> +	struct ucsi_connector *con;
>  	u64 command;
>  	int ret;
>  	int i;
> @@ -1264,7 +1239,7 @@ static int ucsi_init(struct ucsi *ucsi)
>  	}
>  
>  	/* Allocate the connectors. Released in ucsi_unregister() */
> -	ucsi->connector = kcalloc(ucsi->cap.num_connectors,
> +	ucsi->connector = kcalloc(ucsi->cap.num_connectors + 1,
>  				  sizeof(*ucsi->connector), GFP_KERNEL);
>  	if (!ucsi->connector) {
>  		ret = -ENOMEM;
> @@ -1288,7 +1263,15 @@ static int ucsi_init(struct ucsi *ucsi)
>  	return 0;
>  
>  err_unregister:
> -	ucsi_unregister_connectors(ucsi);
> +	for (con = ucsi->connector; con->port; con++) {
> +		ucsi_unregister_partner(con);
> +		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> +		ucsi_unregister_port_psy(con);
> +		if (con->wq)
> +			destroy_workqueue(con->wq);
> +		typec_unregister_port(con->port);
> +		con->port = NULL;
> +	}
>  
>  err_reset:
>  	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
> @@ -1402,6 +1385,7 @@ EXPORT_SYMBOL_GPL(ucsi_register);
>  void ucsi_unregister(struct ucsi *ucsi)
>  {
>  	u64 cmd = UCSI_SET_NOTIFICATION_ENABLE;
> +	int i;
>  
>  	/* Make sure that we are not in the middle of driver initialization */
>  	cancel_delayed_work_sync(&ucsi->work);
> @@ -1409,7 +1393,18 @@ void ucsi_unregister(struct ucsi *ucsi)
>  	/* Disable notifications */
>  	ucsi->ops->async_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
>  
> -	ucsi_unregister_connectors(ucsi);
> +	for (i = 0; i < ucsi->cap.num_connectors; i++) {
> +		cancel_work_sync(&ucsi->connector[i].work);
> +		ucsi_unregister_partner(&ucsi->connector[i]);
> +		ucsi_unregister_altmodes(&ucsi->connector[i],
> +					 UCSI_RECIPIENT_CON);
> +		ucsi_unregister_port_psy(&ucsi->connector[i]);
> +		if (ucsi->connector[i].wq)
> +			destroy_workqueue(ucsi->connector[i].wq);
> +		typec_unregister_port(ucsi->connector[i].port);
> +	}
> +
> +	kfree(ucsi->connector);
>  }
>  EXPORT_SYMBOL_GPL(ucsi_unregister);
>  
> -- 
> 2.35.3

thanks,

-- 
heikki
