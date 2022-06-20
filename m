Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30155115B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiFTHSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbiFTHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:18:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E2DF45;
        Mon, 20 Jun 2022 00:18:46 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K7FtNo016906;
        Mon, 20 Jun 2022 07:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IXPS0hxb2WsPVstdS80ZS9yicyCYhnEl/7vD2drjTP4=;
 b=GHSbyoInDtnWCSbySiwdMDHRJ9aDWqn1r5ZC1ZYhfRBUguFfT6K6oNC2lULbOHRUmo/H
 KVvSVljd9JOxiLdvHIluwTmf3/FZZcZl/05OE2D6aZKixoEokKWd7vYq4bK1bOxyXcsB
 SUvhSu8yJIlz52bL7Hpw3kP+c2UXaK9Uw8e4g1J9o3ZHrTENrBqTGoINkqh1O9mPWfsP
 KAGN5jb1QrfDXxfwD3h9tbfBit9bxx52+6L2oeJ33RbEKu8TW6Zy4gYOS301n7ieNhYF
 emAxgRmzrWEpCan79qghju/nVY2DoZ6+hHSC0S7a/33RpciDGJkTp0nsqCOOL4iNb4nl yg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsrqt0v3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 07:18:42 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K77ilh012066;
        Mon, 20 Jun 2022 07:18:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3gs6b8sn1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 07:18:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K7IcUX19071430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 07:18:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA054203F;
        Mon, 20 Jun 2022 07:18:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9871B42041;
        Mon, 20 Jun 2022 07:18:37 +0000 (GMT)
Received: from [9.171.78.67] (unknown [9.171.78.67])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jun 2022 07:18:37 +0000 (GMT)
Message-ID: <9ef06123-b44f-b009-5bf5-60ad27bbede7@linux.ibm.com>
Date:   Mon, 20 Jun 2022 09:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] s390/kvm: avoid hypfs error message
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220607123314.10255-1-jgross@suse.com>
 <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <5431f626-9bd3-ed54-9889-aafbba9ca3e0@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zw-vnw8fT7O8emOlwCa-pj0E_NR-o1AD
X-Proofpoint-ORIG-GUID: Zw-vnw8fT7O8emOlwCa-pj0E_NR-o1AD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.06.22 um 08:03 schrieb Juergen Gross:
> Ping?
> 
> On 07.06.22 14:33, Juergen Gross wrote:
>> When booting under KVM the following error messages are issued:
>>
>> hypfs.7f5705: The hardware system does not support hypfs
>> hypfs.7a79f0: Initialization of hypfs failed with rc=-61
>>
>> While being documented, they can easily be avoided by bailing out of
>> hypfs_init() early in case of running as a KVM guest.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/s390/hypfs/inode.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
>> index 5c97f48cea91..bdf078f3c641 100644
>> --- a/arch/s390/hypfs/inode.c
>> +++ b/arch/s390/hypfs/inode.c
>> @@ -464,6 +464,9 @@ static int __init hypfs_init(void)
>>   {
>>       int rc;
>> +    if (MACHINE_IS_KVM)
>> +        return -ENODATA;
>> +
>>       hypfs_dbfs_init();
>>       if (hypfs_diag_init()) {

In case KVM implements hypfs this check would then be wrong.
Question to people on CC/TO.
Would it be an option to still check with KVM but avoid the error message.
So basically changing hypfs_diag_init and fail_dbfs_exit to check
for KVM on error?
Or is this worse?
