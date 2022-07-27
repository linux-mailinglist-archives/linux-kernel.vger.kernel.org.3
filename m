Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546C558202C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiG0Gf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiG0Gf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:35:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D121E0B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65072B81AD5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D04AC433C1;
        Wed, 27 Jul 2022 06:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658903753;
        bh=+rU/ef0qw0LJcL86d8Nur1scEUCC8Ns9bMWxg7XWaLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h93tm6Exu6eVlxGRpWlpecKC20tiZIn6mGezo2lQLrLLtsuBp/wtwz4MHOGyAFcBB
         9H245Q0KXtOfYewYkli+K0VG80EhJlhu3ErrhP7NzKefmYiViUNGSSy8VySc10K1Lc
         KkSBtYf7BNtm3c+cdGVLtRTEw63QL9bvcdhYOObM=
Date:   Wed, 27 Jul 2022 08:35:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 2/3] staging: rtl8192u: move debug files to debugfs
Message-ID: <YuDcxgcD5KkeV4Tx@kroah.com>
References: <20220718120149.GD2338@kadam>
 <20220719055047.322355-3-ztong0001@gmail.com>
 <YtalnN70xXy3PNNN@kroah.com>
 <CAA5qM4B9p05KLFhsmcbYud65dUHPXqETc7rFqer0pNLjH_mJpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4B9p05KLFhsmcbYud65dUHPXqETc7rFqer0pNLjH_mJpA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:58:24PM -0700, Tong Zhang wrote:
> On Tue, Jul 19, 2022 at 5:53 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 18, 2022 at 10:50:37PM -0700, Tong Zhang wrote:
> > > There are 4 debug files created under /proc/net/[Devname]. Devname could
> > > Due to this is purely for debuging as files are created read only,
> > > move this to debugfs like other NIC drivers do instead of using procfs.
> > > This is also to prepare for address rmmod warn issue.
> >
> > Minor comments based on good debugfs usage:
> >
> > > --- a/drivers/staging/rtl8192u/r8192U.h
> > > +++ b/drivers/staging/rtl8192u/r8192U.h
> > > @@ -1061,6 +1061,9 @@ typedef struct r8192_priv {
> > >       struct delayed_work gpio_change_rf_wq;
> > >       struct delayed_work initialgain_operate_wq;
> > >       struct workqueue_struct *priv_wq;
> > > +
> > > +     /* debugfs */
> > > +     struct dentry *debugfs_dir;
> >
> > Why do you need to save this dentry?  Can't you just look it up when you
> > want to remove the files?
> >
> 
> Hi Greg,
> Thanks for the comments.
> 
> I am thinking whether it is possible to rename the device and run
> rmmod to remove something it shouldn't.
> If we are using debugfs_lookup(dev->name, NULL), say, the existing
> directories/files are
> 
>   /sys/kernel/debug/DIRA
>   /sys/kernel/debug/wlan0

Ick, wait, that's not good.  We need a driver subdirectory name in there
so that this driver doesn't stomp over some other driver that might be
doing the same foolish thing and using the root of debugfs.

> I then rename device wlan0 to DIRA, after that I remove the module by
> doing rmmod.
> Apparently either the wlan0 directory will not be renamed successfully
> due to collision or DIRA directory might be overwritten? (this part I
> haven't checked yet)
> Either Way,  later on if we do rmmod, the driver will try to do
> debugfs_lookup("fileA", NULL) and remove /sys/kernel/debug/DIRA which
> it shouldn't.
> Or if it is possible to rename the device to some wacky string
> containing wildcard or .. to launch an attack.
> 
> Maybe I am being naive but please correct me if I am wrong.
> 
> Or maybe we should put those debug files under the module's own
> directory and do lookup from there instead. like the following dir
> structure
> 
> /sys/kernel/debug/r8192u_usb/wlan0/stats-rx
> /sys/kernel/debug/r8192u_usb/wlan0/stats-rx
> /sys/kernel/debug/r8192u_usb/wlan0/stats-ap
> /sys/kernel/debug/r8192u_usb/wlan0/registers

Yes, that would be much much better.  That way you "know" you can look
up the name again correctly.

thanks,

greg k-h
