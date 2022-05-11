Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1105E523094
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiEKKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiEKKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E997927B20
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652264344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9TokjqGxY4QglqVSG22lCcz992Q8/mhNfdXjbidjQY=;
        b=f+Tpx7MxiDaEShnzaHxqO1TC6nRNbIcpjSYbxz7B0pjBPpyNErRYSAcQ0JiDCHzey9CNQk
        EQWtkG4zp7dd2G+I3SW46oU8VlZWOa0A82uD1TPkbkJYsMESQrgkH2gcYD0AzzHcXpoeVe
        8tgU/3kydBFa3dPM2Eib1yda3FLpjUQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-pazxRdx2Onm_AL_cbg4hrQ-1; Wed, 11 May 2022 06:19:00 -0400
X-MC-Unique: pazxRdx2Onm_AL_cbg4hrQ-1
Received: by mail-lj1-f200.google.com with SMTP id j20-20020a2e8014000000b00250baa159ceso563095ljg.18
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9TokjqGxY4QglqVSG22lCcz992Q8/mhNfdXjbidjQY=;
        b=NmFZbOIJzxEDbfHKxzvPkuUi6Lx+UY0SFUWpql40DFQqr+lyTjndSFV/pgcVX/XFLC
         VM4RzSWQ/3tGn37Ls+KVlCCa3UW+FQdprnyPYIz1vDfwqy6vGYB+lHxb3d1Y7/DF8in4
         0DTwe1F/zYazok2pkop/5T+2z51w+dl1RNsssykmFBwjx8dRAjg79YQkOhLVQM3/EtrM
         +3dDKJ/hBDY3RXmPKOzAYbvZMdmThY4bIt+0lQ8/jRsggom/X4roNp2mQyqsgOjKVako
         0MSjVPonYUKsD64SR2DYO1xIEyY166Tx6cvGYI3G/or6pb2KwXqT2YGb+q2RNsKQfqnW
         +uog==
X-Gm-Message-State: AOAM533msMWLvSfQDgUpJ53E+jUNzNf/KDh3yn0GeJhsPrWoO/KVa+dP
        fH1kirU6/Ci8wuNDZ0R84gAyLkSovusyc1A1LaJyGRmP807lwOP9IAhmMQcl67fm3EUwIMcWTwn
        hWUs3i/RQxoIh9dH2ZoWxZnuo9vkf6oUrCkjwf21y
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr19246461lfj.587.1652264338806;
        Wed, 11 May 2022 03:18:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpTOzDD2FjkHJo7T/BkCX3Znv1KFmNfUN5fbbXVEW4lzoNdcuck5WMwc/riTdg+4v9YGqWsKE8nVG1ZhNoKRw=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr19246452lfj.587.1652264338607; Wed, 11
 May 2022 03:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511084804.82482-1-elic@nvidia.com> <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
 <DM8PR12MB5400BC33A5ABD2FCBD0CA852ABC89@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400BC33A5ABD2FCBD0CA852ABC89@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 18:18:47 +0800
Message-ID: <CACGkMEvTTyT=RFp3aAL+8XcL229Fw=pW9_7zNntrUViriUHuNw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 6:02 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, May 11, 2022 12:34 PM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-kernel <linux-kernel@vger.kernel.org>; Si-
> > Wei Liu <si-wei.liu@oracle.com>
> > Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
> >
> > On Wed, May 11, 2022 at 4:48 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Following the recommendation in virio spec 1.1, a device offering
> > > VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
> > >
> > > Print a warning if this recommendation is not met.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> >
> > I wonder why it's a must?
>
> It's definitely not a must but I thought if the spec says "should" it deserves a warning

Right.

> but we can drop this if you think the warning is not in place.

I remember netlink has an extra log buffer, I wonder if it's better to
warn there?

>
> >
> > > ---
> > >  drivers/vdpa/vdpa.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 91f4c13c7c7c..961168fe9094 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> > >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
> > >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> > >
> > > +/* Recommended virtio spec 1.1 section 5.1.4.1 */
> > > +#define VIRTIO_MIN_PREFERRED_MTU 1280
> > > +
> > >  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
> > >  {
> > >         struct vdpa_dev_set_config config = {};
> > > @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
> > >                 err = PTR_ERR(mdev);
> > >                 goto err;
> > >         }
> > > +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> > > +           (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> > > +           config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> >
> > Should be <= ?
>
> I don't think so. If it equals 1280 you don't want to warn.

Yes, you're right.

Thanks

>
> >
> > Thanks
> >
> > > +               pr_warn("MTU is below recommended value\n");
> > >         if ((config.mask & mdev->config_attr_mask) != config.mask) {
> > >                 NL_SET_ERR_MSG_MOD(info->extack,
> > >                                    "All provided attributes are not supported");
> > > @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> > >         [VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> > >         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> > >         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > > -       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> > > +       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
> > >  };
> > >
> > >  static const struct genl_ops vdpa_nl_ops[] = {
> > > --
> > > 2.35.1
> > >
>

