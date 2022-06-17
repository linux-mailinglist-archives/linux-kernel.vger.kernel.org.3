Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADB154EF86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiFQDPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiFQDPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD2C732070
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655435705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zyXdUs74Sn1gokvnhKFxRwfNZUQVkLFJThbXXT8GKOo=;
        b=FpGlBWWrV1qfjPPvo3gQvmv/oFAqtoyoS3Tv/qymj6piv4j491bd+Gxqtnge8Y/tdiW/zN
        32KSs9k0pSkFFkt6Yo4LDJpkVwy9Krap/TWNZaw/1yJvDc0aMvbdBPzMNTBCs+osV+y+Sh
        QtQ/be8q4276AvwQDpIBv6WOljpBWX0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-Vqv8WMDGMLWce811vrlarA-1; Thu, 16 Jun 2022 23:15:03 -0400
X-MC-Unique: Vqv8WMDGMLWce811vrlarA-1
Received: by mail-lf1-f72.google.com with SMTP id f32-20020a0565123b2000b004791bf1af10so1690620lfv.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyXdUs74Sn1gokvnhKFxRwfNZUQVkLFJThbXXT8GKOo=;
        b=5GOtVVogV+ZjNP1E8xyTRDj0+8WRyjbqoZfa9CYJfoIfuf28fXAqVYis2Qgk+8g4VX
         bsNapR0/Fkkr7HzQQy9WjnZiRqHj/Uzqu91157BH/KcP+C+d79/iIPSoX+g4qzG33wiD
         M6I4r9l+wZ7GzYTLySDCSmoLwyHTt29d8H06t/L078ad5wLCvuOkmwn7e/JHQJSdk2wZ
         CIvb1rfEgE4RNqHU7jHdxrjL09kS1ne5AbxHPik2h0v3UHzX/Mrojhm2P1OYhXso+LSt
         1WCLbxU/UcJbUn57m+gA4CSeyVHY04MTpXC4E1S3Q/Bzt3Qu7uzZ+1GDF+pGA2D09K+N
         dgdQ==
X-Gm-Message-State: AJIora8I0qvhWqW/vgLzfuqgjL04B0SD2rRHTn1M1XK3k9VwVLo1D6A1
        A+99ffzbi58OyNG+/UYGXS3Y/1PaKEYB/vgMBHZTWyAGid8krYsTnLFV0KX5gRylVdC8yhkDvbf
        SDiEDR3okV9gWL7uvTGKrLe3xLs6g+c1Ld6S3xjLz
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id m18-20020a194352000000b0047905d13fefmr4339512lfj.411.1655435701800;
        Thu, 16 Jun 2022 20:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrhZSavPJtlgCcYBizs4v7LLbX7WbLjH0ir+NVgTVj79Hn7OdCFvYsSXLKV5EDBsPKindEevKRIpCVFBpp9dE=
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr4339489lfj.411.1655435701522; Thu, 16
 Jun 2022 20:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEs05ZisiPW+7H6Omp80MzmZWZCpc1mf5Vd99C3H-KUtgA@mail.gmail.com>
 <20220613041416-mutt-send-email-mst@kernel.org> <CACGkMEsT_fWdPxN1cTWOX=vu-ntp3Xo4j46-ZKALeSXr7DmJFQ@mail.gmail.com>
 <20220613045606-mutt-send-email-mst@kernel.org> <CACGkMEtAQck7Nr6SP_pD0MGT3njnwZSyT=xPyYzUU3c5GNNM_w@mail.gmail.com>
 <CACGkMEvUFJkC=mnvL2PSH6-3RMcJUk84f-9X46JVcj2vTAr4SQ@mail.gmail.com>
 <20220613052644-mutt-send-email-mst@kernel.org> <CACGkMEstGvhETXThuwO+tLVBuRgQb8uC_6DdAM8ZxOi5UKBRbg@mail.gmail.com>
 <Yqi7UhasBDPKCpuV@e120937-lin> <CACGkMEv2A7ZHQTrdg9H=xZScAf2DE=Dguaz60ykd4KQGNLrn2Q@mail.gmail.com>
 <YqojyHuocSoZ0v/Y@e120937-lin>
In-Reply-To: <YqojyHuocSoZ0v/Y@e120937-lin>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 17 Jun 2022 11:14:50 +0800
Message-ID: <CACGkMEsdhCx8mmGn+axjM-+Psep4jVN2zzbBQhjW3y6gvHXxXQ@mail.gmail.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, conghui.chen@intel.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        netdev <netdev@vger.kernel.org>, pankaj.gupta.linux@gmail.com,
        sudeep.holla@arm.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 2:24 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Wed, Jun 15, 2022 at 09:41:18AM +0800, Jason Wang wrote:
> > On Wed, Jun 15, 2022 at 12:46 AM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
>
> Hi Jason,
>
> > >
> > > On Tue, Jun 14, 2022 at 03:40:21PM +0800, Jason Wang wrote:
> > > > On Mon, Jun 13, 2022 at 5:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > >
>
> [snip]
>
> > > >
> > > > >  arm_scmi
> > > >
> > > > It looks to me the singleton device could be used by SCMI immediately after
> > > >
> > > >         /* Ensure initialized scmi_vdev is visible */
> > > >         smp_store_mb(scmi_vdev, vdev);
> > > >
> > > > So we probably need to do virtio_device_ready() before that. It has an
> > > > optional rx queue but the filling is done after the above assignment,
> > > > so it's safe. And the callback looks safe is a callback is triggered
> > > > after virtio_device_ready() buy before the above assignment.
> > > >
> > >
> > > I wanted to give it a go at this series testing it on the context of
> > > SCMI but it does not apply
> > >
> > > - not on a v5.18:
> > >
> > > 17:33 $ git rebase -i v5.18
> > > 17:33 $ git am ./v6_20220527_jasowang_rework_on_the_irq_hardening_of_virtio.mbx
> > > Applying: virtio: use virtio_device_ready() in virtio_device_restore()
> > > Applying: virtio: use virtio_reset_device() when possible
> > > Applying: virtio: introduce config op to synchronize vring callbacks
> > > Applying: virtio-pci: implement synchronize_cbs()
> > > Applying: virtio-mmio: implement synchronize_cbs()
> > > error: patch failed: drivers/virtio/virtio_mmio.c:345
> > > error: drivers/virtio/virtio_mmio.c: patch does not apply
> > > Patch failed at 0005 virtio-mmio: implement synchronize_cbs()
> > >
> > > - neither on a v5.19-rc2:
> > >
> > > 17:33 $ git rebase -i v5.19-rc2
> > > 17:35 $ git am ./v6_20220527_jasowang_rework_on_the_irq_hardening_of_virtio.mbx
> > > Applying: virtio: use virtio_device_ready() in virtio_device_restore()
> > > error: patch failed: drivers/virtio/virtio.c:526
> > > error: drivers/virtio/virtio.c: patch does not apply
> > > Patch failed at 0001 virtio: use virtio_device_ready() in
> > > virtio_device_restore()
> > > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > > When you have resolved this problem, run "git am --continue".
> > >
> > > ... what I should take as base ?
> >
> > It should have already been included in rc2, so there's no need to
> > apply patch manually.
> >
>
> I tested this series as included in v5.19-rc2 (WITHOUT adding a virtio_device_ready
> in SCMI virtio as you mentioned above ... if I got it right) and I have NOT seen any
> issue around SCMI virtio using my usual test setup (using both SCMI vqueues).
>
> No anomalies even when using SCMI virtio in atomic/polling mode.
>
> Adding a virtio_device_ready() at the end of the SCMI virtio probe()
> works fine either, it does not make any difference in my setup.
> (both using QEMU and kvmtool with this latter NOT supporting
>  virtio_V1...not sure if it makes a difference but I thought was worth
>  mentioning)

Thanks a lot for the testing.

We want to prevent malicious hypervisors from attacking us. So more questions:

Assuming we do:

virtio_device_ready();
/* Ensure initialized scmi_vdev is visible */
smp_store_mb(scmi_vdev, vdev);

This means we allow the callbacks (scmi_vio_complete) to be called
before smp_store_mb(). We need to make sure the callbacks are robust.
And this looks fine since we have the check of
scmi_vio_channel_acquire() and if the notification is called before
smp_store_mb(), the acquire will fail.

If we put virtio_device_ready() after smp_store_mb() like:

/* Ensure initialized scmi_vdev is visible */
smp_store_mb(scmi_vdev, vdev);
virtio_device_ready();

If I understand correctly, there will be a race since the SCMI may try
to use the device before virtio_device_ready(), this violates the
virtio spec somehow.

Thanks

>
> Thanks,
> Cristian
>

