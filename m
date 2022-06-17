Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2259C54EEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379476AbiFQBPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379466AbiFQBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB6B96162E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655428534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qj6jImPewXvPaBqVDCu6KZmly2mSua8Ga/tEmjDhDBg=;
        b=L/X8cVsyM/uwQn3/aEL5dbDB3t1xZsFjM/jQlTUHWehC3mctC9H5cT4En8Zt9Vdg0QB5Ua
        jPrp0f/kFJkNDMcd78vK7neTqSNikwZIxI8y8vb2TbcZDqiqNPNN4MHpiOyJ/u/h1jZb2H
        itm7rSXKrq9MKoh9nefBImT0W7/pF1Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-XMmEZ8X-MBKqjrq5d-5lmA-1; Thu, 16 Jun 2022 21:15:33 -0400
X-MC-Unique: XMmEZ8X-MBKqjrq5d-5lmA-1
Received: by mail-lf1-f69.google.com with SMTP id d37-20020a0565123d2500b0047c62294e85so1574874lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qj6jImPewXvPaBqVDCu6KZmly2mSua8Ga/tEmjDhDBg=;
        b=iotmQw7dt0hRMvmxsCtjQnpKgXc3B94VJ9AM/r8cu2fjW5HTgSMCpEtKbNiVweokGL
         K78a8yaOjSIDg2jQ5gyIKSM349wVzVgjTdFY+wxVYZpYOkb5nYXVmf3fRWiTEhM6cipg
         0SXSwn+vWkV3+3uJMpdN4OZtJIAbbFuvOV6q0tpHkCD6sCW+Hz66Jal9ubuVQudGf4L3
         uuftQzxM2+oeAVzt6+EkVXC3mVPNjFsuYj7fxPjScLuxbr7+sbWMuX5SQGAi/1o8IgWM
         sJzkRT54oqWU6fyqjPSSy1hw3QAVqiwnM+MjUxtfyTC0SzuEMG542oTV28XARbxtcObm
         WHzg==
X-Gm-Message-State: AJIora8BpoIo7JhHufVJKHpDO2NCQECz6YXRpDNmsTr8Tk/CUT8mwhQh
        SKTV/paQbPZTqURdWQLQUdqpGR9xrClra1Pf+YWipaa+tJ1ckmSnW9aNttVhGptS9prekR0+WdC
        jpY9RRVbxFP8++kgiE23cJXGH0m7SX47Yf18BmdJW
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id m15-20020a0565120a8f00b0047963e5d59fmr4266511lfu.124.1655428531124;
        Thu, 16 Jun 2022 18:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tVLEwZlQ5b3n2hD9EvzjMdrwv7jEBRqw/ihfRAuZxBUVL8mY4ADtDpm6/g+7FS+TtENdDl8nkcM5M830HVPM4=
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id
 m15-20020a0565120a8f00b0047963e5d59fmr4266484lfu.124.1655428530874; Thu, 16
 Jun 2022 18:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220526124338.36247-1-eperezma@redhat.com> <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org> <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
 <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
 <PH0PR12MB5481D099A324C91DAF01259BDCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEueG76L8H+F70D=T5kjK_+J68ARNQmQQo51rq3CfcOdRA@mail.gmail.com>
 <PH0PR12MB5481994AF05D3B4999EC1F0EDCAD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtRTyymit=Zmwwcq0jNan-_C9p70vcLP0g7XmwQiOjUbw@mail.gmail.com> <PH0PR12MB548104990A5544C738A5A95BDCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548104990A5544C738A5A95BDCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Jun 2022 09:15:19 +0800
Message-ID: <CACGkMEtytpnCdWdmSh-BuFGXt55DJ9dYxnbw7JQwMXi9bQ8fvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
To:     Parav Pandit <parav@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 3:36 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, June 14, 2022 9:29 PM
> >
> > Well, it's an example of how vDPA is implemented. I think we agree that=
 for
> > vDPA, vendors have the flexibility to implement their perferrable datap=
ath.
> >
> Yes for the vdpa level and for the virtio level.
>
> > >
> > > I remember few months back, you acked in the weekly meeting that TC h=
as
> > approved the AQ direction.
> > > And we are still in this circle of debating the AQ.
> >
> > I think not. Just to make sure we are on the same page, the proposal he=
re is
> > for vDPA, and hope it can provide forward compatibility to virtio. So i=
n the
> > context of vDPA, admin virtqueue is not a must.
> In context of vdpa over virtio, an efficient transport interface is neede=
d.
> If AQ is not much any other interface such as hundreds to thousands of re=
gisters is not must either.
>
> AQ is one interface proposed with multiple benefits.
> I haven=E2=80=99t seen any other alternatives that delivers all the benef=
its.
> Only one I have seen is synchronous config registers.
>
> If you let vendors progress, handful of sensible interfaces can exist, ea=
ch with different characteristics.
> How would we proceed from here?

I'm pretty fine with having admin virtqueue in the virtio spec. If you
remember, I've even submitted a proposal to use admin virtqueue as a
transport last year.

Let's just proceed in the virtio-dev list.

Thanks

