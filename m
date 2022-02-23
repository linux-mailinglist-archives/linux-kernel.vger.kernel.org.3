Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D687F4C1D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiBWUqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:46:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8B4DF42;
        Wed, 23 Feb 2022 12:45:48 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NKF4qL025832;
        Wed, 23 Feb 2022 20:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=P9w0LjnRQCmW7EIl3CKX1esvC4RSB5f2OeuFKGEk13c=;
 b=g6KGVONqoR3epSR3Sk66IR8orfxzPjeOotsnFTpRs7+3dIYV1ITLfSo89Kjyfa4E18N5
 jhoVGW+F/0mRKKq7azCingFJLIk6gzk7x2TN2LT6nkA4eYyYttA0lKALn+G1AiafyKrv
 pQvvQ+PdMxsQ2KutXWK1vQ7M3Q9E9OtKGfd1c4uTzi7sfybvl1UEuSjOpNpUKUw5W6xS
 JwsggxjwduLXrLmJuHfqFqk5HEkF8TKcOHIcuDxyBUbXff8rEC1ocryd80CtXyYIV7op
 DYJCXbnzEbOTzojJYL4hJCbK3RZBzaFtUtVxQGKqtXZv6XBRkWkJ9kmhrjqkrFyqOoGY Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edq0j8awa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 20:45:32 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NJhCRd002967;
        Wed, 23 Feb 2022 20:45:32 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edq0j8avw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 20:45:32 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NKi590010487;
        Wed, 23 Feb 2022 20:45:31 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3ear6bgqwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 20:45:31 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NKjRJo34537964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 20:45:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B615EBE063;
        Wed, 23 Feb 2022 20:45:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97F11BE058;
        Wed, 23 Feb 2022 20:45:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 20:45:26 +0000 (GMT)
Message-ID: <46156a90-d6a6-a0cc-247a-3ceb29f1cf75@linux.ibm.com>
Date:   Wed, 23 Feb 2022 15:45:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 26/27] ima: Limit number of policy rules in
 non-init_ima_ns
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-27-stefanb@linux.ibm.com>
 <5e4a862917785972281bbcb483404da01b71e801.camel@linux.ibm.com>
 <479f09e7-0d39-0281-45ef-5cce4861d24d@linux.ibm.com>
 <8a4f9cb6cab5ba04eb61e346d0fca16efa4c6703.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <8a4f9cb6cab5ba04eb61e346d0fca16efa4c6703.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YT3eMPXUv5ygLu07mnIhImeTmpUHMT9V
X-Proofpoint-GUID: SGRKohjMfnoameOg4zdckiqP5pmL7WYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202230116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/22 12:04, Mimi Zohar wrote:
> On Wed, 2022-02-23 at 11:37 -0500, Stefan Berger wrote:
>> On 2/23/22 10:38, Mimi Zohar wrote:
>>> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>>>> Limit the number of policy rules one can set in non-init_ima_ns to a
>>>> hardcoded 1024 rules. If the user attempts to exceed this limit by
>>>> setting too many additional rules, emit an audit message with the cause
>>>> 'too-many-rules' and simply ignore the newly added rules.
>>> This paragraph describes 'what' you're doing, not 'why'.  Please prefix
>>> this paragraph with a short, probably one sentence, reason for the
>>> change.
>>>> Switch the accounting for the memory allocated for IMA policy rules to
>>>> GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting takes effect.
>>> Does this change affect the existing IMA policy rules for init_ima_ns?
>> There's typically no cgroup for the int_ima_ns, so not effect on
>> init_ima_ns.
>>
>> Here's the updated text:
>>
>> Limit the number of policy rules one can set in non-init_ima_ns to a
>> hardcoded 1024 rules to restrict the amount of memory used for IMA's
>> policy.
> The question is "why" there should be a difference between the
> init_ima_ns and non-init_ima_ns cases.  Perhaps something like, "Only


Chistian had suggested it to not have the number of policy rules unbounded.


> host root with CAP_SYS_ADMIN may write init_ima_ns policy rules, but in
> the non-init_ima_ns case root in the namespace with CAP_MAC_ADMIN
> privileges may write IMA policy rules.  Limit the total number of IMA
> policy rules per namespace."

What does it have to do with CAP_SYS_ADMIN and CAP_MAC_ADMIN and why 
mention these here? It seem primarily a limit of number of rules to 
avoid huge kernel memory consumption in the case that a cgroup limit for 
memory was not set up.


>
>>   Ignore the added rules if the user attempts to exceed this
>> limit by setting too many additional rules.
>>
>> Switch the accounting for the memory allocated for IMA policy rules to
>> GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting takes effect.
>> This switch has no effect on the init_ima_ns.
> thanks,
>
> Mimi
>
