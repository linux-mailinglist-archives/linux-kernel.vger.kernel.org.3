Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3FE49034B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiAQH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbiAQH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:58:58 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF431C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:58:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t9so22274295oie.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n90Yt0bjmJUFoRDJKyJmGtSaOSP7/z10vdpKeraltf8=;
        b=6y5M0I85tqIm5DVUelB3EwLInUnEOxRxAfwa8l8yHfBomdjgKEfd4L1oArQYHso+qY
         TQimD3GlKoql6MZQcEMU28C3jYTjdBW6HzNDt4K4EsyxyXb4noKnI+2HLu+2mOO2DGIN
         JtAt1L1W9il9QZZb0vQJ4APi59OBsSltaa/TcGUPeFti69kGTgxcAzGFRob0G6FkAbtB
         XwWT24dxTwPIsYzMQIk9rXEuspPO/XjzdETfyn53y/dsSFN6gnFaJ0+AFZszDnf8m+YV
         FSbzCeo3CKoY8a67d15SPgEjb5CGk57O7BCs3Gy7+7+JAh7E3ESGmG7iicFLvckVHZbR
         vPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n90Yt0bjmJUFoRDJKyJmGtSaOSP7/z10vdpKeraltf8=;
        b=a0BFPc6HpXDXTJW0y40CvgqNe5rBb0VyKuBaqTBw+8ll5utGLeu0ObQhIrzfreZb9Y
         aeT1tLB2M7wpwgVhM71fPb70rzIm33tMr/YsKF6K+RkIkOvtOJiczDZKGrlaeRLYyWVJ
         ME4vU4WYJb88s/SbXWaFmVkQECazY3NUp0WRpEGaibb/pSJVxphkpt8EP+TsvCOiOLN6
         2XSEBVHDCi1QPgeaOVDBbkuwrMkIkBgim7rABzI3tJjsZE5h84gNTAFRc7sdOxUH3sBC
         4InaFkCIO0N+fnJ6M/pgNzgwmLZmA5/uvTRbxQ3hAT5sARgV9nSsKt7+dfD5gWVIqevc
         t82g==
X-Gm-Message-State: AOAM532F0SdHky5mEWyFCl+r1saQPGpaOmAbMdnyg49XkNXGdrf0QDMt
        nDrnjTINY8jbQl2rB7pPuGj19Vq93EOnqoZZ/aQwNw==
X-Google-Smtp-Source: ABdhPJzYuRez50xbjcGtoJOCYG+BqgeEKDAeBhnZQUeQZVhplPtXnBN66e3oDjlrIcZ1wrYimG3o0zBLI4EkvI9iheo=
X-Received: by 2002:a05:6808:1206:: with SMTP id a6mr16516174oil.94.1642406338084;
 Sun, 16 Jan 2022 23:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20220109210659.2866740-1-andrew@daynix.com> <20220109210659.2866740-5-andrew@daynix.com>
 <e92eba5b-1fd6-0b58-6fb5-2e322fdad3ef@redhat.com>
In-Reply-To: <e92eba5b-1fd6-0b58-6fb5-2e322fdad3ef@redhat.com>
From:   Andrew Melnichenko <andrew@daynix.com>
Date:   Mon, 17 Jan 2022 09:58:47 +0200
Message-ID: <CABcq3pFOL9u9rdwjyERzf06314MU9q3P0dFkQGzX2XxJv_Fe7w@mail.gmail.com>
Subject: Re: [PATCH 4/4] drivers/net/virtio_net: Added RSS hash report control.
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Yan Vugenfirer <yan@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> e.g RXH_VLAN with port hash?
> Any way to merge the two switch? The code is hard to be reviewed anyhow.
I'll refactor virtnet_set_hashflow.

> I think it's better to use VIRTIO_NET_HASH_REPORT_NONE here.
Yes, I'll fix that.

On Tue, Jan 11, 2022 at 6:33 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2022/1/10 =E4=B8=8A=E5=8D=885:06, Andrew Melnychenko =E5=86=99=
=E9=81=93:
> > Now it's possible to control supported hashflows.
> > Also added hashflow set/get callbacks.
> > Also, disabling RXH_IP_SRC/DST for TCP would disable then for UDP.
> > TCP and UDP supports only:
> > ethtool -U eth0 rx-flow-hash tcp4 sd
> >      RXH_IP_SRC + RXH_IP_DST
> > ethtool -U eth0 rx-flow-hash tcp4 sdfn
> >      RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   drivers/net/virtio_net.c | 159 ++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 159 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 6e7461b01f87..1b8dd384483c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -235,6 +235,7 @@ struct virtnet_info {
> >       u8 rss_key_size;
> >       u16 rss_indir_table_size;
> >       u32 rss_hash_types_supported;
> > +     u32 rss_hash_types_saved;
> >
> >       /* Has control virtqueue */
> >       bool has_cvq;
> > @@ -2275,6 +2276,7 @@ static void virtnet_init_default_rss(struct virtn=
et_info *vi)
> >       int i =3D 0;
> >
> >       vi->ctrl->rss.table_info.hash_types =3D vi->rss_hash_types_suppor=
ted;
> > +     vi->rss_hash_types_saved =3D vi->rss_hash_types_supported;
> >       vi->ctrl->rss.table_info.indirection_table_mask =3D vi->rss_indir=
_table_size - 1;
> >       vi->ctrl->rss.table_info.unclassified_queue =3D 0;
> >
> > @@ -2289,6 +2291,131 @@ static void virtnet_init_default_rss(struct vir=
tnet_info *vi)
> >       netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> >   }
> >
> > +static void virtnet_get_hashflow(const struct virtnet_info *vi, struct=
 ethtool_rxnfc *info)
> > +{
> > +     info->data =3D 0;
> > +     switch (info->flow_type) {
> > +     case TCP_V4_FLOW:
> > +             if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_T=
CPv4) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST |
> > +                                              RXH_L4_B_0_1 | RXH_L4_B_=
2_3;
> > +             } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH=
_TYPE_IPv4) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST;
> > +             }
> > +             break;
> > +     case TCP_V6_FLOW:
> > +             if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_T=
CPv6) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST |
> > +                                              RXH_L4_B_0_1 | RXH_L4_B_=
2_3;
> > +             } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH=
_TYPE_IPv6) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST;
> > +             }
> > +             break;
> > +     case UDP_V4_FLOW:
> > +             if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_U=
DPv4) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST |
> > +                                              RXH_L4_B_0_1 | RXH_L4_B_=
2_3;
> > +             } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH=
_TYPE_IPv4) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST;
> > +             }
> > +             break;
> > +     case UDP_V6_FLOW:
> > +             if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_U=
DPv6) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST |
> > +                                              RXH_L4_B_0_1 | RXH_L4_B_=
2_3;
> > +             } else if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH=
_TYPE_IPv6) {
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST;
> > +             }
> > +             break;
> > +     case IPV4_FLOW:
> > +             if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_I=
Pv4)
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST;
> > +
> > +             break;
> > +     case IPV6_FLOW:
> > +             if (vi->rss_hash_types_saved & VIRTIO_NET_RSS_HASH_TYPE_I=
Pv4)
> > +                     info->data =3D RXH_IP_SRC | RXH_IP_DST;
> > +
> > +             break;
> > +     default:
> > +             info->data =3D 0;
> > +             break;
> > +     }
> > +}
> > +
> > +static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethto=
ol_rxnfc *info)
> > +{
> > +     u64 is_iphash =3D info->data & (RXH_IP_SRC | RXH_IP_DST);
> > +     u64 is_porthash =3D info->data & (RXH_L4_B_0_1 | RXH_L4_B_2_3);
> > +     u32 new_hashtypes =3D vi->rss_hash_types_saved;
> > +
> > +     if ((is_iphash && (is_iphash !=3D (RXH_IP_SRC | RXH_IP_DST))) ||
> > +         (is_porthash && (is_porthash !=3D (RXH_L4_B_0_1 | RXH_L4_B_2_=
3)))) {
> > +             return false;
> > +     }
> > +
> > +     if (!is_iphash && is_porthash)
> > +             return false;
>
>
> This seems not filter out all the combinations:
>
> e.g RXH_VLAN with port hash?
>
>
> > +
> > +     switch (info->flow_type) {
> > +     case TCP_V4_FLOW:
> > +     case UDP_V4_FLOW:
> > +     case IPV4_FLOW:
> > +             new_hashtypes &=3D ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> > +             if (is_iphash)
> > +                     new_hashtypes |=3D VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> > +
> > +             break;
> > +     case TCP_V6_FLOW:
> > +     case UDP_V6_FLOW:
> > +     case IPV6_FLOW:
> > +             new_hashtypes &=3D ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > +             if (is_iphash)
> > +                     new_hashtypes |=3D VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > +
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     switch (info->flow_type) {
> > +     case TCP_V4_FLOW:
> > +             new_hashtypes &=3D ~VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
>
>
> Any way to merge the two switch? The code is hard to be reviewed anyhow.
>
>
> > +             if (is_porthash)
> > +                     new_hashtypes |=3D VIRTIO_NET_RSS_HASH_TYPE_TCPv4=
;
> > +
> > +             break;
> > +     case UDP_V4_FLOW:
> > +             new_hashtypes &=3D ~VIRTIO_NET_RSS_HASH_TYPE_UDPv4;
> > +             if (is_porthash)
> > +                     new_hashtypes |=3D VIRTIO_NET_RSS_HASH_TYPE_UDPv4=
;
> > +
> > +             break;
> > +     case TCP_V6_FLOW:
> > +             new_hashtypes &=3D ~VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
> > +             if (is_porthash)
> > +                     new_hashtypes |=3D VIRTIO_NET_RSS_HASH_TYPE_TCPv6=
;
> > +
> > +             break;
> > +     case UDP_V6_FLOW:
> > +             new_hashtypes &=3D ~VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
> > +             if (is_porthash)
> > +                     new_hashtypes |=3D VIRTIO_NET_RSS_HASH_TYPE_UDPv6=
;
> > +
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     if (new_hashtypes !=3D vi->rss_hash_types_saved) {
> > +             vi->rss_hash_types_saved =3D new_hashtypes;
> > +             vi->ctrl->rss.table_info.hash_types =3D vi->rss_hash_type=
s_saved;
> > +             if (vi->dev->features & NETIF_F_RXHASH)
> > +                     return virtnet_commit_rss_command(vi);
> > +     }
> > +
> > +     return true;
> > +}
> >
> >   static void virtnet_get_drvinfo(struct net_device *dev,
> >                               struct ethtool_drvinfo *info)
> > @@ -2574,6 +2701,27 @@ static int virtnet_get_rxnfc(struct net_device *=
dev, struct ethtool_rxnfc *info,
> >       switch (info->cmd) {
> >       case ETHTOOL_GRXRINGS:
> >               info->data =3D vi->curr_queue_pairs;
> > +             break;
> > +     case ETHTOOL_GRXFH:
> > +             virtnet_get_hashflow(vi, info);
> > +             break;
> > +     default:
> > +             rc =3D -EOPNOTSUPP;
> > +     }
> > +
> > +     return rc;
> > +}
> > +
> > +static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rx=
nfc *info)
> > +{
> > +     struct virtnet_info *vi =3D netdev_priv(dev);
> > +     int rc =3D 0;
> > +
> > +     switch (info->cmd) {
> > +     case ETHTOOL_SRXFH:
> > +             if (!virtnet_set_hashflow(vi, info))
> > +                     rc =3D -EINVAL;
> > +
> >               break;
> >       default:
> >               rc =3D -EOPNOTSUPP;
> > @@ -2602,6 +2750,7 @@ static const struct ethtool_ops virtnet_ethtool_o=
ps =3D {
> >       .get_rxfh =3D virtnet_get_rxfh,
> >       .set_rxfh =3D virtnet_set_rxfh,
> >       .get_rxnfc =3D virtnet_get_rxnfc,
> > +     .set_rxnfc =3D virtnet_set_rxnfc,
> >   };
> >
> >   static void virtnet_freeze_down(struct virtio_device *vdev)
> > @@ -2854,6 +3003,16 @@ static int virtnet_set_features(struct net_devic=
e *dev,
> >               vi->guest_offloads =3D offloads;
> >       }
> >
> > +     if ((dev->features ^ features) & NETIF_F_RXHASH) {
> > +             if (features & NETIF_F_RXHASH)
> > +                     vi->ctrl->rss.table_info.hash_types =3D vi->rss_h=
ash_types_saved;
> > +             else
> > +                     vi->ctrl->rss.table_info.hash_types =3D 0;
>
>
> I think it's better to use VIRTIO_NET_HASH_REPORT_NONE here.
>
> Thanks
>
>
> > +
> > +             if (!virtnet_commit_rss_command(vi))
> > +                     return -EINVAL;
> > +     }
> > +
> >       return 0;
> >   }
> >
>
