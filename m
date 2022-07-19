Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6505792CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiGSFxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiGSFxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:53:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897739BAA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:53:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31c86fe1dddso130002587b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddwaIIn58piVSVlYeufxyiAUkUWa6BS/x3DMTO6B49o=;
        b=aVUONajDby8ZEmMd1cWOFu0veJxSidQ8m1I11oHdW9wXYB73fyK91ezbJp5wPlQVJ2
         sE+sHqozuUvdvu9PohAxGxhZAzfxpevvCpBbbvKp02N4ZSWuA3sxkUq2GjEDeKJ6ERhp
         x+joz9KXOyTxkI5WkUt63zsxSoHIzEsxMwhQmKyxWRgcYUG5MiMRD4x0w7gpaVDRF7w4
         SnJA8Es2GHWvjbpVFJ9M40eJy3i0w/aq8R3pOs1OVYASH7Vb3YVt+3V9yc9tqqcoQ4sd
         Ujc0v0MBrDQE1ZQA6nG+/B1lxAHiuGTMBRrv2rFyL6sJaL1QIp39ABRXmanIotYmvs51
         WpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddwaIIn58piVSVlYeufxyiAUkUWa6BS/x3DMTO6B49o=;
        b=xtps70aOKoA/1SzXVLz+HWnYOtx4tJJPstPfKwXoHoRTbdCpq3SWIuuh0Ozc/mHbp8
         chN+4j3kzYMfKxbFOe4A7NDANiD2qZ29sbeQynagvP3aH2T5iE/eys5mWSuUafYghm23
         FR3V1wUjetSsrHzX2ny5t0fgsCbAW049fWTzAbTviRvflg6hivdOsOLAcpGzWA/MjN/F
         eumrJeFBWhY/U/1RB9bCe47adgaVVH23PbTs66XZY+ox1CQ/U3FME/HdmvaSJ+TV08Y9
         sURAq6z1Im8TyLpZtd3990K1p3pFdUH+NMP2bkytZfxjnBfhmuAQtVkv5A7bKv2v+pZM
         MmzQ==
X-Gm-Message-State: AJIora9QSVAK8XJUL4RO4oajIf9Msj6l37v5m5vEMF6RPfRfyOc9rqF4
        32WyCSgk7ocdP8pY+/AFALKgA+/w42susGjyJ8eryp+f
X-Google-Smtp-Source: AGRyM1voiLA+Jnkzd6JrEEDR31unWn3tsBQx1ZcSZOM73aSF4usz60SOtIuSERmQ7z6cJay/BQKXbbYczl1pWtYUOmY=
X-Received: by 2002:a81:12d8:0:b0:31c:ab66:4693 with SMTP id
 207-20020a8112d8000000b0031cab664693mr34526341yws.452.1658209988175; Mon, 18
 Jul 2022 22:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjmX0BDh-35GQxf3-fXFa8_EKfh2fwYKZDgH4NzGGQHiSg@mail.gmail.com>
 <20220717070204.705878-1-ztong0001@gmail.com> <20220718120149.GD2338@kadam>
In-Reply-To: <20220718120149.GD2338@kadam>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 18 Jul 2022 22:52:57 -0700
Message-ID: <CAA5qM4DWdtx6rndL5SGo=MacHYH8L2FVhmO_F07EDppkTnKbHA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: fix rmmod warn when wlan0 is renamed
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Zheyu Ma <zheyuma97@gmail.com>
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

On Mon, Jul 18, 2022 at 5:02 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sun, Jul 17, 2022 at 12:01:57AM -0700, Tong Zhang wrote:
> > +static int rtl8192_usb_netdev_event(struct notifier_block *nb, unsigned long event,
> > +             void *data)
> > +{
> > +     struct net_device *netdev = netdev_notifier_info_to_dev(data);
> > +
> > +     if (netdev->netdev_ops != &rtl8192_netdev_ops)
> > +             goto out;
> > +
> > +     switch (event) {
> > +             case NETDEV_CHANGENAME:
> > +                     rtl8192_debugfs_rename(netdev);
> > +                     break;
> > +
> > +             default:
> > +                     break;
> > +     }
>
> This isn't indented properly.  Don't forget to run ./scripts/checkpatch.pl
> on your patch.
>
> > +
> > +out:
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block rtl8192_usb_netdev_notifier = {
> > +     .notifier_call = rtl8192_usb_netdev_event,
> > +};
> > +
> > +
>
> Here too.
>
> >  static int __init rtl8192_usb_module_init(void)
> >  {
> >       int ret;
> > @@ -4788,10 +4638,14 @@ static int __init rtl8192_usb_module_init(void)
>
> [ snip ]
>
> > +void rtl8192_debugfs_init(struct net_device *dev)
> > +{
> > +     struct dentry *dir;
> > +     struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> > +
> > +     dir = debugfs_create_dir(dev->name, NULL);
> > +     if (IS_ERR_OR_NULL(dir))
> > +             return;
>
> In olden times the debugfs_create_dir() function used to return a mix
> of error pointers and NULL.  But the idea with that function is that
> most people are not supposed to check for errors.  But instead of that
> they added all kind of *buggy* checks.  So then we made it just return
> error pointers.
>
> This code *does* care about it because it uses the
> priv->debugfs_dir->d_name.name in rtl8192_debugfs_rename().
>
> But caring about the debugfs dir and creating a rtl8192_debugfs_rename()
> function is really unusual.  And normally when we have to do something
> unusual that means we are doing something wrong...  :/
>
> Anyway, just check for if (IS_ERR(dir)) {
>
> > +
> > +     debugfs_create_file("stats-rx", 0444, dir, dev, &rtl8192_usb_stats_rx_fops);
> > +     debugfs_create_file("stats-tx", 0444, dir, dev, &rtl8192_usb_stats_tx_fops);
> > +     debugfs_create_file("stats-ap", 0444, dir, dev, &rtl8192_usb_stats_ap_fops);
> > +     debugfs_create_file("registers", 0444, dir, dev, &rtl8192_usb_registers_fops);
> > +
> > +     priv->debugfs_dir = dir;
> > +}
> > +
> > +void rtl8192_debugfs_exit(struct net_device *dev)
> > +{
> > +     struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> > +     if (!priv->debugfs_dir)
> > +             return;
> > +     debugfs_remove_recursive(priv->debugfs_dir);
> > +     priv->debugfs_dir = NULL;
> > +}
> > +
> > +void rtl8192_debugfs_rename(struct net_device *dev)
> > +{
> > +     struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> > +
> > +     if (!priv->debugfs_dir)
> > +             return;
> > +
> > +     if (!strcmp(priv->debugfs_dir->d_name.name, dev->name))
> > +             return;
> > +
> > +     debugfs_rename(priv->debugfs_dir->d_parent, priv->debugfs_dir,
> > +                     priv->debugfs_dir->d_parent, dev->name);
> > +}
> > +
>
> regards,
> dan carpenter

I modified the patch and sent it as v2.
Thanks and have a good one!
- Tong
