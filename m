Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20774579FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiGSNjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiGSNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BC8F5138
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C05E3B81B88
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E380BC341CA;
        Tue, 19 Jul 2022 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658235217;
        bh=qaDL+/mcT4X+8FQIZSw7fmB7zry+U4EkwhvmMtJKNNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGVCY8EnI55Zu20J6/eAW8KJ8Au2kZ3oZAkVKMny1npzR+oclg4UlILSkPpB4I/hi
         PcJS/WzqX6hgKPdzXAgjymNIcy0gzx/iLeHeBCnAUkElEXRC7dtuwpVhr100Gs0h43
         AIYcA3crT548YCu0v9l3YIVl2hWbiEalD+HPzETM=
Date:   Tue, 19 Jul 2022 14:37:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, dan.carpenter@oracle.com
Subject: Re: [PATCH v2 2/3] staging: rtl8192u: move debug files to debugfs
Message-ID: <YtalnN70xXy3PNNN@kroah.com>
References: <20220718120149.GD2338@kadam>
 <20220719055047.322355-3-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719055047.322355-3-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:50:37PM -0700, Tong Zhang wrote:
> There are 4 debug files created under /proc/net/[Devname]. Devname could
> Due to this is purely for debuging as files are created read only,
> move this to debugfs like other NIC drivers do instead of using procfs.
> This is also to prepare for address rmmod warn issue.

Minor comments based on good debugfs usage:

> --- a/drivers/staging/rtl8192u/r8192U.h
> +++ b/drivers/staging/rtl8192u/r8192U.h
> @@ -1061,6 +1061,9 @@ typedef struct r8192_priv {
>  	struct delayed_work gpio_change_rf_wq;
>  	struct delayed_work initialgain_operate_wq;
>  	struct workqueue_struct *priv_wq;
> +
> +	/* debugfs */
> +	struct dentry *debugfs_dir;

Why do you need to save this dentry?  Can't you just look it up when you
want to remove the files?

> +void rtl8192_debugfs_init(struct net_device *dev)
>  {
> -	struct proc_dir_entry *dir;
> +	struct dentry *dir;
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);

No need to cast this.  Same for later on in this file.

> -	if (!rtl8192_proc)
> +	dir = debugfs_create_dir(dev->name, NULL);
> +	if (IS_ERR(dir))
>  		return;

No need to check, just keep moving on.

>  
> -	dir = proc_mkdir_data(dev->name, 0, rtl8192_proc, dev);
> -	if (!dir)
> -		return;
> +	debugfs_create_file("stats-rx", 0444, dir, dev, &rtl8192_usb_stats_rx_fops);
> +	debugfs_create_file("stats-tx", 0444, dir, dev, &rtl8192_usb_stats_tx_fops);
> +	debugfs_create_file("stats-ap", 0444, dir, dev, &rtl8192_usb_stats_ap_fops);
> +	debugfs_create_file("registers", 0444, dir, dev, &rtl8192_usb_registers_fops);
>  
> -	proc_create_single("stats-rx", S_IFREG | 0444, dir,
> -			   proc_get_stats_rx);
> -	proc_create_single("stats-tx", S_IFREG | 0444, dir,
> -			   proc_get_stats_tx);
> -	proc_create_single("stats-ap", S_IFREG | 0444, dir,
> -			   proc_get_stats_ap);
> -	proc_create_single("registers", S_IFREG | 0444, dir,
> -			   proc_get_registers);
> +	priv->debugfs_dir = dir;

Again, no need to save this, just look it up when removing the
directory.

thanks,

greg k-h
