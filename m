Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C75523635
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiEKOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiEKOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:52:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64601D0432
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:52:37 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BEmJfn035793;
        Wed, 11 May 2022 14:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=thvq9ntUKZTn+TunkJ8ceC87i+1AWhK3Cdqoavw8SXc=;
 b=gnFjJ3MaeXNzopGtjYCJRcDGWcB553uU33pb9nwfJQPsZNSs4w5H9Aru1JD3TjqgxPa1
 9z2bjxxuFqkMV/7DlTaX89Gi8Y30zYp/dYYhWEWb9dvhfyahS/ndBz6x9QwZGEi2ty63
 Jj0bLtrDp/TwpjU7p/06MvlFWLRSSFxmSs0QgR8PDMxScqAAyXoShoZmGI0sMM0q3Bkh
 PXwYaxWpqjljr7CKkJ8UOrMeRvEgbUPFhlyMpoAV27cqTxg5evBrJEFYR5KW/fCeiw/A
 thxyFXp3cyh8BsKs9mC0iFCH15ZX4lrmjNbe4FIZoE1uuwY5ovtAFsOQ+wELOav042qx rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0f7tg38c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:52:17 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BEqGtT008884;
        Wed, 11 May 2022 14:52:17 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0f7tg37b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:52:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BElOat009252;
        Wed, 11 May 2022 14:52:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk1hqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:52:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BEpqO127918814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:51:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58D7752050;
        Wed, 11 May 2022 14:52:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 47B315204F;
        Wed, 11 May 2022 14:52:11 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55398)
        id C760EE040D; Wed, 11 May 2022 16:52:10 +0200 (CEST)
Date:   Wed, 11 May 2022 16:52:10 +0200
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <YnvNmtPgip5knLHP@tuxmaker.boeblingen.de.ibm.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
 <20220510072451-mutt-send-email-mst@kernel.org>
 <CACGkMEvWFyEqeeXYEmbU4TWtnj9Ku6J7jLK_7MueuFvpR7FiGg@mail.gmail.com>
 <87r150bi0d.fsf@redhat.com>
 <CACGkMEtPk9P4KhJ5wTOLj9CZoKDx9-X_5uLRVBag692x4s9SrA@mail.gmail.com>
 <87lev8bffh.fsf@redhat.com>
 <CACGkMEviB6-SmJmbV3h2zhaTwnep=WQLdnHXRc6D+UUxRXijfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEviB6-SmJmbV3h2zhaTwnep=WQLdnHXRc6D+UUxRXijfg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GUzW34AMA2zYJUW7R0btPjM3b7hbu0cP
X-Proofpoint-ORIG-GUID: KWF5kOvq1XQbhzBOm-CBx6ohqPLfVC6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=527
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:28:11PM +0800, Jason Wang wrote:
> On Wed, May 11, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> >
> > > On Wed, May 11, 2022 at 4:17 PM Cornelia Huck <cohuck@redhat.com> wrote:
> > >>
> > >> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> > >>
> > >> > On Tue, May 10, 2022 at 7:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >> >>
> > >> >> On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
> > >> >> > @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > >> >> >                       vcdev->err = -EIO;
> > >> >> >       }
> > >> >> >       virtio_ccw_check_activity(vcdev, activity);
> > >> >> > +     read_lock_irqsave(&vcdev->irq_lock, flags);
> > >> >> >       for_each_set_bit(i, indicators(vcdev),
> > >> >> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > >> >> >               /* The bit clear must happen before the vring kick. */
> > >> >>
> > >> >> Cornelia sent a lockdep trace on this.
> > >> >>
> > >> >> Basically I think this gets the irqsave/restore logic wrong.
> > >> >> It attempts to disable irqs in the handler (which is an interrupt
> > >> >> anyway).
> > >> >
> > >> > The reason I use irqsave/restore is that it can be called from process
> > >> > context (if I was not wrong), e.g from io_subchannel_quiesce().
> > >>
> > >> io_subchannel_quiesce() should disable interrupts, though? Otherwise, it
> > >> would be a bug.
> > >
> > > Right, it was protected by a spin_lock_irq(), but I can see other
> > > cdev->handler() in e.g device_fsm.c, the irq status is not obvious, do
> > > they have the same assumption which IRQ is disabled?
> >
> > Yes, that should be the case for any invocations via the fsm as well.
> >
> 
> Ok.
> 
> > It's been some time since I've worked on that part of the code, though,
> > so let's cc: the s390 cio maintainers so that they can speak up if I'm
> > wrong.
> 
> Ok, I will do that.
> 
> Thanks
> 
> >
Thank you Corny to looking in to this. I agree, the cdev->handler is
called with lock held. And as you mentioned, in the fsm these handler
invocations are done with IRQ disabled, which will otherwise end up in a
deadlock.
thanks.
