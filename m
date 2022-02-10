Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F04B06DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiBJHRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:17:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiBJHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B0201E5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644477473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sTTuT1wpA5V7YCk5otpnqf5l5jYPgeufibvl+UEqn2c=;
        b=ZOxG36gyBnKuGxgtSWrGn7to9do5WTBhQCXpeDzxCc5GeJaMhsUgIzp0mXhL9AL62xNG1Y
        +Au9r/0fa6suYe/u5quKYwAqNTOXoGWDi3ZWQwWLWhpushXLllodPSrH547tkO+9q8JH+C
        HBO0S4+HVMECK3vzqprArbBLhxn/4yM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-m5pMv6_XP3ODGW6WWHqC0A-1; Thu, 10 Feb 2022 02:17:51 -0500
X-MC-Unique: m5pMv6_XP3ODGW6WWHqC0A-1
Received: by mail-lj1-f198.google.com with SMTP id u18-20020a2ea172000000b002393f377a13so2176529ljl.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 23:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTTuT1wpA5V7YCk5otpnqf5l5jYPgeufibvl+UEqn2c=;
        b=DPz+d6Jpmiuqh90pMsWqPChThUixD/5vfyrO13yH0k9PlaF+4mbZ/4lwONEREJhsO5
         fzPb76fevW9NsJCqtscTzh+UA1HLUNNo8kZaG72Jsja3JFYuthKaRpTalXjWa//SuMYn
         ltHgE5OkHFePT9Bumys6DpcbRGrQGraYwlEVY2uUbWXXfflzbG7lxZ+Ua1fFnmlMD3oK
         DHmuybZcjmw0nBYHm0P4F8rMxt2UDnqUdU9TtT6pKlLwGmyOnlh3nGc7GNy7+k415tmm
         2YdtLHsYDMRUML0cHbGnl6jMWxou5WIsgKCrFbq9UF65494D9buKuOMDge1SU3n2phNN
         v6Tw==
X-Gm-Message-State: AOAM532bghEdr+es2aW657GX4P6yLY2h9xouRZ8bFLdtc1D29prmXVcj
        y0MVWTRgJHEw4IXuY9QU+fUQWbxotzsgS7PVd8I5f7BqvQAEPjH28/GT7VVCnpISIKtMnTmsb0m
        CV7/m/Sd5PWu1SE24yuL/XBq3yLibKGHo9+CrKlmh
X-Received: by 2002:a05:6512:3401:: with SMTP id i1mr4335997lfr.629.1644477469789;
        Wed, 09 Feb 2022 23:17:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUZBEMHIZcF/XRpUs2UnPvBf2bdlBn1YAVjX3H39EwXxKO5k6jiLG/IEtXn0SyNmkzAr6Jv4pBMsj4aeyw8JM=
X-Received: by 2002:a05:6512:3401:: with SMTP id i1mr4335979lfr.629.1644477469533;
 Wed, 09 Feb 2022 23:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20220121022438.1042547-1-pizhenwei@bytedance.com> <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
In-Reply-To: <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Feb 2022 15:17:38 +0800
Message-ID: <CACGkMEsxnFU5TnPGxU3TjFG6MWZhtCyu93f2qzeAq08ce6VJ_g@mail.gmail.com>
Subject: Re: PING: [PATCH 0/3] Introduce akcipher service for virtio-crypto
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     mst <mst@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helei.sig11@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 2:58 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
>
> PING!

I think it would be helpful to get ack/reviewing from crypto gurus.
Maybe Herbert?

Thanks

>
> PS: Please ignore the warning from kernel test robot, I'll fix it in
> next version.
>
> On 1/21/22 10:24 AM, zhenwei pi wrote:
> > Introduce akcipher service, implement RSA algorithm, and a minor fix.
> >
> > zhenwei pi (3):
> >    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
> >    virtio-crypto: introduce akcipher service
> >    virtio-crypto: implement RSA algorithm
> >
> >   drivers/crypto/virtio/Makefile                |   1 +
> >   .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
> >   drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
> >   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
> >   drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
> >   include/uapi/linux/virtio_crypto.h            |  98 ++-
> >   6 files changed, 693 insertions(+), 10 deletions(-)
> >   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> >
>
> --
> zhenwei pi
>

