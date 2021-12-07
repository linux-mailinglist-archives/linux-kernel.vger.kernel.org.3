Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8946C19F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhLGRW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:22:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23450 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhLGRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:22:21 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7HH5FJ022552;
        Tue, 7 Dec 2021 17:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QxV2tw2tjM5M1L/58DcErHtSO1zHiIB9Bom4uCv2GMw=;
 b=LMR/UTwuNDRQn7uqgr/dZBQQznDL/UoAC+MDaPruUjWsfqjq/XuU1ezH2OnkzwenUpoD
 tzVAL44TxZS9wbq9EPzJ7R4OoX1l+qu7lHcyg+RXAU/sXEKWHAGiBrNfEiCfGCqyRpSY
 Oyz6YgCG2EYJQP0XBS3gYGhbeMPI32aFn5GqWQGt9xzEPWZpmuxYPQwh33X9cop9U5ed
 P2vtGCCLY1W98pzjrRmcJcun0ilssnEZ+Cy/MpB/KEcuQg3iZlNWOJ/A9ZMdCXGX7bQL
 uzBWHchphES+QLdliKTFYaYoHORYa4nF5LJOL3IrCR8zudqNh514uNPRnfrkXyiOUIWK BQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ctbvkr166-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 17:18:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7HChjF031581;
        Tue, 7 Dec 2021 17:18:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3cqykj8trs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 17:18:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7HAxwW29753792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 17:10:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED9C4A4053;
        Tue,  7 Dec 2021 17:18:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C33EAA4059;
        Tue,  7 Dec 2021 17:18:40 +0000 (GMT)
Received: from [9.145.91.80] (unknown [9.145.91.80])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 17:18:40 +0000 (GMT)
Message-ID: <21eb4749-42b1-da78-8833-00d360fa36e5@linux.ibm.com>
Date:   Tue, 7 Dec 2021 18:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v3] powerpc/pseries: read the lpar name from the firmware
Content-Language: en-US
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20211203154321.13168-1-ldufour@linux.ibm.com>
 <87bl1so588.fsf@linux.ibm.com>
 <bbaa0d78-a09f-3ce3-25a9-67434039b741@linux.ibm.com>
 <878rwwny1l.fsf@linux.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <878rwwny1l.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gHiH90jZ6ysKt8fhD1Ti-QLiopl2muGO
X-Proofpoint-GUID: gHiH90jZ6ysKt8fhD1Ti-QLiopl2muGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021, 18:07:50, Nathan Lynch wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> On 07/12/2021, 15:32:39, Nathan Lynch wrote:
>>> Is there a reasonable fallback for VMs where this parameter doesn't
>>> exist? PowerVM partitions should always have it, but what do we want the
>>> behavior to be on other hypervisors?
>>
>> In that case, there is no value displayed in the /proc/powerpc/lparcfg and
>> the lparstat -i command will fall back to the device tree value. I can't
>> see any valid reason to report the value defined in the device tree
>> here.
> 
> Here's a valid reason :-)
> 
> lparstat isn't the only possible consumer of the interface, and the
> 'ibm,partition-name' property and the dynamic system parameter clearly
> serve a common purpose. 'ibm,partition-name' is provided by qemu.

If the hypervisor is not providing this value, this is not the goal of this
interface to fetch it from the device tree.

Any consumer should be able to fall back on the device tree value, and
there is no added value to do such a trick in the kernel when it can be
done in the user space.

> In any case, the function should not print an error when the return
> value is -3 (parameter not supported).

That's a valid requirement.

