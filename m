Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63C258FDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiHKN6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiHKN6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1D5D82755
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660226315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SueXoUwoFpOiUowzXaYPSnSZQFBzpony+oQ+FoIu3TE=;
        b=dw35X9gJFH8Mvqd3WiQbTYSYR3fsaH31uu1sFp9v6oZ0GedYpE47x0xAKe+rWs8m2NYANd
        PGQJbIznHfC9GemeYPaCRsEMDow6pB9FP+/lNJysm1ksT3OmH7cakKrY9DdODS6SFvmJod
        AKPGE03qUSmYSUXQMMapOdm+JQ33s18=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-78-AUTxff9ZNkunE18KLQQ-tQ-1; Thu, 11 Aug 2022 09:58:34 -0400
X-MC-Unique: AUTxff9ZNkunE18KLQQ-tQ-1
Received: by mail-ed1-f70.google.com with SMTP id m18-20020a056402511200b0043d601a8035so11200808edd.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=SueXoUwoFpOiUowzXaYPSnSZQFBzpony+oQ+FoIu3TE=;
        b=JIxqLM7jLf75EnMek3AaPO0Ajd7RzHqs56Btiy8gHQkUIWG8owFkeJmgCTswhRZXD+
         d2cgjOKeQmr/vUrfdvFdgOy9eyPQ/APmpVq0IWsfKHzGt4v5+kuN3oZiAyDYNt7ROz28
         N/BWp+/K2TYwdEO0GhrwAPKzSeOw8630MWqH+A3XZZRw5PrMqz8S89mtxUyqZEF0VLrP
         zNvRE/PjSwn+72wdGC6o0hTZch3sXGszEnGBnmfF/2wkpRIrEPWxKqhKznbY/hXngKSX
         AGEtsm8lKm72ZKgEucPdkMU4lOL21/gOqCy9J7roAgDCBTFz5B7PuL8528CFkslSrkZC
         Q1Tw==
X-Gm-Message-State: ACgBeo1lvpSZPRS5y7RPCd9wydwM+6zv6L7rgi3DADjUX1ONaC7uZeJv
        tpYWH0dOtyMZ7ycASXGAabBRybY9zEgOJBczO7p7AF6mFOlnf3Gm9mRD/gtY/CxTvbZd+RtYonG
        qB5O4PVY3XTSuZpnaN3ZoQtO5
X-Received: by 2002:a17:907:a0c6:b0:730:f081:6e8e with SMTP id hw6-20020a170907a0c600b00730f0816e8emr21391784ejc.479.1660226313546;
        Thu, 11 Aug 2022 06:58:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5b46QDyRM9vbzNuiXMABuDw2O5Su7R7FeFDkEfFhsasyXKwagvg8ClVE2e++6Vq45R4NWZ9Q==
X-Received: by 2002:a17:907:a0c6:b0:730:f081:6e8e with SMTP id hw6-20020a170907a0c600b00730f0816e8emr21391746ejc.479.1660226313014;
        Thu, 11 Aug 2022 06:58:33 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id a1-20020a50ff01000000b0043a5bcf80a2sm9166980edu.60.2022.08.11.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 06:58:32 -0700 (PDT)
Date:   Thu, 11 Aug 2022 09:58:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ecree.xilinx@gmail.com, gautam.dawar@amd.com,
        Zhang Min <zhang.min9@zte.com.cn>, pabloc@xilinx.com,
        Piotr.Uminski@intel.com, Dan Carpenter <dan.carpenter@oracle.com>,
        tanuj.kamde@amd.com, Zhu Lingshan <lingshan.zhu@intel.com>,
        martinh@xilinx.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        lvivier@redhat.com, martinpo@xilinx.com, hanand@xilinx.com,
        Eli Cohen <elic@nvidia.com>, lulu@redhat.com,
        habetsm.xilinx@gmail.com, Parav Pandit <parav@nvidia.com>,
        Longpeng <longpeng2@huawei.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>, dinang@xilinx.com,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v8 0/3] Implement vdpasim suspend operation
Message-ID: <20220811095743-mutt-send-email-mst@kernel.org>
References: <20220811135353.2549658-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220811135353.2549658-1-eperezma@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 03:53:50PM +0200, Eugenio Pérez wrote:
> Implement suspend operation for vdpa_sim devices, so vhost-vdpa will offer
> that backend feature and userspace can effectively suspend the device.
> 
> This is a must before getting virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them. There are
> individual ways to perform that action for some devices
> (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> way to perform it for any vhost device (and, in particular, vhost-vdpa).
> 
> After a successful return of ioctl the device must not process more virtqueue
> descriptors. The device can answer to read or writes of config fields as if it
> were not suspended. In particular, writing to "queue_enable" with a value of 1
> will not make the device start processing virtqueue buffers.
> 
> In the future, we will provide features similar to
> VHOST_USER_GET_INFLIGHT_FD so the device can save pending operations.
> 
> Applied on top of vhost branch.
> 
> Comments are welcome.
> 
> v8:
> * v7 but incremental from vhost instead of isolated.

Now I'm lost. incremental to what? Does the vhost branch now
have the correct bits?

> v7:
> * Remove ioctl leftover argument and update doc accordingly.
> 
> v6:
> * Remove the resume operation, making the ioctl simpler. We can always add
>   another ioctl for VM_STOP/VM_RESUME operation later.
> * s/stop/suspend/ to differentiate more from reset.
> * Clarify scope of the suspend operation.
> 
> v5:
> * s/not stop/resume/ in doc.
> 
> v4:
> * Replace VHOST_STOP to VHOST_VDPA_STOP in vhost ioctl switch case too.
> 
> v3:
> * s/VHOST_STOP/VHOST_VDPA_STOP/
> * Add documentation and requirements of the ioctl above its definition.
> 
> v2:
> * Replace raw _F_STOP with BIT_ULL(_F_STOP).
> * Fix obtaining of stop ioctl arg (it was not obtained but written).
> * Add stop to vdpa_sim_blk.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> 
> Eugenio Pérez (3):
>   vdpa: delete unreachable branch on vdpasim_suspend
>   vdpa: Remove wrong doc of VHOST_VDPA_SUSPEND ioctl
>   vhost: Remove invalid parameter of VHOST_VDPA_SUSPEND ioctl
> 
>  drivers/vdpa/vdpa_sim/vdpa_sim.c |  7 -------
>  include/linux/vdpa.h             |  2 +-
>  include/uapi/linux/vhost.h       | 17 ++++++-----------
>  3 files changed, 7 insertions(+), 19 deletions(-)
> 
> -- 
> 2.31.1
> 

