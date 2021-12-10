Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D004700F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhLJMsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:48:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241161AbhLJMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:48:46 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BABGmXg002917;
        Fri, 10 Dec 2021 12:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BpJ9KVSCJ8ZQ9zK7QSKfVb6aWWCf7K6BxzU3qB4ulYU=;
 b=hRXiwZI1cBImue2/gg5Tch2tgaX+HNN2HGblxaSky7gh2J6nIfoyiQYrzKXPHhk+YmUU
 jM5fqJkf/KtR5nGr08nZI5mAGaMlWzjhIa/6mw3eX0vybDF8mCR6kHakjAbI9WFE9StP
 4qmVv/LGy0HrqgNMe92OIdD7n1Kwe9W/hbkEZXwPXvdXb57rZ7bndgK3Wcs4WwHOziCL
 tmht7CAPwPctCILf+rxBeGzuwvdCa9iCVz28UEIdX8FpSRWfQQCIn95mz8QzYhw8Nc6r
 JdJribNHO2ZK4/0aK/0bzUblxmtThPwAsgEIlMP7lUZ/5Jc21jBuzNlMQpy839/Q7bSr vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cv49nbkwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:44:57 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BACaTcA014524;
        Fri, 10 Dec 2021 12:44:56 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cv49nbkvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:44:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BACh81T009868;
        Fri, 10 Dec 2021 12:44:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3cqykk31pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:44:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BACiqXT34079152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:44:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FA0A5205F;
        Fri, 10 Dec 2021 12:44:52 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.72.154])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3D41752054;
        Fri, 10 Dec 2021 12:44:47 +0000 (GMT)
Subject: Re: [PATCH] tools/perf: remove unneeded variable make code cleaner
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     cgel.zte@gmail.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, chi.minghao@zte.com.cn,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
References: <20211210022911.424512-1-chi.minghao@zte.com.cn>
 <708b524c-2af5-98a1-f56a-4bb4f268de7a@linux.ibm.com>
 <20211210104203.GT16608@worktop.programming.kicks-ass.net>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <500a4cce-1e71-fd8a-8fa3-39eb09964e97@linux.ibm.com>
Date:   Fri, 10 Dec 2021 18:14:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210104203.GT16608@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gQdk6yDzIHg92xSTJhw9FQnD3NfrexX6
X-Proofpoint-GUID: Y1GG5TjhOmQDFvlgOR3MW-0anEzIvrBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=835 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112100070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/21 4:12 PM, Peter Zijlstra wrote:
> On Fri, Dec 10, 2021 at 02:41:55PM +0530, kajoljain wrote:
>>
>>
>> On 12/10/21 7:59 AM, cgel.zte@gmail.com wrote:
>>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>>
>>> return value form directly instead of
>>> taking this in another redundant variable.
>>
>> Can we reword the commit message stating what and
>> from where we are removing it. Its not too clear.
>> Other than that patch looks good to me.
>>
>> Reviewed-By: Kajol Jain<kjain@linux.ibm.com>
> 
> Never reply or accept email from cgel.zte@gmail.com, there's multiple
> people using it to send email, this cannot be right.
> 

Sure peter, Thanks for pointing it. Will take care next time.

Thanks,
Kajol Jain
