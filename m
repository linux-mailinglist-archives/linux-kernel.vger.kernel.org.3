Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB12348E00D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiAMWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiAMWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:07:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CA4C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:07:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so4559930wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3tOErErxThmjD0xxBLw7b3ck6IAyCGXM1dn0Rqm8J7Y=;
        b=yx0rgwkdo3vd7lOgsPs9UiDKqHk6waAbRBsOmbZJS3yNS3sesXofyG5f+XNun78WFh
         /P1ZHMoRashsJOl3O68YqHwA2HYCY23/m3ksGTBFkkcGaiV1HLcDTMS/rOqfZOY4lvpR
         uXuxDKL0K3vVLcipeyGwM0B6QFhDj5B4HV/SRcvfQr1JsUuYjxeCXYQhwLc+URDqRY8F
         K8xIDQylz+0VhLklaLmAmH8MgsWp8YqJFGwE7TrhBkHi7hROaa+OWUDqw8m6brDsJX4M
         Q/7Liz2bUsWq9r7gSsNm00LUtGALuMAirHGzCn44C9A6emSMn1659nkhUta+NvPZpZVi
         wNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3tOErErxThmjD0xxBLw7b3ck6IAyCGXM1dn0Rqm8J7Y=;
        b=R12oTOOUfeNP+3ANUbBrUMwJZrCvUio0qqDjjyVbuOeRxgU/j5BS2OE3/IZ8U6yv9k
         eDD26GgnfGXZXC/e/MNXmhGP2N/110uhnXYpl7M/Q0KpJaWSXczqlX/lPNrdoZaIbXr7
         kpk1/T7kwWJGkgtuBSADVWVSbOOg5joGFJEptCTBu1+xpVbfGxagN50MG+jVo0G4sKcg
         aJt5agfJspvaTLZvGeatBCMnPudQdvOvTUJNu0y225/suaF+vAOtsb5Gb2HvL0hdb1JL
         oUpsdwqNAxhWDMfq2v70uQu/p6hyAlNzoAIpI7FZbKHWpNNU2eBj81rrDTnuAh3tHa5v
         e8lA==
X-Gm-Message-State: AOAM532+G4n7cYzqCiBiZZVN+T7rNL7r3882p3He4lADAqYkzAVannve
        lQ1hFTN1OEO8BNh8OAG5KNWRVHWt1UqcUm8aZDtRow==
X-Google-Smtp-Source: ABdhPJzZVWPUnsC++hqhfhHWCK1QSKdmUSdMmH/91YNlGcRneDSNc3ECfDvSUnknZPIFlzzT/OAJipmH23zkX2eSMeg=
X-Received: by 2002:a7b:c142:: with SMTP id z2mr5464787wmi.167.1642111637971;
 Thu, 13 Jan 2022 14:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20220113150846.1570738-1-rad@semihalf.ocm> <CABBYNZJn1ej18ERtgnF_wvbvBEm0N=cBRHHtr8bu+nfAotjg2Q@mail.gmail.com>
In-Reply-To: <CABBYNZJn1ej18ERtgnF_wvbvBEm0N=cBRHHtr8bu+nfAotjg2Q@mail.gmail.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date:   Thu, 13 Jan 2022 23:07:02 +0100
Message-ID: <CAOs-w0+W_BHTdZkOnu-EPme2dpoO_6bQi_2LRH7Xw0Ge=i9TOA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix skb allocation in mgmt_remote_name()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        upstream@semihalf.com, Angela Czubak <acz@semihalf.com>,
        Marek Maslanka <mm@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

czw., 13 sty 2022 o 17:17 Luiz Augusto von Dentz
<luiz.dentz@gmail.com> napisa=C5=82(a):
>
> Hi Radoslaw,
>
> On Thu, Jan 13, 2022 at 7:09 AM Radoslaw Biernacki <rad@semihalf.com> wro=
te:
> >
> > From: Radoslaw Biernacki <rad@semihalf.com>
> >
> > This patch fixes skb allocation, as lack of space for ev might push skb
> > tail beyond its end.
> > Also introduce eir_precalc_len() that can be used instead of magic
> > numbers for similar eir operations on skb.
> >
> > Fixes: cf1bce1de7eeb ("Bluetooth: mgmt: Make use of mgmt_send_event_skb=
 in MGMT_EV_DEVICE_FOUND")
> > Signed-off-by: Angela Czubak <acz@semihalf.com>
> > Signed-off-by: Marek Maslanka <mm@semihalf.com>
> > Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> > ---
> >  net/bluetooth/eir.h  |  5 +++++
> >  net/bluetooth/mgmt.c | 12 ++++--------
> >  2 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
> > index 05e2e917fc25..e5876751f07e 100644
> > --- a/net/bluetooth/eir.h
> > +++ b/net/bluetooth/eir.h
> > @@ -15,6 +15,11 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 inst=
ance, u8 *ptr);
> >  u8 eir_append_local_name(struct hci_dev *hdev, u8 *eir, u8 ad_len);
> >  u8 eir_append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_len);
> >
> > +static inline u16 eir_precalc_len(u8 data_len)
> > +{
> > +       return sizeof(u8) * 2 + data_len;
> > +}
> > +
> >  static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type,
> >                                   u8 *data, u8 data_len)
> >  {
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 37087cf7dc5a..d517fd847730 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -9680,13 +9680,11 @@ void mgmt_remote_name(struct hci_dev *hdev, bda=
ddr_t *bdaddr, u8 link_type,
> >  {
> >         struct sk_buff *skb;
> >         struct mgmt_ev_device_found *ev;
> > -       u16 eir_len;
> > -       u32 flags;
> > +       u16 eir_len =3D 0;
> > +       u32 flags =3D 0;
> >
> > -       if (name_len)
> > -               skb =3D mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND, 2 + =
name_len);
> > -       else
> > -               skb =3D mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND, 0);
> > +       skb =3D mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
> > +                            sizeof(*ev) + (name ? eir_precalc_len(name=
_len) : 0));
>
> Looks like mgmt_device_connected also has a similar problem.

Yes, I was planning to send a patch to this one though it will not be as sl=
ick.
It would be nice to have a helper which will call skb_put() and add
eir data at once.
Basically skb operation in pair to, what eir_append_data() does with
help of eir_len but without awkwardness when passing return value to
skb_put() (as it returns offset not size).
I will send V2 with two patches. I hope they will align with your
original goal of eliminating the necessity of intermediary buffers at
some point in future.

>
> >         ev =3D skb_put(skb, sizeof(*ev));
> >         bacpy(&ev->addr.bdaddr, bdaddr);
> > @@ -9696,10 +9694,8 @@ void mgmt_remote_name(struct hci_dev *hdev, bdad=
dr_t *bdaddr, u8 link_type,
> >         if (name) {
> >                 eir_len =3D eir_append_data(ev->eir, 0, EIR_NAME_COMPLE=
TE, name,
> >                                           name_len);
> > -               flags =3D 0;
> >                 skb_put(skb, eir_len);
> >         } else {
> > -               eir_len =3D 0;
> >                 flags =3D MGMT_DEV_FOUND_NAME_REQUEST_FAILED;
> >         }
>
> These changes would leave flags and eir_len uninitialized.

Both are initialized to 0 by this patch.

>
> > --
> > 2.34.1.703.g22d0c6ccf7-goog
> >
>
>
> --
> Luiz Augusto von Dentz
