Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B1597FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbiHRIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244025AbiHRIFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF413F5C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660809922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEvqUcQmIj9/YAiae1HApl/DsVDoyFZBZ0Um99hdIHI=;
        b=XwXG5oLzMM1reTPaOKruoN2KUIcD4fN+yWwOyEc5XX0FgTq7Izpo5a6TW2RkyutUg19nGB
        kteY6NvIYUEtBrAY/CoQFyiVnj/4rhjyKwRlaBxNZP615/5pfS1dP/2mDF1FtUrplD5Sw/
        gisYiJ5TPRyG787bwFFy0Nj1GUh6diM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-Jj2tTpd2PzeaKeW9Y156ug-1; Thu, 18 Aug 2022 04:05:20 -0400
X-MC-Unique: Jj2tTpd2PzeaKeW9Y156ug-1
Received: by mail-lf1-f72.google.com with SMTP id i41-20020a0565123e2900b00492bf8db976so222515lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EEvqUcQmIj9/YAiae1HApl/DsVDoyFZBZ0Um99hdIHI=;
        b=de8CxawVFZAOV7iF38G3kWOCUMnT94cMeFracKtF0FRlT0ZBGNIWw61xEx63g/YKLH
         W4z/tydh5biYUjskXSb2xSd48Ll2OxsKeTRip+8BF8TZJS8cutbvXSemLG8Y5A+aHQ9C
         XDzx4aMfqliqIK0f3geXTcstzN9B938oKXgVwfZ6H2lNst552A1sOTQACUFUWvd3L/Wo
         FJmgm4E1kAQYwkQcBJQOJum5TQd6HOmUQAtoUYnwnwuH6rzjOfZv6YWBTx1EzZgXVesk
         0zsNjoJZynpCFBWNalfBPzh45KDZIyi65u2whveHtkqFVkfZVHNQQry+wwT/AAIj+FUP
         uGxQ==
X-Gm-Message-State: ACgBeo0Eluc8vJFHqUW5XEbxX3g+hxszcBO0tfUD2OZx/dafXKjLXSWW
        NbrGTrusbLpP83i60ph3Elfo1unyuu0HpVrzxefToyjlVdZ3tfc08tsWMaGU/6Ns7DlD6ElNt+b
        RpZJ2MtaFzqwqELZJoJOk4dccokToNZpybZ/nev0M
X-Received: by 2002:a2e:a983:0:b0:25f:f273:548e with SMTP id x3-20020a2ea983000000b0025ff273548emr501671ljq.141.1660809919377;
        Thu, 18 Aug 2022 01:05:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46k09nEp5PaxhgcHPz5gwgI+Ykd3f40dyd6/GHGaPhn/5mLrbuDJ2nPozxQfzCNGN6SkupyPLl1nyRciLhMUE=
X-Received: by 2002:a2e:a983:0:b0:25f:f273:548e with SMTP id
 x3-20020a2ea983000000b0025ff273548emr501666ljq.141.1660809919211; Thu, 18 Aug
 2022 01:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220817221956.1149183-1-stefanha@redhat.com>
In-Reply-To: <20220817221956.1149183-1-stefanha@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 18 Aug 2022 16:05:08 +0800
Message-ID: <CACGkMEuVama8zsPmf48t0LwEor1-+ihzajeU3=PdYjKGafdg3g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add basic information on vDPA
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 6:20 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The vDPA driver framework is largely undocumented. Add a basic page that
> describes what vDPA is, where to get more information, and how to use
> the simulator for testing.
>
> In the future it would be nice to add an overview of the driver API as
> well as comprehensive doc comments.

+1

>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  Documentation/driver-api/index.rst |  1 +
>  Documentation/driver-api/vdpa.rst  | 40 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/driver-api/vdpa.rst
>
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index d3a58f77328e..e307779568d4 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -103,6 +103,7 @@ available subsections can be seen below.
>     switchtec
>     sync_file
>     tty/index
> +   vdpa
>     vfio-mediated-device
>     vfio
>     vfio-pci-device-specific-driver-acceptance
> diff --git a/Documentation/driver-api/vdpa.rst b/Documentation/driver-api/vdpa.rst
> new file mode 100644
> index 000000000000..75c666548e1d
> --- /dev/null
> +++ b/Documentation/driver-api/vdpa.rst
> @@ -0,0 +1,40 @@
> +====================================
> +vDPA - VIRTIO Data Path Acceleration
> +====================================
> +
> +The vDPA driver framework can be used to implement VIRTIO devices that are
> +backed by physical hardware or by software. While the device's data path
> +complies with the VIRTIO specification, the control path is driver-specific and
> +a netlink interface exists for instantiating devices.
> +
> +vDPA devices can be attached to the kernel's VIRTIO device drivers or exposed
> +to userspace emulators/virtualizers such as QEMU through vhost.
> +
> +The driver API is not documented beyond the doc comments in <linux/vdpa.h>. The
> +netlink API is not documented beyond the doc comments in <linux/uapi/vdpa.h>.
> +The existing vDPA drivers serve as reference code for those wishing to develop
> +their own drivers.
> +
> +See https://vdpa-dev.gitlab.io/ for more information about vDPA.
> +
> +Questions can be sent to the virtualization@lists.linux-foundation.org mailing
> +list.
> +
> +Device simulators
> +-----------------
> +
> +There are software vDPA device simulators for testing, prototyping, and
> +development purposes. The simulators do not require physical hardware.
> +
> +Available simulators include:
> +
> +- `vdpa_sim_net` implements a virtio-net loopback device.
> +- `vdpa_sim_blk` implements a memory-backed virtio-blk device.
> +
> +To use `vdpa_sim_blk` through vhost::
> +
> +  # modprobe vhost_vdpa
> +  # modprobe vdpa_sim_blk
> +  # vdpa dev add name vdpa-blk1 mgmtdev vdpasim_blk
> +  ...use /dev/vhost-dev-0...
> +  # vdpa dev del vdpa-blk1
> --
> 2.37.2
>

