Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED458202D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiG0GhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiG0GhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68F023BE7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 699896141C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7DAC433D6;
        Wed, 27 Jul 2022 06:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658903838;
        bh=Jnh3dRfpX0ZXk1XE00ChFXhymlExtP+glmxZcPnpX2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyF6gq+u4FOrLT4D8ywKtqtLxaluf/x9Pou3/YPBrdZh4yVsv9jtRsbW1u5bUt0jS
         Fkm5V1Pyx9ITzivx26hVqI4ak10WXWxNiNqsPOhW3WjPglOfcza5upNFS9MJicZJwJ
         KOLjsCXH8xqwe7Nt1ZFrWJM0CjL4PrVEgQ/jNkfY=
Date:   Wed, 27 Jul 2022 08:37:16 +0200
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
Message-ID: <YuDdHMaB6jWARQzA@kroah.com>
References: <20220718120149.GD2338@kadam>
 <20220719055047.322355-3-ztong0001@gmail.com>
 <YtalnN70xXy3PNNN@kroah.com>
 <CAA5qM4A7-hCf8hZq4M8O5havY29PYqym1_TNrWJvcc-LWbLnmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4A7-hCf8hZq4M8O5havY29PYqym1_TNrWJvcc-LWbLnmA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:30:48PM -0700, Tong Zhang wrote:
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
> > > +void rtl8192_debugfs_init(struct net_device *dev)
> > >  {
> > > -     struct proc_dir_entry *dir;
> > > +     struct dentry *dir;
> > > +     struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> >
> > No need to cast this.  Same for later on in this file.
> >
> > > -     if (!rtl8192_proc)
> > > +     dir = debugfs_create_dir(dev->name, NULL);
> > > +     if (IS_ERR(dir))
> > >               return;
> >
> 
> I'm reading this code and your comment again.
> Adding this check will avoid calling into debugfs_create_file() and 4
> function calls and doing checks from there, probably will save a
> couple of CPU cycles and avoid branch prediction penalty if there is
> any.
> I don't think the compiler can optimize for this case though it's not
> performance critical. Anyho I personally feel it is better to keep
> this.

It's not an optimization issue, it's a "we never care about the results
of a call to debugfs_*() issue".

That's all, debugfs is intended to be easy to use, and you should never
care about the return values of if it worked or not, so your code should
not check it and do anything different based on it.

Yes, it's not like "normal" kernel code, but debugfs is not normal at
all, and should never expect to work as it's only for debugging.

thanks,

greg k-h
