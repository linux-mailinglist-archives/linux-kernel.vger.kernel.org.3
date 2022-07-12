Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A728571502
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiGLIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLIrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5BE6A5E7D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657615649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFx5AQzR7h3bQjJMbiVLhXeoM+srJi8z6QukiQafwV0=;
        b=DC4znlOf5YD53a1a3nNUohpa7uXEuPubcSTUur5rNkXo867YPcLHeFG0zwFZbinrtrl87O
        5C/jLkW9rwyPZDBB8x4SEbwVKj6avE5YMc6AF0z4k3Fs4pSEZN8Wvoxpsy/c0jOpBziUFI
        g85vKNncPREKlz6Tdays6ltQ0XixhXA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-m71jASGiPQq7z-V6WAdqeA-1; Tue, 12 Jul 2022 04:47:22 -0400
X-MC-Unique: m71jASGiPQq7z-V6WAdqeA-1
Received: by mail-lj1-f200.google.com with SMTP id a9-20020a2eb169000000b0025d6ddb274bso852536ljm.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BFx5AQzR7h3bQjJMbiVLhXeoM+srJi8z6QukiQafwV0=;
        b=JeI3z2tOIRwffcH0TkqAP12BXuOaTtdEgzT8sKaoEmtRzYLs+CzhJQdi0qg+8TYegD
         5iu/S+mdacq+DeuJXbqX+E7w/JvAzKLEMnBySxiu37rZtCmvA30hXc6LW8/gSzhb7GoJ
         cW/jsifO9bOQLvprWS8uDXPM/QDo7LSO0wUwWDDV4A5GIfiTVKxRYWIAckMkOjeAY5aD
         DuPYzhF02WiILcswpsZlHjLbdtBsjm6f5GUDKDcI1UptgeR46QG1kcbffuA7c9ZzCbjw
         CwzyzltY14WL0ugAGPjdRLEtstBjl26gXkPDG4+v1IekjdH8aumMDHBPhsa7MeUMChu0
         gZ2Q==
X-Gm-Message-State: AJIora+F7o1vfqWoEk3ccOl/kyU96i4QaKORKtZR5aHt8FGr7a3Qiybs
        v59ZVvIPjbS71mUS8khRt97DqnUP3QqUlURwJiB5a1qHw9RKmZVanBSYEMYyymYSLkhs1/0ur9+
        sEAA1LaVf2w3HiYotj773JByORmwM+F9cEPoHmb7f
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id p26-20020a056512313a00b00489caea7e27mr11455303lfd.397.1657615641368;
        Tue, 12 Jul 2022 01:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXhpc5o+rvK1UHCWXYwhf4wkAETF55+sjTRPwgsh/1P4a0/YwnVXRM672RK8JSJyU587qlqVrOXuzz/xxN48g=
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr11455296lfd.397.1657615641163; Tue, 12
 Jul 2022 01:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220704171701.127665-1-sgarzare@redhat.com> <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
 <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
In-Reply-To: <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Jul 2022 16:47:10 +0800
Message-ID: <CACGkMEtHg_EVYcS=Qxsmwq3t+96E8LNqa5Ck1Gi4hJs2AJ0F+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:46 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
>
> On Tue, Jul 12, 2022 at 04:34:11PM +0800, Jason Wang wrote:
> >
> >=E5=9C=A8 2022/7/5 01:16, Stefano Garzarella =E5=86=99=E9=81=93:
> >>The first 3 patches fix various problems I have encountered with
> >>virtio_test (they may go without this series, but I included to allow y=
ou
> >>to test the series).
> >>
> >>Patch 4 is in preparation of patch 5, moving the feature negotiation wh=
en
> >>we initialize the device.
> >>
> >>Patch 5 add the support of vhost-vdpa in virtio_test
> >>
> >>Patch 6 add vdpa_test.ko based on vdpa_sim_test.c, so we can reuse most=
 of
> >>the code coming from the vdpa_sim framework.
> >>
> >>I tested in this way:
> >>
> >>   $ modprobe vdpa_sim
> >>   $ modprobe vhost-vdpa
> >>
> >>   # load the vdpasim_test device
> >>   $ insmod vdpa_test.ko
> >>
> >>   # create a new vdpasim_test device
> >>   $ vdpa dev add mgmtdev vdpasim_test name dev0
> >
> >
> >I wonder what's the benefit of using a dedicated test device other
> >than networking? (already a loopback device anyhow).
> >
>
> The main advantage I was thinking is that we can extend it at will to
> try to cover as much as possible all the paths that maybe with net we
> can't (indirect, reset, etc.).
>
> Plus it should be easier to test vhost-vdpa this way without using QEMU.
>
> Do you think this is redundant?

It's probably fine and it might be better to describe the reason in
the changelog.

THanks

>
> Thanks,
> Stefano
>

