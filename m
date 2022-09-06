Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0925AE4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiIFJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiIFJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:46:32 -0400
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53E076474
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:46:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VOpbTla_1662457586;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VOpbTla_1662457586)
          by smtp.aliyun-inc.com;
          Tue, 06 Sep 2022 17:46:27 +0800
Message-ID: <1662457569.3934484-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] Documentation: add basic information on vDPA
Date:   Tue, 6 Sep 2022 17:46:09 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220817221956.1149183-1-stefanha@redhat.com>
In-Reply-To: <20220817221956.1149183-1-stefanha@redhat.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 18:19:56 -0400, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The vDPA driver framework is largely undocumented. Add a basic page that
> describes what vDPA is, where to get more information, and how to use
> the simulator for testing.
>
> In the future it would be nice to add an overview of the driver API as
> well as comprehensive doc comments.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

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
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
