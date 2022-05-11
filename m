Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5886152308A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiEKKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiEKKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9736624BF7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652264263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wx81tlJYzO9I2LSOtYxQuG9pIbqu4YEcCflIBnljDbw=;
        b=jFJJeUHtR4K9MTg/5gdRlaitGQY3zIW7Myg3QsFMunibh1MBk+1/cImlbuYKfGz+3NAHAI
        Gk3t6gtAc5FrZT4H37YWUztK5kOdwAT+IdWHmNCcPpzn7hgu/UXlrC9EcqcPGY1ye4hCWu
        gawZugt9YkKlDlBMdaNRn7NPEwTXwcc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-kkLS97WANB-Ui76XQY1s9A-1; Wed, 11 May 2022 06:17:42 -0400
X-MC-Unique: kkLS97WANB-Ui76XQY1s9A-1
Received: by mail-lf1-f70.google.com with SMTP id x36-20020a056512132400b0044b07b24746so640313lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wx81tlJYzO9I2LSOtYxQuG9pIbqu4YEcCflIBnljDbw=;
        b=ybsA0EK71V1ze7SyZ3VVZXTfPM6rLandcER86ej2XmKfokH69UF+MLLFKPQEypUqE/
         Mg/6I1To3Fler0i6qqgPYKViCG/hdCED9PAe8jZcTUije3gj0x178SVIwEH1rw7r7KYk
         o3sOtRxwWJ8VfQCzQYAmzQmkt58XkE42c9WTfd5Gw6TL8CLxxAklPL2LoVQPA3Rx3Ey8
         92BdOjzzaDYY/MJDECApt8Pg5F+RpL7YG27gUzQz0/lOJibRlNb1ZzIcRX/blIRRTb2n
         z3yKW2TIaTKwa9PWB4ZIZuPthBS7T17MMTYTPeYmwjEkBDpGlKcEesRnH+tCs87/Xscc
         ffDA==
X-Gm-Message-State: AOAM532PIdxyEJ7v8DldDRV+TxQzuNlnbtWvlJSS8N6UHW9O3Atxky44
        q45S+JWPp3drPnbQ/HLs9gppDwaDa+bRKZxJVjelBIUKlnvbMAXmJt2+UmEZnp/xJiTfZuWbIJT
        CS5HkluPVZPGgrWGY+g2EoAleShKGtZYBnhutC5fy
X-Received: by 2002:ac2:5f7c:0:b0:472:631e:b443 with SMTP id c28-20020ac25f7c000000b00472631eb443mr19249475lfc.376.1652264260958;
        Wed, 11 May 2022 03:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6s5PADUFZu+j8/vnDQxLW0vNWCpzuS5F6JenYeIUvoxG4H/afD3ZPXC+On/SOMZTz+51G8oW9BWXkBH3Kazk=
X-Received: by 2002:ac2:5f7c:0:b0:472:631e:b443 with SMTP id
 c28-20020ac25f7c000000b00472631eb443mr19249463lfc.376.1652264260762; Wed, 11
 May 2022 03:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220511084804.82482-1-elic@nvidia.com> <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
 <20220511055517-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220511055517-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 18:17:29 +0800
Message-ID: <CACGkMEsDOCnQCxDf=8orCxx+38JgdmYZDUVAnUvbSg-af7wEQQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>,
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

On Wed, May 11, 2022 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, May 11, 2022 at 05:34:25PM +0800, Jason Wang wrote:
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
>
> It's a SHOULD in the spec.  I guess 1280 is to allow IPv6.

Right, I see this.

Thanks

>
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
> >
> > Thanks
>
>
>
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

