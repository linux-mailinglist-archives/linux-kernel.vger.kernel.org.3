Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034A54C1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352508AbiFOGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbiFOGYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:24:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E770B27FEE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:24:06 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31336535373so51297497b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LshRSzq22wtp4qhXs+/iZas8+X4eeCgZ5sV4MhFsw2w=;
        b=luyrFMQUtVOGazWD1iq3vMXmKdEc5Z9Js2dg0RzKB7UAOL8BZ52UtgL/CXxEVKZVuw
         Lk4Uf50DB2KCN4AdmvHrHj1dL0buHpaWhvQP2ITrsXjzfMfLafIeW+ByvnE87ylrbN96
         NwgiKQIz2gnpUTJtwkHDdaMyi+OtlkO+HpgYQJA1Xb2gbQ0wx/i1jppcWMwFNPIic/BL
         gHYZPBNIQEnouIR/kcjreA0RJP6sNCa0Cj7vrEecr1j2QTQoDizmKigSbHDaJYHag7vx
         4kk8G8Q4AJJasQv7l8ujLQaoEfvqb6jDOCcGYTrSjw5pjx5idMc+9lQHaLuotaWJ/2ID
         lxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LshRSzq22wtp4qhXs+/iZas8+X4eeCgZ5sV4MhFsw2w=;
        b=IbKk8I9yWQuUUsCl+n9V5HBukUFuDPQxySPf+OFvkXy0QhXFBxWPTeJIuXoJYfBi9d
         2TUj2ZlJwahigM+tt79oRjdu/KaUSR6AKgCDO0gygx0en0lOSxxJF+Df3wB/h3PcmdCV
         ChVBwStEgGPySsbXRDA/z3vqwvBzGCt6a0EoOhlOLsTks+z/aUs/OTcaYzCt0FdJTcb5
         xJBjP5ptoPLHTX2xTLZsIs7fw1zEPW4OrHs+/3FeGl9MjSzr/LmaxL351H1bSE2Kba2u
         i2gKw8Bvfm3ZmnOSv4V2SXK2u3n2oq991klBoJ2ivMZGfnQLdGkQEGQkrM48jqj3HG1P
         Jdqw==
X-Gm-Message-State: AJIora+VxS84I5CoP0dDtMCetIR9HqvBHFJZDNRBPBbB0qtkt/eCrOXS
        4eImqcyJo8qo7Hwg8H3JoobZrp8UJ9m1JYqxoDk=
X-Google-Smtp-Source: AGRyM1tAM6ElCRQ+uq7vQIdf64vAqhTVQNLn5SJ7tZ9sRuvacanhNpyrrq71qFzPCPyW5IbmrgmbXDkARvs8jenWC3E=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr10019086ywk.209.1655274245807; Tue, 14
 Jun 2022 23:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 15 Jun 2022 11:53:54 +0530
Message-ID: <CAOh2x=kxpdisV+tqcYOoZGSKA8YjPMej+7u19Jpa1jmVcZCaxA@mail.gmail.com>
Subject: Re: [PATCH V4 0/8] virtio: Solution to restrict memory access under
 Xen using xen-grant DMA-mapping layer
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On Mon, Jun 6, 2022 at 10:16 AM Oleksandr Tyshchenko
<olekstysh@gmail.com> wrote:
> The high level idea is to create new Xen=E2=80=99s grant table based DMA-=
mapping layer for the guest Linux whose main
> purpose is to provide a special 64-bit DMA address which is formed by usi=
ng the grant reference (for a page
> to be shared with the backend) with offset and setting the highest addres=
s bit (this is for the backend to
> be able to distinguish grant ref based DMA address from normal GPA). For =
this to work we need the ability
> to allocate contiguous (consecutive) grant references for multi-page allo=
cations. And the backend then needs
> to offer VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_VERSION_1 feature bits (it=
 must support virtio-mmio modern
> transport for 64-bit addresses in the virtqueue).

I was trying your series, from Linus's tree now and started seeing
boot failures,
failed to mount rootfs. And the reason probably is these messages:

[ 1.222498] virtio_scsi virtio1: device must provide VIRTIO_F_ACCESS_PLATFO=
RM
[ 1.316334] virtio_net virtio0: device must provide VIRTIO_F_ACCESS_PLATFOR=
M

I understand from your email that the backends need to offer
VIRTIO_F_ACCESS_PLATFORM flag now, but should this requirement be a
bit soft ? I mean shouldn't we allow both types of backends to run with the=
 same
kernel, ones that offer this feature and others that don't ? The ones that =
don't
offer the feature, should continue to work like they used to, i.e.
without the restricted
memory access feature.

I am testing Xen currently with help of Qemu  over my x86 desktop and
these backends
(scsi and net) are part of QEMU itself I think, and I don't really
want to go and make the
change there.

Thanks.

--
Viresh
