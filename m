Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04194D396C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiCITDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiCITDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:03:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A00DF43;
        Wed,  9 Mar 2022 11:02:49 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Igtii028637;
        Wed, 9 Mar 2022 19:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=u455U2uzaGTy4XroNh75yJeEs9gW7zIyr+WZzL7o5O4=;
 b=dq2KBmxUgrXyTQ9bVRZ2TvYaJThUrjH0PK5HuCWcM24+K+U+v8ipx7Hx3kcMbCviemL4
 qpDDoqcIZUMzV7kBOEWRbUH+1ilF7RdSES6kL4Gl5z0XfD9teYZeQtvjBAdPMwEfxJYD
 gv5oWnC/xL2mMNnhHuZPvRoL028SUOSAUzKnhSU8jjxTCN/7eSKmukHx9hA+N+D6bZrl
 DBl9jHxuYiiZTaohIJUEwc2GB0dZZkrNfGStRPvafvQCXn6Rbt2iJLv3hSFh3q77zmEk
 1jWD0abeWr7MOgZhnFlrsoowNonN4Y1/FmJXkTfjGcqLPz8FWlAcRCBuf9So+tVOJWEX zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eny19aqnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 19:02:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 229Iha1H000932;
        Wed, 9 Mar 2022 19:02:28 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eny19aqmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 19:02:28 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229IgvBi032575;
        Wed, 9 Mar 2022 19:02:27 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3enk8xg2k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 19:02:27 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229J2OoN39977344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 19:02:25 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC9F1C6057;
        Wed,  9 Mar 2022 19:02:24 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2160C606D;
        Wed,  9 Mar 2022 19:02:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 19:02:22 +0000 (GMT)
Message-ID: <9ea53711-73ab-d242-9eb6-87497c8dc7ac@linux.ibm.com>
Date:   Wed, 9 Mar 2022 14:02:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
 <068F32E0-B202-4B20-9DE7-57373EF71BFE@oracle.com>
 <930d970d-0120-d3f0-939a-b5ef3b596318@linux.ibm.com>
 <B9A8F5BD-5FDE-4501-9C0A-865579C45627@oracle.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <B9A8F5BD-5FDE-4501-9C0A-865579C45627@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yp4_8YcLujAz14V6k3KiRojzhZwhPdK6
X-Proofpoint-ORIG-GUID: 5ZQTZpmKSS8gPamGYf7wDTk4nCC53n3x
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_07,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/22 13:13, Eric Snowberg wrote:
> 
> 
>> On Mar 9, 2022, at 10:12 AM, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 3/8/22 13:02, Eric Snowberg wrote:
>>>> On Mar 8, 2022, at 5:45 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>
>>>> On Mon, 2022-03-07 at 21:31 -0500, Stefan Berger wrote:
>>>>>
>>>>> On 3/7/22 18:38, Eric Snowberg wrote:
>>>>>>
>>>>>>
>>>>>>> On Mar 7, 2022, at 4:01 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>>>>
>>>>>>> On Mon, 2022-03-07 at 18:06 +0000, Eric Snowberg wrote:
>>>>>>>>
>>>>>>>>>> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
>>>>>>>>>> index 6b1ac5f5896a..49bb2ea7f609 100644
>>>>>>>>>> --- a/crypto/asymmetric_keys/restrict.c
>>>>>>>>>> +++ b/crypto/asymmetric_keys/restrict.c
>>>>>>>>>> @@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
>>>>>>>>>> 	return ret;
>>>>>>>>>> }
>>>>>>>>>> +/**
>>>>>>>>>> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
>>>>>>>>>> + * @dest_keyring: Keyring being linked to.
>>>>>>>>>> + * @type: The type of key being added.
>>>>>>>>>> + * @payload: The payload of the new key.
>>>>>>>>>> + * @trust_keyring: Unused.
>>>>>>>>>> + *
>>>>>>>>>> + * Check if the new certificate is a CA. If it is a CA, then mark the new
>>>>>>>>>> + * certificate as being ok to link.
>>>>>>>>>
>>>>>>>>> CA = root CA here, right?
>>>>>>>>
>>>>>>>> Yes, I’ll update the comment
>>>>>>>
>>>>>>> Updating the comment is not enough.  There's an existing function named
>>>>>>> "x509_check_for_self_signed()" which determines whether the certificate
>>>>>>> is self-signed.
>>>>>>
>>>>>> Originally I tried using that function.  However when the restrict link code is called,
>>>>>> all the necessary x509 information is no longer available.   The code in
>>>>>> restrict_link_by_ca is basically doing the equivalent to x509_check_for_self_signed.
>>>>>> After verifying the cert has the CA flag set, the call to public_key_verify_signature
>>>>>> validates the cert is self signed.
>>>>>>
>>>>> Isn't x509_cert_parse() being called as part of parsing the certificate?
>>>>> If so, it seems to check for a self-signed certificate every time. You
>>>>> could add something like the following to x509_check_for_self_signed(cert):
>>>>> pub->x509_self_signed = cert->self_signed = true;
>>>>>
>>>>> This could then reduce the function in 3/4 to something like:
>>>>>
>>>>> return payload->data[asym_crypto]->x509_self_signed;
>>> When I was studying the restriction code, before writing this patch, it looked like
>>> it was written from the standpoint to be as generic as possible.  All code contained
>>> within it works on either a public_key_signature or a public_key.  I had assumed it
>>> was written this way to be used with different asymmetrical key types now and in
>>> the future. I called the public_key_verify_signature function instead of interrogating
>>> the x509 payload to keep in line with what I thought was the original design. Let me
>>> know if I should be carrying x509 code in here to make the change above.
>>
>> It does not seem right if there were two functions trying to determine whether an x509 cert is self-signed. The existing is invoked as part of loading a key onto the machine keyring from what I can see. It has access to more data about the cert and therefore can do stronger tests, yours doesn't have access to the data. So I guess I would remember in a boolean in the public key structure that the x509 cert it comes from was self signed following the existing test. Key in your function may be that that payload->data[] array is guaranteed to be from the x509 cert as set in x509_key_preparse().
>>
>> https://elixir.bootlin.com/linux/v5.17-rc7/source/crypto/asymmetric_keys/x509_public_key.c#L236
> 
> I could add another bool to the public key structure to designate if the key was self signed,
> but this seems to go against what the kernel document states. "Asymmetric / Public-key
> Cryptography Key Type” [1] states:
> 
> "The “asymmetric” key type is designed to be a container for the keys used in public-key
> cryptography, without imposing any particular restrictions on the form or mechanism of
> the cryptography or form of the key.
> 
> The asymmetric key is given a subtype that defines what sort of data is associated with
> the key and provides operations to describe and destroy it. However, no requirement is
> made that the key data actually be stored in the key."
> 
> Now every public key type would need to fill in the information on whether the key is self
> signed or not.  Instead of going through the public_key_verify_signature function currently
> used in this patch.

Every public key extracted from a x509 certificate would have to set 
this field to true if the public key originates from a self-signed x509 
cert. Is this different from this code here where now every public key 
would have to set the key_is_ca field?

+		if (v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+			ctx->cert->pub->key_is_ca = true;

The extension I would have suggested looked similar:

cert->pub->x509_self_sign = cert->self_signed = true

[ to be put here: 
https://elixir.bootlin.com/linux/v5.17-rc7/source/crypto/asymmetric_keys/x509_public_key.c#L147 
]



> 
> https://docs.kernel.org/crypto/asymmetric-keys.html
> 
