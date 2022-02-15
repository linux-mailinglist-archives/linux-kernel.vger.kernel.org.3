Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56EA4B7361
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiBOPr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:47:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiBOPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:47:14 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173CC0539
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:46:03 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id j9so2915902vkj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BedxqyA3+r1aQxFPn5bMgkj70sSLNh7OJO9s5zLmB+g=;
        b=pS9E5M7E21dgGsY388BFHVXaAKwO4RSi+3GNyKpePpG3i3/VSPOaDNIH5KE1pGiK+E
         EcpJrr127komE34aJPyorPnQj9zlij5HTo1kogQW6DHZRo+grYjzFweW1HK4Il3zblRa
         jYkudAN3kN/oIpqt0XZl+YHkA9oi2yMEMtOwBzLr4KWrkGsH6Ae6xdVF9JF8Sac19VVa
         6sNQZFBLTSOJ4TXZXc7uGA2NxcIfOMWSeQzwUdi9l8q6BUvqrKa99joJ7b0pFsJt2Vml
         JI3g+gYxn/2caKC8oZEXlCnkjuHC/kltUBaoD9BBJ2mrqyVGTNmYZEgFTuUTm9tbzz2R
         znVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BedxqyA3+r1aQxFPn5bMgkj70sSLNh7OJO9s5zLmB+g=;
        b=HPZHZPovWhIPGRFCj7Dj5bbP7/B+NJFtT6bJSNWRdR6amjAlOaUs5zUDef7WRWvbYI
         s8zjnN96GAH/P6tnTFplA34wrq0abF1gugAeuBjPQsKoiJTWb4moZds69gj/7XgMC+Qd
         ctDQeKNErw8UoihBSzFVr1bA/04/dZEt581LIPzpvI/VavSFaXVNNL+CBesumnrnazIC
         jXYKS9aip4M/wH46K10lvkg+4uJhohOU4h/65fLpiZgN6MY1LaL4l8hkcuox3JgqpHwi
         DSPtSk3qqAXEaCiYPheczYexfORQweVCeVhQF3iYwveXqhB3Ig2dG1LqDkN9DnVXm6Wl
         Ly3Q==
X-Gm-Message-State: AOAM531NflDWKaj4kPxUDXyJ2Ui5rLVDFIBzKnu3ZgpefZVucIobtFep
        UNoppfXIkxj8i+k/zOlw3d0iSw1mvxg=
X-Google-Smtp-Source: ABdhPJz8myMWlyAxIjrSlDpCe1/y32nhwu0oUb49Td4a0nYbYmSgZMKV4x/JZ66LPYp/Qny3KMNZSg==
X-Received: by 2002:a05:6122:2319:: with SMTP id bq25mr1453055vkb.41.1644939962442;
        Tue, 15 Feb 2022 07:46:02 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id o11sm52705vsl.0.2022.02.15.07.46.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:46:01 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id v5so10036677uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:46:01 -0800 (PST)
X-Received: by 2002:ab0:384c:: with SMTP id h12mr1480520uaw.122.1644939961027;
 Tue, 15 Feb 2022 07:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20220213150234.31602-1-thomas.liu@ucloud.cn> <CA+FuTSdODATw3hSAMv9aZUmJNM8ZE-YP58pr17bO9rGJUgfegw@mail.gmail.com>
 <CFD9B65A-6762-4D9B-ADEB-B4C0B1902E02@ucloud.cn> <CA+FuTSfQOUEyEDnOU8VVZ=STw_ii-hTwyg-cvpcViPkVK4pLUA@mail.gmail.com>
 <42554FCB-9180-4B32-B5CF-6D3236237D99@ucloud.cn> <CAF=yD-+1RSj_o8n5LDOLVyn_dvVQvmDQo5pacSoDFPOR3M2g5g@mail.gmail.com>
 <CANn89i+T=Ny7pfUomSsa1ub77u8LfYtRZPzmp_0-=oWKt0abLg@mail.gmail.com>
In-Reply-To: <CANn89i+T=Ny7pfUomSsa1ub77u8LfYtRZPzmp_0-=oWKt0abLg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 15 Feb 2022 10:45:24 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc9ZeuLE7tqNT-GnqHb27SE7UAtVRVsZHR+dV6ua=UKPA@mail.gmail.com>
Message-ID: <CA+FuTSc9ZeuLE7tqNT-GnqHb27SE7UAtVRVsZHR+dV6ua=UKPA@mail.gmail.com>
Subject: Re: [PATCH] gso: do not skip outer ip header in case of ipip and net_failover
To:     Eric Dumazet <edumazet@google.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Tao Liu <thomas.liu@ucloud.cn>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Got it. That is an uncommon combination. SKB_GSO_DODGY is set from
> > external virtio_net, which does not support tunnels. But a path with
> > an added tunnel might cause this combination.
> >
> > And inet_gso_segment resets the network header, both times, before
> > calling callbacks.gso_segment()
> >
> >         skb_reset_network_header(skb);
> >         nhoff = skb_network_header(skb) - skb_mac_header(skb);
> >
> >         [...]
> >
> >         if (likely(ops && ops->callbacks.gso_segment))
> >                 segs = ops->callbacks.gso_segment(skb, features);
> >
> > And resets that after for each skb in segs.
> >
> >         skb = segs;
> >         do {
> >                 [...]
> >                 skb->network_header = (u8 *)iph - skb->head;
> >
> > But does not do this if segs == NULL.
> >
> > The packet has to be restored before it is passed to the device. I
> > think we have to handle this case correctly in inet_gso_segment,
> > instead of patching it up in all the various tunnel devices.
> >
> > The same holds for ipv6_gso_segment.
>
> Back in the days, GRO was modified so that we passed a context (nhoff)
> in called functions,
> instead of changing skb offsets. The concept of outer/inner header
> only works with 1 encap.
>
> Perhaps it is time to do the same in GSO, to allow arbitrary levels of
> encapsulation.
> Then we no longer mess with these limited
> 'network_header/inner_network_header' fields
> in the skb.
>
> Stuffing state in the skb has been a mistake I think.

If we could unwind those skb inner_* fields (and reclaim the skbuff
space!) that would be fantastic.

Immediately for this bug: perhaps it can be fixed by resetting the
network_header on the gso skb if segs == NULL. As the offset is stored
on the stack.
