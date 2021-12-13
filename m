Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DACB4728D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbhLMKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:14:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42260 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbhLMKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:10:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 172D6212B8;
        Mon, 13 Dec 2021 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639390225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gym/4gMFs6oYhA4ogfQYa+56iB/R1kO0s7RO+voEqKE=;
        b=krNRHELFHf2Dh2BFsoiYv8gRt6LL4tPXMosztTWQwtmofZLipsVqcsXs47kwy21nkbObtK
        /28+Fv0Gk5hABfYVt5qapJ7HmAOj2qM40bl4NB6hCW3V/BnD0x5OBGzqz1krxuhPVdzwDT
        pBzqV2E4q/5we+UcYTjklbol5GHFpWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639390225;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gym/4gMFs6oYhA4ogfQYa+56iB/R1kO0s7RO+voEqKE=;
        b=oOd4xXFS5hnAluT47UZYND6W/zvVmFHCK4p7b5QBLr/Zzi0otapfdR4BPk7drlXa8PRepL
        GmqNE1KR4cz+4dBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F312213CE5;
        Mon, 13 Dec 2021 10:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uz/oOhAct2HoNgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 13 Dec 2021 10:10:24 +0000
Subject: Re: [PATCH v2 03/18] crypto: dh - optimize domain parameter
 serialization for well-known groups
To:     Nicolai Stange <nstange@suse.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-4-nstange@suse.de>
 <86157a11-7daa-876a-d80b-e6bda36e6368@suse.de> <87r1agrf83.fsf@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e23b0421-799a-9286-0394-fbdf3695eb78@suse.de>
Date:   Mon, 13 Dec 2021 11:10:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87r1agrf83.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 11:06 AM, Nicolai Stange wrote:
> Hannes Reinecke <hare@suse.de> writes:
> 
>> On 12/9/21 10:03 AM, Nicolai Stange wrote:
>>> diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
>>> index aabc91e4f63f..9f21204e5dee 100644
>>> --- a/crypto/dh_helper.c
>>> +++ b/crypto/dh_helper.c
>>> @@ -45,18 +72,24 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params)
>>>  		.type = CRYPTO_KPP_SECRET_TYPE_DH,
>>>  		.len = len
>>>  	};
>>> +	int group_id;
>>>  
>>>  	if (unlikely(!len))
>>>  		return -EINVAL;
>>>  
>>>  	ptr = dh_pack_data(ptr, end, &secret, sizeof(secret));
>>> +	group_id = (int)params->group_id;
>>> +	ptr = dh_pack_data(ptr, end, &group_id, sizeof(group_id));
>>
>> Me being picky again.
>> To my knowledge, 'int' doesn't have a fixed width, but is rather only
>> guaranteed to hold certain values.
>> So as soon as one relies on any fixed size (as this one does) I tend to
>> use fixed size type like 'u32' to make it absolutely clear what is to be
>> expected here.
>>
>> But the I don't know the conventions in the crypto code; if an 'int' is
>> assumed to be 32 bits throughout the crypto code I guess we should be fine.
> 
> Yes, I thought about this, too. However, the other, already existing
> fields like ->key_size and ->p_size are getting serialized as unsigned
> ints and I decided to stick to that for ->group_id as well. Except for
> the testmgr vectors, the encoding is internal to the
> crypto_dh_encode_key() and crypto_dh_decode_key() pair anyway -- all
> that would happen if sizeof(int) != 4 is that the tests would fail.
> 
> So, IMO, making the serialization of struct dh to use u32 throughout is
> not really in scope for this series and would probably deserve a patch
> on its own, if desired.
> 
As I thought.

So that's okay, then.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
