Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0758859DE16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356068AbiHWKlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354791AbiHWK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B8383BFB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661245543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=INN7PIgXiadwGovRAjy42jqyjlBtEC4HF54Zz7onxbw=;
        b=Y/rufR7x9eQ31ob50BpbpiG3wsQtnxMkB+sXvHDYCWvrdwbE/f799IOP3RBj2VpS4widEY
        rFpdZHPabwTb9cIxxf7BmP+H8r6Nagz9c3DvlnYUXV1L/EhcYLz1T63eduN9+vI/CJyeHJ
        bm3SFke7LdmPAvBMaqCMHqvhopBQIcY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-XP67eT6oMTKNqzi3ZoioQw-1; Tue, 23 Aug 2022 05:05:41 -0400
X-MC-Unique: XP67eT6oMTKNqzi3ZoioQw-1
Received: by mail-pl1-f199.google.com with SMTP id q6-20020a17090311c600b0017266460b8fso8751987plh.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc;
        bh=INN7PIgXiadwGovRAjy42jqyjlBtEC4HF54Zz7onxbw=;
        b=Z99n8vXLDFOfO7BnehPfWxRICFPYgfdTC0ZB7gmt8xoJSLF0JfVh1+EzrZVRqbtvoI
         Cs6dWFcFpMvCAW867KlgbtEMIEigxXrWvDV/2ESYW5GEqSU+tpPJ7Y4fGaqXTh2pgpvq
         LNYVO8uaKCHp4MvstE4J1/UGc5GEWwSmUH/ekqSekNGKviZuupzveIAhf4ITz7ERTjSO
         T5c4l9gzLr38ExzT+WTXBhkVgSM0FcAQ06M9rsURU2c2fVMoNq/D+JZr76AQXG1z18qW
         UVHFcxhWQBYfVZCFzsSuDOrS4Ejy9By6hf83jj34wTR1mDRbX4zY+VKVKNmUKhUPlhv4
         YWIg==
X-Gm-Message-State: ACgBeo1Q1QeMA6vWmAwDphKMlus2Sv4kwyKa/L44lK9qLLJCInANd/RV
        wFETIzFqvaOHznwImE8K/cUc0LpeFy70kEIsQJZlCY7cVNNubFQasVptkjSFG8SWpB6VA3HVgZJ
        ppQX+bqZEh/UW6SzyUiPZQHD7
X-Received: by 2002:a63:82c8:0:b0:42a:498e:93ae with SMTP id w191-20020a6382c8000000b0042a498e93aemr14683682pgd.607.1661245540291;
        Tue, 23 Aug 2022 02:05:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DHhQSi/HHjksiZl3epz+OBvTIZi3etnh1KD+p/SnaECEwWLyrQSv5Xeq/sqgreQqQSPBTMg==
X-Received: by 2002:a63:82c8:0:b0:42a:498e:93ae with SMTP id w191-20020a6382c8000000b0042a498e93aemr14683666pgd.607.1661245540056;
        Tue, 23 Aug 2022 02:05:40 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b0016bea74d11esm6167062pls.267.2022.08.23.02.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:05:39 -0700 (PDT)
Date:   Tue, 23 Aug 2022 18:05:36 +0900 (JST)
Message-Id: <20220823.180536.902316146510887788.syoshida@redhat.com>
To:     apopple@nvidia.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH v2] mm/gup.c: Fix return value for
 __gup_longterm_locked()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <8735dnu53w.fsf@nvdebian.thelocal>
References: <20220822153713.962904-1-syoshida@redhat.com>
        <8735dnu53w.fsf@nvdebian.thelocal>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Aug 2022 11:15:29 +1000, Alistair Popple wrote:
> 
> Shigeru Yoshida <syoshida@redhat.com> writes:
> 
>> __get_user_pages_locked() may return the number of pages less than
>> nr_pages.  So __gup_longterm_locked() have to return the number of
>> pages __get_user_pages_locked() returns if it succeeded, not nr_pages
>> requested.
> 
> Thanks for fixing this, I've been out the last few days so just catching
> up. I think I missed that 'rc' was passed as nr_pages into
> check_and_migrate_movable_pages(). Will double check that I don't make
> the same mistake in my latest series.

Thank you so much for your review.  Andrew has already applied the patch.

>> Fixes: 61c63c2076d9 (mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes)
> 
> I couldn't find that SHA1, I'm guessing due to rebasing, etc. of
> mm-unstable? Not sure how that is dealt with, but feel free to also add:

Yes, actually this hash is from from linux-next tree.

Thanks,
Shigeru

> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> 
>> CC: Alistair Popple <apopple@nvidia.com>
>> Reported-by: syzbot+616ff0452fec30f4dcfd@syzkaller.appspotmail.com
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>  mm/gup.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 5aa7531a703b..66582203220a 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2068,22 +2068,24 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>>  				  unsigned int gup_flags)
>>  {
>>  	unsigned int flags;
>> -	long rc;
>> +	long rc, nr_pinned_pages;
>>
>>  	if (!(gup_flags & FOLL_LONGTERM))
>>  		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
>>  					       NULL, gup_flags);
>>  	flags = memalloc_pin_save();
>>  	do {
>> -		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
>> -					     NULL, gup_flags);
>> -		if (rc <= 0)
>> +		nr_pinned_pages =
>> +			__get_user_pages_locked(mm, start, nr_pages, pages,
>> +						vmas, NULL, gup_flags);
>> +		if (nr_pinned_pages <= 0)
>>  			break;
>> -		rc = check_and_migrate_movable_pages(rc, pages, gup_flags);
>> +		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages,
>> +						     gup_flags);
>>  	} while (rc == -EAGAIN);
>>  	memalloc_pin_restore(flags);
>>
>> -	return rc ? rc : nr_pages;
>> +	return rc ? rc : nr_pinned_pages;
>>  }
>>
>>  static bool is_valid_gup_flags(unsigned int gup_flags)
> 

