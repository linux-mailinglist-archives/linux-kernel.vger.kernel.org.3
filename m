Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B775A86D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiHaTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiHaTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:37:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CB9E8333
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=TYUbrq0zEzx9WCgHsYXEyT/kWHYtACgkVDaNLOYouRs=; b=IYi/ZxFj7gpJ+PaBKAKA5kywHq
        DR3I3y0zWmdmDiaA2EHplvdF7cYpsqmz+rKYA+tAr61RF1X2RD/LPS2FDtnS4fL/Ub9AOHyLhMN+d
        2QL290HausMTU+kNF2+uqSoRMbAO0+B79UWKmAx4PLuzP5RJtJkWwM8Jy90fChhTeqGqviJS/raF7
        ewdFtFIVnKHkiiUN7zZAodWspjxBQrAYipO2r8FXTeh7Au8ri0RpFXzqYJQLfTcEygjJQgB6hbuK+
        hYpRgeN/KYTKcIFXTCdt0/NmCrAyWSSay7lwxEos1gaP+AH+VwrvNxqZmhDWDbfBGF8wq2GsytNjJ
        wxf7kn2Q==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTTWc-007vHg-SB; Wed, 31 Aug 2022 19:37:22 +0000
Message-ID: <97f1d259-4fc9-4b9e-7769-3a646ffd0423@infradead.org>
Date:   Wed, 31 Aug 2022 12:37:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] hugetlb: use mm.h instead of mm_types.h
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220831185739.21400-1-rdunlap@infradead.org>
 <Yw+2PrIzebUbVYQR@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yw+2PrIzebUbVYQR@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/22 12:27, Matthew Wilcox wrote:
> On Wed, Aug 31, 2022 at 11:57:39AM -0700, Randy Dunlap wrote:
>> mm_types.h does not have zap_flags_t in it so use mm.h instead
>> in hugetlb.h.
> 
> ... my copy of mm_types.h has zap_flags_t in it.  Was it recently moved?
> Perhaps moving it back is a better solution to this problem?

Ah, I see. This patch was originally to mmotm, but then for merging
(commit 05e90bd05eea), Peter Xu moved the typedef so that this patch
is not needed. Sorry for the noise.

and Thanks.

>> Fixes this build error:
>>
>> In file included from ../drivers/virt/nitro_enclaves/ne_misc_dev.c:16:0:
>> ../include/linux/hugetlb.h:414:4: error: unknown type name ‘zap_flags_t’; did you mean ‘vm_flags_t’?
>>     zap_flags_t zap_flags)
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: linux-mm@kvack.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>> Fixes: mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix.patch
>> v2: add Rev-by: Peter
>>     drop the bogus S-o-b: in Cc: Peter Xu
>>
>>  include/linux/hugetlb.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -2,7 +2,7 @@
>>  #ifndef _LINUX_HUGETLB_H
>>  #define _LINUX_HUGETLB_H
>>  
>> -#include <linux/mm_types.h>
>> +#include <linux/mm.h>
>>  #include <linux/mmdebug.h>
>>  #include <linux/fs.h>
>>  #include <linux/hugetlb_inline.h>
>>

-- 
~Randy
