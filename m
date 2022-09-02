Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087BD5AB82F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIBS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIBS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:29:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757E10B965;
        Fri,  2 Sep 2022 11:21:15 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282Gpo7U017102;
        Fri, 2 Sep 2022 18:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bojKYfmwgKfJpoWd63/pmsTOBsEppyky4YBwWnBPzPY=;
 b=s3NNsWBf6qdp1DZJQjajbPyLOoRFjKSzH8V9FNinodZw7x0BOP6uuLrkDvmr+2XWcDna
 Fes9c5oSEtXgVtD1DAWU+oZNyvtK6k571VgnGyEIO4yq2BTTavmMasJngmRZXUWIBY0H
 /374Q/PThXt/fU81woXu6Hh4Innge8jo0cMzDbK9JVQyfx2qEgIX+nXhBRkXo05uMoK/
 MOzFdA4FDn/GT/s7h3hC+01eA+0bWxTcgFSipVoUy+QRamwloiWO4OLQ0ZW2egRyr6XV
 jtZJef9PeYPG4kCr61iQ/Q//Uw9OLzQoSOXeJ83r8JRjoLpZ2aA+gVEIUwPQ2rJa33Bm zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbnqja6f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 18:21:00 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 282HJudB016808;
        Fri, 2 Sep 2022 18:20:59 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbnqja6ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 18:20:59 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282IKED7017649;
        Fri, 2 Sep 2022 18:20:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3j7awabv9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 18:20:58 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282IKvnt27525500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 18:20:57 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB7B28059;
        Fri,  2 Sep 2022 18:20:57 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A228E28058;
        Fri,  2 Sep 2022 18:20:56 +0000 (GMT)
Received: from [9.160.86.252] (unknown [9.160.86.252])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 18:20:56 +0000 (GMT)
Message-ID: <62637e13-7680-28ff-d395-10e6232fd3e6@linux.ibm.com>
Date:   Fri, 2 Sep 2022 14:20:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
 <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
 <YxEYAcFK0EdahXzJ@nvidia.com>
 <273fdd58-549c-30d4-39a9-85fe631162ba@linux.ibm.com>
 <YxI7kzuchcJz8sRX@nvidia.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <YxI7kzuchcJz8sRX@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GfcCZJAjqxMBlAQ9vfU2MXqE1hXsrave
X-Proofpoint-ORIG-GUID: NeLvF2KEBBGcsnjNXhq_1ApnH2HPlo0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 1:21 PM, Jason Gunthorpe wrote:
> On Fri, Sep 02, 2022 at 01:11:09PM -0400, Matthew Rosato wrote:
>> On 9/1/22 4:37 PM, Jason Gunthorpe wrote:
>>> On Thu, Sep 01, 2022 at 12:14:24PM -0400, Matthew Rosato wrote:
>>>> On 9/1/22 6:25 AM, Robin Murphy wrote:
>>>>> On 2022-08-31 21:12, Matthew Rosato wrote:
>>>>>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>>>>>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>>>>>> domains and the DMA API handling.  However, this commit does not
>>>>>> sufficiently handle the case where the device is released via a call
>>>>>> to the release_device op as it may occur at the same time as an opposing
>>>>>> attach_dev or detach_dev since the group mutex is not held over
>>>>>> release_device.  This was observed if the device is deconfigured during a
>>>>>> small window during vfio-pci initialization and can result in WARNs and
>>>>>> potential kernel panics.
>>>>>
>>>>> Hmm, the more I think about it, something doesn't sit right about this whole situation... release_device is called via the notifier from device_del() after the device has been removed from its parent bus and largely dismantled; it should definitely not still have a driver bound by that point, so how is VFIO doing things that manage to race at all?
>>>>>
>>>>> Robin.
>>>>
>>>> So, I generally have seen the issue manifest as one of the calls
>>>> into the iommu core from __vfio_group_unset_container
>>>> (e.g. iommu_deatch_group via vfio_type1_iommu) failing with a WARN.
>>>> This happens when the vfio group fd is released, which could be
>>>> coming e.g. from a userspace ioctl VFIO_GROUP_UNSET_CONTAINER.
>>>> AFAICT there's nothing serializing the notion of calling into the
>>>> iommu core here against a device that is simultaneously going
>>>> through release_device (because we don't enter release_device with
>>>> the group mutex held), resulting in unpredictable behavior between
>>>> the dueling attach_dev/detach_dev and the release_device for
>>>> s390-iommu at least.
>>>
>>> Oh, this is a vfio bug.
>>
>> I've been running with your diff applied today on s390 and this
>> indeed fixes the issue by preventing the detach-after-release coming
>> out of vfio. 
> 
> Heh, I'm shocked it worked at all
> 
> I've been trying to understand Robin's latest remarks because maybe I
> don't really understand your situation right.
> 
> IMHO this is definately a VFIO bug, because in a single-device group
> we must not allow the domain to remain attached past remove(). Or more
> broadly we shouldn't be holding ownership of a group without also
> having a driver attached.> 
> But this dicussion with Robin about multi-device groups and hotplug
> makes me wonder what your situation is? There is certainly something
> interesting there too, and this can't be a solution to that problem.
> 

It's just a single-device group, that's all we do in s390 today.  Of course, as we move forward to consume s390-iommu for other use-cases (e.g. Niklas DMA conversion) then yeah I think we will still need something within s390-iommu to handle competing e.g. attach/detach and release_device calls.

For this particular issue, the scenario is triggered by deconfiguring that one host device (effectively, pull the plug) while the device is passed to QEMU via vfio-pci.  

>> Can you send as a patch for review?
> 
> After I wrote this I had a better idea, to avoid the completion and
> just fully orphan the group fd.
> 
> And the patch is kind of messy
> 
> Can you forward me the backtrace you hit also?

It manifests in a few different ways (depends on the timing of the iommu_detach_group vs release_device), but this is by far the most common:

[  402.718355] iommu driver failed to attach the default/blocking domain
[  402.718380] WARNING: CPU: 0 PID: 5082 at drivers/iommu/iommu.c:1961 iommu_detach_group+0x6c/0x80
[  402.718389] Modules linked in: macvtap macvlan tap vfio_pci vfio_pci_core irqbypass vfio_virqfd kvm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink mlx5_ib sunrpc ib_uverbs ism smc uvdevice ib_core s390_trng eadm_sch tape_3590 tape tape_class vfio_ccw mdev vfio_iommu_type1 vfio zcrypt_cex4 sch_fq_codel configfs ghash_s390 prng chacha_s390 libchacha aes_s390 mlx5_core des_s390 libdes sha3_512_s390 nvme sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common nvme_core zfcp scsi_transport_fc pkey zcrypt rng_core autofs4
[  402.718439] CPU: 0 PID: 5082 Comm: qemu-system-s39 Tainted: G        W          6.0.0-rc3 #5
[  402.718442] Hardware name: IBM 3931 A01 782 (LPAR)
[  402.718443] Krnl PSW : 0704c00180000000 000000095bb10d28 (iommu_detach_group+0x70/0x80)
[  402.718447]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  402.718450] Krnl GPRS: 0000000000000001 0000000900000027 0000000000000039 000000095c97ffe0
[  402.718453]            00000000fffeffff 00000009fc290000 00000000af1fda50 00000000af590b58
[  402.718455]            00000000af1fdaf0 0000000135c7a320 0000000135e52258 0000000135e52200
[  402.718457]            00000000a29e8000 00000000af590b40 000000095bb10d24 0000038004b13c98
[  402.718464] Krnl Code: 000000095bb10d18: c020003d56fc	larl	%r2,000000095c2bbb10
                          000000095bb10d1e: c0e50019d901	brasl	%r14,000000095be4bf20
                         #000000095bb10d24: af000000		mc	0,0
                         >000000095bb10d28: b904002a		lgr	%r2,%r10
                          000000095bb10d2c: ebaff0a00004	lmg	%r10,%r15,160(%r15)
                          000000095bb10d32: c0f4001aa867	brcl	15,000000095be65e00
                          000000095bb10d38: c004002168e0	brcl	0,000000095bf3def8
                          000000095bb10d3e: eb6ff0480024	stmg	%r6,%r15,72(%r15)
[  402.718532] Call Trace:
[  402.718534]  [<000000095bb10d28>] iommu_detach_group+0x70/0x80 
[  402.718538] ([<000000095bb10d24>] iommu_detach_group+0x6c/0x80)
[  402.718540]  [<000003ff80243b0e>] vfio_iommu_type1_detach_group+0x136/0x6c8 [vfio_iommu_type1] 
[  402.718546]  [<000003ff80137780>] __vfio_group_unset_container+0x58/0x158 [vfio] 
[  402.718552]  [<000003ff80138a16>] vfio_group_fops_unl_ioctl+0x1b6/0x210 [vfio] 
[  402.718557] pci 0004:00:00.0: Removing from iommu group 4
[  402.718555]  [<000000095b5b62e8>] __s390x_sys_ioctl+0xc0/0x100 
[  402.718562]  [<000000095be5d3b4>] __do_syscall+0x1d4/0x200 
[  402.718566]  [<000000095be6c072>] system_call+0x82/0xb0 
[  402.718570] Last Breaking-Event-Address:
[  402.718571]  [<000000095be4bf80>] __warn_printk+0x60/0x68


The WARN is hit because the attach fails due to the simultaneously in-flight release_device.

The subject patch was basically attempting to serialize the value that was being stomped over within s390-iommu (zdev->s390_domain) as a result of the competing iommu_detach_group + release_device.  By ensuring the vfio group is cleaned up before the release, I no longer see the competing threads, with release_device happening after the group is cleaned up. 

> 
> (Though I'm not sure I can get to this promptly, I have only 4 working
> days before LPC and still many things to do)
> 
> Thanks,
> Jason

