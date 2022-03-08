Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9964D0E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbiCHCcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiCHCcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:32:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6618F35DE9;
        Mon,  7 Mar 2022 18:31:44 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2281NISf012621;
        Tue, 8 Mar 2022 02:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pem2LRWua62Gj1EwQLYWIUQJFcSzowZruXSnDTsOI/M=;
 b=N5PAUuplRwFJjlGbOQiPmCgYX1zKpPPsIFGSJbVsgpZBxWr9Ev7raMO2QLlDcxu2voFn
 HghmurKP3vK2mu1YkYcRfSPnIUnupClhdhW0i5PGjdVGufmV88hbTtV6iODr8H8vQl0T
 a9z4fkNZ4kUxHeYnNFX2GSAVM97pi98iZPnQYu9ls/dx5w3hFGjN2hQXzHFassA/fqAD
 KE+zYJQMgCKaihVv0pWC/rtWaT8qds+FvswlutJIJToYKyU9Xvovw1JO2N+U4IdiaPgK
 aWaAeJpWcbg/6qLPMnDtfFs4RbYVlk64fZAmOQv4GP6a/rG5iaUUQzkeJBhQYx4NWoBb OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3enwegrx5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 02:31:27 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2282QXLa014207;
        Tue, 8 Mar 2022 02:31:26 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3enwegrx57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 02:31:26 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2282HpDB024805;
        Tue, 8 Mar 2022 02:31:26 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3ekyg921pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 02:31:26 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2282VO4l17302104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 02:31:24 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D28626A047;
        Tue,  8 Mar 2022 02:31:24 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EAA66A04F;
        Tue,  8 Mar 2022 02:31:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 02:31:21 +0000 (GMT)
Message-ID: <22860730-d615-5683-6af0-05b6f4f3e71d@linux.ibm.com>
Date:   Mon, 7 Mar 2022 21:31:21 -0500
MIME-Version: 1.0
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <67456A73-8B72-4DB6-8E23-7C603661A0A4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: niRBz8tVgOm5ryOaD3F9qE65KNsF8t0m
X-Proofpoint-ORIG-GUID: FHLxAsBlhdbLXzyX9mGYubIMSOQXBE-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_12,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080000
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/22 18:38, Eric Snowberg wrote:
> 
> 
>> On Mar 7, 2022, at 4:01 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Mon, 2022-03-07 at 18:06 +0000, Eric Snowberg wrote:
>>>
>>>>> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
>>>>> index 6b1ac5f5896a..49bb2ea7f609 100644
>>>>> --- a/crypto/asymmetric_keys/restrict.c
>>>>> +++ b/crypto/asymmetric_keys/restrict.c
>>>>> @@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
>>>>> 	return ret;
>>>>> }
>>>>> +/**
>>>>> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
>>>>> + * @dest_keyring: Keyring being linked to.
>>>>> + * @type: The type of key being added.
>>>>> + * @payload: The payload of the new key.
>>>>> + * @trust_keyring: Unused.
>>>>> + *
>>>>> + * Check if the new certificate is a CA. If it is a CA, then mark the new
>>>>> + * certificate as being ok to link.
>>>>
>>>> CA = root CA here, right?
>>>
>>> Yes, I’ll update the comment
>>
>> Updating the comment is not enough.  There's an existing function named
>> "x509_check_for_self_signed()" which determines whether the certificate
>> is self-signed.
> 
> Originally I tried using that function.  However when the restrict link code is called,
> all the necessary x509 information is no longer available.   The code in
> restrict_link_by_ca is basically doing the equivalent to x509_check_for_self_signed.
> After verifying the cert has the CA flag set, the call to public_key_verify_signature
> validates the cert is self signed.
> 
Isn't x509_cert_parse() being called as part of parsing the certificate? 
If so, it seems to check for a self-signed certificate every time. You 
could add something like the following to x509_check_for_self_signed(cert):
pub->x509_self_signed = cert->self_signed = true;

This could then reduce the function in 3/4 to something like:

return payload->data[asym_crypto]->x509_self_signed;


    Stefan
