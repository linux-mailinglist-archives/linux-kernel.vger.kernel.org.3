Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD95373BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 05:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiE3Djn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 23:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiE3Dji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 23:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7FD4719F0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653881975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdZG8wd/mfaE1rIlJ69hB8EXyZHW/gHoxx+VKCUjuys=;
        b=Jjzoh9QA1gH+XboJr1s4bzFEH97iKQlySG9L4fbxysEXFsWvuKWNHVA3q6gq6ILvJCCTFn
        057HsOalJYU/yMzWuW/bKzhU/qSXB+saHfdubzo/PK/h3vb3oIA2DtAoW2GkY+/PRixWcC
        ic2ne+7dSF5bCYCtYD0o2+f1+1XfAi4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-up2NUfEOPQubt0ZG_ul0sg-1; Sun, 29 May 2022 23:39:34 -0400
X-MC-Unique: up2NUfEOPQubt0ZG_ul0sg-1
Received: by mail-lf1-f72.google.com with SMTP id c6-20020a056512104600b00477b25bfdf8so4646261lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 20:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FdZG8wd/mfaE1rIlJ69hB8EXyZHW/gHoxx+VKCUjuys=;
        b=d+HSS5qz2Autm9iaOQPzPRp9KvKVlDX+x8M4fGwAoWitTf9+TgwKmgMAWDQtlY8De+
         VCUjLr/FPt10ug5OpPB66qA20bb2QUgew4LBaHn5u0eZBGFp+vcPWBmqGVNTqOSuWp5F
         ujhv+PleIOU6ppQRgnaX7MEl8O0+pduulaEPVww5SWjnBGFrLTr3cPDEs0vWugumRzOs
         RQZ5oBYkuLal8xzln0I/NsXRcXMtvsDS4Wk5dfUg8I5Y90qxTlo1FZNOQUxDqGOIuCbx
         zAYvrRcoZV7PtLr+6jsRXAnS+OglnyB39XbSnNZOHEl9NQk6FpTPT5NfrAWM5W95/IBv
         ru0A==
X-Gm-Message-State: AOAM533zK59QeMGyrEORDoiK31SBOwOs/Yv0REP4IcDbUE5V7BXBhIF/
        oo/R8lSjxRUkJ+f83Ka1uxWhGnRdSig0EkK1jddGXrYP62FHIMIAh5U99NFgqInrG2ufw3anLlB
        boeML/b7ceERXGMpBWO5foJ8NbOFZ9aIwr3E3IzyG
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id o5-20020a2ebd85000000b002509bf28e27mr31984316ljq.177.1653881972926;
        Sun, 29 May 2022 20:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ+6zqmnNnl7EEnXkdvxuYG8LYk8erHBazoZjoQnAG/qmTMJwUD0nMIgF2AK7TVkQU1NACb7Vt0qIrH9A2MBc=
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr31984290ljq.177.1653881972697; Sun, 29
 May 2022 20:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com> <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220527065442-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 30 May 2022 11:39:21 +0800
Message-ID: <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, May 26, 2022 at 12:54:32PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Sent: Thursday, May 26, 2022 8:44 AM
> >
> > > Implement stop operation for vdpa_sim devices, so vhost-vdpa will off=
er
> > >
> > > that backend feature and userspace can effectively stop the device.
> > >
> > >
> > >
> > > This is a must before get virtqueue indexes (base) for live migration=
,
> > >
> > > since the device could modify them after userland gets them. There ar=
e
> > >
> > > individual ways to perform that action for some devices
> > >
> > > (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there
> > > was no
> > >
> > > way to perform it for any vhost device (and, in particular, vhost-vdp=
a).
> > >
> > >
> > >
> > > After the return of ioctl with stop !=3D 0, the device MUST finish an=
y
> > >
> > > pending operations like in flight requests. It must also preserve all
> > >
> > > the necessary state (the virtqueue vring base plus the possible devic=
e
> > >
> > > specific states) that is required for restoring in the future. The
> > >
> > > device must not change its configuration after that point.
> > >
> > >
> > >
> > > After the return of ioctl with stop =3D=3D 0, the device can continue
> > >
> > > processing buffers as long as typical conditions are met (vq is enabl=
ed,
> > >
> > > DRIVER_OK status bit is enabled, etc).
> >
> > Just to be clear, we are adding vdpa level new ioctl() that doesn=E2=80=
=99t map to any mechanism in the virtio spec.
> >
> > Why can't we use this ioctl() to indicate driver to start/stop the devi=
ce instead of driving it through the driver_ok?
> > This is in the context of other discussion we had in the LM series.
>
> If there's something in the spec that does this then let's use that.

Actually, we try to propose a independent feature here:

https://lists.oasis-open.org/archives/virtio-dev/202111/msg00020.html

Does it make sense to you?

Thanks

> Unfortunately the LM series seems to be stuck on moving
> bits around with the admin virtqueue ...
>
> --
> MST
>

