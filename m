Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E349C535179
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiEZPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347910AbiEZPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448335BD30
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653579164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSIoSHlZYk5kjqEqH2i0FGPAET7bzIBvQki4K3sUagE=;
        b=cZsZKzZ/oLtLMge5pcilHZOPzXWso6FReT1rPEv7h7dsL35U7S+MKKbaNVGdAB3ngBc2Kj
        IcumLlbxdav3QNHINgYsMhg+FY4HE8nxrfvNe/cz1Bx5PD/MmVAhyJ5McMP7rEJZ+LU/nS
        bx+rHZJwkEPLhc9Xeh2esLvmfYDZHsA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-ojledXyMNK2wpfp_olv12w-1; Thu, 26 May 2022 11:32:42 -0400
X-MC-Unique: ojledXyMNK2wpfp_olv12w-1
Received: by mail-qt1-f197.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso1891803qtp.19
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sSIoSHlZYk5kjqEqH2i0FGPAET7bzIBvQki4K3sUagE=;
        b=UFI0CqxnAV1vmBJ1fdCpbHcw9WbY+Aspym0MdmIWyPnx3WTHUNtI1tDVuiuHC9dmaJ
         1PpdNGAEB8NkBdw4Nkn+8iQt0LG0tnPB94IRbFmSLQNl6Kg8EBASvl1PsFQOncpxMz99
         KKSGUhO5Ou3t+ExY4wISwV654q0k5Q9jRqdfWSCtB/8SiuqXj05+9JruNU+U+BqWf4cc
         dly1bZ2GI7vwagx2/ycbdi1n5p+0A86dHOp5uMwZ9eos7TiyteIzb9aF0BWn0q8s9Q3t
         7+IrGyngtA4PNcM5t983Tp2iY4lg8cfnHXuGH8ZIfAmACmHuZp2ccrTt8U4MlFgW18og
         tBdQ==
X-Gm-Message-State: AOAM533EN1PddBCt8Psw4gYGQOwgzrAmgID7B1LBPuZ8LzmGMjvPK1II
        cjZ69W5qmuEetN1S7krFkaZHs/IWuiOX6aVUQb5YncYgC0jZjuOyZfCjzQ/h6m+UCMs8WegP+Kt
        wBmknLckL9K76ei5VINyTHFqQwT7GeefLUf8VCPnY
X-Received: by 2002:a05:620a:1a9a:b0:69c:4a99:ea50 with SMTP id bl26-20020a05620a1a9a00b0069c4a99ea50mr24811589qkb.632.1653579162405;
        Thu, 26 May 2022 08:32:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTUtJpLbB76Kl8KfE+6tzdQIhBG/FiDcSn5h10IiXuPTy5XUOKyKTlOm+jakaia5HxurC6beYgghXJMiAxuEA=
X-Received: by 2002:a05:620a:1a9a:b0:69c:4a99:ea50 with SMTP id
 bl26-20020a05620a1a9a00b0069c4a99ea50mr24811565qkb.632.1653579162169; Thu, 26
 May 2022 08:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com> <20220526124338.36247-2-eperezma@redhat.com>
 <20220526142318.mi2kfywbpvuky4lw@sgarzare-redhat>
In-Reply-To: <20220526142318.mi2kfywbpvuky4lw@sgarzare-redhat>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 26 May 2022 17:32:06 +0200
Message-ID: <CAJaqyWe4ok+QxhwAx30oESf18NUhJOFdmeZbNs0AXSxZsU-Mvw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] vdpa: Add stop operation
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Martin Porter <martinpo@xilinx.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Pablo Cascon Katchadourian <pabloc@xilinx.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhang Min <zhang.min9@zte.com.cn>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Cindy Lu <lulu@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        "Uminski, Piotr" <Piotr.Uminski@intel.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>, ecree.xilinx@gmail.com,
        "Dawar, Gautam" <gautam.dawar@amd.com>, habetsm.xilinx@gmail.com,
        "Kamde, Tanuj" <tanuj.kamde@amd.com>,
        Harpreet Singh Anand <hanand@xilinx.com>,
        Dinan Gunawardena <dinang@xilinx.com>,
        Longpeng <longpeng2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 4:23 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
>
> On Thu, May 26, 2022 at 02:43:35PM +0200, Eugenio P=C3=A9rez wrote:
> >This operation is optional: It it's not implemented, backend feature bit
> >will not be exposed.
> >
> >Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >---
> > include/linux/vdpa.h | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >index 15af802d41c4..ddfebc4e1e01 100644
> >--- a/include/linux/vdpa.h
> >+++ b/include/linux/vdpa.h
> >@@ -215,6 +215,11 @@ struct vdpa_map_file {
> >  * @reset:                    Reset device
> >  *                            @vdev: vdpa device
> >  *                            Returns integer: success (0) or error (< =
0)
> >+ * @stop:                     Stop or resume the device (optional, but =
it must
> >+ *                            be implemented if require device stop)
> >+ *                            @vdev: vdpa device
> >+ *                            @stop: stop (true), not stop (false)
>
> Sorry for just seeing this now, but if you have to send a v5, maybe we
> could use "resume" here instead of "not stop".
>

I agree it fits way better, I'll queue for the next :). Thanks!

> Thanks,
> Stefano
>
> >+ *                            Returns integer: success (0) or error (< =
0)
> >  * @get_config_size:          Get the size of the configuration space i=
ncludes
> >  *                            fields that are conditional on feature bi=
ts.
> >  *                            @vdev: vdpa device
> >@@ -316,6 +321,7 @@ struct vdpa_config_ops {
> >       u8 (*get_status)(struct vdpa_device *vdev);
> >       void (*set_status)(struct vdpa_device *vdev, u8 status);
> >       int (*reset)(struct vdpa_device *vdev);
> >+      int (*stop)(struct vdpa_device *vdev, bool stop);
> >       size_t (*get_config_size)(struct vdpa_device *vdev);
> >       void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> >                          void *buf, unsigned int len);
> >--
> >2.31.1
> >
>

