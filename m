Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79150540180
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiFGOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245599AbiFGOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:34:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5AB879
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:34:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso15621928pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=027YaoyvyAc/mF6u+WuR4wY8YjOOeIp62H/y/ouNaZs=;
        b=ErWhIp3PtPJCfXnP0e79ifi/G1DoBLN1q5UPlmYNENGrPgrlVce9v80iUsE/8dxGNr
         1wkptiVh/a56F3VZLtI3vpl3/b16ATQLu/tC/xyM/YJZZIfgX3OH74C50Zi6f1YZfFE9
         sYoNvbQjvs6zvtqj3oK9Nb9WXjFlSv2HsfRXowaKpPUttiZR9fMrpDSnXpDpfzTlVcvP
         YmnOk7kI0cYuqq0cNpOtlw7cL+ahavPS6aPVxLFbrwpcHPbaYJdI9x/mb9Nidn8kLouB
         DOu83Te+9TfRgY22rMOb+r35a/5vZFufbjUm/V79X+moCIL3DPa2YsN89WGpI1PN8PdE
         gvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=027YaoyvyAc/mF6u+WuR4wY8YjOOeIp62H/y/ouNaZs=;
        b=MAve+hsC08m4f/gGVObSDPimLWKiO6z9sBc4LnMQU2OsQY8CCFFt28bLExtq9DThne
         ZYQ2MZP0dGEsyOaUUmm2McJZImE6eEO3/rDhHZJbNyb9NoO1kJFV/HkwUJZ4603SLKIf
         xf9hj1cVMR8fOZYAyDXdLaUIbi6FDdsKH+RRzIM+lp6pYK1/ldonQZAHwqMJ1auKSSNj
         AB7ZLB2Fm5fa0TJzsDtQi5crUalKsbfS0YgfsxRupiOx63LfWLZFSAqe6CLfxc1iGfSf
         UyskuTRtCWtC0lLWgPqxaZEVUSQCrkkI+DZGMenC7S6v2MMpSvq21Bgk9kf2BfaoWqAu
         /Q6A==
X-Gm-Message-State: AOAM530mIOX6Ib9iiTS6CqnZ8imLF8dzgcshx/NkqVWjVXUOjnM3Lgl8
        yXUe/AGvEuXQWUb87zWjnlQ=
X-Google-Smtp-Source: ABdhPJyBPsIB0n1eKeyLa/KeHNHto49csAeUIQI6A7XmIPBbbFTKyDK7sab46/904rekquLmSzX/aA==
X-Received: by 2002:a17:90b:4ccf:b0:1ea:264c:7c0c with SMTP id nd15-20020a17090b4ccf00b001ea264c7c0cmr873033pjb.176.1654612465872;
        Tue, 07 Jun 2022 07:34:25 -0700 (PDT)
Received: from [192.168.1.104] ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id je21-20020a170903265500b00163b02822bdsm12533885plb.160.2022.06.07.07.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 07:34:25 -0700 (PDT)
Message-ID: <be3c0a7d-91f1-ab55-f560-2ece4720d405@gmail.com>
Date:   Tue, 7 Jun 2022 22:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/4] mm: kmemleak: add rbtree for objects allocated
 with physical address
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-3-patrick.wang.shcn@gmail.com>
 <Yp4RgegLBhvVeaid@arm.com>
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
In-Reply-To: <Yp4RgegLBhvVeaid@arm.com>
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



On 2022/6/6 22:38, Catalin Marinas wrote:
> On Fri, Jun 03, 2022 at 11:54:13AM +0800, Patrick Wang wrote:
>> @@ -536,27 +543,32 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
>>   }
>>   
>>   /*
>> - * Remove an object from the object_tree_root and object_list. Must be called
>> - * with the kmemleak_lock held _if_ kmemleak is still enabled.
>> + * Remove an object from the object_tree_root (or object_phys_tree_root)
>> + * and object_list. Must be called with the kmemleak_lock held _if_ kmemleak
>> + * is still enabled.
>>    */
>>   static void __remove_object(struct kmemleak_object *object)
>>   {
>> -	rb_erase(&object->rb_node, &object_tree_root);
>> +	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
>> +				   &object_phys_tree_root :
>> +				   &object_tree_root);
> 
> This pattern appears in a few place, I guess it's better with a macro,
> say get_object_tree_root(object). But see how many are left, I have some
> comments below on reducing the diff.

Will do.

> 
>> @@ -709,12 +724,12 @@ static void delete_object_full(unsigned long ptr)
>>    * delete it. If the memory block is partially freed, the function may create
>>    * additional metadata for the remaining parts of the block.
>>    */
>> -static void delete_object_part(unsigned long ptr, size_t size)
>> +static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>>   {
>>   	struct kmemleak_object *object;
>>   	unsigned long start, end;
>>   
>> -	object = find_and_remove_object(ptr, 1);
>> +	object = find_and_remove_object(ptr, 1, is_phys);
>>   	if (!object) {
>>   #ifdef DEBUG
>>   		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
> 
> The previous patch introduced a check on object->flags for
> delete_object_part(). I think you can just use is_phys directly now when
> calling create_object().

Will do.

> 
>> @@ -1275,7 +1290,7 @@ static void scan_block(void *_start, void *_end,
>>   		 * is still present in object_tree_root and object_list
>>   		 * (with updates protected by kmemleak_lock).
>>   		 */
>> -		object = lookup_object(pointer, 1);
>> +		object = lookup_object(pointer, 1, false);
>>   		if (!object)
>>   			continue;
>>   		if (object == scanned)
>> @@ -1299,7 +1314,7 @@ static void scan_block(void *_start, void *_end,
>>   		raw_spin_unlock(&object->lock);
>>   
>>   		if (excess_ref) {
>> -			object = lookup_object(excess_ref, 0);
>> +			object = lookup_object(excess_ref, 0, false);
>>   			if (!object)
>>   				continue;
>>   			if (object == scanned)
>> @@ -1728,7 +1743,7 @@ static int dump_str_object_info(const char *str)
>>   
>>   	if (kstrtoul(str, 0, &addr))
>>   		return -EINVAL;
>> -	object = find_and_get_object(addr, 0);
>> +	object = find_and_get_object(addr, 0, false);
>>   	if (!object) {
>>   		pr_info("Unknown object at 0x%08lx\n", addr);
>>   		return -EINVAL;
> 
> I think find_and_get_object() is never called on a phys object, so you
> can probably simplify these a bit. Just add an is_phys argument where
> strictly necessary and maybe even add a separate function like
> lookup_object_phys() to reduce the other changes.

Will add lookup_object_phys() function and find_and_get_object_phys()
function. The find_and_get_object() function is also called in many
places.

Thanks,
Patrick

