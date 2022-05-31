Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86313538AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiEaFkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiEaFkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC9C1941B0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653975637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0/inTPXCkYCa8tPwUAmu5S5vMTpS/z+cw62yovLB+o=;
        b=Kpru4rLswabQ2uo6XSRUf/fct/zj5ZOC4LjZgdlYwG8ss6ryaeEClpnTB+vRxjkUHs5t2c
        3Xn2yQTQ/gWd9VRmmCRp0RJAI2xjeWiPXYcZ7X8tT0ckK/1w/Z4PMsedE3PkSG/RUQsilp
        Y7oaPGd6bPekjRFseQThLDElGGNmoR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-eta5QGojNwCcCrcKSqHW5A-1; Tue, 31 May 2022 01:40:35 -0400
X-MC-Unique: eta5QGojNwCcCrcKSqHW5A-1
Received: by mail-wm1-f70.google.com with SMTP id n25-20020a05600c3b9900b0039733081b4dso720531wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g0/inTPXCkYCa8tPwUAmu5S5vMTpS/z+cw62yovLB+o=;
        b=tTE+KoRnBcuuZye/zGVI7pzlGWELiMPhAda48WJvKh0/WtDwDyV2lzRYRfdKFYDqvw
         LqKr9OXiexANT6eh/b9cRgO8NxsKMWbEHWsWkngIyXGxjCVCSodyxlONDFoO6xO8mMPN
         K34MWk+B2vYnnMGHlAzzb/mZyluScStqi0j6RTcSErIUO+2ryiyUIOWJQmizVBgAc3Vv
         xVl0v31HH0vhVPM5CNKBalo29cpPXpuzGZRcmOurfqlzLncMaX+vAOwnlWD251t4+HwB
         2PWbxlW7uSOfFnIVCGekV7iVuTVjP+tNVAt0j2SN627XLTloCnTDjKG2j16++otGRMKv
         dOKA==
X-Gm-Message-State: AOAM5303VLEzvROKzByReXKl02H3c7dbnrLN/rmOiq/cJ3avyx5B5lCF
        xavj20BCzoqcEIRjGian+2v6k/3I/3ntuoL/sO1txLECgLF+5f4I/CVXAKWNmD5czdxKwLsFmBe
        RHfIormymb0rmuvCyeGpxPDDA
X-Received: by 2002:a05:6000:2c8:b0:210:ddd:170c with SMTP id o8-20020a05600002c800b002100ddd170cmr19414118wry.338.1653975634523;
        Mon, 30 May 2022 22:40:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGl9FELIFTb9xFqXU89C9vQtydLRw+e/4/cFXIEETVgJhiweAwF7+L8FqRQddILAHWIYlsNg==
X-Received: by 2002:a05:6000:2c8:b0:210:ddd:170c with SMTP id o8-20020a05600002c800b002100ddd170cmr19414081wry.338.1653975634242;
        Mon, 30 May 2022 22:40:34 -0700 (PDT)
Received: from redhat.com ([2.52.157.68])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c3b0300b003942a244f2fsm1153615wms.8.2022.05.30.22.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 22:40:33 -0700 (PDT)
Date:   Tue, 31 May 2022 01:40:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
Message-ID: <20220531013913-mutt-send-email-mst@kernel.org>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 11:39:21AM +0800, Jason Wang wrote:
> On Fri, May 27, 2022 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, May 26, 2022 at 12:54:32PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Eugenio Pérez <eperezma@redhat.com>
> > > > Sent: Thursday, May 26, 2022 8:44 AM
> > >
> > > > Implement stop operation for vdpa_sim devices, so vhost-vdpa will offer
> > > >
> > > > that backend feature and userspace can effectively stop the device.
> > > >
> > > >
> > > >
> > > > This is a must before get virtqueue indexes (base) for live migration,
> > > >
> > > > since the device could modify them after userland gets them. There are
> > > >
> > > > individual ways to perform that action for some devices
> > > >
> > > > (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there
> > > > was no
> > > >
> > > > way to perform it for any vhost device (and, in particular, vhost-vdpa).
> > > >
> > > >
> > > >
> > > > After the return of ioctl with stop != 0, the device MUST finish any
> > > >
> > > > pending operations like in flight requests. It must also preserve all
> > > >
> > > > the necessary state (the virtqueue vring base plus the possible device
> > > >
> > > > specific states) that is required for restoring in the future. The
> > > >
> > > > device must not change its configuration after that point.
> > > >
> > > >
> > > >
> > > > After the return of ioctl with stop == 0, the device can continue
> > > >
> > > > processing buffers as long as typical conditions are met (vq is enabled,
> > > >
> > > > DRIVER_OK status bit is enabled, etc).
> > >
> > > Just to be clear, we are adding vdpa level new ioctl() that doesn’t map to any mechanism in the virtio spec.
> > >
> > > Why can't we use this ioctl() to indicate driver to start/stop the device instead of driving it through the driver_ok?
> > > This is in the context of other discussion we had in the LM series.
> >
> > If there's something in the spec that does this then let's use that.
> 
> Actually, we try to propose a independent feature here:
> 
> https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.html
> 
> Does it make sense to you?
> 
> Thanks

But I thought the LM patches are trying to replace all that?


> > Unfortunately the LM series seems to be stuck on moving
> > bits around with the admin virtqueue ...
> >
> > --
> > MST
> >

