Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF957B0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiGTGQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGTGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:16:37 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC937237D5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:16:36 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 75so30473518ybf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSjBzbQXi48SppjVr1IPcqMTpoaKVTuGleBE5e4PPlg=;
        b=qWXeq02jQmT+avZ0bEOeykaLx0NiTCENxYehlpmum3Tqjz/39ns7GDlC7oQ5U9RW9m
         fTdtiHBXZk5QaePwi3CnRmuBzXqBR8ZKtw3p9DWuB7mwLaiY/6glmnuVdGXl7Lwi9Z5V
         jVE5q0GONsOzo3D5bYi7MOlgw7ZdcQZlRJdG/vdwNFXhPyUpLqO10ySpoSug1Z/W5F2u
         dFRdP9eGgq/Qw/zXkwNAQYMAxi/CaYCDcygd59KSvptIGmAB4h4BXqL5M/xARtjZHazy
         RpGxSxLsWZ3r6bMJ40lu41w3CICHo+D5xKTTemBU4pa5RKRjsTGUmVrZPh5MkSiC3oXK
         5YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSjBzbQXi48SppjVr1IPcqMTpoaKVTuGleBE5e4PPlg=;
        b=4HagiEiOSWg3P82ccLOwN9x/LSU0Y9YaL3hJzS0oSiHZwXkMCScZIpnLp9Ql6cJUTr
         mXxGjflYTPgtFCO7iOF60UCqqoTTywl2+4LFNU4EWzBdGKSXbx8+3x+e4GfPN9BdidHe
         H6+v/ECbr9eJqZTKlq1rpl5CNXET0kuXJKVBqVPfcGtP+snUJaqTqgJtP+NIP3s1f5c9
         o4znOhp0Kr+G83c66jeggaN6uzwenzXfK/Ws2nJAi226oy/5tIm4ZfJojefO8roS2dZZ
         CmuMVnKQH4W6LKTUzpYFOQPDHjoLhSYu6h6VmMsn3cnqZZYvRd7SffJVaWpFgTKw51Sg
         JM1w==
X-Gm-Message-State: AJIora9aBsBJP33oJ3x5R4pYA34XbkC/UF/w6ghLqEuclz1xJN/Co1HO
        SsoI6d5X0DCN8L1+oZK3l9PhkV/LXk9PmdJCsApC0hCFuK8=
X-Google-Smtp-Source: AGRyM1sbsogFERLkqhAThmJCalZGERmvQ/8csNFvLoZa0P+wocRLfiNEivXiqvsj0TUz7W30xVkIEr05HjKQSoZMRco=
X-Received: by 2002:a25:cc14:0:b0:66f:7466:53cf with SMTP id
 l20-20020a25cc14000000b0066f746653cfmr38011196ybf.191.1658297796013; Tue, 19
 Jul 2022 23:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220718120149.GD2338@kadam> <20220719055047.322355-4-ztong0001@gmail.com>
 <YtamHKt7e/xqk+Jk@kroah.com>
In-Reply-To: <YtamHKt7e/xqk+Jk@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 19 Jul 2022 23:16:25 -0700
Message-ID: <CAA5qM4BC00XusFV3Upd8L0Z-m1gRW45HrZvVFLhQfjFp6EVxoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 5:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 18, 2022 at 10:50:38PM -0700, Tong Zhang wrote:
> > This driver creates 4 debug files under [devname] folder. The devname
> > could be wlan0 initially, however it could be renamed later to e.g.
> > enx00e04c00000. This will cause problem during debug file teardown since
> > it uses  netdev->name which is no longer wlan0. To solve this problem,
> > add a notifier to handle device renaming.
> >
> > Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> > Tested-by: Zheyu Ma <zheyuma97@gmail.com>
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U.h         |  1 +
> >  drivers/staging/rtl8192u/r8192U_core.c    | 35 ++++++++++++++++++++++-
> >  drivers/staging/rtl8192u/r8192U_debugfs.c | 13 +++++++++
> >  3 files changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
> > index e8860bb2b607..ccce37b7e2ae 100644
> > --- a/drivers/staging/rtl8192u/r8192U.h
> > +++ b/drivers/staging/rtl8192u/r8192U.h
> > @@ -1122,4 +1122,5 @@ void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
> >
> >  void rtl8192_debugfs_init(struct net_device *dev);
> >  void rtl8192_debugfs_exit(struct net_device *dev);
> > +void rtl8192_debugfs_rename(struct net_device *dev);
> >  #endif
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> > index ac3716550505..5cc78c5bd706 100644
> > --- a/drivers/staging/rtl8192u/r8192U_core.c
> > +++ b/drivers/staging/rtl8192u/r8192U_core.c
> > @@ -4606,6 +4606,30 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
> >       RT_TRACE(COMP_DOWN, "wlan driver removed\n");
> >  }
> >
> > +static int rtl8192_usb_netdev_event(struct notifier_block *nb, unsigned long event,
> > +                                 void *data)
> > +{
> > +     struct net_device *netdev = netdev_notifier_info_to_dev(data);
> > +
> > +     if (netdev->netdev_ops != &rtl8192_netdev_ops)
> > +             goto out;
> > +
> > +     switch (event) {
> > +     case NETDEV_CHANGENAME:
> > +             rtl8192_debugfs_rename(netdev);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +out:
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block rtl8192_usb_netdev_notifier = {
> > +     .notifier_call = rtl8192_usb_netdev_event,
> > +};
> > +
> >  static int __init rtl8192_usb_module_init(void)
> >  {
> >       int ret;
> > @@ -4615,10 +4639,16 @@ static int __init rtl8192_usb_module_init(void)
> >       RT_TRACE(COMP_INIT, "Initializing module");
> >       RT_TRACE(COMP_INIT, "Wireless extensions version %d", WIRELESS_EXT);
> >
> > +     ret = register_netdevice_notifier(&rtl8192_usb_netdev_notifier);
> > +     if (ret) {
> > +             pr_err("register_netdevice_notifier failed %d\n", ret);
> > +             return ret;
> > +     }
> > +
> >       ret = ieee80211_debug_init();
> >       if (ret) {
> >               pr_err("ieee80211_debug_init() failed %d\n", ret);
> > -             return ret;
> > +             goto unregister_notifier;
> >       }
> >
> >       ret = ieee80211_crypto_init();
> > @@ -4660,6 +4690,8 @@ static int __init rtl8192_usb_module_init(void)
> >       ieee80211_crypto_deinit();
> >  debug_exit:
> >       ieee80211_debug_exit();
> > +unregister_notifier:
> > +     unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
> >       return ret;
> >  }
> >
> > @@ -4671,6 +4703,7 @@ static void __exit rtl8192_usb_module_exit(void)
> >       ieee80211_crypto_tkip_exit();
> >       ieee80211_crypto_deinit();
> >       ieee80211_debug_exit();
> > +     unregister_netdevice_notifier(&rtl8192_usb_netdev_notifier);
> >       RT_TRACE(COMP_DOWN, "Exiting");
> >  }
> >
> > diff --git a/drivers/staging/rtl8192u/r8192U_debugfs.c b/drivers/staging/rtl8192u/r8192U_debugfs.c
> > index 5c9376e50889..c94f5dfac96b 100644
> > --- a/drivers/staging/rtl8192u/r8192U_debugfs.c
> > +++ b/drivers/staging/rtl8192u/r8192U_debugfs.c
> > @@ -173,3 +173,16 @@ void rtl8192_debugfs_exit(struct net_device *dev)
> >       priv->debugfs_dir = NULL;
> >  }
> >
> > +void rtl8192_debugfs_rename(struct net_device *dev)
> > +{
> > +     struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
>
> No need to cast.
>
> > +
> > +     if (!priv->debugfs_dir)
> > +             return;
>
> Why does it matter?
>
> > +
> > +     if (!strcmp(priv->debugfs_dir->d_name.name, dev->name))
>
> Ick, never poke around in a dentry from debugfs if you can help it.  You
> know you are being renamed, why does it matter to check or not?
>
> > +             return;
> > +
> > +     debugfs_rename(priv->debugfs_dir->d_parent, priv->debugfs_dir,
> > +                    priv->debugfs_dir->d_parent, dev->name);
>
> Don't poke around in the dentry for the parent here either.  That feels
> racy and wrong.  Isn't there some other way to get the parent?
>
> Also you can look up the dentry for this, no need to have it saved, like
> I said in patch 2.

I think we need to save the old entry here otherwise we don't know the
original name  since dev->name has already been overwritten.

> thanks,
>
> greg k-h
