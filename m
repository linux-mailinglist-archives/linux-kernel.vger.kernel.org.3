Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F284FE349
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356478AbiDLN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356442AbiDLN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:57:38 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20D65C365
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:55:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 3so6284839qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LFvLVPPZvgTha+ooTFHZYTgCdG0ws8rFXkLKQoX43UY=;
        b=FA+rr0NcdFLgw1DDIDpBm6C7a+RJK9x6Q/vYBNaD5r9jvT/GN5T5xXvd5SG17etgIT
         KYCVFlTLhOishU/IXTzUYj5L+xwoUbLM5oJ1110bdHym7a2fhL/Cq6LYTzHMRMPoziYx
         aLyg0LAp2jAYecsyNOugoXyF39CEuxkby2O9NMnY6MN3zclaEjefEylZEK/09uYfplHu
         V1qxdo4nKF1aXGR6q+KSSCcALxSK9gpPM0tkH96DQv5iv9a54llRH/qJgPx+XbzLqTkI
         zdnggLF017XnhD7ubJRX0EF3mkY5BtXD/K+LMXYDZ4ojawcrv6OJCj/gM639Ultgxl2B
         MdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LFvLVPPZvgTha+ooTFHZYTgCdG0ws8rFXkLKQoX43UY=;
        b=b3rMPc4OUL2vCy0rBdkP7KHgeDiYlwIieuOAYVTwPO1c/rAC+2Ut6lTBNATgtqRqCP
         IWY2CHDkVF5rRadeKEpML7zsvO8MQ6Uv+myozsrsxN+OxBi9DeTlexR5Rz+1I1c/5o+d
         whJsKtTbg2+wDXQRCeYUPNj8lxLqnkHhL4pOeR6M3pHXUfi5C2+oGNni3UUeX4uhffep
         JpBCMRt/WEAOvutj9crqaAJQ8tBZDT4DWB8B8z3m9xq5NF5ACm0iiZUaWcKK8VhByemA
         w3c/UNX/Ex6B9Z0ylfS7JU08mF2p7BefEv9GopzyROnjIFaON7mbMt8feJKUb7CV9TP9
         3afg==
X-Gm-Message-State: AOAM532eXk43Mh5k0FcpSh4/sle4T4Z5zs1c5PNI43duHIQrf2HgY7x1
        7nOvWhHlhwXyf7b9BB33Ujx4cg==
X-Google-Smtp-Source: ABdhPJyXnKkmTlbfV6KWPHp27buSH2OPZ0NW3zzuV8rNMnApOKIMVBJ3bSpnwE7Y7amf9XZvhvbU2Q==
X-Received: by 2002:a05:620a:2446:b0:69c:4dfa:b9bf with SMTP id h6-20020a05620a244600b0069c4dfab9bfmr289167qkn.15.1649771719135;
        Tue, 12 Apr 2022 06:55:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u5-20020a05622a198500b002ee933faf83sm4518445qtc.73.2022.04.12.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:55:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1neGzF-000rGH-Rn; Tue, 12 Apr 2022 10:55:17 -0300
Date:   Tue, 12 Apr 2022 10:55:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     alex.williamson@redhat.com, linux-s390@vger.kernel.org,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 16/21] KVM: vfio: add s390x hook to register KVM guest
 designation
Message-ID: <20220412135517.GE64706@ziepe.ca>
References: <20220404174349.58530-1-mjrosato@linux.ibm.com>
 <20220404174349.58530-17-mjrosato@linux.ibm.com>
 <20220408124536.GX64706@ziepe.ca>
 <3639d5fb-ff71-d42e-ef09-0b297f7e1a45@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3639d5fb-ff71-d42e-ef09-0b297f7e1a45@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 09:39:44AM -0400, Matthew Rosato wrote:
> On 4/8/22 8:45 AM, Jason Gunthorpe wrote:
> > On Mon, Apr 04, 2022 at 01:43:44PM -0400, Matthew Rosato wrote:
> > > At the time a KVM is associated with a vfio group, s390x zPCI devices
> > > must register a special guest indication (GISA designation) to allow
> > > for the use of interpretive execution facilities.  This indication is
> > > used to ensure that only the specified KVM can interact with the device.
> > > Similarly, the indication must be removed once the KVM is no longer
> > > associated with the device.
> > > 
> > > This patch adds an s390-specific hook to invoke a KVM registration routine
> > > for each device associated with the iommu group; in reality, it will be a
> > > NOP for all but zPCI devices on s390x.
> > > 
> > > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > >   virt/kvm/vfio.c | 35 ++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > I wonder if this should be done in the vfio_pci side from the existing
> > kvm notifier
> > 
> 
> So you mean rather than hooking into virt as I do here, drive something out
> of drivers/vfio/vfio.c:vfio_group_set_kvm?  Note, the kvm notifier is
> handled in vfio, not vfio_pci, so if you want to handle it in vfio_pci I
> think we'd need to add a new routine to vfio_device_ops and only define it
> vfio_pci for s390

I've been thinking about doing that anyhow, exactly for reasons like
this..

> static const struct vfio_device_ops vfio_pci_ops = {
> 	.name		= "vfio-pci",
> [...]
> #ifdef CONFIG_S390
> 	.set_kvm = vfio_pci_zdev_set_kvm,
> #endif
> };
> 
> and something like...
> 
> void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
> {
> 	struct vfio_device *vdev;
> 	group->kvm = kvm;
> 
> 	mutex_lock(&group->device_lock);
> 	list_for_each_entry(vdev, &group->device_list, group_next) {
> 		if (vdev->ops->set_kvm)
> 			it->ops->set_kvm(vdev, kvm);
> 	}
> 	mutex_unlock(&group->device_lock);

Almost, the device should be open before calling the callback

And you have to inject a callback during open if the device is opened
after the kvm was set.

But I don't think you need to do this, you can just register a
notifier in zpci when it hooks open_device like everything else,
right?

Jason
