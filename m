Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0956B313
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiGHHDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiGHHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:03:45 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE071BE1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:03:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c8a1e9e33so138168577b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r1OKhE7nPaz8Ibdpa/NFUSBILiriMdou2alvBZWJn8=;
        b=FOoq+XCQcOUOGAxMBkVFot96nKbM5UJXZ+fyNso8kcf6ozqH1iJAZiHaqOga9g8T1c
         TaBVqFq0/woyIq7nWqdt7XH5iJz5rTpeViLFHZEsKgmGfftRwRB8L5ayV3TUwnkdeCE/
         OEzY+0uLlw5yZO9fpce5tRpmkF5CrMwqnsoBoFozT+ntQN8p3BFOzOYxxUKlSLFsD0sZ
         ubXSZG5ZYnDVMdKGb59mipPNtdfPXBTxO+lC6QcyNJoE8/MY2pc+Y+z1089y1NCruX1A
         9CzSED9O1V4TFBUz6iz9HzWsfRARS8fQLWn+b+Fb6bzvFAfIWcnwqj7CmXORZ/654MoU
         L4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r1OKhE7nPaz8Ibdpa/NFUSBILiriMdou2alvBZWJn8=;
        b=PED78g2dTO3FpopI0Fyw4I7ze7YFWiIf9TQvcWQQCchL3e8LfL6OuJH9m/gAWoPgYk
         d5cEKlTEUFA6YZH+8IckZ0iEQ4LOuInJfZHGxLzTmvBFmHRmoptRXU1uHYXIzMI4gPQa
         16/9cnxUqXzIhHalizTP9Z1ftRwmeMK5gpMbbgwWSVfT3h12bDNKG88ExTbGuSaqyP7C
         gc1psjtO8TNeXNq+OVS97B9c84HtqcZSkb17aF74+ynE8SKe1LW1e6LxD9zh6Ad5akLg
         9R/Wxj2ujjeaWCa3E6ZSj4YSiM7ncWmbVzGaAlujNXBqElI7ilPh5nbK5HNoGIPD57uj
         RNJg==
X-Gm-Message-State: AJIora+vji86Go6POyUgIj8v42QNu8T9nvQVfSCR9j08KK4KZ+l+qT1S
        gJoZXXremHd8sIECryNlZT0IzcYeiKO5tdA8BOrLow==
X-Google-Smtp-Source: AGRyM1s1zxKeJaH04JGKD2OfBZEMYPMyBL6RTZC7T4tvDBmbfjGBd5ReKp27rZGd+/NDGyM+a5OOMP3Cs4OyxKUVovQ=
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr2350367ywe.47.1657263823522; Fri, 08 Jul
 2022 00:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220708063257.1192311-1-yajun.deng@linux.dev>
In-Reply-To: <20220708063257.1192311-1-yajun.deng@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Jul 2022 09:03:31 +0200
Message-ID: <CANn89iKuTLb15AMxXY8Q7FHF__f7kfRuDQFSkK1SwUR5m4fn+A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: rtnetlink: add rx_otherhost_dropped for
 struct rtnl_link_stats
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Ji <jeffreyji@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 8:33 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> The commit 794c24e9921f ("net-core: rx_otherhost_dropped to core_stats")
> introduce rx_otherhost_dropped, add rx_otherhost_dropped for struct
> rtnl_link_stats to keep sync with struct rtnl_link_stats64.
>
> As the same time, add BUILD_BUG_ON() in copy_rtnl_link_stats().
>

Any reason you chose to not cc the original patch author ?

If I remember well, not adding fields into legacy 'struct
rtnl_link_stats' was a conscious decision.

There is no requirement to keep rtnl_link_stats & rtnl_link_stats64 in sync.
rtnl_link_stats is deprecated, user space really wants to use
rtnl_link_stats64 instead,
if they need access to new fields added in recent kernels.

Thank you.

[1]
commit 9256645af09807bc52fa8b2e66ecd28ab25318c4
Author: Jarod Wilson <jarod@redhat.com>
Date:   Mon Feb 1 18:51:04 2016 -0500

    net/core: relax BUILD_BUG_ON in netdev_stats_to_stats64

    The netdev_stats_to_stats64 function copies the deprecated
    net_device_stats format stats into rtnl_link_stats64 for legacy support
    purposes, but with the BUILD_BUG_ON as it was, it wasn't possible to
    extend rtnl_link_stats64 without also extending net_device_stats. Relax
    the BUILD_BUG_ON to only require that rtnl_link_stats64 is larger, and
    zero out all the stat counters that aren't present in net_device_stats.

    CC: Eric Dumazet <edumazet@google.com>
    CC: netdev@vger.kernel.org
    Signed-off-by: Jarod Wilson <jarod@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  include/uapi/linux/if_link.h |  1 +
>  net/core/rtnetlink.c         | 36 +++++++-----------------------------
>  2 files changed, 8 insertions(+), 29 deletions(-)
>
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index e36d9d2c65a7..fd6776d665c8 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -37,6 +37,7 @@ struct rtnl_link_stats {
>         __u32   tx_compressed;
>
>         __u32   rx_nohandler;
> +       __u32   rx_otherhost_dropped;
>  };
>
>  /**
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ac45328607f7..818649850b2c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -908,35 +908,13 @@ static unsigned int rtnl_dev_combine_flags(const struct net_device *dev,
>  static void copy_rtnl_link_stats(struct rtnl_link_stats *a,
>                                  const struct rtnl_link_stats64 *b)
>  {
> -       a->rx_packets = b->rx_packets;
> -       a->tx_packets = b->tx_packets;
> -       a->rx_bytes = b->rx_bytes;
> -       a->tx_bytes = b->tx_bytes;
> -       a->rx_errors = b->rx_errors;
> -       a->tx_errors = b->tx_errors;
> -       a->rx_dropped = b->rx_dropped;
> -       a->tx_dropped = b->tx_dropped;
> -
> -       a->multicast = b->multicast;
> -       a->collisions = b->collisions;
> -
> -       a->rx_length_errors = b->rx_length_errors;
> -       a->rx_over_errors = b->rx_over_errors;
> -       a->rx_crc_errors = b->rx_crc_errors;
> -       a->rx_frame_errors = b->rx_frame_errors;
> -       a->rx_fifo_errors = b->rx_fifo_errors;
> -       a->rx_missed_errors = b->rx_missed_errors;
> -
> -       a->tx_aborted_errors = b->tx_aborted_errors;
> -       a->tx_carrier_errors = b->tx_carrier_errors;
> -       a->tx_fifo_errors = b->tx_fifo_errors;
> -       a->tx_heartbeat_errors = b->tx_heartbeat_errors;
> -       a->tx_window_errors = b->tx_window_errors;
> -
> -       a->rx_compressed = b->rx_compressed;
> -       a->tx_compressed = b->tx_compressed;
> -
> -       a->rx_nohandler = b->rx_nohandler;
> +       size_t i, n = sizeof(*b) / sizeof(u64);
> +       const u64 *src = (const u64 *)b;
> +       u32 *dst = (u32 *)a;
> +
> +       BUILD_BUG_ON(n != sizeof(*a) / sizeof(u32));
> +       for (i = 0; i < n; i++)
> +               dst[i] = src[i];
>  }
>
>  /* All VF info */
> --
> 2.25.1
>
