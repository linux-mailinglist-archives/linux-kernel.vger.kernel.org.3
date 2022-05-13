Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAA525BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377367AbiEMGfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiEMGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:35:02 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFE702A18A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:35:00 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E68791E80C96;
        Fri, 13 May 2022 14:29:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yc2e7FKnwc4q; Fri, 13 May 2022 14:29:15 +0800 (CST)
Received: from [172.30.21.106] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5D7C61E80C93;
        Fri, 13 May 2022 14:29:15 +0800 (CST)
Subject: Re: [PATCH] mm: change "char *bdi_unknown_name" to "char
 bdi_unknown_name[]"
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220512082637.24649-1-liqiong@nfschina.com>
 <20220512130051.94a0c53e5d1498292473975d@linux-foundation.org>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <2d698914-befd-0283-71ed-599aa1bf9e3d@nfschina.com>
Date:   Fri, 13 May 2022 14:34:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20220512130051.94a0c53e5d1498292473975d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
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

在 2022年05月13日 04:00, Andrew Morton 写道:
> On Thu, 12 May 2022 16:26:37 +0800 liqiong <liqiong@nfschina.com> wrote:
>
>> "char bdi_unknown_nam[]" string form declares a single variable.
>> It is better then "char *bdi_unknown_name" which creates two
>> variables.
>>
>> ...
>>
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
>> @@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
>>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
>>  
>>  static struct class *bdi_class;
>> -static const char *bdi_unknown_name = "(unknown)";
>> +static const char bdi_unknown_name[] = "(unknown)";
>>  
> heh, fun patch.  We actually do this quite a lot.  
>
> 	grep -r "^[a-z].*char \*[a-z].*= \"" .
>
> is a pathetic pattern which catches a lot of them.
>
>
> However.  I expected your patch to shrink the kernel a bit, but it has
> the opposite effect:
>
> hp2:/usr/src/25> size mm/backing-dev.o
>    text	   data	    bss	    dec	    hex	filename
>   21288	   9396	   3808	  34492	   86bc	mm/backing-dev.o-before
>   21300	   9428	   3808	  34536	   86e8	mm/backing-dev.o-after
>
> Even .data became larger.  I didn't investigate why.
Hi,
It seems  the patch creates a new section:
0000000000000000 l       ___ksymtab_gpl+bdi_dev_name    0000000000000000 __ksymtab_bdi_dev_name
0000000000000f60 l     O .rodata        000000000000000a bdi_unknown_name
And  put  "bdi_unknown_name"  at  .rodata.str1.1:

This work was published in "KernelJanitors/Todo". It says:

"foo []" is better because it declares a single variable,   For variables marked __initdata, the "*foo" form causes
only the pointer, not the string itself, to be dropped from the kernel image, which is a bug.
Using the "foo[]" form with regular 'ole local variables also makes the assembly shorter.

I thought it make sense,  so i  searched the mm tree by "grep  -nHre char.*\*.*=.*\"",  and checked all the "char *foo"
string form,  It seems only this one should be fixed.



