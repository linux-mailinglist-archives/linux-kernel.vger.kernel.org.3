Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C406F51299C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiD1CrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiD1CrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:47:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172E81EFD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:43:49 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S0NxE0007306;
        Thu, 28 Apr 2022 02:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=I7+IAwtxTapFJYhZvZoTTtFaCWq9J4pTQ54VhBKsD98=;
 b=QKt0TXVH91lvQtZQ/uF69kApFnBTeX1jX78tbyzUMuk5Y9EXGTIxmll2If33yJBf6kV4
 zPYOzSHCR02SPUuIBePqGEYKGXyP2hjUWx8HswPXqFAoMnxWZn5Edu0S+rfvqY39cteP
 WKsSXY7J//znvVghINQ8bwylBlPbSVMV+mUVTmK28JvhNl0T4U7HYRN/HzKyufb9U5dg
 6Rt+RNiS8IaD/EY1sUw844+c8pp5gpQYBwGyAMkzfJk5k1czawTfPeJBMs2CU9oeS1o5
 /nX+CjA4i6ZRyeuNfGugD23fcY/wmexJl/TbQOqsD1smv3zlaT017pohQg6P6SzZ5i4i 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqgbk1y06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 02:43:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23S2fGmr000616;
        Thu, 28 Apr 2022 02:43:22 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqgbk1xyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 02:43:22 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23S2dWei004030;
        Thu, 28 Apr 2022 02:43:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3fm938wb0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 02:43:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23S2hIEF55771408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:43:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F863A404D;
        Thu, 28 Apr 2022 02:43:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C402EA4040;
        Thu, 28 Apr 2022 02:43:17 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.21.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 28 Apr 2022 02:43:17 +0000 (GMT)
Date:   Thu, 28 Apr 2022 04:43:15 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428044315.3945e660.pasic@linux.ibm.com>
In-Reply-To: <87ilqu7u6w.fsf@redhat.com>
References: <20220425040512-mutt-send-email-mst@kernel.org>
        <87a6c98rwf.fsf@redhat.com>
        <20220425095742-mutt-send-email-mst@kernel.org>
        <20220426042911.544477f9.pasic@linux.ibm.com>
        <20220425233434-mutt-send-email-mst@kernel.org>
        <20220425233604-mutt-send-email-mst@kernel.org>
        <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
        <20220425235134-mutt-send-email-mst@kernel.org>
        <20220425235415-mutt-send-email-mst@kernel.org>
        <87o80n7soq.fsf@redhat.com>
        <20220426124243-mutt-send-email-mst@kernel.org>
        <87ilqu7u6w.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nVGGsjJyI-Dp1hqx04GKo6n8n4njrryo
X-Proofpoint-GUID: -3sWKC2dVUz214jceQbUHmppgsr5vVfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280012
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 11:27:03 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, Apr 26 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Apr 26, 2022 at 05:47:17PM +0200, Cornelia Huck wrote:  
> >> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>   
> >> > On Mon, Apr 25, 2022 at 11:53:24PM -0400, Michael S. Tsirkin wrote:  
> >> >> On Tue, Apr 26, 2022 at 11:42:45AM +0800, Jason Wang wrote:  
> >> >> > 
> >> >> > 在 2022/4/26 11:38, Michael S. Tsirkin 写道:  
> >> >> > > On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:  
> >> >> > > > On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:  
> >> >> > > > > On Mon, 25 Apr 2022 09:59:55 -0400
> >> >> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> > > > >   
> >> >> > > > > > On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:  
> >> >> > > > > > > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:  
> >> >> > > > > > > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> >> >> > > > > > > > > This patch tries to implement the synchronize_cbs() for ccw. For the
> >> >> > > > > > > > > vring_interrupt() that is called via virtio_airq_handler(), the
> >> >> > > > > > > > > synchronization is simply done via the airq_info's lock. For the
> >> >> > > > > > > > > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> >> >> > > > > > > > > device spinlock for irq is introduced ans used in the synchronization
> >> >> > > > > > > > > method.
> >> >> > > > > > > > > 
> >> >> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> >> >> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> >> >> > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> >> > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> >> >> > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> >> >> > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> >> >> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>  
> >> >> > > > > > > > 
> >> >> > > > > > > > This is the only one that is giving me pause. Halil, Cornelia,
> >> >> > > > > > > > should we be concerned about the performance impact here?
> >> >> > > > > > > > Any chance it can be tested?  
> >> >> > > > > > > We can have a bunch of devices using the same airq structure, and the
> >> >> > > > > > > sync cb creates a choke point, same as registering/unregistering.  
> >> >> > > > > > BTW can callbacks for multiple VQs run on multiple CPUs at the moment?  
> >> >> > > > > I'm not sure I understand the question.
> >> >> > > > > 
> >> >> > > > > I do think we can have multiple CPUs that are executing some portion of
> >> >> > > > > virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
> >> >> > > > > 
> >> >> > > > > On the other hand we could also end up serializing synchronize_cbs()
> >> >> > > > > calls for different devices if they happen to use the same airq_info. But
> >> >> > > > > this probably was not your question  
> >> >> > > > 
> >> >> > > > I am less concerned about  synchronize_cbs being slow and more about
> >> >> > > > the slowdown in interrupt processing itself.
> >> >> > > >   
> >> >> > > > > > this patch serializes them on a spinlock.
> >> >> > > > > >   
> >> >> > > > > Those could then pile up on the newly introduced spinlock.  
> >> 
> >> How bad would that be in practice? IIUC, we hit on the spinlock when
> >> - doing synchronize_cbs (should be rare)
> >> - processing queue interrupts for devices using per-device indicators
> >>   (which is the non-preferred path, which I would basically only expect
> >>   when running on an ancient or non-standard hypervisor)  
> >
> > this one is my concern. I am worried serializing everything on a single lock
> > will drastically regress performance here.  
> 
> Yeah, that case could get much worse. OTOH, how likely is it that any
> setup that runs a recent kernel will actually end up with devices using
> per-device indicators? Anything running under a QEMU released in the
> last couple of years is unlikely to not use airqs, I think. Halil, do
> you think that the classic indicator setup would be more common on any
> non-QEMU hypervisors?
> 

I really don't know. My opinion is that, two stages indicators are kind
of recommended for anybody who cares about notifications performance.

> IOW, how much effort is it worth spending on optimizing this case? We
> certainly should explore any simple solutions, but I don't think we need
> to twist ourselves into pretzels to solve it.
> 

Frankly, I would be fine with an rwlock based solution as proposed by
Jason. My rationale is: we recommend two stage indicators, and the two
stage indicators are already encumbered by an rwlock on the interrupt
path. Yes, the coalescence of adapter interrupts is architecturally
different, and so it is with GISA (without GISA, I'm not even sure), so
this rwlock end up being worse than the one for 2 stage. But my feeling
is, that it should be fine. On the other hand, I don't feel comfortable
with plain spinlock, and I am curious about a more advanced solution.
But my guess is that rwlock + some testing for the legacy indicator case
just to double check if there is a heavy regression despite of our
expectations to see none should do the trick.

Regards,
Halil

> >
> >  
> >> - configuration change interrupts (should be rare)
> >> - during setup, reset, etc. (should not be a concern)  
> 

