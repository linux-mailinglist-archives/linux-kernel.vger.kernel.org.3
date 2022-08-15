Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B485C59347D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiHOSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHOSHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:07:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E5F29C96;
        Mon, 15 Aug 2022 11:07:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j3so8405057ljo.0;
        Mon, 15 Aug 2022 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=0RJHfed+jRQniNEgBz8w4HYP5Z9aKBBKPSPpaEsO1s0=;
        b=eUeguH1xX17loOK1eWgABdF5x35FeNK2teQ78Ln6YIinBCzdyXfEVjeWnZp0CLVHu+
         YZdyJK214SktzPznc2Jhi7XDBQzY8GU/FU6260B9LK3YDtQ91USAwgiGhqSSHL8wBe6+
         /hO3lf09o9Efuyeb5lI8Ik1Q9Mvm/cMCMGV0lqTC/88RghyyquhuKixI5IvQtX2Jaa6b
         mVZkdj6O6EqNQjcMpJd2g0LEcKAAES2SlTjAi4QuY8wo55e02Hjh0VukxzR5g4grE/sp
         tsZp/Gy71VWemqTcfvX0v/cb5PuyLKMfyXQuT2ftGmfCEKJuHu9n9pzQW3C7gz+T0vRv
         H8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=0RJHfed+jRQniNEgBz8w4HYP5Z9aKBBKPSPpaEsO1s0=;
        b=e7/XVoexNqRpsbV3oHu9nQvtcjun16lIL5dT6Lvf06Thu2UeGbUF8FtnINC51eqMTF
         TXZRBMCVJINdtrFaqeV00I31Nqgn/Q6uPOWPE7yRTnkqe/YpYcOwvq+Iq+7EYKIMz/q1
         V7dUsPrBi5e2VAQTC08iAVCM5RWFIxTLEmA8luOuWL1rPI5lhQsZw5/fyhFR+sf4CkGc
         kG4OnGed8xCiZK8+G7wa9/Ku+S7/dVp6UIa1hE6izWEASbLx54ZF5mciDNsoFa31SMAb
         e0Wq5U1Mm14Gj7R7pQIUDAJz8vyf5QY/AiJ614XRN3GyEH+mRpItNSjbTsFPZT+Kkqao
         Rkag==
X-Gm-Message-State: ACgBeo0Mbmzf+FfglRHZicT+K7hotpGKDeGnFZNhsi1UsH61grtA+1Zp
        YOMAGOhST3fVw+JtKJthf8FXiy6vwroHLFRrapQAbb+6KHk=
X-Google-Smtp-Source: AA6agR4GLJtFil7b3VqHDMXJeF5NZCKrYyBK5cB74iuNZ0L9X62wsLtZjTOyN42cdBYdOGn4LGfmfHjLJZ4ylv71pS4=
X-Received: by 2002:a05:651c:4d4:b0:25e:c766:202e with SMTP id
 e20-20020a05651c04d400b0025ec766202emr5009874lji.423.1660586837284; Mon, 15
 Aug 2022 11:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220811094542.268519-1-mst@redhat.com>
In-Reply-To: <20220811094542.268519-1-mst@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Aug 2022 11:07:05 -0700
Message-ID: <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: virtio_bt: fix device removal
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, Aug 11, 2022 at 2:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Device removal is clearly out of virtio spec: it attempts to remove
> unused buffers from a VQ before invoking device reset. To fix, make
> open/close NOPs and do all cleanup/setup in probe/remove.
>
> NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
> not really what a driver is supposed to be doing. These are transport
> enable/disable callbacks from the BT core towards the driver. It maps to
> a device being enabled/disabled by something like bluetoothd for
> example. So if disabled, users expect that no resources/queues are in
> use.  It does work with all other transports like USB, SDIO, UART etc.
> There should be no buffer used if the device is powered off. We also
> don=E2=80=99t have any USB URBs in-flight if the transport is not active.
>
> The way to implement a proper fix would be using vq reset if supported,
> or even using a full device reset.
>
> The cost of the hack is a single skb wasted on an unused bt device.
>
> NB2: with this fix in place driver still suffers from a race condition
> if an interrupt triggers while device is being reset.  To fix, in the
> virtbt_close() callback we should deactivate all interrupts.  To be
> fixed.
>
> squashed fixup: bluetooth: virtio_bt: fix an error code in probe()

Shouldn't the line above be a Fixes tag with the commit hash you are
attempting to fix, other than that I'd be fine to apply these changes.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <20220811080943.198245-1-mst@redhat.com>
> ---
>
> changes from v2:
>         tkeaked commit log to make lines shorter
> changes from v1:
>         fixed error handling
>
>  drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.=
c
> index 67c21263f9e0..f6d699fed139 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *v=
bt)
>
>  static int virtbt_open(struct hci_dev *hdev)
>  {
> -       struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> +       return 0;
> +}
>
> +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> +{
>         if (virtbt_add_inbuf(vbt) < 0)
>                 return -EIO;
>
> @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
>
>  static int virtbt_close(struct hci_dev *hdev)
>  {
> -       struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> +       return 0;
> +}
> +
> +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> +{
>         int i;
>
>         cancel_work_sync(&vbt->rx);
> @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
>                 goto failed;
>         }
>
> +       virtio_device_ready(vdev);
> +       err =3D virtbt_open_vdev(vbt);
> +       if (err)
> +               goto open_failed;
> +
>         return 0;
>
> +open_failed:
> +       hci_free_dev(hdev);
>  failed:
>         vdev->config->del_vqs(vdev);
>         return err;
> @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
>
>         hci_unregister_dev(hdev);
>         virtio_reset_device(vdev);
> +       virtbt_close_vdev(vbt);
>
>         hci_free_dev(hdev);
>         vbt->hdev =3D NULL;
> --
> MST
>


--=20
Luiz Augusto von Dentz
