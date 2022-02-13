Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4B4B3C81
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiBMRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:22:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiBMRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:22:40 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47234593A2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:22:34 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so16757343oos.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gOn1TOfNbMYLyYypKWqKuyTET7LgcArVblqVE8rQPA=;
        b=wgN6IGSEI7Z4WyUQRMYo3hg1Eyj/7D3v4ndCYWxXPMwiHyQZtx39kgmrd7M08chLQO
         PGzPMjzgGOW8PpSkd3QmwcMGwokLOdrLGojEodkXUWfu+VC50pFR/rOq/vJt27Sye2ua
         WaPRpO054M0tMgT/sw7OV2Jp00U0LeObVrh4ccCUiIM+Nsi09tJdWxmdD0wCTxtWKoYR
         +2XHEEeGa50aM7Q2xzixvYE6ZzRUAglEJbbYavQ+bozoD3ZhBU1HB2Ulztd619xGhGvh
         xJFTcNVbPfrZHmmPLXh/C42UwAKgnB0kAu91fXHo5fqvX9V2nkio5+dSO5fKMS2I2Xrl
         3IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gOn1TOfNbMYLyYypKWqKuyTET7LgcArVblqVE8rQPA=;
        b=UIQ7Xi1TsyQJmcLR1Sx3jwyXRqWicOooFLofZ2UaW4NnkrGO1HseK9UP0HKajiL9zW
         vWpL9kW/CcX/KmZfEU4nniEjZ4wKoEeIH6Ec4+uMgv4Q+XAy9ZWvoaFVxQlvGHKErgTv
         H0rVTdpieNz7ndO5TT73TwSrZl1jWUY22XzJ07GyLZ6KPe6kiqS05WvdqrMF05bw2Kr3
         S/Xkeo4HMuBt9TsmNUPoy/7dgGnXosC+w1JFlzTTtEjzkmEsLwQMwZZeWsC1Um5ZWdh3
         zN4Ki+/C+s4sVkAiCQxf2hNQSd8Q/GNJos3KteW5cYOUXTv7ova8hZ68ekp8Zfu1eezs
         yiug==
X-Gm-Message-State: AOAM5325CI2ozosY/YHBmmC0sqW9B6xJluLfCHMzlDBKXMb+gNbNgg2R
        e9n3s5NyPxCgTkFkP8TL0pTUsZO0Oa0rpNelX2os62W3Ecq7Lg==
X-Google-Smtp-Source: ABdhPJz82meVOYuliKCNgF06zpRUPtI5pe4EBPzRa1KfIkD9BUZy/9+Lxm8YzJocRT68c/rZijNBZ1CgcHQ7P689+Vg=
X-Received: by 2002:a05:6870:7687:: with SMTP id dx7mr1469694oab.327.1644772953668;
 Sun, 13 Feb 2022 09:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com> <20220208181510.787069-5-andrew@daynix.com>
 <CA+FuTScRp5hhkvETuVRsUxMRCZVU0wVrmd5_=a5UoKNLDv4LnA@mail.gmail.com>
In-Reply-To: <CA+FuTScRp5hhkvETuVRsUxMRCZVU0wVrmd5_=a5UoKNLDv4LnA@mail.gmail.com>
From:   Andrew Melnichenko <andrew@daynix.com>
Date:   Sun, 13 Feb 2022 19:22:22 +0200
Message-ID: <CABcq3pGQkw7uyQc+nfK0OZ5ejh3+7ws+cj41zyW99+3FsKW0og@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drivers/net/virtio_net: Added RSS hash report control.
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Yan Vugenfirer <yan@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


On Tue, Feb 8, 2022 at 10:59 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Feb 8, 2022 at 1:19 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> >
> > Now it's possible to control supported hashflows.
> > Added hashflow set/get callbacks.
> > Also, disabling RXH_IP_SRC/DST for TCP would disable then for UDP.
>
> I don't follow this comment. Can you elaborate?

I'll rephrase it in next version of patches.
The idea is that VirtioNet RSS doesn't distinguish IP hashes between
TCP and UDP.
For TCP and UDP it's possible to set IP+PORT hashes.
But disabling IP hashes will disable them for TCP and UDP simultaneously.
It's possible to set IP+PORT for TCP and IP for everything else(UDP, ICMP etc.)

>
> > TCP and UDP supports only:
> > ethtool -U eth0 rx-flow-hash tcp4 sd
> >     RXH_IP_SRC + RXH_IP_DST
> > ethtool -U eth0 rx-flow-hash tcp4 sdfn
> >     RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/net/virtio_net.c | 141 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 140 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 543da2fbdd2d..88759d5e693c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -231,6 +231,7 @@ struct virtnet_info {
> >         u8 rss_key_size;
> >         u16 rss_indir_table_size;
> >         u32 rss_hash_types_supported;
> > +       u32 rss_hash_types_saved;
>
> hash_types_active?

I think "hash_types_saved" is more suitable for the current field.
Idea is that the user may disable RSS/HASH and we need to save
what hash type configurations previously were enabled.
So, we can restore it when the user will enable RSS/HASH back.

>
> > +static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *info)
> > +{
> > +       u32 new_hashtypes = vi->rss_hash_types_saved;
> > +       bool is_disable = info->data & RXH_DISCARD;
> > +       bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
> > +
> > +       /* supports only 'sd', 'sdfn' and 'r' */
> > +       if (!((info->data == (RXH_IP_SRC | RXH_IP_DST)) | is_l4 | is_disable))
>
> maybe add an is_l3

There used to be "is_l3", but that variable was used only in that
condition statement.
So I've decided to inplace it.

>
> > +               return false;
> > +
> > +       switch (info->flow_type) {
> > +       case TCP_V4_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_TCPv4);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv4 : 0);
> > +               break;
> > +       case UDP_V4_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_UDPv4);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv4 : 0);
> > +               break;
> > +       case IPV4_FLOW:
> > +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> > +               if (!is_disable)
> > +                       new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> > +               break;
> > +       case TCP_V6_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_TCPv6);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv6 : 0);
> > +               break;
> > +       case UDP_V6_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_UDPv6);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv6 : 0);
> > +               break;
> > +       case IPV6_FLOW:
> > +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > +               if (!is_disable)
> > +                       new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > +               break;
> > +       default:
> > +               /* unsupported flow */
> > +               return false;
> > +       }
> > +
> > +       /* if unsupported hashtype was set */
> > +       if (new_hashtypes != (new_hashtypes & vi->rss_hash_types_supported))
> > +               return false;
> > +
> > +       if (new_hashtypes != vi->rss_hash_types_saved) {
> > +               vi->rss_hash_types_saved = new_hashtypes;
>
> should only be updated if the commit function returned success?

Not really, we already made all checks against "supported" hash types.
Also, the commit function may not be called if RSS is disabled by the user.
