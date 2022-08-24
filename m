Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9762A5A0240
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiHXTqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHXTqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:46:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6379A6E;
        Wed, 24 Aug 2022 12:46:03 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OJPM1n007073;
        Wed, 24 Aug 2022 19:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ncbFd3RKOyk3UBhCn1Wb6P/0yuzM8GZ5YQYqxjnzXfw=;
 b=SziQgu3BHzOq4IV5KalKdIbLWPwFp6pahley1QZf+lApCWrXvA4eTx5lJQEEt7GtTrUo
 Mx0Kt5YXwzQu9SwDwOnPSrWcshyNg4XL0s+XDtUCRpruLmUJzmsOlRBBKVH3tL5iUpPH
 2tK4gwxxMMDWWl+2MygM/NCqMMqJyJn1Ez/D48rw55fXkNRWdd6dpWEQwkmJNWJ1iuoz
 ZYy1IGBdopofl/OVvgUwd/FAC6MYUFIAbvYmSNA4U7tziSepWVpnGMvlqQMrj12prvST
 S4gIcanE4VthxAAVwrm2ekjvGL4BPIz22WysksnKDIPIgOhj2V6mPTIABO2ClF0Fs+eM KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5t4qgpaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 19:45:54 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27OJQiCF010408;
        Wed, 24 Aug 2022 19:45:53 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5t4qgpa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 19:45:53 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27OJZ44u019983;
        Wed, 24 Aug 2022 19:45:52 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3j2q8a9yjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 19:45:52 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27OJjpEI5440224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 19:45:51 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D3DABE056;
        Wed, 24 Aug 2022 19:46:35 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CA48BE053;
        Wed, 24 Aug 2022 19:46:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Aug 2022 19:46:34 +0000 (GMT)
Message-ID: <1d0557ec-82a4-564f-fb6e-219966b2c600@linux.ibm.com>
Date:   Wed, 24 Aug 2022 15:45:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RESEND PATCH] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Content-Language: en-US
To:     Denis Kenzior <denkenz@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824190409.4286-1-denkenz@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220824190409.4286-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WOtspsK91uZIN07azF1R84a7Qb8_hmsb
X-Proofpoint-ORIG-GUID: ThmQ7FUkRWPYNM_6YVqF2dCLSV_f_77p
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/22 15:04, Denis Kenzior wrote:
> When support for ECDSA keys was added, constraints for data & signature
> sizes were never updated.  This makes it impossible to use such keys via
> keyctl API from userspace; fix that.
> 
> Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>

Same comment again as here: 
https://lore.kernel.org/all/4b82b766-4482-762f-f366-cf5a47321ef7@linux.ibm.com/#t

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   crypto/asymmetric_keys/public_key.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 2f8352e88860..eca5671ad3f2 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -186,8 +186,28 @@ static int software_key_query(const struct kernel_pkey_params *params,
>   
>   	len = crypto_akcipher_maxsize(tfm);
>   	info->key_size = len * 8;
> -	info->max_data_size = len;
> -	info->max_sig_size = len;
> +
> +	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
> +		/*
> +		 * ECDSA key sizes are much smaller than RSA, and thus could
> +		 * operate on (hashed) inputs that are larger than key size.
> +		 * For example SHA384-hashed input used with secp256r1
> +		 * based keys.  Set max_data_size to be at least as large as
> +		 * the largest supported hash size (SHA512)
> +		 */
> +		info->max_data_size = 64;
> +
> +		/*
> +		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
> +		 * which is actually 2 'key_size'-bit integers encoded in
> +		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> +		 */
> +		info->max_sig_size = 2 * (len + 3) + 2;
> +	} else {
> +		info->max_data_size = len;
> +		info->max_sig_size = len;
> +	}
> +
>   	info->max_enc_size = len;
>   	info->max_dec_size = len;
>   	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
