Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E855A2B03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiHZPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344603AbiHZPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:20:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6AE395C;
        Fri, 26 Aug 2022 08:13:52 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QFBkSF004766;
        Fri, 26 Aug 2022 15:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qkRQUQoVJ2NaZXBHU8Y4slmyi1yVQH8/k3SrHjhWtT8=;
 b=NY+KNv5S079Bq1NodJa3Ns4ZYcfGh2z1t4ifBKqJp2q6qmsay2IGNiT0uPjxk7cXDwSx
 4d+ZZs3atp7Bbv55w/GarW3xdrKmhXrXeT+rULT6MVGlosEtHraY0OVGZVOhh0zz/VL3
 nmxeTb6eCMXzzZHGZNxusjtiMWR4Dzz3fi6sZoq7U5P5H49FUnOANgph34mCAgmoHIEU
 kPtWVx1ZVXZcdE5FL5L5+p01SmdRYHyAXaoAfnk+MnV4gnmL2/dZpFEVVqbKMRKiR5wM
 iOzRUw9Py8Inx6SamZU+JcBB+v6vjmlJJ1AQlR+jdjVpRJyDWpL6/kDBPLU9yHtJVu1G Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j70kr81gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 15:13:44 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27QFDhMN016518;
        Fri, 26 Aug 2022 15:13:43 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j70kr81ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 15:13:43 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27QEnmeK016814;
        Fri, 26 Aug 2022 15:13:42 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 3j2q8aeucw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 15:13:42 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27QFDgoc9437588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 15:13:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF151AE060;
        Fri, 26 Aug 2022 15:13:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD256AE05C;
        Fri, 26 Aug 2022 15:13:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Aug 2022 15:13:41 +0000 (GMT)
Message-ID: <9645e3f7-a569-b72a-2516-d75959040336@linux.ibm.com>
Date:   Fri, 26 Aug 2022 11:13:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Content-Language: en-US
To:     Denis Kenzior <denkenz@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220826145119.9375-1-denkenz@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220826145119.9375-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mtJ0x2AnGVnzcctXSRlmf4-F5bKXnZRQ
X-Proofpoint-GUID: _iAQTqCXX8AT1Y04_Oj2bh2ojgRnpPPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/22 10:51, Denis Kenzior wrote:
> When support for ECDSA keys was added, constraints for data & signature
> sizes were never updated.  This makes it impossible to use such keys via
> keyctl API from userspace.
> 
> Update constraint on max_data_size to 64 bytes in order to support
> SHA512-based signatures. Also update the signature length constraints
> per ECDSA signature encoding described in RFC 5480.
> 
> Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
> 
> Version History:
> 
>    v2: Update patch description according to Jarkko's comments.  No
>    functional code changes.
> 
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
