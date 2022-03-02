Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8184CAFED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbiCBUdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244151AbiCBUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 188AECFBAD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646253123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5wugH19XjB/MiHjxcE61Vh3TFZ4V2EHNp8wpx5bEs0=;
        b=bEolR46kn5oGpE/Ybo35Azgtc1njvRxaZ6kZqWK2NFspCfbIaAHnmurToOMkDvTVuN/yrZ
        tHBR0C/HABqjnIe57G3GyyBrqop2dROKN5dyuRHA/ghCAP5Tgl5wsHST2byOeEcATIdNod
        jdMBUVPid+hYA3+1mTv29Bc5QD3kCa8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-Vhax2cf5PROZJJo1XCbDGg-1; Wed, 02 Mar 2022 15:32:02 -0500
X-MC-Unique: Vhax2cf5PROZJJo1XCbDGg-1
Received: by mail-io1-f70.google.com with SMTP id i2-20020a6bb802000000b006453e7b0898so2039373iof.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=A5wugH19XjB/MiHjxcE61Vh3TFZ4V2EHNp8wpx5bEs0=;
        b=DhSSlewiYOYk7e32D2VUZmXNSy1TUi+rtdG+Lo2qSdhYfvg0UlxVwmN1NLJpIeBJ+k
         kwNMBBHIujt/0H3QBtgRPQ9tdi374fIh9owz9gh5BJhjzGm3Uc9vcJ/znkZtTS514r8u
         ODri6evXbZiZMGw8bMbqfZtnZTogohXIkFNvgXgMwNyJI7q80XplS3gjK7uN66Rag/97
         aWLXRr4oErnMqpmcJY3/r0XGAOjd7lJ0BWnSVhjPrH7tCxtKvSaaC0Mq62qrO94Q+Vp1
         TXb2UH0MEBOEiojZaY0K+l9GeTNDE/ZH9PtI3vDlmxnP8MEDRipxoYUiXFIB4hb+Lo3e
         ehSQ==
X-Gm-Message-State: AOAM5338Ahp2CaJFntJakbh4fLmOM6XiFrqPdMd1CkXHoFsvkoyt5mAc
        Rrrn7L3cfODzwKrdAG46bunNq+s3Zz8wv39+7IOkzDmhe4YNLbRj8e5vubFunhOkfPMpotlfUeS
        StpNQAyPYj4QnlvepX1rqzVVO
X-Received: by 2002:a05:6602:3401:b0:641:617f:f459 with SMTP id n1-20020a056602340100b00641617ff459mr24076431ioz.4.1646253120958;
        Wed, 02 Mar 2022 12:32:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjUc0n4B+xHk2iHP2ukBQI1xB+4yS7CH2r2wbQJy+lkKm0OKwjVobmsRg/cGsAOqwaL/NnWg==
X-Received: by 2002:a05:6602:3401:b0:641:617f:f459 with SMTP id n1-20020a056602340100b00641617ff459mr24076390ioz.4.1646253120481;
        Wed, 02 Mar 2022 12:32:00 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b24-20020a5d8d98000000b006409ad493fbsm62212ioj.21.2022.03.02.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:32:00 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:31:59 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <jgg@nvidia.com>, <cohuck@redhat.com>, <mgurtovoy@nvidia.com>,
        <yishaih@nvidia.com>, <linuxarm@huawei.com>,
        <liulongfang@huawei.com>, <prime.zeng@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v7 07/10] vfio: Extend the device migration protocol
 with PRE_COPY
Message-ID: <20220302133159.3c803f56.alex.williamson@redhat.com>
In-Reply-To: <20220302172903.1995-8-shameerali.kolothum.thodi@huawei.com>
References: <20220302172903.1995-1-shameerali.kolothum.thodi@huawei.com>
        <20220302172903.1995-8-shameerali.kolothum.thodi@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 17:29:00 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> The optional PRE_COPY states open the saving data transfer FD before
> reaching STOP_COPY and allows the device to dirty track internal state
> changes with the general idea to reduce the volume of data transferred
> in the STOP_COPY stage.
>=20
> While in PRE_COPY the device remains RUNNING, but the saving FD is open.
>=20
> Only if the device also supports RUNNING_P2P can it support PRE_COPY_P2P,
> which halts P2P transfers while continuing the saving FD.
>=20
> PRE_COPY, with P2P support, requires the driver to implement 7 new arcs
> and exists as an optional FSM branch between RUNNING and STOP_COPY:
> =C2=A0 =C2=A0 RUNNING -> PRE_COPY -> PRE_COPY_P2P -> STOP_COPY
>=20
> A new ioctl VFIO_MIG_GET_PRECOPY_INFO is provided to allow userspace to
> query the progress of the precopy operation in the driver with the idea it
> will judge to move to STOP_COPY at least once the initial data set is
> transferred, and possibly after the dirty size has shrunk appropriately.
>=20
> This ioctl is valid only in VFIO_DEVICE_STATE_PRE_COPY state and kernel
> driver should return -EINVAL from any other migration state.

Nit, PRE_COPY and PRE_COPY_P2P
=20
> Compared to the v1 clarification, STOP_COPY -> PRE_COPY is made optional
> and to be defined in future.

It's not really optional, it's explicitly unsupported in this extension.

> While making the whole PRE_COPY feature
> optional eliminates the concern from mlx5, this is still a complicated arc
> to implement and seems prudent to leave it closed until a proper use case
> is developed.

This seems like a leftover from the RFC that could be dropped.

> We also split the pending_bytes report into the initial and
> sustaining values, and define the protocol to get an event via poll() for
> new dirty data during PRE_COPY.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> [Shameer: Renamed ioctl and updated ioctl usage description]
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/vfio/vfio.c       |  71 +++++++++++++++++++++++-
>  include/uapi/linux/vfio.h | 113 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 179 insertions(+), 5 deletions(-)
>=20
...
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index fea86061b44e..440dbfaabdb3 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -819,12 +819,20 @@ struct vfio_device_feature {
>   * VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P means that RUNNING_P2P
>   * is supported in addition to the STOP_COPY states.
>   *
> + * VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_PRE_COPY means that
> + * PRE_COPY is supported in addition to the STOP_COPY states.
> + *
> + * VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P | VFIO_MIGRATION_PRE_CO=
PY
> + * means that RUNNING_P2P, PRE_COPY and PRE_COPY_P2P are supported
> + * in addition to the STOP_COPY states.
> + *
>   * Other combinations of flags have behavior to be defined in the future.
>   */
>  struct vfio_device_feature_migration {
>  	__aligned_u64 flags;
>  #define VFIO_MIGRATION_STOP_COPY	(1 << 0)
>  #define VFIO_MIGRATION_P2P		(1 << 1)
> +#define VFIO_MIGRATION_PRE_COPY		(1 << 2)
>  };
>  #define VFIO_DEVICE_FEATURE_MIGRATION 1
> =20
> @@ -875,8 +883,13 @@ struct vfio_device_feature_mig_state {
>   *  RESUMING - The device is stopped and is loading a new internal state
>   *  ERROR - The device has failed and must be reset
>   *
> - * And 1 optional state to support VFIO_MIGRATION_P2P:
> + * And optional states to support VFIO_MIGRATION_P2P:
>   *  RUNNING_P2P - RUNNING, except the device cannot do peer to peer DMA
> + * And VFIO_MIGRATION_PRE_COPY:
> + *  PRE_COPY - The device is running normally but tracking internal state
> + *             changes
> + * And VFIO_MIGRATION_P2P | VFIO_MIGRATION_PRE_COPY:
> + *  PRE_COPY_P2P - PRE_COPY, except the device cannot do peer to peer DMA
>   *
>   * The FSM takes actions on the arcs between FSM states. The driver impl=
ements
>   * the following behavior for the FSM arcs:
> @@ -908,20 +921,48 @@ struct vfio_device_feature_mig_state {
>   *
>   *   To abort a RESUMING session the device must be reset.
>   *
> + * PRE_COPY -> RUNNING
>   * RUNNING_P2P -> RUNNING
>   *   While in RUNNING the device is fully operational, the device may ge=
nerate
>   *   interrupts, DMA, respond to MMIO, all vfio device regions are funct=
ional,
>   *   and the device may advance its internal state.
>   *
> + *   The PRE_COPY arc will terminate a data transfer session.
> + *
> + * PRE_COPY_P2P -> RUNNING_P2P
>   * RUNNING -> RUNNING_P2P
>   * STOP -> RUNNING_P2P
>   *   While in RUNNING_P2P the device is partially running in the P2P qui=
escent
>   *   state defined below.
>   *
> + *   The PRE_COPY arc will terminate a data transfer session.
> + *
> + * RUNNING -> PRE_COPY
> + * RUNNING_P2P -> PRE_COPY_P2P
>   * STOP -> STOP_COPY
> - *   This arc begin the process of saving the device state and will retu=
rn a
> - *   new data_fd.
> + *   PRE_COPY, PRE_COPY_P2P and STOP_COPY form the "saving group" of sta=
tes
> + *   which share a data transfer session. Moving between these states al=
ters
> + *   what is streamed in session, but does not terminate or otherwise ef=
fect
> + *   the associated fd.
> + *
> + *   These arcs begin the process of saving the device state and will re=
turn a
> + *   new data_fd. The migration driver may perform actions such as enabl=
ing
> + *   dirty logging of device state when entering PRE_COPY or PER_COPY_P2=
P.
> + *
> + *   Each arc does not change the device operation, the device remains
> + *   RUNNING, P2P quiesced or in STOP. The STOP_COPY state is described =
below
> + *   in PRE_COPY_P2P -> STOP_COPY.
> + *
> + * PRE_COPY -> PRE_COPY_P2P
> + *   Entering PRE_COPY_P2P continues all the behaviors of PRE_COPY above.
> + *   However, while in the PRE_COPY_P2P state, the device is partially r=
unning
> + *   in the P2P quiescent state defined below, like RUNNING_P2P.
>   *
> + * PRE_COPY_P2P -> PRE_COPY
> + *   This arc allows returning the device to a full RUNNING behavior whi=
le
> + *   continuing all the behaviors of PRE_COPY.
> + *
> + * PRE_COPY_P2P -> STOP_COPY
>   *   While in the STOP_COPY state the device has the same behavior as ST=
OP
>   *   with the addition that the data transfers session continues to stre=
am the
>   *   migration state. End of stream on the FD indicates the entire device
> @@ -939,6 +980,13 @@ struct vfio_device_feature_mig_state {
>   *   device state for this arc if required to prepare the device to rece=
ive the
>   *   migration data.
>   *
> + * STOP_COPY -> PRE_COPY
> + * STOP_COPY -> PRE_COPY_P2P
> + *   These arcs are not permitted and return error if requested. Future
> + *   revisions of this API may define behaviors for these arcs, in this =
case
> + *   support will be discoverable by a new flag in
> + *   VFIO_DEVICE_FEATURE_MIGRATION.
> + *
>   * any -> ERROR
>   *   ERROR cannot be specified as a device state, however any transition=
 request
>   *   can be failed with an errno return and may then move the device_sta=
te into
> @@ -950,7 +998,7 @@ struct vfio_device_feature_mig_state {
>   * The optional peer to peer (P2P) quiescent state is intended to be a q=
uiescent
>   * state for the device for the purposes of managing multiple devices wi=
thin a
>   * user context where peer-to-peer DMA between devices may be active. The
> - * RUNNING_P2P states must prevent the device from initiating
> + * RUNNING_P2P and PRE_COPY_P2P states must prevent the device from init=
iating
>   * any new P2P DMA transactions. If the device can identify P2P transact=
ions
>   * then it can stop only P2P DMA, otherwise it must stop all DMA. The mi=
gration
>   * driver must complete any such outstanding operations prior to complet=
ing the
> @@ -963,6 +1011,8 @@ struct vfio_device_feature_mig_state {
>   * above FSM arcs. As there are multiple paths through the FSM arcs the =
path
>   * should be selected based on the following rules:
>   *   - Select the shortest path.
> + *   - The path cannot have saving group states as interior arcs, only
> + *     starting/end states.
>   * Refer to vfio_mig_get_next_state() for the result of the algorithm.
>   *
>   * The automatic transit through the FSM arcs that make up the combinati=
on
> @@ -976,6 +1026,9 @@ struct vfio_device_feature_mig_state {
>   * support them. The user can discover if these states are supported by =
using
>   * VFIO_DEVICE_FEATURE_MIGRATION. By using combination transitions the u=
ser can
>   * avoid knowing about these optional states if the kernel driver suppor=
ts them.
> + *
> + * Arcs touching PRE_COPY and PRE_COPY_P2P are removed if support for PR=
E_COPY
> + * is not present.
>   */
>  enum vfio_device_mig_state {
>  	VFIO_DEVICE_STATE_ERROR =3D 0,
> @@ -984,8 +1037,60 @@ enum vfio_device_mig_state {
>  	VFIO_DEVICE_STATE_STOP_COPY =3D 3,
>  	VFIO_DEVICE_STATE_RESUMING =3D 4,
>  	VFIO_DEVICE_STATE_RUNNING_P2P =3D 5,
> +	VFIO_DEVICE_STATE_PRE_COPY =3D 6,
> +	VFIO_DEVICE_STATE_PRE_COPY_P2P =3D 7,
> +};
> +
> +/**
> + * VFIO_MIG_GET_PRECOPY_INFO - _IO(VFIO_TYPE, VFIO_BASE + 21)
> + *
> + * This ioctl is used on the migration data FD in the precopy phase of t=
he
> + * migration data transfer. It returns an estimate of the current data s=
izes
> + * remaining to be transferred. It allows the user to judge when it is
> + * appropriate to leave PRE_COPY for STOP_COPY.
> + *
> + * This ioctl is valid only in VFIO_DEVICE_STATE_PRE_COPY state and kern=
el

PRE_COPY and PRE_COPY_P2P states, maybe we can generally refer to these
as "PRE_COPY states".

> + * driver should return -EINVAL from any other migration state.
> + *
> + * initial_bytes reflects the estimated remaining size of any initial ma=
ndatory
> + * precopy data transfer. When initial_bytes returns as zero then the in=
itial
> + * phase of the precopy data is completed. Generally initial_bytes shoul=
d start
> + * out as approximately the entire device state.

What is "mandatory" intended to mean here?  The user isn't required to
collect any data from the device in the PRE_COPY states.

> + *
> + * dirty_bytes reflects an estimate for how much more data needs to be
> + * transferred to complete the migration. Generally it should start as z=
ero
> + * and increase as internal state is dirtied.

Maybe let's try to combine the descriptions, I'll give it a shot:

"The vfio_precopy_info data structure returned by this ioctl provides
 estimates of data available from the device during the PRE_COPY states.
 This estimate is split into two categories, initial_bytes and
 dirty_bytes.

 The initial_bytes field indicates the amount of static data available
 from the device.  This field should have a non-zero initial value and
 decrease as migration data is read from the device.

 The dirty_bytes field tracks device state changes relative to data
 previously retrieved.  This field starts at zero and may increase as
 the internal device state is modified or decrease as that modified
 state is read from the device.

 Userspace may use the combination of these fields to estimate the
 potential data size available during the PRE_COPY phases, as well as
 trends relative to the rate the device is dirtying it's internal
 state, but these fields are not required to have any bearing relative
 to the data size available during the STOP_COPY phase."

> + *
> + * Drivers should attempt to return estimates so that initial_bytes +
> + * dirty_bytes matches the amount of data an immediate transition to STO=
P_COPY
> + * will require to be streamed.

I think previous discussions have proven this false, we expect trailing
data that is only available in STOP_COPY, we cannot bound the size of
that data, and dirty_bytes is not intended to expose data that cannot
be retrieved during the PRE_COPY phases.  Thanks,

Alex

> + *
> + * Drivers have a lot of flexibility in when and what they transfer duri=
ng the
> + * PRE_COPY phase, and how they report this from VFIO_MIG_GET_PRECOPY_IN=
FO.
> + *
> + * During pre-copy the migration data FD has a temporary "end of stream"=
 that is
> + * reached when both initial_bytes and dirty_byte are zero. For instance=
, this
> + * may indicate that the device is idle and not currently dirtying any i=
nternal
> + * state. When read() is done on this temporary end of stream the kernel=
 driver
> + * should return ENOMSG from read(). Userspace can wait for more data (w=
hich may
> + * never come) by using poll.
> + *
> + * Once in STOP_COPY the migration data FD has a permanent end of stream
> + * signaled in the usual way by read() always returning 0 and poll always
> + * returning readable. ENOMSG may not be returned in STOP_COPY. Support
> + * for this ioctl is optional.
> + *
> + * Return: 0 on success, -1 and errno set on failure.
> + */
> +struct vfio_precopy_info {
> +	__u32 argsz;
> +	__u32 flags;
> +	__aligned_u64 initial_bytes;
> +	__aligned_u64 dirty_bytes;
>  };
> =20
> +#define VFIO_MIG_GET_PRECOPY_INFO _IO(VFIO_TYPE, VFIO_BASE + 21)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
> =20
>  /**

