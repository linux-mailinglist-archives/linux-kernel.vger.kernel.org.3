Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B097A46D6D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhLHPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:25:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59888 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235895AbhLHPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:25:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8DHgxN009674;
        Wed, 8 Dec 2021 15:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=toawrVvCPUHpquufnA13Q37Azo2nGAGLi9oPn89p26o=;
 b=BjHblkrI34tFTT0g634fePquHwWgtzK1rxOR3hdEe2SBlbxNRWTobg4CFWOeSipOI9zc
 GyhNpLSs9hrBPsaLNCslaqpdTQ4TNmhNcpcWvD02XTEG0H5AWFAQt+glCIAQpv0mtqah
 cq+ePOAQMwrsT4TjkFdz9wr2gV26gBAh5qU9EjGD82tBTo7c7jgcebBdQtLBm2jh13OR
 i1nSHwRHWEmtzgq+VNdUCmnFJOCpmBnpYqHu25ImmMOCnCmg26eGDPyqzmv6PaitbJ5O
 Z3Eglg6CpilTV0PVX1AGnt/2oOWqSiRDCMyUfz1tZmlCQPa9fwu2DgnC68A1Q/3IXXYq Hw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctwfcapyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:21:33 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8FCM4w028250;
        Wed, 8 Dec 2021 15:21:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3cqyy8cdpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:21:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8FLVOx50004464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 15:21:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41B3AB206B;
        Wed,  8 Dec 2021 15:21:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3F34B2065;
        Wed,  8 Dec 2021 15:21:30 +0000 (GMT)
Received: from localhost (unknown [9.211.99.77])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 15:21:30 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/pseries: read the lpar name from the firmware
In-Reply-To: <21eb4749-42b1-da78-8833-00d360fa36e5@linux.ibm.com>
References: <20211203154321.13168-1-ldufour@linux.ibm.com>
 <87bl1so588.fsf@linux.ibm.com>
 <bbaa0d78-a09f-3ce3-25a9-67434039b741@linux.ibm.com>
 <878rwwny1l.fsf@linux.ibm.com>
 <21eb4749-42b1-da78-8833-00d360fa36e5@linux.ibm.com>
Date:   Wed, 08 Dec 2021 09:21:29 -0600
Message-ID: <874k7jnmva.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5SUFZv8zyIlLHlETlpA7y8qaT_Ol3sDl
X-Proofpoint-ORIG-GUID: 5SUFZv8zyIlLHlETlpA7y8qaT_Ol3sDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_06,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> On 07/12/2021, 18:07:50, Nathan Lynch wrote:
>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>> On 07/12/2021, 15:32:39, Nathan Lynch wrote:
>>>> Is there a reasonable fallback for VMs where this parameter doesn't
>>>> exist? PowerVM partitions should always have it, but what do we want the
>>>> behavior to be on other hypervisors?
>>>
>>> In that case, there is no value displayed in the /proc/powerpc/lparcfg and
>>> the lparstat -i command will fall back to the device tree value. I can't
>>> see any valid reason to report the value defined in the device tree
>>> here.
>> 
>> Here's a valid reason :-)
>> 
>> lparstat isn't the only possible consumer of the interface, and the
>> 'ibm,partition-name' property and the dynamic system parameter clearly
>> serve a common purpose. 'ibm,partition-name' is provided by qemu.
>
> If the hypervisor is not providing this value, this is not the goal of this
> interface to fetch it from the device tree.
>
> Any consumer should be able to fall back on the device tree value, and
> there is no added value to do such a trick in the kernel when it can be
> done in the user space.

There is value in imposing a level of abstraction so that the semantics
are:

* Report the name assigned to the guest by the hosting environment, if
  available

as opposed to

* Return the string returned by a RTAS call to ibm,get-system-parameter
  with token 55, if implemented

The benefit is that consumers of lparcfg do not have to be coded with
the knowledge that "if a partition_name= line is absent, the
ibm,get-system-parameter RTAS call must have failed, so now I should
read /sys/firmware/devicetree/base/ibm,partition_name." That's the sort
of esoterica that is appropriate for the kernel to encapsulate.

And I'd say the effort involved (falling back to a root node property
lookup) is proportional to the benefit.
