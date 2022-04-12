Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7194FC90B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiDLAEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 20:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiDLAEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:04:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6512ED42
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:02:29 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BNicXa024777;
        Tue, 12 Apr 2022 00:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ymhm3gWLFUXXkn5483f/1Rx+YzD94Ie5+Dy9QnMA8pY=;
 b=nMj6Kj2t1b92u0VcCmR6oYCfajpyNsrxYFqMKOSUcbx0EbCBtvtMoNvVxmcjcDCImz5b
 Knyqm9f97FyI7AMfZgI4b4kcQt1lsS+NvtplK1x0TipnVcjSO/sDyaNQzqUnUYtMc3yp
 Losyt5avJAMTUssB1+JIYAoTUOCav761xOdnF1cAibWL56zJ0UZpDEnxVfqDAk6wceWA
 aoxJQDPOmXHqCGFoZvvnvWXU2ntwerzFXWvL9JOon7Hbxm7pQgsh43qIN2VvK6YHOmuO
 XOwzWhrOnAx8CD+j+BKpgG/g2OAyX4uM4xRzZ0Vm4jdGSSUbfJyoaB2OCiij5D7QTPlu dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fcx9987ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 00:02:05 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23BNnExM003563;
        Tue, 12 Apr 2022 00:02:04 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fcx9987p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 00:02:04 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23BNrv2L030620;
        Tue, 12 Apr 2022 00:02:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3fb1dj3v9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 00:02:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23C020kV24248614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 00:02:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8251A11C050;
        Tue, 12 Apr 2022 00:02:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C11AC11C04A;
        Tue, 12 Apr 2022 00:01:59 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.66.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 12 Apr 2022 00:01:59 +0000 (GMT)
Date:   Tue, 12 Apr 2022 02:01:45 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220412020145.32e26e5a.pasic@linux.ibm.com>
In-Reply-To: <877d7vbspu.fsf@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
        <20220406083538.16274-5-jasowang@redhat.com>
        <20220406075952-mutt-send-email-mst@kernel.org>
        <87wng2e527.fsf@redhat.com>
        <20220408150307.24b6b99f.pasic@linux.ibm.com>
        <20220410034556-mutt-send-email-mst@kernel.org>
        <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
        <877d7vbspu.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1bvXk22wNw3YGkUdJsgQgRpdAVK_Flry
X-Proofpoint-ORIG-GUID: 0h2qVqskP8RMF8-85NvyW9SJF_9wzeKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_09,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 16:27:41 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, Apr 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> 
> > On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:  
> >>
> >> On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:  
> >> > On Wed, 06 Apr 2022 15:04:32 +0200
> >> > Cornelia Huck <cohuck@redhat.com> wrote:
> >> >  
> >> > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > >  
> >> > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:  
> >> > > >> This patch implements PCI version of synchronize_vqs().
> >> > > >>
> >> > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> > > >> Cc: Marc Zyngier <maz@kernel.org>
> >> > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> >> > > >
> >> > > > Please add implementations at least for ccw and mmio.  
> >> > >
> >> > > I'm not sure what (if anything) can/should be done for ccw...  
> >> >
> >> > If nothing needs to be done I would like to have at least a comment in
> >> > the code that explains why. So that somebody who reads the code
> >> > doesn't wonder: why is virtio-ccw not implementing that callback.  
> >>
> >> Right.
> >>
> >> I am currently thinking instead of making this optional in the
> >> core we should make it mandatory, and have transports which do not
> >> need to sync have an empty stub with documentation explaining why.  
> 
> Yes, that makes sense to me. If we can explain why we don't need to do
> anything, we should keep that explanation easily accessible.
> 
> >>
> >> Also, do we want to document this sync is explicitly for irq enable/disable?
> >> synchronize_irq_enable_disable?  
> >
> > I would not since the transport is not guaranteed to use an interrupt
> > for callbacks.
> >  
> >>
> >>  
> >> > >  
> >> > > >  
> >> > > >> ---
> >> > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> >> > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> >> > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> >> > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> >> > > >>  4 files changed, 19 insertions(+)
> >> > > >>
> >> > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> > > >> index d724f676608b..b78c8bc93a97 100644
> >> > > >> --- a/drivers/virtio/virtio_pci_common.c
> >> > > >> +++ b/drivers/virtio/virtio_pci_common.c
> >> > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >> > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >> > > >>  }
> >> > > >>
> >> > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> >> > > >> +{
> >> > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> > > >> +        int i;
> >> > > >> +
> >> > > >> +        if (vp_dev->intx_enabled) {
> >> > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> >> > > >> +                return;
> >> > > >> +        }
> >> > > >> +
> >> > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
> >> > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >> > > >> +}
> >> > > >> +  
> >> > >
> >> > > ...given that this seems to synchronize threaded interrupt handlers?
> >> > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> >> > > 'irq' for channel devices anyway, and the handler just calls the
> >> > > relevant callbacks directly.)  
> >> >
> >> > Sorry I don't understand enough yet. A more verbose documentation on
> >> > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> >> > surely benefit me. It may be more than enough for a back-belt but it
> >> > ain't enough for me to tell what is the callback supposed to accomplish.  
> 
> +1 for more explanations.
> 
> >> >
> >> > I will have to study this discussion and the code more thoroughly.
> >> > Tentatively I side with Jason and Michael in a sense, that I don't
> >> > believe virtio-ccw is safe against rough interrupts.  
> >
> > That's my feeling as well.  
> 
> I'd say ccw is safe against "notification interrupts before indicators
> have been registered".

I believe Jason's scope is broader than that. Let me try to explain. A
quote form the standard:
"""
3.1.1 Driver Requirements: Device Initialization
The driver MUST follow this sequence to initialize a device: 
    1. Reset the device. 
    2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device. 
    3. Set the DRIVER status bit: the guest OS knows how to drive the device. 
    4. Read device feature bits, and write the subset of feature bits understood by the OS and driver to the device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it. 
    5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step. 
    6. Re-read device status to ensure the FEATURES_OK bit is still set: otherwise, the device does not support our subset of features and the device is unusable. 
    7. Perform device-specific setup, including discovery of virtqueues for the device, optional per-bus setup, reading and possibly writing the device’s virtio configuration space, and population of virtqueues. 
    8. Set the DRIVER_OK status bit. At this point the device is “live”.
"""

That means stuff may happen between "discovery of virtqueues" and "DRIVER_OK". So it
is not sufficient to be "safe against notifications before indicators
have been registered", but we want to be also safe between "indicators have
been registered" and "DRIVER_OK status has been set". 

@Jason: can you confirm?

Regarding the question "are we safe against notifications before
indicators have been registered" I think we really need to think about
something like Secure Execution. We don't have, and we are unlikely
to have in hardware virtio-ccw implementations, and for a malicious hypervisor
that has full access to the guest memory hardening makes no sense.

But if we assume that an attacker can inject adapter interrupts for an arbitrary
ISC, and can poke any shared memory (notifier bits are shared)... Things might
become critical already when register_adapter_interrupt() does it's magic.


> For the reverse case, maybe we should always
> invalidate the indicators in the reset case? More information regarding
> the attack vector would help here :)
> 
> My main concern is that we would need to synchronize against a single
> interrupt that covers all kinds of I/O interrupts, not just a single
> device...
> 

Could we synchronize on struct airq_info's lock member? If we were
to grab all of these that might be involved...

AFAIU for the synchronize implementation we need a lock or a set of locks
that contain all the possible vring_interrupt() calls with the queuues
that belong to the given device as a critical section. That way, one
has the acquire's and release's in place so that the vrign_interrupt()
either guaranteed to finish before the change of driver_ready is
guaranteed to be complete, or it is guaranteed to see the change.

In any case, I guess we should first get clear on the first part. I.e.
when do we want to allow host->guest notifications.

Regards,
Halil

