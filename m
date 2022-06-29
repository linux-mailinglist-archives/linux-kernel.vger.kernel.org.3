Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6255F4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiF2ENK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiF2EM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:12:57 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842EC396B8;
        Tue, 28 Jun 2022 21:12:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VHm8czW_1656475943;
Received: from 30.240.101.24(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VHm8czW_1656475943)
          by smtp.aliyun-inc.com;
          Wed, 29 Jun 2022 12:12:24 +0800
Message-ID: <be004040-a17b-bddb-b56d-eb569658f7a9@linux.alibaba.com>
Date:   Wed, 29 Jun 2022 12:12:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/2 RESEND] pkcs7: support EC-RDSA/streebog in
 SignerInfo
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Elvira Khabirova <e.khabirova@omp.ru>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220627092142.21095-1-tianjia.zhang@linux.alibaba.com>
 <20220627092142.21095-3-tianjia.zhang@linux.alibaba.com>
 <Yru5Xao3LSB0cChI@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Yru5Xao3LSB0cChI@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 6/29/22 10:31 AM, Jarkko Sakkinen wrote:
> On Mon, Jun 27, 2022 at 05:21:42PM +0800, Tianjia Zhang wrote:
>> From: Elvira Khabirova <e.khabirova@omp.ru>
>>
>> Allow using EC-RDSA/streebog in pkcs7 certificates in a similar way
>> to how it's done in the x509 parser.
>>
>> This is needed e.g. for loading kernel modules signed with EC-RDSA.
>>
>> Signed-off-by: Elvira Khabirova <e.khabirova@omp.ru>
>> Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
>> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   crypto/asymmetric_keys/pkcs7_parser.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
>> index 24e2e4a6d842..277482bb1777 100644
>> --- a/crypto/asymmetric_keys/pkcs7_parser.c
>> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
>> @@ -251,6 +251,12 @@ int pkcs7_sig_note_digest_algo(void *context, size_t hdrlen,
>>   	case OID_sm3:
>>   		ctx->sinfo->sig->hash_algo = "sm3";
>>   		break;
>> +	case OID_gost2012Digest256:
>> +		ctx->sinfo->sig->hash_algo = "streebog256";
>> +		break;
>> +	case OID_gost2012Digest512:
>> +		ctx->sinfo->sig->hash_algo = "streebog512";
>> +		break;
>>   	default:
>>   		printk("Unsupported digest algo: %u\n", ctx->last_oid);
>>   		return -ENOPKG;
>> @@ -284,6 +290,11 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
>>   		ctx->sinfo->sig->pkey_algo = "sm2";
>>   		ctx->sinfo->sig->encoding = "raw";
>>   		break;
>> +	case OID_gost2012PKey256:
>> +	case OID_gost2012PKey512:
>> +		ctx->sinfo->sig->pkey_algo = "ecrdsa";
>> +		ctx->sinfo->sig->encoding = "raw";
>> +		break;
>>   	default:
>>   		printk("Unsupported pkey algo: %u\n", ctx->last_oid);
>>   		return -ENOPKG;
>> -- 
>> 2.24.3 (Apple Git-128)
>>
> 
> Please, check:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> 
> BR, Jarkko

Great work, thanks.

Best regards,
Tianjia
