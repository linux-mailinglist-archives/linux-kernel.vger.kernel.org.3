Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4CE5342BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbiEYSNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiEYSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:13:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C549FB3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:13:39 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PI8XMW014637;
        Wed, 25 May 2022 18:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c90VbzludSe3WWR2dEBJQIzAKyerhT/hAYy8bxFqBEU=;
 b=deeCDdyodGzbDAmhn0G3wA9nDJxJPWtwaSgAPMrvweoMAjgYVt8wl/RxXbt+IZZVBdsT
 9T8YtiO9yHoeBBRDlRbV8uLxA2oro/gvoTaNvH+JuCqg3XnFXsfCa3n8waf9pHgAlWdh
 OTtRm7Xae+B7hwTCm0uLNvMuwtsnX45Sgklp0SkkkXRKqXdrKnx+fIXmFBoo644A0Kmh
 vkVkQ+TRDwiuKRIY3JlfCaHAzYCcnHXXZtpR3S6MAqYIIJTwzdW2d5alcZhmUq3NmYAI
 Jjv9KBRJmoi8g17c3hd0yL6ZP89WZUe24Ykqj0/b8HcEKmFXf1Uts1R1yFVhOdoZ2thh 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9s3q8frc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 18:13:00 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24PI98fF015922;
        Wed, 25 May 2022 18:13:00 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9s3q8fqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 18:12:59 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24PI2Z7N013807;
        Wed, 25 May 2022 18:12:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3g93ux1hc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 18:12:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PICtIm17826102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 18:12:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02883A404D;
        Wed, 25 May 2022 18:12:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C52F2A4040;
        Wed, 25 May 2022 18:12:50 +0000 (GMT)
Received: from [9.43.39.177] (unknown [9.43.39.177])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 May 2022 18:12:50 +0000 (GMT)
Message-ID: <0d2a6ea3-71cc-a8e1-22eb-7b66f533b3bf@linux.vnet.ibm.com>
Date:   Wed, 25 May 2022 23:42:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 0/7] objtool: Enable and implement --mcount option
 on powerpc
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>
References: <cover.1653398233.git.christophe.leroy@csgroup.eu>
 <ac4e3ceb-7de8-2c3f-4689-1730d811bf3d@linux.vnet.ibm.com>
 <ea64b232-e002-9317-dca1-c5933fb94e03@csgroup.eu>
From:   Sathvika Vasireddy <sv@linux.vnet.ibm.com>
In-Reply-To: <ea64b232-e002-9317-dca1-c5933fb94e03@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2DRrvEcSudu_hcGNc-97UCTObC7drrD3
X-Proofpoint-ORIG-GUID: JfemvQlEl5pCKZ1PoKYAgx743ovQKMga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_04,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205250089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/05/22 23:09, Christophe Leroy wrote:
> Hi Sathvika,
>
> Le 25/05/2022 à 12:14, Sathvika Vasireddy a écrit :
>> Hi Christophe,
>>
>> On 24/05/22 18:47, Christophe Leroy wrote:
>>> This draft series adds PPC32 support to Sathvika's series.
>>> Verified on pmac32 on QEMU.
>>>
>>> It should in principle also work for PPC64 BE but for the time being
>>> something goes wrong. In the beginning I had a segfaut hence the first
>>> patch. But I still get no mcount section in the files.
>> Since PPC64 BE uses older elfv1 ABI, it prepends a dot to symbols.
>> And so, the relocation records in case of PPC64BE point to "._mcount",
>> rather than just "_mcount". We should be looking for "._mcount" to be
>> able to generate mcount_loc section in the files.
>>
>> Like:
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 70be5a72e838..7da5bf8c7236 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -2185,7 +2185,7 @@ static int classify_symbols(struct objtool_file
>> *file)
>>                           if (arch_is_retpoline(func))
>>                                   func->retpoline_thunk = true;
>>
>> -                       if ((!strcmp(func->name, "__fentry__")) ||
>> (!strcmp(func->name, "_mcount")))
>> +                       if ((!strcmp(func->name, "__fentry__")) ||
>> (!strcmp(func->name, "_mcount")) || (!strcmp(func->name, "._mcount")))
>>                                   func->fentry = true;
>>
>>                           if (is_profiling_func(func->name))
>>
>>
>> With this change, I could see __mcount_loc section being
>> generated in individual ppc64be object files.
>>
> Or should we implement an equivalent of arch_ftrace_match_adjust() in
> objtool ?

Yeah, I think it makes more sense if we make it arch specific.
Thanks for the suggestion. I'll make this change in next revision :-)

- Sathvika


