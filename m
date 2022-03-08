Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369CF4D19C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiCHN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347276AbiCHN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:58:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7049FB8;
        Tue,  8 Mar 2022 05:57:20 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228BiXU4028651;
        Tue, 8 Mar 2022 13:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Bno03ztPGdkb/J8OMRCEUOZu5BftkyZYzfREQxNRAoo=;
 b=E5DTplVyZ8W2Fgu7VQwdl39487vPJXPMlSSCzxl07dAbsDs3XbBBFVuIwamh11gpGcYW
 +6WEta6G3mo3wB7uDTZ0KSGN4FpuudE4IZknAs99SsskdQQQpE2CZwIftJ4she1gfHeJ
 gH9Lo/mTRImRjtz+MUFNpnyqi28RqLJvIcl30AAq4dhk2Uq7Zg/kx5CS7chXEagsV1q/
 AcoAyUbCHDGDSfSHPYNrqCPUUiVITouiscQlOjqHeJ4GfktWPg/gKR4jdgn0/xgkgdW9
 MthzFwOz1mt5SVALU2xReArmz8y21sV5HK3FwDIizVCI888B/dNcUG3nw6ky7K6AipSn RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep106924x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 13:57:04 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228DDX5L031586;
        Tue, 8 Mar 2022 13:57:04 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep106924n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 13:57:04 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228Dr1Jr003326;
        Tue, 8 Mar 2022 13:57:03 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 3ekyg9naqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 13:57:03 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228Dv2L033096134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 13:57:02 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08F576E053;
        Tue,  8 Mar 2022 13:57:02 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCCC56E050;
        Tue,  8 Mar 2022 13:56:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 13:56:58 +0000 (GMT)
Message-ID: <ea42a31d-f62e-83e0-f66c-215d8b27b5ad@linux.ibm.com>
Date:   Tue, 8 Mar 2022 08:56:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-4-eric.snowberg@oracle.com>
 <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
 <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
 <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
 <67456A73-8B72-4DB6-8E23-7C603661A0A4@oracle.com>
 <22860730-d615-5683-6af0-05b6f4f3e71d@linux.ibm.com>
 <e10f2161aaa69a9d301b3a16a37cbab266318aee.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <e10f2161aaa69a9d301b3a16a37cbab266318aee.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hsMouMnA1HlAehPOEBIP3TFkl6OzcKUf
X-Proofpoint-GUID: WgO2kkeG5uRK4-i-TJWwI5i7YARrGzeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/22 07:45, Mimi Zohar wrote:
> On Mon, 2022-03-07 at 21:31 -0500, Stefan Berger wrote:
>>
>> On 3/7/22 18:38, Eric Snowberg wrote:
>>>
>>>
>>>> On Mar 7, 2022, at 4:01 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>
>>>> On Mon, 2022-03-07 at 18:06 +0000, Eric Snowberg wrote:
>>>>>
>>>>>>> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
>>>>>>> index 6b1ac5f5896a..49bb2ea7f609 100644
>>>>>>> --- a/crypto/asymmetric_keys/restrict.c
>>>>>>> +++ b/crypto/asymmetric_keys/restrict.c
>>>>>>> @@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
>>>>>>> 	return ret;
>>>>>>> }
>>>>>>> +/**
>>>>>>> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
>>>>>>> + * @dest_keyring: Keyring being linked to.
>>>>>>> + * @type: The type of key being added.
>>>>>>> + * @payload: The payload of the new key.
>>>>>>> + * @trust_keyring: Unused.
>>>>>>> + *
>>>>>>> + * Check if the new certificate is a CA. If it is a CA, then mark the new
>>>>>>> + * certificate as being ok to link.
>>>>>>
>>>>>> CA = root CA here, right?
>>>>>
>>>>> Yes, I’ll update the comment
>>>>
>>>> Updating the comment is not enough.  There's an existing function named
>>>> "x509_check_for_self_signed()" which determines whether the certificate
>>>> is self-signed.
>>>
>>> Originally I tried using that function.  However when the restrict link code is called,
>>> all the necessary x509 information is no longer available.   The code in
>>> restrict_link_by_ca is basically doing the equivalent to x509_check_for_self_signed.
>>> After verifying the cert has the CA flag set, the call to public_key_verify_signature
>>> validates the cert is self signed.
>>>
>> Isn't x509_cert_parse() being called as part of parsing the certificate?
>> If so, it seems to check for a self-signed certificate every time. You
>> could add something like the following to x509_check_for_self_signed(cert):
>> pub->x509_self_signed = cert->self_signed = true;
>>
>> This could then reduce the function in 3/4 to something like:
>>
>> return payload->data[asym_crypto]->x509_self_signed;
> 
> Agreed, as long as the other two criteria are also met: CA and keyUsage
> should be required and limited to keyCertSign.

right, it's not as easy as the return statement above...

> 
> thanks,
> 
> Mimi
> 
