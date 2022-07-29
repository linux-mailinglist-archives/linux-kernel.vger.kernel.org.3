Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDD584CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiG2HbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiG2HbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B37B34F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 166E1B826F6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E87C433D7;
        Fri, 29 Jul 2022 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659079869;
        bh=uVqBBUFDgwzLq6Qvi2MmJujKdCy1mCzQvzDS8fkCihQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lgz+wvqbhvqGsia7w8nMspgAsBmZZu0VNhISB5W3pqXF/Vstcsxvo6EqmtqpAxSLi
         FuUmYBC7DhWN/o7fehdbabwiX+vVZDzO7pwFGtrGMuNobgJs5tIW11znOQDMOP5xfa
         pryq5GGZImBGh+aIIiMmRgfp/pQ6ugyQdRVgUFkg=
Date:   Fri, 29 Jul 2022 09:31:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 2/3] staging: rtl8192u: move debug files to debugfs
Message-ID: <YuOMun7jQov+InCw@kroah.com>
References: <YuDdHMaB6jWARQzA@kroah.com>
 <20220729035230.226172-1-ztong0001@gmail.com>
 <20220729035230.226172-3-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729035230.226172-3-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 08:52:19PM -0700, Tong Zhang wrote:
>  
> -static struct proc_dir_entry *rtl8192_proc;
> -static int __maybe_unused proc_get_stats_ap(struct seq_file *m, void *v)
> +#define R8192U_DEBUGFS_DIR_NAME "r8192u_usb"

KBUILD_MODNAME is a better thing to use here.

> +void rtl8192_debugfs_init_one(struct net_device *dev)
> +{
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);

No need to cast.

> +	struct dentry *parent_dir = debugfs_lookup(R8192U_DEBUGFS_DIR_NAME, NULL);
> +	struct dentry *dir = debugfs_create_dir(dev->name, parent_dir);
> +
> +	debugfs_create_file("stats-rx", 0444, dir, dev, &rtl8192_usb_stats_rx_fops);
> +	debugfs_create_file("stats-tx", 0444, dir, dev, &rtl8192_usb_stats_tx_fops);
> +	debugfs_create_file("stats-ap", 0444, dir, dev, &rtl8192_usb_stats_ap_fops);
> +	debugfs_create_file("registers", 0444, dir, dev, &rtl8192_usb_registers_fops);
> +
> +	priv->debugfs_dir = dir;
> +}
> +
> +void rtl8192_debugfs_exit_one(struct net_device *dev)
>  {
> -	RT_TRACE(COMP_INIT, "Initializing proc filesystem");
> -	rtl8192_proc = proc_mkdir(RTL819XU_MODULE_NAME, init_net.proc_net);
> +	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);

No need for a cast.

thanks,

greg k-h
