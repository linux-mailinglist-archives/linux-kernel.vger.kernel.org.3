Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1C5746BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiGNI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiGNI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:29:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FC21276C;
        Thu, 14 Jul 2022 01:29:31 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E7oGNj027583;
        Thu, 14 Jul 2022 08:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3jQ61/O3RHNvo+Uxn3UXtV6mB8X3oEHqZVGcKkyjFmM=;
 b=DkGoOQEd4Pjna7gj+9ooUVf+ax7155DiMy4BXWLq00tzPAhqWCgm3+9w++fENqs/Ye/q
 sAyV7hrMQ6V0xfRyRf7NRoaVLx0T1ErReoSw0OdQRb5qQEFqhz/cpk5B2pb8LmhzjRyg
 Qo9QjW9G67OlOXxIO6zpmPnwcopfU+bn0Zy5CwF/MXx7WNjI2GpC9xutxG9BpPg3jaEI
 Od3ZMjtGF/4CjVwERz6lZ9b+zehSRZ3k/qjf+f4fEoVmaS+/W0ZSEt8YF8nkAwne8bCH
 xwqAhDvSHzeJ7vPL1Tj0itVqCL/NDycRWIUO3tQeJ3VhqcYhQY7G6eFPTIISrkVdhJ8v tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3haf3m13ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 08:29:30 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26E7q4XI031870;
        Thu, 14 Jul 2022 08:29:30 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3haf3m13j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 08:29:29 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26E8KBRN026528;
        Thu, 14 Jul 2022 08:29:29 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3h9e04vtvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 08:29:29 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26E8TRwp29032822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 08:29:28 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6D76C6057;
        Thu, 14 Jul 2022 08:29:27 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 466AAC6063;
        Thu, 14 Jul 2022 08:29:26 +0000 (GMT)
Received: from [9.65.197.138] (unknown [9.65.197.138])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jul 2022 08:29:25 +0000 (GMT)
Message-ID: <d3984f3d-4e28-61fc-879c-ca38b7daa779@linux.ibm.com>
Date:   Thu, 14 Jul 2022 11:29:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Documentation: siphash: Fix typo in the name of
 offsetofend macro
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-doc@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
References: <20220712104455.1408150-1-dovmurik@linux.ibm.com>
 <87fsj6bhwb.fsf@meer.lwn.net> <Ys13bqGuPYBUGg3O@zx2c4.com>
 <87fsj44w9h.fsf@meer.lwn.net>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <87fsj44w9h.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hkqn6I2Qm3Ate44xNBFbuyoEWjdELzow
X-Proofpoint-GUID: 7_QH3cuDFgZZUbM0gwZm0ZMGbaVWd2TG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_06,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=728 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2022 23:01, Jonathan Corbet wrote:
> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> 
>> Hi Jon,
>>
>> On Tue, Jul 12, 2022 at 07:05:40AM -0600, Jonathan Corbet wrote:
>>> Dov Murik <dovmurik@linux.ibm.com> writes:
>>>
>>>> The siphash documentation misspelled "offsetendof" instead of
>>>> "offsetofend".
>>>>
>>>> Fixes: 2c956a60778cbb ("siphash: add cryptographically secure PRF")
>>>
>>> When you send a patch with a Fixes tag it's always a good idea to CC the
>>> author of the patch being fixed.  Adding Jason...let me know if you'd
>>> like me to grab this.
>>
>> Thanks for CC'ing me. Sure, feel free to take this:
>>
>>     Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Applied, thanks.

Thank you Jon.

I'll try to remember your tip about CC the author of the Fixes tag.

-Dov


> 
> jon
