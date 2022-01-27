Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900C649E510
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiA0Ost (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:48:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238164AbiA0Osr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:48:47 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20REfkhI037202;
        Thu, 27 Jan 2022 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HL8Ok0bxRpotvVJgli4toUrwvcNQQiHkYva6uE8SYHg=;
 b=B5wWiJUYkYN49tSRNa+C2mv12OxD/gda+dmRd0hK5zHIS4K6L1DfyhG5pygx49lOldST
 ZkcwRzV68X6mRQPoy6EAoqtfMiUz+gexqGBkbmGf5drlyz8aS9yK6nEg0QH8uQ8XYYa5
 gJJdj95Xz76WeR0GV1xiDwLRQzvCrHu09VcYr3jepAPNUuHmJVklFxKyPBayhmkUxNak
 2fFenKi0UOLsUca4ZSDoMPtg5KfJZZInL7PC5Oym45ZtOLWaqEsAZlrtL0KBctZTxfIb
 q1i1POkXeq5eV83glCtZkMu19xsW+vLhuA5+4+P604gU3lnnMvK9WI2i9qtpy8qgDiju OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duu7bkhvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:48:46 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20REgs0K040699;
        Thu, 27 Jan 2022 14:48:46 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duu7bkhvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:48:46 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RElAHs006244;
        Thu, 27 Jan 2022 14:48:45 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3dt1xb6uyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:48:45 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20REmgkU4325640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 14:48:42 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6506828067;
        Thu, 27 Jan 2022 14:48:42 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14CFF2805A;
        Thu, 27 Jan 2022 14:48:41 +0000 (GMT)
Received: from [9.65.230.214] (unknown [9.65.230.214])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 14:48:40 +0000 (GMT)
Message-ID: <04166a97-f4ad-7db6-e00c-11a86f54914a@linux.ibm.com>
Date:   Thu, 27 Jan 2022 09:48:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <87k0g8scx1.fsf@redhat.com>
 <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
 <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com> <87tufaqbex.fsf@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <87tufaqbex.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hf9YNZqztLL5yOE8eAx3rsXWz6ErmGJY
X-Proofpoint-GUID: INFpb6rT95J2YgHIy3HhpnckKnHpSbI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 07:51, Cornelia Huck wrote:
> On Wed, Dec 15 2021, Thomas Huth <thuth@redhat.com> wrote:
>
>> On 14/12/2021 22.55, Tony Krowiak wrote:
>>>
>>> On 12/13/21 11:11, Cornelia Huck wrote:
>>>> One possibility is simply blocking autoload of the module in userspace by
>>>> default, and only allow it to be loaded automatically when e.g. qemu-kvm
>>>> is installed on the system. This is obviously something that needs to be
>>>> decided by the distros.
>>>>
>>>> (kvm might actually be autoloaded already, so autoloading vfio-ap would
>>>> not really make it worse.)
>>> Of the vfio_ccw module is automatically loaded, then the kvm
>>> module will also get loaded. I startup up a RHEL8.3 system and
>>> sure enough, the vfio_ccw module is loaded along with the
>>> kvm, vfio and mdev modules. If this is true for all distros, then
>>> it wouldn't make much difference if the vfio_ap module is
>>> autoloaded too.
>> I think I don't mind too much if we auto-load vfio-ap or not - but I think
>> we should make it consistent with vfio-ccw. So either auto-load both modules
>> (if the corresponding devices are available), or remove the
>> MODULE_DEVICE_TABLE() entries from both modules?
> I think we really need to take a step back and think about the purpose
> of adding a MODULE_DEVICE_TABLE()... basically, it declares which types
> of devices on a certain bus a driver supports, in a way that can be
> consumed by userspace (after file2alias.c worked on it).
>
> Userspace typically uses this to match devices it is notified about to
> drivers that could possibly drive those devices. In general, the
> assumption is that you will want to have the drivers for your devices
> loaded. In some cases (drivers only used in special cases, like here),
> it might be a better idea to autoload the drivers only under certain
> circumstances (e.g. if you know you're going to run KVM guests).
>
> My main point, however, is that we're talking about policy here: whether
> a potentially useful driver should be loaded or not is a decision that
> should be made by userspace. Not providing a MODULE_DEVICE_TABLE does
> not look like the right solution, as it deprives userspace of the
> information to autoload the driver, if it actually wants to do so.

I agree.

>

