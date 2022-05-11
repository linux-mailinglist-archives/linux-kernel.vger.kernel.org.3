Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85295234EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbiEKOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiEKOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:02:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0C62202
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:02:11 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BDKVnd029848;
        Wed, 11 May 2022 14:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=qsQ5SKdZ0ioW8fqIOFzLQJ9VmnLyw+WheucOVyOqJyg=;
 b=k4Rx4Nf8+Bx/Ryz55H7dbjXRRxBo1ea4Oy+RBhUJOBmxr+uRIels04vcd5/UKx2vUmzg
 lWw27swv7KYIMoypYXbP1VVWDVwafJeVToYGHy5ZIIcz8wv8rnjMPurpIAQsDSkIgS71
 8DPKmjlZCh8MZcj3wBpUmaLpofdoOIW40lj4DArBvIZUZFOijQKDlpoAOV0PNZa+SuWI
 Ni/NXHJi7vWDtdhONEEUJ9FmZB+xhl4kQAY6iAjl67lq97vfLWC8uYat/w3RBwOQgscb
 7kJEokRQVoWWox8teCjVLXl9rQ3LpVqlRqEbN9SM7GdLH2TgwLTg5NH7fiNLhGyy8Avs 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0dxq8t7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:01:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BDjBOt035787;
        Wed, 11 May 2022 14:01:54 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0dxq8t6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:01:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BDvLUM009481;
        Wed, 11 May 2022 14:01:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3fwg1hvb3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:01:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BE1nhq57868570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:01:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0E115204F;
        Wed, 11 May 2022 14:01:49 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.152.224.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 37EDD5204E;
        Wed, 11 May 2022 14:01:49 +0000 (GMT)
Date:   Wed, 11 May 2022 16:01:47 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, mst <mst@redhat.com>,
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
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
Message-ID: <20220511160147.46cbf2fb.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
        <875ymd3fd1.fsf@redhat.com>
        <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YwY84jtz4mZc8wDYsffoaslHaMgif1_C
X-Proofpoint-ORIG-GUID: HB8f3CTnTA7Z_CM9GzFj0wrmdbOigrtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_05,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=917 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 10:22:59 +0800
Jason Wang <jasowang@redhat.com> wrote:

> >        CPU0
> >        ----
> >   lock(&vcdev->irq_lock);
> >   <Interrupt>
> >     lock(&vcdev->irq_lock);
> >
> >  *** DEADLOCK ***  
> 
> It looks to me we need to use write_lock_irq()/write_unlock_irq() to
> do the synchronization.
> 
> And we probably need to keep the
> read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
> virtio_ccw_int_handler() to be called from process context (e.g from
> the io_subchannel_quiesce()).
> 

Sounds correct.

Regards,
Halil
