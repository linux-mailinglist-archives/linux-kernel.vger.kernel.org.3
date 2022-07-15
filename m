Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D73D576939
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGOVxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiGOVxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:53:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB7488752;
        Fri, 15 Jul 2022 14:53:16 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FJb9Rw017003;
        Fri, 15 Jul 2022 21:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xEsbWzo7tDk/z11XoXB7E6aUnOCq/Vviu8d4ley9Vug=;
 b=QQiEfdboqUHoewMHKtC5FU/H/a+vX6XnZpSIXowNKqVpiHvKKYMd5hRIChIQ8lvTMj5H
 4eMYAJ6MCwwfe9+hvMKFe2bUEx7j93P5oZP7oIlVDBhPKIvF2PwRyAXVfqAj1wG597SY
 Nw5jf5XcR20AWugSmFTOq2KGjuP/ky4Cfsvnjc/vpGDmAlOQmBHBYzt4o4DZ0Fcghf0s
 2Be5jqIC+UT9uXEbhA/VsolnWGEUb44hH2TlLvR0+W+43BsmmEmtlgOXpTYd3+ntlCnZ
 cqoJvjlhIMyAc9iAICwpgjInp/G4fLHDjR9SJeVj2KpB6wLXkSN9CDU/iH6J/5Hulve8 vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hbbh0eds3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 21:53:11 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26FLYUCE004798;
        Fri, 15 Jul 2022 21:53:10 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hbbh0eds0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 21:53:10 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26FLptUJ012667;
        Fri, 15 Jul 2022 21:53:10 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3h71aa3hbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 21:53:10 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26FLr9jj2097756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 21:53:09 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8C5CAC05F;
        Fri, 15 Jul 2022 21:53:09 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71388AC05E;
        Fri, 15 Jul 2022 21:53:09 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jul 2022 21:53:09 +0000 (GMT)
Message-ID: <4b82b766-4482-762f-f366-cf5a47321ef7@linux.ibm.com>
Date:   Fri, 15 Jul 2022 17:53:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Content-Language: en-US
To:     Denis Kenzior <denkenz@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220715182810.30505-1-denkenz@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220715182810.30505-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 232kP6svoJql8Y8Z_Td0NSrqJfEq6KQD
X-Proofpoint-ORIG-GUID: dSB4sike6dYJXvFwX9nmqREVCTmAkyJ3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_13,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/22 14:28, Denis Kenzior wrote:
> When support for ECDSA keys was added, constraints for data & signature
> sizes were never updated.  This makes it impossible to use such keys via
> keyctl API from userspace; fix that.
> 
> Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
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


This part matches what I wrote about here: 
https://lore.kernel.org/linux-integrity/127811ae-ef71-d225-0450-710a6ee6afef@linux.ibm.com/T/#m7aea8ca697e7c35773c3f8f110329553f4f8d91e

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> +	} else {
> +		info->max_data_size = len;
> +		info->max_sig_size = len;
> +	}
> +
>   	info->max_enc_size = len;
>   	info->max_dec_size = len;
>   	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
