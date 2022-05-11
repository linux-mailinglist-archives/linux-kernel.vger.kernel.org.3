Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C6523020
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiEKJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiEKJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 607191BDDAB
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652263137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FfW+5+mV9G3R406B7MYW3KSbtguNpvUzxhTqvODpUM=;
        b=ZOtWHvU3RZSxWVK6gFe1gO/OyjQ0RPHbuerN0AhOmw2afPYfRUe+yU0H4r3Pu8w6ZPRsrs
        7EeUH27XXbmsVOyq3d0nYLRISPFPWHY2oKhqZdkfw4BSjg3Nacp5qK5DHBuQxTPhbSfXcG
        4mVJHxx1j/5OTpLjvr3uISQFr8CO7u8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-4EHkJGt0ONuDY4tsUoHtXg-1; Wed, 11 May 2022 05:58:56 -0400
X-MC-Unique: 4EHkJGt0ONuDY4tsUoHtXg-1
Received: by mail-wm1-f72.google.com with SMTP id i18-20020a1c5412000000b0039491a8298cso545117wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+FfW+5+mV9G3R406B7MYW3KSbtguNpvUzxhTqvODpUM=;
        b=27B/PlITrl9lJvVtd5on7OVUNN5KD1u93yszlAVmvzK3l22jY+mzaQiXA9AQ0rBdDb
         Zig8n5aChau5qZpmaPfQ6syQQLEPGXzAfJPE99Fsbdvj9VfYBT6aODP7+ZyTET8opD41
         0qqihYPnH95jG5kzPJ1Kfqv1w27lxdCbcIzrVrBbnL3OXQG9LDOK7DuX7zE2GDAxgPAl
         qB3CLLQKZEri41GOKeC09E3LXsVMR/zjpYnQ5b6d1XBBT2pK/TgIgM2kcKLEqSD/mta0
         Zy3680uM/TAmPbfCDHVyqZ9/Y+CYQ2d3dHakoeW8Q4CoeyTAQ+ODFMIGtplOjr6CIPUy
         eZkw==
X-Gm-Message-State: AOAM533kP4w9Yz2D2H9hp8LO0rqTKGeBXMgY9GNIOWh1BOCvsyY1UNZu
        DbzKF0pVZoSKfqvUKApM89rtd0O8FuFIpi4p5lH1oMWoA0JqzpJU2OlvOEewakirYUsXPuHnGrb
        A/RN/H+egyXR2ZyhAPFkJ81A0
X-Received: by 2002:a5d:4252:0:b0:20c:6ffc:77b1 with SMTP id s18-20020a5d4252000000b0020c6ffc77b1mr21611675wrr.483.1652263134984;
        Wed, 11 May 2022 02:58:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy4NKG8oWbkw7DrLO4G0kGqLd8SWY59yELzw8BfqPhBBDOczYpic50262Syt6xWWlxXlPvgQ==
X-Received: by 2002:a5d:4252:0:b0:20c:6ffc:77b1 with SMTP id s18-20020a5d4252000000b0020c6ffc77b1mr21611657wrr.483.1652263134635;
        Wed, 11 May 2022 02:58:54 -0700 (PDT)
Received: from redhat.com ([2a10:8004:5a99:0:647:dca8:57e:1626])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003942a244f40sm5437292wms.25.2022.05.11.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:58:54 -0700 (PDT)
Date:   Wed, 11 May 2022 05:58:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
Message-ID: <20220511055517-mutt-send-email-mst@kernel.org>
References: <20220511084804.82482-1-elic@nvidia.com>
 <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:34:25PM +0800, Jason Wang wrote:
> On Wed, May 11, 2022 at 4:48 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > Following the recommendation in virio spec 1.1, a device offering
> > VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
> >
> > Print a warning if this recommendation is not met.
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> 
> I wonder why it's a must?


It's a SHOULD in the spec.  I guess 1280 is to allow IPv6.

> > ---
> >  drivers/vdpa/vdpa.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 91f4c13c7c7c..961168fe9094 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
> >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> >
> > +/* Recommended virtio spec 1.1 section 5.1.4.1 */
> > +#define VIRTIO_MIN_PREFERRED_MTU 1280
> > +
> >  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
> >  {
> >         struct vdpa_dev_set_config config = {};
> > @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
> >                 err = PTR_ERR(mdev);
> >                 goto err;
> >         }
> > +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> > +           (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> > +           config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> 
> Should be <= ?
> 
> Thanks



> > +               pr_warn("MTU is below recommended value\n");
> >         if ((config.mask & mdev->config_attr_mask) != config.mask) {
> >                 NL_SET_ERR_MSG_MOD(info->extack,
> >                                    "All provided attributes are not supported");
> > @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> >         [VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> >         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> >         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > -       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> > +       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
> >  };
> >
> >  static const struct genl_ops vdpa_nl_ops[] = {
> > --
> > 2.35.1
> >

