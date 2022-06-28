Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B5055C421
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiF1DQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiF1DQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:16:02 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73661706F;
        Mon, 27 Jun 2022 20:15:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VHfHwgb_1656386154;
Received: from 30.240.101.24(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VHfHwgb_1656386154)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 11:15:55 +0800
Message-ID: <de4fa766-0f9f-43cc-b528-4b8f9d2e828b@linux.alibaba.com>
Date:   Tue, 28 Jun 2022 11:15:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 RESEND] KEYS: asymmetric: enforce SM2 signature use
 pkey algo
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Eric Biggers <ebiggers@google.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627092027.20858-1-tianjia.zhang@linux.alibaba.com>
 <Yro54bzvRZqbmCxb@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <Yro54bzvRZqbmCxb@kernel.org>
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

On 6/28/22 7:14 AM, Jarkko Sakkinen wrote:
> On Mon, Jun 27, 2022 at 05:20:27PM +0800, Tianjia Zhang wrote:
>> The signature verification of SM2 needs to add the Za value and
>> recalculate sig->digest, which requires the detection of the pkey_algo
>> in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
>> field in sig is attacker-controlled and should be use pkey->pkey_algo
>> instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
>> will also cause signature verification failure.
>>
>> The software_key_determine_akcipher() already forces the algorithms
>> are matched, so the SM3 algorithm is enforced in the SM2 signature,
>> although this has been checked, we still avoid using any algorithm
>> information in the signature as input.
>>
>> Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
>> Reported-by: Eric Biggers <ebiggers@google.com>
>> Cc: stable@vger.kernel.org # v5.10+
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   crypto/asymmetric_keys/public_key.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
>> index 7c9e6be35c30..3f17ee860f89 100644
>> --- a/crypto/asymmetric_keys/public_key.c
>> +++ b/crypto/asymmetric_keys/public_key.c
>> @@ -309,7 +309,8 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
>>   	if (ret)
>>   		return ret;
>>   
>> -	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
>> +	/* SM2 signatures always use the SM3 hash algorithm */
>> +	tfm = crypto_alloc_shash("sm3", 0, 0);
> 
> So, why this should not validate sig->hash_alog *to be* "sm3"?
> 
> I.e. add instead guard before crypto_alloc_hash:
> 
>          if (strncmp(sig->hash_algo, "sm3") != 0) {
>                  /* error */
>          }
>          /* continue */
> 

Thanks, it's reasonable and I'll take your advice.

Best regards,
Tianjia
