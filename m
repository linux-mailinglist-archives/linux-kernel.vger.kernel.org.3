Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5B4CD7C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbiCDP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbiCDP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:29:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFE1B7609;
        Fri,  4 Mar 2022 07:28:29 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224ErmgO012060;
        Fri, 4 Mar 2022 15:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v5Se0jKm4CMv9uIVa6be0qCve1fQPCIql88P/RlscIA=;
 b=TRvzmKdRhjqQG5owYoA3iDZXDs8fOo4vA5+NtcI+bfol5C0RNiqHlufIkai16ejsDRPy
 0zQ18peXmYR8jxR1c0sK8nBzRImmgWdaQBS9BZHNuhFh5qjhW9C50VKk6ZvAdMAenBIA
 1WCHhsva/oe2qOqq4jzjV+PmBZhKjn43GrFuS/zEtLQzPvVxJdhaJMCWgfJNQ7SoLNOH
 bTikiOj6QK7wZJdd/hJxujVeil9aO385m7T/zlRPomqgs3fGKefUjWWcqbV1curyALyL
 9bHN0bRp9XeWSMZG+vxR97NF/4PdHu3jXYAZPSzP1yHYzNtjGY/82EOXQd8x6/590SeW ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ekmxe0r2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 15:28:15 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224FMRHb004683;
        Fri, 4 Mar 2022 15:28:14 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ekmxe0r28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 15:28:14 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224F3Vla026833;
        Fri, 4 Mar 2022 15:28:13 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3ek4kbdk9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 15:28:13 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 224FSCrJ32309540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 15:28:12 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2730228064;
        Fri,  4 Mar 2022 15:28:12 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC07328059;
        Fri,  4 Mar 2022 15:28:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  4 Mar 2022 15:28:11 +0000 (GMT)
Message-ID: <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
Date:   Fri, 4 Mar 2022 10:28:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>, zohar@linux.ibm.com,
        jarkko@kernel.org, dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-4-eric.snowberg@oracle.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220301173651.3435350-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RuNIIzeS8WIQ_TOMFwmjOBKOWyyIVYyO
X-Proofpoint-GUID: h-ySz9CxSLuwNKm-arhd5Et2R_ciAJ8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/1/22 12:36, Eric Snowberg wrote:
> Add a new link restriction.  Restrict the addition of keys in a keyring
> based on the key to be added being a CA.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>   crypto/asymmetric_keys/restrict.c | 43 +++++++++++++++++++++++++++++++
>   include/crypto/public_key.h       | 15 +++++++++++
>   2 files changed, 58 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> index 6b1ac5f5896a..49bb2ea7f609 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -108,6 +108,49 @@ int restrict_link_by_signature(struct key *dest_keyring,
>   	return ret;
>   }
>   
> +/**
> + * restrict_link_by_ca - Restrict additions to a ring of CA keys
> + * @dest_keyring: Keyring being linked to.
> + * @type: The type of key being added.
> + * @payload: The payload of the new key.
> + * @trust_keyring: Unused.
> + *
> + * Check if the new certificate is a CA. If it is a CA, then mark the new
> + * certificate as being ok to link.

CA = root CA here, right?


> + *
> + * Returns 0 if the new certificate was accepted, -ENOKEY if the
> + * certificate is not a CA. -ENOPKG if the signature uses unsupported
> + * crypto, or some other error if there is a matching certificate but
> + * the signature check cannot be performed.
> + */
> +int restrict_link_by_ca(struct key *dest_keyring,
> +			const struct key_type *type,
> +			const union key_payload *payload,
> +			struct key *trust_keyring)
This function needs to correspond to the key_restrict_link_func_t and 
therefore has 4 parameter. Call the unused 'trust_keyring' 'unused' instead?
> +{
> +	const struct public_key_signature *sig;
> +	const struct public_key *pkey;
> +
> +	if (type != &key_type_asymmetric)
> +		return -EOPNOTSUPP;
> +
> +	sig = payload->data[asym_auth];
> +	if (!sig)
> +		return -ENOPKG;
> +
> +	if (!sig->auth_ids[0] && !sig->auth_ids[1])
> +		return -ENOKEY;
> +
> +	pkey = payload->data[asym_crypto];
> +	if (!pkey)
> +		return -ENOPKG;
> +
> +	if (!pkey->key_is_ca)
> +		return -ENOKEY;
> +
> +	return public_key_verify_signature(pkey, sig);
> +}
> +

Comparing this to 'restrict_link_by_signature'... looks good.


>   static bool match_either_id(const struct asymmetric_key_id **pair,
>   			    const struct asymmetric_key_id *single)
>   {
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 0521241764b7..5eadb182a400 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -72,6 +72,21 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
>   						 const union key_payload *payload,
>   						 struct key *trusted);
>   
> +#if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
> +extern int restrict_link_by_ca(struct key *dest_keyring,
> +			       const struct key_type *type,
> +			       const union key_payload *payload,
> +			       struct key *trust_keyring);
> +#else
> +static inline int restrict_link_by_ca(struct key *dest_keyring,
> +				      const struct key_type *type,
> +				      const union key_payload *payload,
> +				      struct key *trust_keyring)
> +{
> +	return 0;
> +}
> +#endif
> +
>   extern int query_asymmetric_key(const struct kernel_pkey_params *,
>   				struct kernel_pkey_query *);
>   
