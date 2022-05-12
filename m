Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569C5525346
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356890AbiELRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356888AbiELRKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:10:42 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A036021B5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:10:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 35B681E80D6B;
        Fri, 13 May 2022 01:05:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VMlKyIXNQHXH; Fri, 13 May 2022 01:05:00 +0800 (CST)
Received: from [172.30.21.106] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AB25F1E80D22;
        Fri, 13 May 2022 01:05:00 +0800 (CST)
Subject: Re: [PATCH] mm: change "char *bdi_unknown_name" to "char
 bdi_unknown_name[]"
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220512082637.24649-1-liqiong@nfschina.com>
 <Yn0n23MRQ+wD1ZWN@FVFYT0MHHV2J.usts.net>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <f4317b85-0a7b-913c-6d45-9f8b7c65e40b@nfschina.com>
Date:   Fri, 13 May 2022 01:10:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <Yn0n23MRQ+wD1ZWN@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022年05月12日 23:29, Muchun Song 写道:
> On Thu, May 12, 2022 at 04:26:37PM +0800, liqiong wrote:
>> "char bdi_unknown_nam[]" string form declares a single variable.
>> It is better then "char *bdi_unknown_name" which creates two
>> variables.
>>
> Sorry, I do not understand what you are saying here.  Creating
> two variables means what?
>
> Thanks.

Hi there，

The string form of "char *" creates two variables in the final assembly output, 
a static string, and a char pointer to the static string.

Use "objdump -S -D *.o", can find out the static string occurring at 
"Contents of section .rodata".


>  
>> Signed-off-by: liqiong <liqiong@nfschina.com>
>> ---
>>  mm/backing-dev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>> index 7176af65b103..4982ccc63536 100644
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
>> @@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
>>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
>>  
>>  static struct class *bdi_class;
>> -static const char *bdi_unknown_name = "(unknown)";
>> +static const char bdi_unknown_name[] = "(unknown)";
>>  
>>  /*
>>   * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
>> -- 
>> 2.11.0
>>
>>

-- 
李力琼 <13524287433>
上海市浦东新区海科路99号中科院上海高等研究院3号楼3楼

