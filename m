Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD152335B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiEKMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiEKMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:49:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A835A6222
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:49:47 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BBhI9E032342;
        Wed, 11 May 2022 12:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1PGXnKpwL9pMg8WhOFKAsaQ7qZ1YpzH8fm4i2e6k9/Q=;
 b=l0X6G8vJfhJz2nMjZqDHcLznN9ce/G/4huJN0/ueEe6nigkItrGRBfV1s4CfYWpktTb0
 /BlM7Sr3+cu83ZLuy9atyGn7m9yRGn+uzYRSZoJJW7qGvZVZMl5SV1MtS8jKkDNETWoa
 4u+2g/oqc/r5sBgpX1Q68em903lhVdU4OpA49SXlboLYkjHhipVDqf3hKCRx5amEBCuy
 9kWzcuFREV8eEF012Upov9rbtMw5g9KdL4lgBspqXbhQwdbdv2JxPdm6lqSQASr/sjnE
 tShuAhO8c8O7HDY4JobhIl0cvtk30hJaIUGwKrST+WfK5066fY53sulmVzsqj1wsBYoD cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g09fkcqq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:49:23 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BCbWTW017466;
        Wed, 11 May 2022 12:49:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g09fkcqpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:49:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BCgo0Z009518;
        Wed, 11 May 2022 12:49:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8wg7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:49:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BCnIS937028130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:49:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70BC952050;
        Wed, 11 May 2022 12:49:18 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.152.224.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0D9405204F;
        Wed, 11 May 2022 12:49:18 +0000 (GMT)
Date:   Wed, 11 May 2022 14:49:15 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>, eperezma <eperezma@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
Message-ID: <20220511144915.02efda98.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEt0WdaVCbzeJ9KJuLw273D6KjSOG85RCk675QW3ZxvEsQ@mail.gmail.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
        <20220507071954.14455-9-jasowang@redhat.com>
        <20220510072833-mutt-send-email-mst@kernel.org>
        <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
        <87o804bgrl.fsf@redhat.com>
        <CACGkMEt0WdaVCbzeJ9KJuLw273D6KjSOG85RCk675QW3ZxvEsQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xp4X4iqv_cT9aIe_M_aVP-nbqyDxiCzb
X-Proofpoint-ORIG-GUID: auMKS3LXBZLXOUa2V_ijx9HG9fJJl7Wn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 17:27:44 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On Wed, May 11, 2022 at 4:44 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> >  
> > > On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:  
> > >>
> > >> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:  
> > >> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > >> > index d8a2340f928e..23f1694cdbd5 100644
> > >> > --- a/include/linux/virtio_config.h
> > >> > +++ b/include/linux/virtio_config.h
> > >> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
> > >> >       unsigned status = dev->config->get_status(dev);
> > >> >
> > >> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > >> > +
> > >> > +     /*
> > >> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > >> > +      * will see the driver specific setup if it sees vq->broken
> > >> > +      * as false.
> > >> > +      */
> > >> > +     virtio_synchronize_cbs(dev);  
> > >>
> > >> since you mention vq->broken above, maybe add
> > >>         "set vq->broken to false"  
> > >
> > > Ok.
> > >  
> > >>  
> > >> > +     __virtio_unbreak_device(dev);
> > >> > +     /*
> > >> > +      * The transport is expected ensure the visibility of  
> > >>
> > >> to ensure  
> > >
> > > Will fix.
> > >  
> > >>  
> > >> > +      * vq->broken  
> > >>
> > >> let's add: "visibility by vq callbacks"  
> > >
> > > Sure.
> > >  
> > >>  
> > >> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
> > >> > +      */  
> > >>
> > >>
> > >> Can I see some analysis of existing transports showing
> > >> this is actually the case for them?  
> > >
> > > Yes.
> > >  
> > >> And maybe add a comment near set_status to document the
> > >> requirement.  
> > >
> > > For PCI and MMIO, we can quote the memory-barriers.txt or explain that
> > > wmb() is not needed before the MMIO writel().
> > > For CCW, it looks not obvious, it looks to me the IO was submitted via
> > > __ssch() which has an inline assembly.  Cornelia and Hali, could you
> > > help me to understand if and how did virtio_ccw_set_status() can
> > > ensure the visibility of the previous driver setup and vq->broken
> > > here?  
> >
> > I'm not sure I completely understand the question here, but let me try:  
> 
> It's something like the following case:
> 
> CPU 0: vq->broken = false
> CPU 0: set_status(DRIVER_OK)
> CPU 1: vring_interrupt() { if (vq->broken) return IRQ_NONE; }
> 
> We need to make sure the CPU 1 sees the vq->broken if the interrupt is
> raised after DRVER_OK.
> 
> For PCI, we use MMIO of writel() for set_status(), a wmb() is not
> needed in this case according to memory-barriers.txt.
> 
> "
> Note that, when using writel(), a prior
> wmb() is not needed to guarantee that the cache coherent memory writes
> have completed before writing to the MMIO region.
> "


IMHO the key facts here are the following:
* ssch and all other I/O instructions are serializing instructions
* all interruptions are serializing operations 

For reference see
https://www.ibm.com/resources/publications/OutputPubsDetails?PubID=SA22783213
page 5-138.


Maybe we should add that to the linux documentation somewhere if
not already mentioned.

So IMHO we don't need CPU0 to do a wmb() because of the ssch.

> 
> So CPU 1 will see the broken as false.

But barriers need to be paired. And in my understanding the ssch
doesn't really ensure that CPU1 is about to see the change, unless
there is a suitable barrier that pairs with the barrier implied
the ssch instruction.

Assumed vring_interrupt() is always done in hard-irq context, AFAIU,
we should be fine. Is that assumption correct?

Why are we fine:
* Either the ssch was performed before the interrupt for
  vring_interrupt() got delivered on CPU1, and then we are guaranteed to
  see the updated value for vq->broken,
* or the interrupt that triggered vring_interrupt() was delivered before
  the ssch instruction got executed. But in this case it is fine to
  ignore the notification, because this is actually the bad case
  we want to guard against: we got a notification when
  notifications are not allowed.

We may end up with !vq->broken and !DEVICE_OK as well, but that should
be fine because, although that notification would be a should not happen
one, I understand it would not catch us with our pants down.

Regards,
Halil


> 
> >
> > virtio_ccw_set_status() uses a channel command to set the status, with
> > the interesting stuff done inside ccw_io_helper(). That function
> > - takes the subchannel lock, disabling interrupts  
> 
> Then it is, for x86 the operation to disable interrupt is a full
> barrier. I guess this should apply to other architecture like s390. I
> see a stnsm is used in this case but a quick google doesn't tell me if
> it's a barrier.
> If this is true. The vring_interrupt will see broken as false.
> 
> > - does the ssch; this instruction will fail if there's already another
> >   I/O in progress, or an interrupt is pending for the subchannel; on
> >   success, it is guaranteed that we'll get an interrupt eventually  
> 
> I guess ssch might imply a barrier as well, otherwise we may need a
> lot of barriers before this.
> 
> Thanks
> 
> > - unlock the subchannel, and wait for the interupt handler to eventually
> >   process the interrupt, so I guess it should see the vq->broken value?
> >
> > If the I/O fails, virtio_ccw_set_status() will revert its internal
> > status to the old value.
> >
> >  
> > >
> > > Thanks
> > >  
> > >>  
> > >> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > >> >  }  
> >  
> 

