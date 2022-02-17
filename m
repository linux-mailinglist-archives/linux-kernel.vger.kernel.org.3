Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1114BA6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbiBQREU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:04:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiBQRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:04:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783D1C7EA4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:04:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 037701F383;
        Thu, 17 Feb 2022 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645117442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKbc9KvNKps7m3RUOPrYHBO98Vg0WoynWbU0oCx7WKM=;
        b=p+X6Ad7ZueQiQO+WPDqvruaTR4aOOxHcHhN+1Ief5sJJW0GK3NsxXvjlhtHkXj76j34jkS
        Wn/zKMe3zI0egSkHawRHGHHqxYgEc0AHQFlp2641EQ2ykAO9hOMSVtuxllf4sPCuacHpiH
        Lh4WxpXHoIEjqvC5kreIOhneGb3ogZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645117442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKbc9KvNKps7m3RUOPrYHBO98Vg0WoynWbU0oCx7WKM=;
        b=pEGg0Fx2KoANzummLqbpJryuWYr7cE3rwoZ1HI07fxRz6k7V+Yu5WSAtP6DMn6xbcTH3nv
        fXaaC//wSlwiE0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCB8313C23;
        Thu, 17 Feb 2022 17:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mvg0MQGADmLHDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 17 Feb 2022 17:04:01 +0000
Message-ID: <49a1bc35-7505-bc82-2931-e57f7b959cb3@suse.cz>
Date:   Thu, 17 Feb 2022 18:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/slab_common: use helper function is_power_of_2()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
References: <20220217091609.8214-1-linmiaohe@huawei.com>
 <8f307e8a-5f97-cf5d-0a77-1c79b05abd60@suse.cz>
 <5d904bee-3faf-374a-090c-ce7c99c84ea9@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <5d904bee-3faf-374a-090c-ce7c99c84ea9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 11:44, Miaohe Lin wrote:
> On 2022/2/17 17:23, Vlastimil Babka wrote:
>> On 2/17/22 10:16, Miaohe Lin wrote:
>>> Use helper function is_power_of_2() to check if KMALLOC_MIN_SIZE is power
>>> of two. Minor readability improvement.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> 
>> We can try, but in case some compiler will no longer able to perform the
>> check at build-time (although is_power_of_2() looks sufficiently trivial
>> too), we'll have to revert it.
> 
> I see. I checked the compiler in my env but there might be some compilers can't
> perform the check at build-time.

I'll add this to the slab tree and linux-next and we'll see if wider testing
uncovers such compilers. Should be unlikely.

> Many thanks for your reply.
> 
>> 
>>> ---
>>>  mm/slab_common.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>>> index 23f2ab0713b7..6ee64d6208b3 100644
>>> --- a/mm/slab_common.c
>>> +++ b/mm/slab_common.c
>>> @@ -807,7 +807,7 @@ void __init setup_kmalloc_cache_index_table(void)
>>>  	unsigned int i;
>>>  
>>>  	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 256 ||
>>> -		(KMALLOC_MIN_SIZE & (KMALLOC_MIN_SIZE - 1)));
>>> +		!is_power_of_2(KMALLOC_MIN_SIZE));
>>>  
>>>  	for (i = 8; i < KMALLOC_MIN_SIZE; i += 8) {
>>>  		unsigned int elem = size_index_elem(i);
>> 
>> .
>> 
> 

