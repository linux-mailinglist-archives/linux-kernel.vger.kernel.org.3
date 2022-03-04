Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2624CD75B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiCDPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiCDPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:11:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF621C2332;
        Fri,  4 Mar 2022 07:10:54 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224DB0Yc014910;
        Fri, 4 Mar 2022 15:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ciIHhFJaJb75Cjc8NGM6MB6m0nC4s4N+phinFfx7gNs=;
 b=Y4GJXTOEJbiMndgkGKppBHTJsKK6kNydc/YWhoePimLI64mHX01DQe62DUDOgOR3HNwm
 q+UTro61PJ+jzpgPJ7VXYFVlmoWsY9rrf8fvdJZOtc4YYyAdix8BUijQ1OYjxUBPrPyU
 3gLCsRtCzJouLWyftqwFVHtiW+4nya2ZvZiljvNp69HpdAIRC5D71uAaardgLtM3UdLc
 3WTkAWVoh+HBOxwF5JP7MM6NRQYSoIDl14O2b+ermDKaRwCxEaD5lTBwDjxDls0Pisqz
 HEzVmvefs2bVd5Sf/vY6nxQXX3g5E0N8coBUGgZPdgOhpj/H68z5ZvpTTZ1yq7TJ2BuK 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekdcq9cxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 15:10:22 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224EIUkY013229;
        Fri, 4 Mar 2022 15:10:21 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekdcq9cxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 15:10:21 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224F3L9e022567;
        Fri, 4 Mar 2022 15:10:21 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 3ek4k9ngwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 15:10:21 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 224FAIHo12911226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 15:10:18 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67BD8112061;
        Fri,  4 Mar 2022 15:10:18 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43B19112065;
        Fri,  4 Mar 2022 15:10:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  4 Mar 2022 15:10:18 +0000 (GMT)
Message-ID: <b6e9eb1e-846c-c98e-ad16-c651b5e1dad7@linux.ibm.com>
Date:   Fri, 4 Mar 2022 10:10:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] X.509: Parse Basic Constraints for CA
Content-Language: en-US
To:     Eric Snowberg <eric.snowberg@oracle.com>, zohar@linux.ibm.com,
        jarkko@kernel.org, dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-3-eric.snowberg@oracle.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220301173651.3435350-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -IV59bcrT_bnon1M2ufEuXGdsyL4J80o
X-Proofpoint-GUID: jIXztiokg71__8i1rfcjmST00a2jpD05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
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
> Parse the X.509 Basic Constraints.  The basic constraints extension
> identifies whether the subject of the certificate is a CA.
>
> BasicConstraints ::= SEQUENCE {
>          cA                      BOOLEAN DEFAULT FALSE,
>          pathLenConstraint       INTEGER (0..MAX) OPTIONAL }
>
> If the CA is true, store it in a new public_key field call key_is_ca.
> This will be used in a follow on patch that requires knowing if the
> public key is a CA.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>   crypto/asymmetric_keys/x509_cert_parser.c | 9 +++++++++
>   include/crypto/public_key.h               | 1 +
>   2 files changed, 10 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 2899ed80bb18..38c907f4ce27 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -583,6 +583,15 @@ int x509_process_extension(void *context, size_t hdrlen,
>   		return 0;
>   	}
>   
> +	if (ctx->last_oid == OID_basicConstraints) {

Don't you have to check whether you can access v[0] and v[1]?

if (vlen < 3)

     return -EBADMSG;

or should it even be

if (vlen != 3)

      return -EBADMSG;


> +		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
> +			return -EBADMSG;
> +		if (v[1] != vlen - 2)
> +			return -EBADMSG;
> +		if (v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
> +			ctx->cert->pub->key_is_ca = true;
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 6d61695e1cde..0521241764b7 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -26,6 +26,7 @@ struct public_key {
>   	void *params;
>   	u32 paramlen;
>   	bool key_is_private;
> +	bool key_is_ca;
>   	const char *id_type;
>   	const char *pkey_algo;
>   };
