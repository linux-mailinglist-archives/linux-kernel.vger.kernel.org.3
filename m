Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A944FD646
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384360AbiDLJ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381356AbiDLIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB55370C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:56:11 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C6ft7Y029349;
        Tue, 12 Apr 2022 07:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=xBbtpFu+g0M5oAS5qWS81PsG9t3GJIOwiA28DUQVs5g=;
 b=SVt+WNZtqmPYAF1sZKsrFMSalIkYkLBUKYWFGmso0cvIt6pFOBLJn+hFqCkiGkQZ8QlW
 Cpm3SrNXmSZI1LyT5UoWIFoLoW9CyJvTSevYp6+23sjOFvnru3bBUx6U5IJKMCjm+YxC
 8OU7TpD1xZny6mJvUjc8AESJO7YtKCWqAUUsYG5Ff58UoMrv/Yf8ruq2uH/gTgTiGTAM
 UdzurUjj7dXdoMLi03n2lbdmhcS1os5jK6pAAjIfs3CPUeuvMF/6AJTPH2AJ0sIbtmBL
 jTmjME6SO4w33YEUfPIdnSPjVB3nc5vGAhUMtQ1L0UWZC8LvuPx2GvaurSL5+sXxHaxI Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fd4cj9e3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 07:55:46 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23C7YZ1Z024509;
        Tue, 12 Apr 2022 07:55:46 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fd4cj9e2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 07:55:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23C7sIaW012477;
        Tue, 12 Apr 2022 07:55:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s8vd9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 07:55:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23C7tf9n34013486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:55:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29C2BAE04D;
        Tue, 12 Apr 2022 07:55:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 776EBAE055;
        Tue, 12 Apr 2022 07:55:40 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.60.83])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 12 Apr 2022 07:55:40 +0000 (GMT)
Date:   Tue, 12 Apr 2022 09:55:19 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220412095519.245cf9f7.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEvDSv+sZwLYqqfP-jzDzonmon+CxeSXkvyd6F-CbfV3tQ@mail.gmail.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
        <20220406083538.16274-5-jasowang@redhat.com>
        <20220406075952-mutt-send-email-mst@kernel.org>
        <87wng2e527.fsf@redhat.com>
        <20220408150307.24b6b99f.pasic@linux.ibm.com>
        <20220410034556-mutt-send-email-mst@kernel.org>
        <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
        <877d7vbspu.fsf@redhat.com>
        <20220412020145.32e26e5a.pasic@linux.ibm.com>
        <CACGkMEvDSv+sZwLYqqfP-jzDzonmon+CxeSXkvyd6F-CbfV3tQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CmSVxQ2lgNAuH9PRyaNdXW8BiJbSoWi6
X-Proofpoint-ORIG-GUID: k8zmRpchgAEYpZ3jEgIZi-3Qw_H2iW3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-12_02,2022-04-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=814 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 10:24:35 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > Regarding the question "are we safe against notifications before
> > indicators have been registered" I think we really need to think about
> > something like Secure Execution. We don't have, and we are unlikely
> > to have in hardware virtio-ccw implementations, and for a malicious hypervisor
> > that has full access to the guest memory hardening makes no sense.  
> 
> Does s390 have something like memory encryption? (I guess yes). In the
> case of x86 VM encryption, the I/O buffers were now done via software
> IOTLB, that's why hardening of the virtio driver is needed to prevent
> the hypervisor to poke the swiotlb etc.

Yep! Secure Execution is a confidential computing solution which is much
like encrypted guest memory, except for one gets exceptions when trying
to access private memory instead of ending up with garbage  because of
the encryption. These improvements are IMHO relevant to us!

Regards,
Halil
