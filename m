Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAED4D7741
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiCMR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiCMR0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3373E53717
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647192343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn0ofAxJNZv/2uo5vBgkjuwAgV3+0z/a9iEotzvvTQE=;
        b=ggNHqWqSC7Uf0fYcPJOhP2HFn+Eoxk0laKQcsDNSj8/Yp66Ijdw24aYjuhri9VjWCe10qs
        c5zu9WO+PBn/PGnP/5cGIoZ3UlXS2jEBm7PXdZSVx+B8S6JPCo9T1iLK+bIFVtTUArHkCB
        jKeyXvGnABG2lrf5veaDdoDkHbUAM/I=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-4UINGTeHPvKulW_jhGWM9Q-1; Sun, 13 Mar 2022 13:25:42 -0400
X-MC-Unique: 4UINGTeHPvKulW_jhGWM9Q-1
Received: by mail-oo1-f69.google.com with SMTP id j18-20020a4ae852000000b003181c031d81so11299685ooj.22
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 10:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mn0ofAxJNZv/2uo5vBgkjuwAgV3+0z/a9iEotzvvTQE=;
        b=fGNosILfAaLDmPcK48DWFRrNG3Q3S8t5lsfGb8BHjHOInMryvIql7Fr6PagN1UC5NX
         u/H39Bq50ZfYKaixv0MjdfNke4RiL6yMgHHjHMriHsRYjtaW4dIfZ93zvib3xBLzRBbI
         8+80TBDQBR2L5Rjg+NvJcmyuC8kvD14IiJWdQ2lLVOWBExH5oaEhSrZHuXLztQqyBUi5
         PUiNQSNYwSBDrW/1u4B1GBedk8vq3w69DIybyXDWr5/ujV6fRm4BgWiCuKfnv3YO6f+f
         BqRVC863dMVTNradGfvAZiiIknAJ9hW5vY5NvGq2lqWLjKDownfzz8q5ujeLjzx179A7
         8IbQ==
X-Gm-Message-State: AOAM53368nrlMKWRJVM+YjDf7d1nH/2Gc84U/67isx/Du7SwwC/nPrZA
        6Tj4eTQpfInpq1ePiMU+7XT1o/hMWiY6zrAeRX1++PORXggfqQWxzgGnSzL1tSyavt5QAPw5wdV
        4i1HwkmlV5Ucall0l57s3f557134e6tfacZj5/zOCqMgY9OOCOanX7QeF8OsyO5bKUIfHbvE=
X-Received: by 2002:a9d:18e:0:b0:5b2:60a3:df31 with SMTP id e14-20020a9d018e000000b005b260a3df31mr9422836ote.251.1647192341083;
        Sun, 13 Mar 2022 10:25:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDRtAEOItqVfXBOcK5Q/GbO5z+zCivcrPSOHA871UqYPp60rMql/v/tWlrJBXy+L1wXPJ8Dw==
X-Received: by 2002:a9d:18e:0:b0:5b2:60a3:df31 with SMTP id e14-20020a9d018e000000b005b260a3df31mr9422825ote.251.1647192340814;
        Sun, 13 Mar 2022 10:25:40 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830310300b005c93d1cbb9fsm3469035ots.68.2022.03.13.10.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 10:25:40 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: warn that small allocs should be combined
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20220313140827.1503359-1-trix@redhat.com>
 <75480288322af54a589539d8296bd9a35a67dbca.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d51c3c16-21fa-01c7-3faf-e96eb70c4721@redhat.com>
Date:   Sun, 13 Mar 2022 10:25:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <75480288322af54a589539d8296bd9a35a67dbca.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/13/22 9:09 AM, Joe Perches wrote:
> On Sun, 2022-03-13 at 07:08 -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A memory allocation has overhead.  When a
>> small allocation is made the overhead dominates.
>> By combining the fixed sized small allocations
>> with others, the memory usage can be reduced
>> by eliminating the overhead of the small allocs.
> This will generate false positives as small allocs are
> sometimes required for usb dma.
>
> How many of these "small allocs" _could_ be combined and under
> what circumstance?
>
> Can you show me a current example in the kernel where this
> is useful?

Tracing what the memory is used for is not easy.

And opens a can of worms.

Most/all of the alloc use only GFP_KERNEL.

If this allocs implicitly align / size suites dma which i am

guessing is (void *) aligned/size then then there will be some

cases of overalignment.

The addition of a GFP_DMA could indicate the memory was to be dma-ed, 
but cause other breakage.

So there is not a good way currently for checkpatch to figure this out.

>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -7076,6 +7076,12 @@ sub process {
>>   			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>>   		}
>>   
>> +# check for small allocs
>> +		if ($line =~ /\b(?:kv|k|v)[zm]alloc\s*\(\s*(\d|sizeof\s*\([su](8|16|32)s*\))\s*,/) {
>> +			WARN("SMALL_ALLOC",
>> +			     "Small allocs should be combined\n" . $herecurr);
>> +		}
>> +
> Couple more comments:
>
> Anyone using vmalloc variants for a small alloc is confused.
> What defines "small"?
> Why would a single decimal like 8 be small, but say 16 would not be?
>
> checkpatch has a couple of regexes that could be useful here
>
> Maybe instead of sizeof(your regex) use
>
> 	sizeof\s*\(\s*(?:\d|$C90_int_types|$typeTypedefs)\s*,
>
> as that will find more "small" uses of individual types like
> "unsigned long", __s32, u_int_16, etc...
>
ok

Tom

>

