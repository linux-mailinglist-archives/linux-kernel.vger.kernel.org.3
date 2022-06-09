Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1009E5444A1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbiFIHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbiFIHTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE39B243B97
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654759176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZJhp5L1ykqWD7LdN0E4Ox3CGQKebfkP1ixyik/IJxo=;
        b=HgBstNws9Eunb5gATT8vUJOL42RYBSpfJ7bQ7F+yq9fNyHB3QjRAQDONbgRGaHdiEeJzr6
        YP4YxQOdpUr4q7ghO0ivHQ+/buVf5/Cvy9cL01N+2KjYmThhJ9zHoWyokDM3p6XQxpDvyd
        uuUzdS6e+WWyz086QWgFe6yjfANbnZI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-7wvyx7i9Nqanc9AljoF4uw-1; Thu, 09 Jun 2022 03:19:35 -0400
X-MC-Unique: 7wvyx7i9Nqanc9AljoF4uw-1
Received: by mail-lj1-f197.google.com with SMTP id 1-20020a2e1641000000b00255569ac874so4262311ljw.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZJhp5L1ykqWD7LdN0E4Ox3CGQKebfkP1ixyik/IJxo=;
        b=KSlLg0LNgfS5VioXEUmEA86iXI8rzzcfB15XtgaenhHr32cL2TMPmt+fuTJrYHd213
         3dmynYXtIidXVMlTpj0wlTUIszPvRg90EznnIWGn/vRPcz++NTAsIkFcSN9/AN3HLePk
         Pw+64WtH3cYNDg3fSnSl+vGr5sxP5fb0u+i7kZxjqyeaG5qYnEAgWnP+fjGbFSh2YiHR
         MsqHojyhI9fHRvAC0YgudePU1GZSK09MUgkgckgrk6fxNO7T3jcIWyMWBf8QU75cNzDN
         /tmr2RF1XQvG1Yi7r8VlSq1eOJpn5xOSnGkCJ73ucVHtox9T2TTApirJ5R4nBL/XBe7L
         8g4Q==
X-Gm-Message-State: AOAM533tSO8Yj8InBTLAc8w5kEhnIafQbD/4nmMLlSMSeZi1t5yTT7kY
        /e+qGxllKTqnbjDw4ZzTc9AYN1vpVNBKQIeCPEqRxZGFadjfABu4uA4ro4idcI7+wyOTh1iB5FE
        oQPkEHAY7Zmr4Pg/p0jr5gpafnjpQ2r1N3/PLw9u0
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id d21-20020a05651c089500b00250c5ecbc89mr60689053ljq.251.1654759173931;
        Thu, 09 Jun 2022 00:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb90dNZuYzoDTn4w+qZtYw1PWxrMu4ox+V+bc3835dZlQxeb3AGEBqe4wWKmMUQZhifbzb0yqD707QLMIfw/4=
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr60689031ljq.251.1654759173667; Thu, 09
 Jun 2022 00:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220603103356.26564-1-gautam.dawar@amd.com> <CACGkMEs38ycmAaDc48_rt5BeBHq4tzKH39gj=KczYFQC16ns5Q@mail.gmail.com>
 <DM4PR12MB5841EB20B82969B6D67638AF99A49@DM4PR12MB5841.namprd12.prod.outlook.com>
 <PH0PR12MB54814B1D6E884E50E5C26786DCA49@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54814B1D6E884E50E5C26786DCA49@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Jun 2022 15:19:22 +0800
Message-ID: <CACGkMEsdMzLb+JtdZ7vTmMb=jU7PpM5GaJT1uD6t_tty46x2OA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: allow vdpa dev_del management operation to return failure
To:     Parav Pandit <parav@nvidia.com>
Cc:     "Dawar, Gautam" <gautam.dawar@amd.com>,
        netdev <netdev@vger.kernel.org>,
        "linux-net-drivers (AMD-Xilinx)" <linux-net-drivers@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 6:43 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Dawar, Gautam <gautam.dawar@amd.com>
> > Sent: Wednesday, June 8, 2022 6:30 AM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: netdev <netdev@vger.kernel.org>; linux-net-drivers (AMD-Xilinx) <linux-
> > net-drivers@amd.com>; Anand, Harpreet <harpreet.anand@amd.com>;
> > Michael S. Tsirkin <mst@redhat.com>; Zhu Lingshan
> > <lingshan.zhu@intel.com>; Xie Yongji <xieyongji@bytedance.com>; Eli
> > Cohen <elic@nvidia.com>; Parav Pandit <parav@nvidia.com>; Si-Wei Liu <si-
> > wei.liu@oracle.com>; Stefano Garzarella <sgarzare@redhat.com>; Wan
> > Jiabing <wanjiabing@vivo.com>; Dan Carpenter
> > <dan.carpenter@oracle.com>; virtualization <virtualization@lists.linux-
> > foundation.org>; linux-kernel <linux-kernel@vger.kernel.org>
> > Subject: RE: [PATCH] vdpa: allow vdpa dev_del management operation to
> > return failure
> >
> > [AMD Official Use Only - General]
> >
> > Hi Gautam:
> > [GD>>] Hi Jason,
> >
> > On Fri, Jun 3, 2022 at 6:34 PM Gautam Dawar <gautam.dawar@amd.com>
> > wrote:
> > >
> > > Currently, the vdpa_nl_cmd_dev_del_set_doit() implementation allows
> > > returning a value to depict the operation status but the return type
> > > of dev_del() callback is void. So, any error while deleting the vdpa
> > > device in the vdpa parent driver can't be returned to the management
> > > layer.
> >
> > I wonder under which cognition we can hit an error in dev_del()?
> > [GD>>] In the AMD-Xilinx vDPA driver, on receiving vdpa device deletion
> > request, I try to identify if the vdpa device is in use by any virtio-net driver
> > (through any vdpa bus driver) by looking at the vdpa device status value. In
> > case the vdpa device status is >= VIRTIO_CONFIG_S_DRIVER, -EBUSY is
> > returned.
> > This is to avoid side-effects as noted in
> > https://bugzilla.kernel.org/show_bug.cgi?id=213179 caused by deleting the
> > vdpa device when it is being used.
> > >
> User should be able to delete the device anytime.

It requires a poll event to user space and then Qemu can release the
vhost-vDPA device. This is how VFIO works. We probably need to
implement something like this.

But notice that, at the worst case, usersapce may not respond to this
event, so there's nothing more kenrel can do execpt for waiting.

We need to consider something different. I used to have an idea to
make vhost-vdpa couple with vDPA loosely with SRCU/RCU. We might
consider implementing that.

> Upper layers who are unable to perform teardown sequence should be fixed.

I think we probably don't need to bother with failing the dev_del().
We can consider to fix/workaround the waiting first.

Thanks

