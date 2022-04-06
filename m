Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9584F6D97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiDFV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiDFV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:59:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B325100E3A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:57:41 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id f3so3460855qvz.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rU3HELUX1XIytnmJX3ImprHYMsSbQFe5QXWr9mWpDno=;
        b=gqSaIZ6PbdRaDdsgcUaKEm4bAh0znrnMb0xSRY8tLLEoZys8+3TpztKS9SLxOEwEwf
         rxuQJbK6+WYzU486JcgzpTMVJlG0tJR4rKgb8wm70JlQfHu+50wpC4DixvUqlZdXp9M1
         SOiFBIaHLXHYJL6GBIZVbMAU4bu533ieqLFeL0GrGE4aOyWOhLHDJ7sgVqN4GQLes6Go
         DQxgHpJrQrLDIP+ijEZwnFJ68EPz59uz0l8LZwb4aJKZsa3jEF0+MWR82r+V2zSRBxIH
         zMPvNAEM0IVAlsd66H8KYQMpsVnUg7MkqKsEeEv965c7kTobzs4FcefoV8NCaGS4Zh25
         x4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rU3HELUX1XIytnmJX3ImprHYMsSbQFe5QXWr9mWpDno=;
        b=1Ul+UwZpfr4Gs4k8bBd7XsN/7TdDtAXPMowtWYjfyewh00dIzRJi1tmE7PgUdTpfdr
         7jnDH//K0weTCsSazsWsS8E9zjapbAIL3CGhBzC3OQ7787HxhV06xbieMdnV16azh3LT
         /NGC+IsD4c3xUUuXxaPkCzygiUjNSSZjBWfUcTkeQYzbnTrJsOdXmH+D0/QVEh54UGr9
         ETZKSt1MQMIupZXd4KG/UiZqtQsy633hU6oK6dCOYg+eEyaW0FgNE9IJRyIAZyrTcj4H
         SgqCYJ3MI0yoANVKSLFkxIPW3l7R8XFn1w9qcLPK5by1lU/gAtkQB4uAjPIQPAhNL1bz
         XjWw==
X-Gm-Message-State: AOAM533kaaOK4lilzxz7u1oRv0ko87DL8VZzrKmZ5eEQX+IlhFnLkRV4
        XkOxMa7aajcHnlRQ3DhmCDc32ixdXOE=
X-Google-Smtp-Source: ABdhPJzCfi9Fz1zWZQibYtxfu1ku0Wh3ORE0jCoxXScCLMl8RsJGsSfZk5sviGg+voLL/FRREwli9g==
X-Received: by 2002:a05:6214:1d28:b0:443:e2e3:6221 with SMTP id f8-20020a0562141d2800b00443e2e36221mr9050012qvd.6.1649282260493;
        Wed, 06 Apr 2022 14:57:40 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id u17-20020ac858d1000000b002e1cdbb50besm14195906qta.78.2022.04.06.14.57.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 14:57:40 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e5e9025c20so41988837b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:57:39 -0700 (PDT)
X-Received: by 2002:a81:b04a:0:b0:2eb:6919:f27 with SMTP id
 x10-20020a81b04a000000b002eb69190f27mr9061866ywk.54.1649282259237; Wed, 06
 Apr 2022 14:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220406192956.3291614-1-vladimir.oltean@nxp.com>
 <20220406192956.3291614-2-vladimir.oltean@nxp.com> <CA+FuTSdK4T7DBf9wi3GjXA6P9o+6X-7c5vh9V0BN40GwbKSeGw@mail.gmail.com>
 <20220406194711.3apwre6dbzbtw3ou@skbuf>
In-Reply-To: <20220406194711.3apwre6dbzbtw3ou@skbuf>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 6 Apr 2022 17:57:03 -0400
X-Gmail-Original-Message-ID: <CA+FuTScA5=kkgZ2MfbzFpxKtkVdkZe_9Vmz1innHf+co7hJTAQ@mail.gmail.com>
Message-ID: <CA+FuTScA5=kkgZ2MfbzFpxKtkVdkZe_9Vmz1innHf+co7hJTAQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 1/2] ipv6: add missing tx timestamping on IPPROTO_RAW
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 5:15 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> On Wed, Apr 06, 2022 at 03:45:14PM -0400, Willem de Bruijn wrote:
> > On Wed, Apr 6, 2022 at 3:30 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > >
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > [ Upstream commit fbfb2321e950918b430e7225546296b2dcadf725 ]
> > >
> > > Raw sockets support tx timestamping, but one case is missing.
> > >
> > > IPPROTO_RAW takes a separate packet construction path. raw_send_hdrinc
> > > has an explicit call to sock_tx_timestamp, but rawv6_send_hdrinc does
> > > not. Add it.
> > >
> > > Fixes: 11878b40ed5c ("net-timestamp: SOCK_RAW and PING timestamping")
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > For 4.14.y cherry-pick:
> >
> > Acked-by: Willem de Bruijn <willemb@google.com>
>
> Thanks.
>
> > Might be good to point out that this is not only a clean cherry-pick
> > of the one-line patch, but has to include part of commit a818f75e311c
> > ("net: ipv6: Hook into time based transmission") to plumb the
> > sockcm_cookie. The rest of that patch is not a candidate for stable,
> > so LGTM.
>
> Point out how?

In this case I did, so we're good. In general, perhaps it's fine to
add such comments below the original Signed-off-by/Acked-by/.. block?
Not sure what the common approach is, if any.
