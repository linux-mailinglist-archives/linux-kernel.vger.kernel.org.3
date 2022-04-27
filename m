Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93001510E69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357030AbiD0CCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357026AbiD0CCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C01D5175DF3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651024763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sVNLxT/zHEaMt8P7fI0boe7g3Ldt0xcsRU5f4SMRwcM=;
        b=g5ZF5l/RdIy99QrKLrEIkfH5ffuoQFeggFEfg1qoCDwh+cihl1uGAy9mYL7WyWm02JMFwJ
        KOG8XrTJjtP239MXQSZAIOIZBNAV7RLTJmEHmQV24pO3ZO8j5D4jp1tAVbyD15eQwmtL7j
        VY7+YE/aFEyGcW0Fd5WjJ1WB2L6HxNQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-_389r1ygNPuIJDjLKUz7CQ-1; Tue, 26 Apr 2022 21:59:22 -0400
X-MC-Unique: _389r1ygNPuIJDjLKUz7CQ-1
Received: by mail-ed1-f72.google.com with SMTP id eg38-20020a05640228a600b00425d61d0302so164023edb.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVNLxT/zHEaMt8P7fI0boe7g3Ldt0xcsRU5f4SMRwcM=;
        b=LZG+914tT/G3TnLlA46KJioO24LLSOQu2nU11mn7b2ealZGxDSNd5uIumjMOZXxtlD
         GibuE26vGkb2LIg4iVx4z1PXmbVLhK1LloIrRpQEJYjQMWtF6j9KZfuZEryCu26i9m5s
         C0X3PJZoBMe+sMlASbCh26i0QqRACXK3kZveY3GGDSs6bW7YKEvYqmQvf3Zz5+l3do1X
         jWYgN0bfCL2sp7J59kMwCQQzBbchnsjE8f1tfyN/WAGSNUB67svgALWFtVMbdI4nYFJp
         IbDWvZjyz3PhKlKBP2sK04T849ssJBPC3Q67iTDs1nivBMC1s45Fb4ayCFjXhQOcIf6s
         w0rg==
X-Gm-Message-State: AOAM5331ztoHWfb/XW/EC1+tfAP6x9Aq20imR47QvbQLQGW8pdDoP+2U
        sIFH8xCScgkuMWnwvO5Yz4aL+atsnazalrim5V17jK5wXjpL4dJox53jE2oFQQusDIKRi2WBpRa
        ovDxjPxYvU5SqnN5f/r9ybe5+71UH3hECCddzDWi4
X-Received: by 2002:a17:907:97cc:b0:6df:83bc:314c with SMTP id js12-20020a17090797cc00b006df83bc314cmr24251607ejc.587.1651024760709;
        Tue, 26 Apr 2022 18:59:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQoN9SjyBgsfD9IE3Ztqsl2vBRS6Enk3TvvOOK3BJ5ng4yPnLCWFgpWA075dU1bF4CmXogJwO+InnJthtYzfk=
X-Received: by 2002:a17:907:97cc:b0:6df:83bc:314c with SMTP id
 js12-20020a17090797cc00b006df83bc314cmr24251603ejc.587.1651024760530; Tue, 26
 Apr 2022 18:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220425062735.172576-2-lulu@redhat.com> <CACGkMEtGZqoei6i=LmVrTgNfWM4SpxjQH-8j7BP=EoFO=iqeYw@mail.gmail.com>
In-Reply-To: <CACGkMEtGZqoei6i=LmVrTgNfWM4SpxjQH-8j7BP=EoFO=iqeYw@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Wed, 27 Apr 2022 09:58:41 +0800
Message-ID: <CACLfguUmEEdJzPTsR9h-N=rVa4ktT8s6=aBsJ_MdRRy24LRyMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 2:05 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Apr 25, 2022 at 2:27 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > this patch is to add the support for vdpa tool in vp_vdpa
> > here is the example steps
> >
> > modprobe vp_vdpa
> > modprobe vhost_vdpa
> > echo 0000:00:06.0>/sys/bus/pci/drivers/virtio-pci/unbind
> > echo 1af4 1041 > /sys/bus/pci/drivers/vp-vdpa/new_id
> >
> > vdpa dev add name vdpa1 mgmtdev pci/0000:00:06.0
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 138 +++++++++++++++++++++++-------
> >  1 file changed, 106 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index cce101e6a940..873402977543 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -32,7 +32,8 @@ struct vp_vring {
> >
> >  struct vp_vdpa {
> >         struct vdpa_device vdpa;
> > -       struct virtio_pci_modern_device mdev;
> > +       /* this is an pointer point to the mdev in vp_vdpa_mgmtdev*/
> > +       struct virtio_pci_modern_device *mdev;
>
> The code can explain itself, so the comment is redundant.
>
sure wll remove this.
> >         struct vp_vring *vring;
> >         struct vdpa_callback config_cb;
> >         char msix_name[VP_VDPA_NAME_SIZE];
> > @@ -41,6 +42,12 @@ struct vp_vdpa {
> >         int vectors;
> >  };
> >
> > +struct vp_vdpa_mgmtdev {
> > +       struct vdpa_mgmt_dev mgtdev;
> > +       struct virtio_pci_modern_device mdev;
>
> I think coupling it with mgmt device is probably not good, any reason
> we can't allocate it independently?
>
yes I also think it make code confused,  but we need to init  it in
static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
and then  pass it to
static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
   const struct vdpa_dev_set_config *add_config)
the only struct we can use is struct vdpa_mgmt_dev *v_mdev,  not sure
if we have
some better choice ?

> Thanks
>
> > +       struct vp_vdpa *vp_vdpa;
> > +};
>

