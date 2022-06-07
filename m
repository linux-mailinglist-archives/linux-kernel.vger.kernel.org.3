Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACEB540187
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245628AbiFGOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbiFGOgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:36:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F678D6B7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:36:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o6so9896217plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SG3XUTBpuI26q8m4p1Hw86RdFCjh9ZpBJz6Fnipknjg=;
        b=Hu1mE7Dz8GlP2wHbDT8TautdCY9eMNndDOwk/InhDSJhbstWucqk+cFE57v2rx7H4O
         gC0HQL+3aVkYWbAapAbDh5qrjT0SpQ5TCO7gbTb8dbn2hUmiKZAwMNk/AV1M8+xhnk2T
         jiDMexPSplWW9VIb7TMfHhbwLEu+yFXeaSFYB4MpV09yjOKg1u3czyZvCktlzqR8MRVw
         GNn3No7fA1K9YIGC6sWMNKE4gPV7TgfvhTKUWBD3rZ+FSM9jBijz3Y1bQIZtrmDD4ipO
         A0sS4IpyMFERVy6IkrWCmW+8F42Js0sPk2bpe9yauySyarZc7qhezDVsN5xCErfMliiP
         KfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SG3XUTBpuI26q8m4p1Hw86RdFCjh9ZpBJz6Fnipknjg=;
        b=AQ73Si42bXX55iTNBIasrE/Ui4WwmY5SrSfoMWwoyEjoXFYP4uYqnoOek+z9XY+O6d
         pEIlbSK2RMFgzCNLNJtLo+7qdW6FeBZQhGLoCXAW00xUDHvBsooWlSltczhY0qV6plBL
         mbsAS3CBdxq9LzNzSmvBMJXfSHAzGMqGyEjAVnrBHVsiMm39ZDWrjPqj5nsO1+cwaLla
         Qi3qDRf52R8eDmwGwmkTG8C/g+PKOJTzz55SJe9dzBo2CimNu53fzVP85f2MF7GT3XhS
         8/3F2H5G4zJ7UesWi7xt9ZKC1d5Qm+OcMVhb6RAgBLshawcIi9x5mp86Q7aGtWlDpK8A
         bnew==
X-Gm-Message-State: AOAM532J8J5ku37gXmODOca6JW+vbMuqVA/Flr23ymbBWDOwgi/bEU7W
        FZYJUztikTF1fqdeo1JMIww=
X-Google-Smtp-Source: ABdhPJw9zt2VhRGPsiLqPs0L+hmc/DwWjTu5Gws0XzLidWyZ7RWHpNZsYQhAt02IuVoIHe7Y2aCT3w==
X-Received: by 2002:a17:90a:fb93:b0:1e8:a809:af4d with SMTP id cp19-20020a17090afb9300b001e8a809af4dmr3208958pjb.7.1654612573977;
        Tue, 07 Jun 2022 07:36:13 -0700 (PDT)
Received: from [192.168.1.104] ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902ed4200b0016392bd5060sm12534598plb.142.2022.06.07.07.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 07:36:13 -0700 (PDT)
Message-ID: <da096aaf-87b8-e322-1622-4acd28e37dea@gmail.com>
Date:   Tue, 7 Jun 2022 22:36:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] mm: kmemleak: handle address stored in object
 based on its type
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-4-patrick.wang.shcn@gmail.com>
 <Yp4Wwtg1uxZ9NLTw@arm.com>
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
In-Reply-To: <Yp4Wwtg1uxZ9NLTw@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/6 23:01, Catalin Marinas wrote:
> On Fri, Jun 03, 2022 at 11:54:14AM +0800, Patrick Wang wrote:
>> Treat the address stored in object in different way according
>> to its type:
>>
>> - Only use kasan_reset_tag for virtual address
>> - Only update min_addr and max_addr for virtual address
>> - Convert physical address to virtual address in scan_object
>>
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
>> ---
>>   mm/kmemleak.c | 34 ++++++++++++++++++++++++----------
>>   1 file changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 218144392446..246a70b7218f 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -297,7 +297,9 @@ static void hex_dump_object(struct seq_file *seq,
>>   	warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
>>   	kasan_disable_current();
>>   	warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
>> -			     HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
>> +			     HEX_GROUP_SIZE, object->flags & OBJECT_PHYS ? ptr :
>> +			     kasan_reset_tag((void *)ptr),
>> +			     len, HEX_ASCII);
>>   	kasan_enable_current();
>>   }
> 
> This will go wrong since ptr is the actual physical address, it cannot
> be dereferenced. This should only be used on virtual pointers and this
> is the case already as we never print unreferenced objects from the phys
> tree. What we could do though is something like an early exit from this
> function (together with a comment that it doesn't support dumping such
> objects):
> 
> 	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
> 		return;
> 

I also found this. Will do.

>>   
>> @@ -389,14 +391,15 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias,
>>   {
>>   	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
>>   			     object_tree_root.rb_node;
>> -	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
>> +	unsigned long untagged_ptr = is_phys ? ptr : (unsigned long)kasan_reset_tag((void *)ptr);
>>   
>>   	while (rb) {
>>   		struct kmemleak_object *object;
>>   		unsigned long untagged_objp;
>>   
>>   		object = rb_entry(rb, struct kmemleak_object, rb_node);
>> -		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
>> +		untagged_objp = is_phys ? object->pointer :
>> +				(unsigned long)kasan_reset_tag((void *)object->pointer);
>>   
>>   		if (untagged_ptr < untagged_objp)
>>   			rb = object->rb_node.rb_left;
> 
> You could leave this unchanged. A phys pointer is already untagged, so
> it wouldn't make any difference.

Right, will do.

> 
>> @@ -643,16 +646,19 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>>   
>>   	raw_spin_lock_irqsave(&kmemleak_lock, flags);
>>   
>> -	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
>> -	min_addr = min(min_addr, untagged_ptr);
>> -	max_addr = max(max_addr, untagged_ptr + size);
>> +	untagged_ptr = is_phys ? ptr : (unsigned long)kasan_reset_tag((void *)ptr);
> 
> Same here.

Will do.

> 
>> +	if (!is_phys) {
>> +		min_addr = min(min_addr, untagged_ptr);
>> +		max_addr = max(max_addr, untagged_ptr + size);
>> +	}
>>   	link = is_phys ? &object_phys_tree_root.rb_node :
>>   		&object_tree_root.rb_node;
>>   	rb_parent = NULL;
>>   	while (*link) {
>>   		rb_parent = *link;
>>   		parent = rb_entry(rb_parent, struct kmemleak_object, rb_node);
>> -		untagged_objp = (unsigned long)kasan_reset_tag((void *)parent->pointer);
>> +		untagged_objp = is_phys ? parent->pointer :
>> +				(unsigned long)kasan_reset_tag((void *)parent->pointer);
> 
> And here.

Will do.

> 
>>   		if (untagged_ptr + size <= untagged_objp)
>>   			link = &parent->rb_node.rb_left;
>>   		else if (untagged_objp + parent->size <= untagged_ptr)
>> @@ -1202,7 +1208,9 @@ static bool update_checksum(struct kmemleak_object *object)
>>   
>>   	kasan_disable_current();
>>   	kcsan_disable_current();
>> -	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
>> +	object->checksum = crc32(0, object->flags & OBJECT_PHYS ? (void *)object->pointer :
>> +				    kasan_reset_tag((void *)object->pointer),
>> +				    object->size);
> 
> Luckily that's never called on a phys object, otherwise *object->pointer
> would segfault. As for hex_dump, just return early with a warning if
> that's the case.

Right, will do.

Thanks,
Patrick

