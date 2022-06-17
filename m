Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048F54EED1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379564AbiFQBa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378921AbiFQBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A916B63532
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655429453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdXVpK4M15aXqV7NHwfDKuztrburhsd2qHWyDgt1bpM=;
        b=AsBkMmdljRHd8jk1uYTzcSBcZvCatBima8cunN8o+JPIlnQOp1CDuuQQ1XN/adzDxf71wK
        8RfVcEzyri0/HVHZLVSuDQGFxuPI7a8tpRXUuVc+Ll+7nwDURnGM7NXA2DJllsyIQhmem7
        bn7Lorkn+gE5yS6ZL4LdCqOWPC8ln1s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-7xqhHk-0MnOAmuf2DcB8aw-1; Thu, 16 Jun 2022 21:30:52 -0400
X-MC-Unique: 7xqhHk-0MnOAmuf2DcB8aw-1
Received: by mail-lf1-f69.google.com with SMTP id g40-20020a0565123ba800b004791450e602so1571419lfv.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdXVpK4M15aXqV7NHwfDKuztrburhsd2qHWyDgt1bpM=;
        b=2tZXLMAIkWXhmPzJxY38SksoqmCJTYRNNFkbAtaMcdG6Nl/UQoKVDEmNcrSxAIXV1u
         mE8DuT1iIBPqLTivYBWpNPpxeD5Fm45hQwwKqAgva3zyjlnEl0dYFVbOWo/mkwTAONGJ
         gkMdqVCCYy0A/4Z1VHqBu3iS27O5dHBAiXaJJKEp/V0mnyrEPDua5Eq4MjAcs2BeIHDH
         K07wARscJ47kVvrHG3kkp+Bu6nNtR6NlVZIJFDMh4EbEevZ8LcLBxlDnLZmtpC17CFYj
         AOkil8HSyolHzmNS3/Jhn3kfP8b97vHzsx9iypz8obtsNjPnJEp6BNPobAX9UAd4GQSi
         nn7g==
X-Gm-Message-State: AJIora/FRQ2v4eHuB/uDA1hqWcZ92Yb67BxynxQRzKGbm4eCIXjd0aDj
        n08xtLVe5CEZViBXn3vJm0/uqP/prT7WYQUoxq+vwPvFwLjtqQuNLFgaKysIofUaWC6jR5aKcxK
        b/l+7rtoiDtgPiTAmvLx/sCXiCyIIxwY7z3yjOW26
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id o12-20020a05651205cc00b0047a0bf7f1abmr4267448lfo.397.1655429450425;
        Thu, 16 Jun 2022 18:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4Qjm7Ni+jE/Bp49gsRtZ1ZAQGwI2kW6yJTksXUAOA6+4gstzTdAjJrDnXXTTXD+choWDoMfhNR+jr8WymojY=
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr4267441lfo.397.1655429450215; Thu, 16
 Jun 2022 18:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112347.18717-1-andrew@daynix.com> <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
 <CABcq3pFJcsoj+dDf6tirT_hfTB6rj9+f6KNFafwg+usqYwTdDA@mail.gmail.com>
 <CACGkMEtaigzuwy25rE-7N40TQGvXVmJVQivavmuwrCuw0Z=LUQ@mail.gmail.com>
 <CABcq3pFzzSHA3pqbKFEsLaFg7FkFZkdxs+N_ET_n_XLBaWVnHA@mail.gmail.com> <CABcq3pHkqxunsaZ8qt=FicL1361D0EktxZhqib+MGDJ=DVB6FA@mail.gmail.com>
In-Reply-To: <CABcq3pHkqxunsaZ8qt=FicL1361D0EktxZhqib+MGDJ=DVB6FA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Jun 2022 09:30:39 +0800
Message-ID: <CACGkMEscbjvSD3prC9WMSPD=vembZ2ZtKiAcekqAeDnWgXND3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] TUN/VirtioNet USO features support.
To:     Andrew Melnichenko <andrew@daynix.com>
Cc:     davem <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, mst <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Yan Vugenfirer <yan@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 7:59 PM Andrew Melnichenko <andrew@daynix.com> wrote:
>
> Hi, Jason
> Apparently, your patch should work.
> For now, I have an issue where segmentation between two guests on one
> host still occurs.
> Neither previous "hack" nor your patch helps.
> Now I'm looking what the issue may be.
> If you have some suggestions on where may I look, it would be helpful, thanks!

I think maybe it's worth tracking which function did the segmentation.

Thanks

>
> On Thu, May 26, 2022 at 3:18 PM Andrew Melnichenko <andrew@daynix.com> wrote:
> >
> > I'll check it, thank you!
> >
> > On Thu, May 26, 2022 at 9:56 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Tue, May 24, 2022 at 7:07 PM Andrew Melnichenko <andrew@daynix.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > The issue is that host segments packets between guests on the same host.
> > > > Tests show that it happens because SKB_GSO_DODGY skb offload in
> > > > virtio_net_hdr_from_skb().
> > > > To do segmentation you need to remove SKB_GSO_DODGY or add SKB_GSO_PARTIAL
> > > > The solution with DODGY/PARTIAL offload looks like a dirty hack, so
> > > > for now, I've lived it as it is for further investigation.
> > >
> > > Ok, I managed to find the previous discussion. It looks to me the
> > > reason is that __udp_gso_segment will segment dodgy packets
> > > unconditionally.
> > >
> > > I wonder if the attached patch works? (compile test only).
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > On Tue, May 17, 2022 at 9:32 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Thu, May 12, 2022 at 7:33 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> > > > > >
> > > > > > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > > > > > Technically they enable NETIF_F_GSO_UDP_L4
> > > > > > (and only if USO4 & USO6 are set simultaneously).
> > > > > > It allows to transmission of large UDP packets.
> > > > > >
> > > > > > Different features USO4 and USO6 are required for qemu where Windows guests can
> > > > > > enable disable USO receives for IPv4 and IPv6 separately.
> > > > > > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > > > > > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > > > > > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> > > > > >
> > > > > > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> > > > > >
> > > > > > New types for VirtioNet already on mailing:
> > > > > > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> > > > > >
> > > > > > Also, there is a known issue with transmitting packages between two guests.
> > > > >
> > > > > Could you explain this more? It looks like a bug. (Or any pointer to
> > > > > the discussion)
> > > > >
> > > > > Thanks
> > > > >
> > > > > > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> > > > > >
> > > > > > Andrew (5):
> > > > > >   uapi/linux/if_tun.h: Added new offload types for USO4/6.
> > > > > >   driver/net/tun: Added features for USO.
> > > > > >   uapi/linux/virtio_net.h: Added USO types.
> > > > > >   linux/virtio_net.h: Support USO offload in vnet header.
> > > > > >   drivers/net/virtio_net.c: Added USO support.
> > > > > >
> > > > > >  drivers/net/tap.c               | 10 ++++++++--
> > > > > >  drivers/net/tun.c               |  8 +++++++-
> > > > > >  drivers/net/virtio_net.c        | 19 +++++++++++++++----
> > > > > >  include/linux/virtio_net.h      |  9 +++++++++
> > > > > >  include/uapi/linux/if_tun.h     |  2 ++
> > > > > >  include/uapi/linux/virtio_net.h |  4 ++++
> > > > > >  6 files changed, 45 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.35.1
> > > > > >
> > > > >
> > > >
>

