Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2548C46D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353375AbiALNKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:10:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240733AbiALNK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:10:28 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CC0nxE010267;
        Wed, 12 Jan 2022 13:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WE/h8p+zfUwl0XsOgyrkKm55pvwEA29XYRNXiHXrPs8=;
 b=IMJYWb8oloNk2epW2AqRtQWlsLoXMzEfJ6vfY7n8/M+w1pUA3Qs+z2+ZClahD28qRl9K
 6YSiT7gSEcQDvfc9SauuKO+3A8gF0YWgBxh6fP33pLOAQ7pupGR/HaGyWPOsZ1pSlSOJ
 Gaz3oxUigsKBdx0zNaCcZQjpVWpj2a9L33YJu42/g1KEIw7lyArOnuQQvGGpvxZdo7BV
 QDhnddl8nbIpND+FmWzDbSFZL5bBbEcWmeGcNip5lqO5iWHH3vS1CZOqQNQIxGNFmIzb
 YY5SybTmwIew0WS3W8Jd/G0/q058H120JUDV1JhWFM2ZdGwbASvuc/Qec55T2TK7uwOc PA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhtht0fj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 13:10:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20CD70cq025221;
        Wed, 12 Jan 2022 13:10:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3df289bxym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 13:10:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20CDAFwG34603438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 13:10:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7CE1AE04D;
        Wed, 12 Jan 2022 13:10:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 977C5AE058;
        Wed, 12 Jan 2022 13:10:15 +0000 (GMT)
Received: from [9.145.93.126] (unknown [9.145.93.126])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jan 2022 13:10:15 +0000 (GMT)
Message-ID: <ba78ac07-d3c1-ad7a-12eb-9bc53cdb9c43@linux.ibm.com>
Date:   Wed, 12 Jan 2022 14:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v5] powerpc/pseries: read the lpar name from the firmware
Content-Language: en-US
To:     Michael Ellerman <michaele@au1.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Nathan Lynch <nathanl@linux.ibm.com>
References: <20220106161339.74656-1-ldufour@linux.ibm.com>
 <c26f2961-dd19-b888-b601-af5ade74c140@linux.ibm.com>
 <87zgo128x0.fsf@mpe.ellerman.id.au>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <87zgo128x0.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: __8lH80r6UhtEQcTThHPRTptXKA3aFmv
X-Proofpoint-ORIG-GUID: __8lH80r6UhtEQcTThHPRTptXKA3aFmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022, 23:40:27, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
>> On 1/6/22 8:13 AM, Laurent Dufour wrote:
>>> The LPAR name may be changed after the LPAR has been started in the HMC.
>>> In that case lparstat command is not reporting the updated value because it
>>> reads it from the device tree which is read at boot time.
>>>
>>> However this value could be read from RTAS.
>>>
>>> Adding this value in the /proc/powerpc/lparcfg output allows to read the
>>> updated value.
>>>
>>> However the hypervisor, like Qemu/KVM, may not support this RTAS
>>> parameter. In that case the value reported in lparcfg is read from the
>>> device tree and so is not updated accordingly.
>>>
>>> Cc: Nathan Lynch <nathanl@linux.ibm.com>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>>
>> My only nit would be that in general for consistency with other function names
>> _RTAS_ and _DT_ should be lowercase. Seeing as they are statically scoped within
>> lparcfg.c maybe its ok. Otherwise,
> 
> Yeah I agree, I changed them to lower case when applying.

Thanks Michael and Tyrel.

