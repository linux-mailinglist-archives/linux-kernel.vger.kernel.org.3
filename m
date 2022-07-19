Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5C579FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiGSNjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiGSNj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:39:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4C5B0F8B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1F4BB81B8B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28C3C341CA;
        Tue, 19 Jul 2022 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658235220;
        bh=Erf2DzYHgAFCvrbDQB6/G45m0OcBuEH4oOVkNpZ0lr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCFObNZmCGEO9MSr5y7KxDxjPFFagMjp1PFgOSkAjSltTkrD9pT0I21a2uZknpDXl
         aMtXBzxfT8TpfnIiTnmHSeMcVT7u+rp7ikUmWWOPIcTcVo5yPihLlrhp1w+PFRe3Iw
         UZWAMC7dvSr8JQu78LLnpEKE8uUdWThwyhy42phw=
Date:   Tue, 19 Jul 2022 14:39:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, dan.carpenter@oracle.com,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH v2 3/3] staging: rtl8192u: fix rmmod warn when wlan0 is
 renamed
Message-ID: <YtamHKt7e/xqk+Jk@kroah.com>
References: <20220718120149.GD2338@kadam>
 <20220719055047.322355-4-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719055047.322355-4-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:50:38PM -0700, Tong Zhang wrote:
> This driver creates 4 debug files under [devname] folder. The devname
> could be wlan0 initially, however it could be renamed later to e.g.
> enx00e04c00000. This will cause problem during debug file teardown since
> it uses  netdev->name which is no longer wlan0. To solve this problem,
> add a notifier to handle device renaming.
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Tested-by: Zheyu Ma <zheyuma97@gmail.com>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U.h         |  1 +
>  drivers/staging/rtl8192u/r8192U_core.c    | 35 ++++++++++++++++++++++-
>  drivers/staging/rtl8192u/r8192U_debugfs.c | 13 +++++++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
> index e8860bb2b607..ccce37b7e2ae 100644
> --- a/drivers/staging/rtl8192u/r8192U.h
> +++ b/drivers/staging/rtl8192u/r8192U.h
> @@ -1122,4 +1122,5 @@ void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
>  
>  void rtl8192_debugfs_init(struct net_device *dev);
>  void rtl8192_debugfs_exit(struct net_device *dev);
> +void rtl8192_debugfs_rename(struct net_device *dev);
>  #endif
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index ac3716550505..5cc78c5bd706 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -4606,6 +4606,30 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
>  	RT_TRACE(COMP_DOWN, "wlan driver removed\n");
>  }
>  
> +static int rtl8192_usb_netdev_event(struct notifier_block *nb, unsigned long event,
> +				    void *data)
> +{
> +	struct net_device *netdev = netdev_notifier_info_to_dev(data);
> +
> +	if (netdev->netdev_ops != &rtl8192_netdev_ops)
> +		goto out;
> +
> +	switch (event) {
> +	case NETDEV_CHANGENAME:
> +		rtl8192_debugfs_rename(netdev);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +out:
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block rtl8192_usb_netdev_notifier = {
> +	.notifier_call = rtl8192_usb_netdev_event,
> +};
> +
>  static int __init rtl8192_usb_module_init(void)
>  {
>  	int ret;
> @@ -4615,10 +4639,16 @@ static int __init rtl8192_usb_module_init(void)
>  	RT_TRACE(COMP_INIT, "Initializing module");
>  	RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
>  
> +	ret = register_netdevice_notifier(&rtl8192_usb_netdev_notifier);
> +	if (ret) {
> +		pr_err("register_netdevice_notifier failed %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = ieee80211_debug_init();
>  	if (ret) {
>  		pr_err("ieee80211_debug_init() failed %d\n", ret);
> -		return ret;
> +		goto unregister_notifier;
>  	}
>  
>  	ret = ieee80211_crypto_init();
> @@ -4660,6 +4690,8 @@ static int __init rtl8192_usb_module_init(void)
>  	ieee80211_crypto_deinit();
>  debug_exit:
>  	ieee80211_debug_exit();
> +unregister_notifier:
> +	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
>  	return ret;
>  }
>  
> @@ -4671,6 +4703,7 @@ static void __exit rtl8192_usb_module_exit(void)
>  	ieee80211_crypto_tkip_exit();
>  	ieee80211_crypto_deinit();
>  	ieee80211_debug_exit();
> +	unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
>  	RT_TRACE(COMP_DOWN, "Exiting");
>  }
>  
> diff --git a/drivers/staging/rtl8192u/r8192U_debugfs.c b/drivers/staging/rtl8192u/r8192U_debugfs.c
> index 5c9376e50889..c94f5dfac96b 100644
> --- a/drivers/staging/rtl8192u/r8192U_debugfs.c
> +++ b/drivers/staging/rtl8192u/r8192U_debugfs.c
> @@ -173,3 +173,16 @@ void rtl8192_debugfs_exit(struct net_device *dev)
>  	priv->debugfs_dir = NULL;
>  }
>  
> +void rtl8192_debugfs_rename(struct net_device *dev)
> +{
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);

No need to cast.

> +
> +	if (!priv->debugfs_dir)
> +		return;

Why does it matter?

> +
> +	if (!strcmp(priv->debugfs_dir->d_name.name, dev->name))

Ick, never poke around in a dentry from debugfs if you can help it.  You
know you are being renamed, why does it matter to check or not?

> +		return;
> +
> +	debugfs_rename(priv->debugfs_dir->d_parent, priv->debugfs_dir,
> +		       priv->debugfs_dir->d_parent, dev->name);

Don't poke around in the dentry for the parent here either.  That feels
racy and wrong.  Isn't there some other way to get the parent?

Also you can look up the dentry for this, no need to have it saved, like
I said in patch 2.

thanks,

greg k-h
