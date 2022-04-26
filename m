Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5C50EEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiDZCcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiDZCcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:32:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E7113C8A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:29:33 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q2BKn3027092;
        Tue, 26 Apr 2022 02:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ORjGnEMDrvo3+6uualxTOacerrMHtkGkqIJwhd1RrQw=;
 b=OI1fPB+6S7gRMEmbdzYIzZHZZ8ZPD+2UWPeLdXiBuiPfx8kkd72at4f6ed+nH2KdPuDs
 jOu00CwrtdfH8t1YX7B0cwO1GtfgZCFAYH2HL009F7E1Z3EC/AOdayRuAHcOpJV/Mf7w
 afcmMvphSwa42C2VTPpZ3Tv/yx6q8YPb0Nud/ID/Wrv7rZkniZ3ZYaTEqDa9Uoee2Uno
 82onSqbv+HTquPHFdSSB+vzHOPSSttxxaGXXuESPQ3LRlyX54etm3ndB5lgstKYFnETR
 8eVRu8DF2KM1TYeCvY+2U508e3/51RdWf0xgfryrLQJ0gJSb11rCNjYM28U5dH87y4Op LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp4txtsyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 02:29:19 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q2Olka010189;
        Tue, 26 Apr 2022 02:29:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp4txtsy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 02:29:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q2CPW0003706;
        Tue, 26 Apr 2022 02:29:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj36vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 02:29:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q2TExw47645034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 02:29:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418EC42042;
        Tue, 26 Apr 2022 02:29:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 968DB4203F;
        Tue, 26 Apr 2022 02:29:13 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.52.32])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 26 Apr 2022 02:29:13 +0000 (GMT)
Date:   Tue, 26 Apr 2022 04:29:11 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220426042911.544477f9.pasic@linux.ibm.com>
In-Reply-To: <20220425095742-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
        <20220425024418.8415-7-jasowang@redhat.com>
        <20220425040512-mutt-send-email-mst@kernel.org>
        <87a6c98rwf.fsf@redhat.com>
        <20220425095742-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eUvDg2_gBEW68dtdUTwHrS5eIvmZyaS2
X-Proofpoint-ORIG-GUID: c41i5I_tk-ghEpQj5XSK1OlF6NaEfU5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260012
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 09:59:55 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
> > On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:  
> > >> This patch tries to implement the synchronize_cbs() for ccw. For the
> > >> vring_interrupt() that is called via virtio_airq_handler(), the
> > >> synchronization is simply done via the airq_info's lock. For the
> > >> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > >> device spinlock for irq is introduced ans used in the synchronization
> > >> method.
> > >> 
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >> Cc: Marc Zyngier <maz@kernel.org>
> > >> Cc: Halil Pasic <pasic@linux.ibm.com>
> > >> Cc: Cornelia Huck <cohuck@redhat.com>
> > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > >
> > >
> > > This is the only one that is giving me pause. Halil, Cornelia,
> > > should we be concerned about the performance impact here?
> > > Any chance it can be tested?  
> > 
> > We can have a bunch of devices using the same airq structure, and the
> > sync cb creates a choke point, same as registering/unregistering.  
> 
> BTW can callbacks for multiple VQs run on multiple CPUs at the moment?

I'm not sure I understand the question.

I do think we can have multiple CPUs that are executing some portion of
virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?

On the other hand we could also end up serializing synchronize_cbs()
calls for different devices if they happen to use the same airq_info. But
this probably was not your question

> this patch serializes them on a spinlock.
>

Those could then pile up on the newly introduced spinlock.

Regards,
Halil

