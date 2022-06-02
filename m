Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41153B176
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiFBCDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiFBCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC0C2630B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654135382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbogCu4cCieqVdCMmZW/jFyVB+BvEMhJqOq5Ni57RGQ=;
        b=Z1zMlQAh6buEfpcSZmwBQ6zPuQah7G7gwYXdsXKUhYvMZIXgRiAc8g3CX9pDifA/a2KCPO
        81gsBz1hM2g5UYtjVFMJKzZ+kSXWz/052nAWvBdAYGsVb0el9Bw1ZLTOYT5TkhPRkvGdzn
        vqW29a+KV8yQIuWZO4DdkMHGK5UHTA8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-FEHVmdy3POmh5LVODOkXeQ-1; Wed, 01 Jun 2022 22:03:01 -0400
X-MC-Unique: FEHVmdy3POmh5LVODOkXeQ-1
Received: by mail-lf1-f69.google.com with SMTP id bf30-20020a056512259e00b00478a8b7ab63so1770059lfb.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JbogCu4cCieqVdCMmZW/jFyVB+BvEMhJqOq5Ni57RGQ=;
        b=deHUBp4LIvz0v+J/PfmPK8H3rnLLlYSHJsF/TXTRT6IkZsn1s/oRFxHtifgeVR4xAZ
         PGcOlFtLMr+pxaBXV8ljeLSGX43916uarExehW/qgv6IjwxVP+axox7vTcNl5QbwDPN2
         cbjCTnxMbYN8qQC1z4QgY9aJ1XrqS5ktaoyI2jkrhQwkNEW1Pu3I6P2rwoKLBjo6/fj8
         LAYHsxDbAPdGPO73lRPfNbMI2PnFi1OmDr5/w3547y0L1IVxKKDfJhk8OrF99nK9KWSt
         dUBxA0x5FWucvD54IObCleLd2hr/P22jAGUnJHzVFhlZTUQ73DsJs3QkQoj2U/Pdq+7h
         W8QQ==
X-Gm-Message-State: AOAM532Vb6c+y21xYxNmn+bjkI6hNud2GD25ct6Je13LWW5oAJq2vDqO
        wtaXLRH/IAD/oWWLeGOhi3MyLvncpOOKgo9H+X2agRDvDLBSIQEIJRbOpOEtWzsCPyzYcRvi5I5
        Y4/jKZjcRtu7mBPqUY5OZpSTpXKpAS7bZUGuA9/dT
X-Received: by 2002:a05:6512:c0e:b0:478:5a91:20bb with SMTP id z14-20020a0565120c0e00b004785a9120bbmr42956282lfu.587.1654135380300;
        Wed, 01 Jun 2022 19:03:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqAQK+T/zKYKhW+h+wH5I2vGaLZi733+pOzkjBsFuyIWvHTvv6WoCBRWN4kHLMhSOqGrYwJ6/gQ9v1y+/MmWU=
X-Received: by 2002:a05:6512:c0e:b0:478:5a91:20bb with SMTP id
 z14-20020a0565120c0e00b004785a9120bbmr42956248lfu.587.1654135380074; Wed, 01
 Jun 2022 19:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com> <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org> <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJaqyWe7YFM0anKLJvvRja-EJW5bwmb1gMGXnC62LVMKrSn3sw@mail.gmail.com> <PH0PR12MB5481DFD45D7B27A4E4783B8BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481DFD45D7B27A4E4783B8BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 2 Jun 2022 10:02:48 +0800
Message-ID: <CACGkMEs=wePpvKhmBPJnPX-sDwYkdHtV0i4GjmtQAwkvO9weaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To:     Parav Pandit <parav@nvidia.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "martinh@xilinx.com" <martinh@xilinx.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "martinpo@xilinx.com" <martinpo@xilinx.com>,
        "lvivier@redhat.com" <lvivier@redhat.com>,
        "pabloc@xilinx.com" <pabloc@xilinx.com>,
        Eli Cohen <elic@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhang Min <zhang.min9@zte.com.cn>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
        "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "dinang@xilinx.com" <dinang@xilinx.com>,
        Longpeng <longpeng2@huawei.com>
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

On Thu, Jun 2, 2022 at 3:30 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Eugenio Perez Martin <eperezma@redhat.com>
> > Sent: Wednesday, June 1, 2022 5:50 AM
> >
> > On Tue, May 31, 2022 at 10:19 PM Parav Pandit <parav@nvidia.com> wrote:
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Sunday, May 29, 2022 11:39 PM
> > > >
> > > > On Fri, May 27, 2022 at 6:56 PM Michael S. Tsirkin <mst@redhat.com>
> > wrote:
> > > > >
> > > > > On Thu, May 26, 2022 at 12:54:32PM +0000, Parav Pandit wrote:
> > > > > >
> > > > > >
> > > > > > > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > Sent: Thursday, May 26, 2022 8:44 AM
> > > > > >
> > > > > > > Implement stop operation for vdpa_sim devices, so vhost-vdpa
> > > > > > > will offer
> > > > > > >
> > > > > > > that backend feature and userspace can effectively stop the d=
evice.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > This is a must before get virtqueue indexes (base) for live
> > > > > > > migration,
> > > > > > >
> > > > > > > since the device could modify them after userland gets them.
> > > > > > > There are
> > > > > > >
> > > > > > > individual ways to perform that action for some devices
> > > > > > >
> > > > > > > (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...)
> > but
> > > > there
> > > > > > > was no
> > > > > > >
> > > > > > > way to perform it for any vhost device (and, in particular, v=
host-
> > vdpa).
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > After the return of ioctl with stop !=3D 0, the device MUST
> > > > > > > finish any
> > > > > > >
> > > > > > > pending operations like in flight requests. It must also
> > > > > > > preserve all
> > > > > > >
> > > > > > > the necessary state (the virtqueue vring base plus the
> > > > > > > possible device
> > > > > > >
> > > > > > > specific states) that is required for restoring in the future=
.
> > > > > > > The
> > > > > > >
> > > > > > > device must not change its configuration after that point.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > After the return of ioctl with stop =3D=3D 0, the device can
> > > > > > > continue
> > > > > > >
> > > > > > > processing buffers as long as typical conditions are met (vq
> > > > > > > is enabled,
> > > > > > >
> > > > > > > DRIVER_OK status bit is enabled, etc).
> > > > > >
> > > > > > Just to be clear, we are adding vdpa level new ioctl() that
> > > > > > doesn=E2=80=99t map to
> > > > any mechanism in the virtio spec.
> > > > > >
> > > > > > Why can't we use this ioctl() to indicate driver to start/stop
> > > > > > the device
> > > > instead of driving it through the driver_ok?
> > > > > > This is in the context of other discussion we had in the LM ser=
ies.
> > > > >
> > > > > If there's something in the spec that does this then let's use th=
at.
> > > >
> > > > Actually, we try to propose a independent feature here:
> > > >
> > > > https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.ht=
m
> > > > l
> > > >
> > > This will stop the device for all the operations.
> > > Once the device is stopped, its state cannot be queried further as de=
vice
> > won't respond.
> > > It has limited use case.
> > > What we need is to stop non admin queue related portion of the device=
.
> > >
> >
> > Still don't follow this, sorry.
> Once a device it stopped its state etc cannot be queried.

This is not what is proposed here.

> if you want to stop and still allow certain operations, a better spec def=
inition is needed that says,
>
> stop A, B, C, but allow D, E, F, G.
> A =3D stop CVQs and save its state somewhere
> B =3D stop data VQs and save it state somewhere
> C =3D stop generic config interrupt

Actually, it's the stop of the config space change.
And what more, any guest visible state must not be changed.

>
> D =3D query state of multiple VQs
> E =3D query device statistics and other elements/objects in future

This is the device state I believe.

> F =3D setup/config/restore certain fields

This is the reverse of D and E, that is setting the state.

> G =3D resume the device
>

Thanks

> >
> > Adding the admin vq to the mix, this would stop a device of a device gr=
oup,
> > but not the whole virtqueue group. If the admin VQ is offered by the PF
> > (since it's not exposed to the guest), it will continue accepting reque=
sts as
> > normal. If it's exposed in the VF, I think the best bet is to shadow it=
, since
> > guest and host requests could conflict.
> >
> > Since this is offered through vdpa, the device backend driver can route=
 it to
> > whatever method works better for the hardware. For example, to send an
> > admin vq command to the PF. That's why it's important to keep the featu=
re
> > as self-contained and orthogonal to others as possible.
> >
>
> I replied in other thread to continue there.

