Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA724F964D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiDHNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiDHNFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:05:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB1F267FAA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:03:39 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238D1J9s032334;
        Fri, 8 Apr 2022 13:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=/Bzxxg1QWV2zTZLJYuemtOnOWtUYLKKRvdzaHjiJa80=;
 b=oadugTP17bUKmETwp80eex9cNWjnQWZU6tDx4Wg73gfSSKwUoP4kP2/idl4NScdwR7JJ
 7EVriThCP7fAY9wGP9YvSwjB2aFCwwV/pqeTSlx7CIiYkOojnMp199mh3tVZDNL0HxR0
 gwmcJ7WO6f6A3HonLmfNHfSseQ4jMqXzyHTOO7nDsWU9nyEjwGFrnLxmHdefhiKJPb7T
 obxOf5cbYd0cbc/xaKdsTfkdFTs0t13aM+6RZzSC0rT8zel2kA5EqEXva1S1yLmkeqYE
 toGRZlQEIbebUUdWw6uI9kVu4WG8JAr7i5UwIQJCsdZMq2HdJXD/vB2QoTvcxHu3K7Os Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fabc4kmhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 13:03:15 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 238CnRwC009831;
        Fri, 8 Apr 2022 13:03:14 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fabc4kmh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 13:03:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238CvERB031199;
        Fri, 8 Apr 2022 13:03:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhusun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 13:03:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238ConXP28705158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 12:50:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB68A42049;
        Fri,  8 Apr 2022 13:03:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3615A4203F;
        Fri,  8 Apr 2022 13:03:09 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.91.78])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  8 Apr 2022 13:03:09 +0000 (GMT)
Date:   Fri, 8 Apr 2022 15:03:07 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tglx@linutronix.de,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220408150307.24b6b99f.pasic@linux.ibm.com>
In-Reply-To: <87wng2e527.fsf@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
        <20220406083538.16274-5-jasowang@redhat.com>
        <20220406075952-mutt-send-email-mst@kernel.org>
        <87wng2e527.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pea_3SdETi5KqpcWHIwOkTb7dRCt-z75
X-Proofpoint-ORIG-GUID: Lk-kM33MKokmvJMY6cCIhgQ_k2uPcOqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_04,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Apr 2022 15:04:32 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:  
> >> This patch implements PCI version of synchronize_vqs().
> >> 
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> >
> > Please add implementations at least for ccw and mmio.  
> 
> I'm not sure what (if anything) can/should be done for ccw...

If nothing needs to be done I would like to have at least a comment in
the code that explains why. So that somebody who reads the code
doesn't wonder: why is virtio-ccw not implementing that callback.

> 
> >  
> >> ---
> >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> >>  drivers/virtio/virtio_pci_common.h |  2 ++
> >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> >>  4 files changed, 19 insertions(+)
> >> 
> >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> >> index d724f676608b..b78c8bc93a97 100644
> >> --- a/drivers/virtio/virtio_pci_common.c
> >> +++ b/drivers/virtio/virtio_pci_common.c
> >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >>  }
> >>  
> >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> >> +{
> >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >> +	int i;
> >> +
> >> +	if (vp_dev->intx_enabled) {
> >> +		synchronize_irq(vp_dev->pci_dev->irq);
> >> +		return;
> >> +	}
> >> +
> >> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> >> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >> +}
> >> +  
> 
> ...given that this seems to synchronize threaded interrupt handlers?
> Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> 'irq' for channel devices anyway, and the handler just calls the
> relevant callbacks directly.)

Sorry I don't understand enough yet. A more verbose documentation on
"virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
surely benefit me. It may be more than enough for a back-belt but it
ain't enough for me to tell what is the callback supposed to accomplish.

I will have to study this discussion and the code more thoroughly.
Tentatively I side with Jason and Michael in a sense, that I don't
believe virtio-ccw is safe against rough interrupts.

Sorry for the late response. I intend to revisit this on Monday. If
I don't please feel encouraged to ping.

Regards,
Halil

