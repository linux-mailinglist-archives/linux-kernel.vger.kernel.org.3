Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297CA477027
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhLPL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:26:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236647AbhLPL0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:26:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGAfm37005116;
        Thu, 16 Dec 2021 11:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qhejk9Xe+Hy4NuzX0gEZGgDr2UCHbSBZ3zggci4eepc=;
 b=QQ7OpSFP/PNrkIENKMKSPUToZHUihKKEyPlG6nG4if2OR/fAAngY4ABkwHOZTkDP0Xhw
 WwDW/O5pQelKGPAN+P7Zl68BpwSbWPL2dPoM4EhugYUCkyvPyPAPfo2LQyFXTMqhvq+B
 JLQQoukPZ65UAWWUlxXRwON63sAaWF3BFpPNIUxHTspdrwNPTJ4c1sUU9aTWcfqfuMJF
 4STfR9OG4dKQ4qfSQLYNTsUAXVMSoYRN3k1bTZxP60nrQWZmTPX4mIkT8wYa8IxjuOYg
 6+sUBTEiDqhKY8wcJfNlt+cRhqZHH1kEJ8ndFokDRxuSGK4hfg4qPDPf8LVFS79KqH+X HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cye125n57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 11:26:01 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BGAtRbL013908;
        Thu, 16 Dec 2021 11:26:01 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cye125n4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 11:26:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BGBBjcd024404;
        Thu, 16 Dec 2021 11:25:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3cy7qw678q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 11:25:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BGBPtIo33685958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 11:25:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6CEE4C058;
        Thu, 16 Dec 2021 11:25:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3025B4C05A;
        Thu, 16 Dec 2021 11:25:55 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.42.46])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 16 Dec 2021 11:25:55 +0000 (GMT)
Date:   Thu, 16 Dec 2021 12:25:52 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Message-ID: <20211216122552.0ee1b998.pasic@linux.ibm.com>
In-Reply-To: <87r1acrfzi.fsf@redhat.com>
References: <20211201141110.94636-1-thuth@redhat.com>
        <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
        <87k0g8scx1.fsf@redhat.com>
        <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
        <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com>
        <87tufaqbex.fsf@redhat.com>
        <20211216000229.7a284661.pasic@linux.ibm.com>
        <87r1acrfzi.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tav5ChsLlnpMwU0_PgLPU6mkSst4IlK_
X-Proofpoint-ORIG-GUID: jBoMzwEckF-4xLMVg4DDRuy6qhbRpKVw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_04,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 11:39:13 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > Also what does vfio-pci do? As far as I can tell vfio-pci does not
> > participate in module auto loading just because there are pci devices.
> > The have some smart override I don't quite understand:
> > https://patchwork.ozlabs.org/project/linux-pci/patch/20210826103912.128972-11-yishaih@nvidia.com/
> > Before, I don't think they had a MODULE_DEVICE_TABLE:
> > https://elixir.bootlin.com/linux/v5.8.18/source/drivers/vfio/pci/vfio_pci.c  
> 
> I don't think it makes sense to look at pci for inspiration here; they
> have a myriad of different device types, while ap only has a few (and
> probably not that many different ones on a given system), and css only
> has one that really matters.

I really don't understand how they having a myraid of different device
types is relevant here. Are they not taking care of that by using
PCI_ANY_ID anyway? Can you please explain?

Please have another look at the commit message of 
cc6711b0bf36 ("PCI / VFIO: Add 'override_only' support for VFIO PCI sub system").
They generate alias(es) that catch every PCI device (via PCI_ANY_ID), but
in a way that precludes auto-loading and enables a generic 'override'
algorithm.

Regards,
Halil
