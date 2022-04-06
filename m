Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50D4F6105
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiDFN6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiDFN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:57:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EAB184241
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:09:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E14A210F5;
        Wed,  6 Apr 2022 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649236151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XztoAOcqNaq3/X/lxnWMOgV0ixpXKMfSOqrPJG0IV8w=;
        b=S8+YGfIXOrUKldiJ0tqUDz2yM2NcBpd9f3xIDA7BoMMi0eKolnmtAcN/uZ+ufvTX06fiQm
        85w8x7Gqqc8pRFMcvI0kYoAFCadHQSrBOfh/ZXKpFTwvYAo1iZjrlmKmKkbxTH1wB63hq8
        es8jNscNfP/GgtfMBCojs09VxQtZ+fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649236151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XztoAOcqNaq3/X/lxnWMOgV0ixpXKMfSOqrPJG0IV8w=;
        b=XWVSerDhWi97xpK2/vwXwp6epgmc18PQib3jlMoS8kHYJtmaG8d+qag+1r6Sqotq9z2n8O
        pe0vWxlFFOzcbFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AA94139F5;
        Wed,  6 Apr 2022 09:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PZhgGbdYTWLNfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 06 Apr 2022 09:09:11 +0000
Message-ID: <4c8aa38f-a427-bd56-4224-7217af7f9a74@suse.cz>
Date:   Wed, 6 Apr 2022 11:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/6] mm/slub: distinguish and print stack traces in
 debugfs files
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
References: <20220404164112.18372-1-vbabka@suse.cz>
 <20220404164112.18372-5-vbabka@suse.cz>
 <a8801c0-45d6-7c90-35f9-c3221736ef13@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <a8801c0-45d6-7c90-35f9-c3221736ef13@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 23:40, David Rientjes wrote:
>> @@ -5116,9 +5117,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>>  {
>>  	long start, end, pos;
>>  	struct location *l;
>> -	unsigned long caddr;
>> +	unsigned long caddr, chandle;
>>  	unsigned long age = jiffies - track->when;
>> +	depot_stack_handle_t handle = 0;
>>  
>> +#ifdef CONFIG_STACKDEPOT
>> +	handle = READ_ONCE(track->handle);
>> +#endif
>>  	start = -1;
>>  	end = t->count;
>>  
>> @@ -5133,7 +5138,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>>  			break;
>>  
>>  		caddr = t->loc[pos].addr;
>> -		if (track->addr == caddr) {
>> +		chandle = t->loc[pos].handle;
>> +		if ((track->addr == caddr) && (handle == chandle)) {
>>  
>>  			l = &t->loc[pos];
>>  			l->count++;
>> @@ -5158,6 +5164,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
>>  
>>  		if (track->addr < caddr)
>>  			end = pos;
>> +		else if (track->addr == caddr && handle < chandle)
>> +			end = pos;
>>  		else
>>  			start = pos;
>>  	}
> 
> Does this need to properly handle the case where handle == NULL?

Hm I can't think of how much more properly is possible. If objects have same
track->addr (which is the immediate caller) and also same NULL handle, they
will be counted together. I think it's the best we can do?
