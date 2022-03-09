Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D44D3598
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiCIRQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiCIRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:15:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B62669;
        Wed,  9 Mar 2022 09:13:20 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229FZ7pX031743;
        Wed, 9 Mar 2022 17:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ERfmtCrOveRkJbrZVDECIm+95CvkUGw5l6XDtNMGZR8=;
 b=ThJK20YhdsNzKWFDPul1yUDK52WlcmG5oJEo57z4jL0jXnfwFSef+NDvviUVJ+nGJPDu
 Wh+tJ6i3iV8dr+ckCtzlYfw/fIEQ6L7/nQeQhwJAoSfmEy8nX/ytVYQL8RHXj5XJsbPH
 hLZEL1k/tfEI42Zpkx15jmu+a5D51G5wSKRvZnlVmI5M6cunOqkgVuf1zxIKVmUtyTVS
 FBbiOVrA/PXnHx3uzeQiTf/UJIpRVWwm8MPvxnlkyisOxHqIH7MDML9esX3lqumy8E58
 bu5ZwgTiSA6N3ZHTVGMCml2VepXdReQkYXFpsNAzPSq/kdp/03t0ZTREDc7laW4TTA9P cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep1077340-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 17:12:49 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 229Gv4Ne001953;
        Wed, 9 Mar 2022 17:12:48 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep107733j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 17:12:48 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229HChND022064;
        Wed, 9 Mar 2022 17:12:47 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3emy8hanpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 17:12:47 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229HCjJe22610408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 17:12:45 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2940BE05F;
        Wed,  9 Mar 2022 17:12:45 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8C4DBE058;
        Wed,  9 Mar 2022 17:12:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 17:12:42 +0000 (GMT)
Message-ID: <930d970d-0120-d3f0-939a-b5ef3b596318@linux.ibm.com>
Date:   Wed, 9 Mar 2022 12:12:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>
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
 <068F32E0-B202-4B20-9DE7-57373EF71BFE@oracle.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <068F32E0-B202-4B20-9DE7-57373EF71BFE@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rqnPdFEcO6soykUtSB6sY7xeZNaeIZxc
X-Proofpoint-GUID: F7UnrJsWqoGVmzw3lmyFlc0pK--_0eBm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_07,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/22 13:02, Eric Snowberg wrote:
> 
> 
>> On Mar 8, 2022, at 5:45 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Mon, 2022-03-07 at 21:31 -0500, Stefan Berger wrote:
>>>
>>> On 3/7/22 18:38, Eric Snowberg wrote:
>>>>
>>>>
>>>>> On Mar 7, 2022, at 4:01 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>>
>>>>> On Mon, 2022-03-07 at 18:06 +0000, Eric Snowberg wrote:
>>>>>>
>>>>>>>> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
>>>>>>>> index 6b1ac5f5896a..49bb2ea7f609 100644
>>>>>>>> --- a/crypto/asymmetric_keys/restrict.c
>>>>>>>> +++ b/crypto/asymmetric_keys/restrict.c
>>>>>>>> @@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
>>>>>>>> 	return ret;
>>>>>>>> }
>>>>>>>> +/**
>>>>>>>> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
>>>>>>>> + * @dest_keyring: Keyring being linked to.
>>>>>>>> + * @type: The type of key being added.
>>>>>>>> + * @payload: The payload of the new key.
>>>>>>>> + * @trust_keyring: Unused.
>>>>>>>> + *
>>>>>>>> + * Check if the new certificate is a CA. If it is a CA, then mark the new
>>>>>>>> + * certificate as being ok to link.
>>>>>>>
>>>>>>> CA = root CA here, right?
>>>>>>
>>>>>> Yes, I’ll update the comment
>>>>>
>>>>> Updating the comment is not enough.  There's an existing function named
>>>>> "x509_check_for_self_signed()" which determines whether the certificate
>>>>> is self-signed.
>>>>
>>>> Originally I tried using that function.  However when the restrict link code is called,
>>>> all the necessary x509 information is no longer available.   The code in
>>>> restrict_link_by_ca is basically doing the equivalent to x509_check_for_self_signed.
>>>> After verifying the cert has the CA flag set, the call to public_key_verify_signature
>>>> validates the cert is self signed.
>>>>
>>> Isn't x509_cert_parse() being called as part of parsing the certificate?
>>> If so, it seems to check for a self-signed certificate every time. You
>>> could add something like the following to x509_check_for_self_signed(cert):
>>> pub->x509_self_signed = cert->self_signed = true;
>>>
>>> This could then reduce the function in 3/4 to something like:
>>>
>>> return payload->data[asym_crypto]->x509_self_signed;
> 
> When I was studying the restriction code, before writing this patch, it looked like
> it was written from the standpoint to be as generic as possible.  All code contained
> within it works on either a public_key_signature or a public_key.  I had assumed it
> was written this way to be used with different asymmetrical key types now and in
> the future. I called the public_key_verify_signature function instead of interrogating
> the x509 payload to keep in line with what I thought was the original design. Let me
> know if I should be carrying x509 code in here to make the change above.

It does not seem right if there were two functions trying to determine 
whether an x509 cert is self-signed. The existing is invoked as part of 
loading a key onto the machine keyring from what I can see. It has 
access to more data about the cert and therefore can do stronger tests, 
yours doesn't have access to the data. So I guess I would remember in a 
boolean in the public key structure that the x509 cert it comes from was 
self signed following the existing test. Key in your function may be 
that that payload->data[] array is guaranteed to be from the x509 cert 
as set in x509_key_preparse().

https://elixir.bootlin.com/linux/v5.17-rc7/source/crypto/asymmetric_keys/x509_public_key.c#L236

    StefanIt does not seem right if there were two functions trying to 
determine whether an x509 cert is self-signed. The existing is invoked 
as part of loading a key onto the machine keyring from what I can see. 
It has access to more data about the cert and therefore can do stronger 
tests, yours doesn't have access to the data. So I guess I would 
remember in a boolean in the public key structure that the x509 cert it 
comes from was self signed following the existing test. Key in your 
function may be that that payload->data[] array is guaranteed to be from 
the x509 cert as set in x509_key_preparse().

https://elixir.bootlin.com/linux/v5.17-rc7/source/crypto/asymmetric_keys/x509_public_key.c#L236

    Stefan
