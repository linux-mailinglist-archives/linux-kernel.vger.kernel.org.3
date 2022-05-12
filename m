Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F252468A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350765AbiELHKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350737AbiELHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E082466C8C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652339425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YS0S6KH7SUmuANQj1TttUhl1vOvBYTpy060LSdzgn98=;
        b=IYRlFigUqfcL0n6Qs02alBxjyyyB2/GJaY1Ywc6wVBlJWgkp0Y0j+Av57a3pw347w8gAZZ
        4pDCms1zOFfKPP7gGCT+xhhExu+gqGw4padEmvizWYWTVRevl5HEcJ69B0kZtv6wrDIquY
        NjwoKECR3l9WYqqZpyETCQd5epMidGk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-EJRPKzTmM1Sdq9JSqRPlZA-1; Thu, 12 May 2022 03:10:23 -0400
X-MC-Unique: EJRPKzTmM1Sdq9JSqRPlZA-1
Received: by mail-wm1-f70.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so1305772wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=YS0S6KH7SUmuANQj1TttUhl1vOvBYTpy060LSdzgn98=;
        b=scYZfQp56qzN01Ap7xtuCNeDZ1gvZQB27K4hjwQCaA9ykByhWkgPjQVSxJ0UN61yM/
         ynig3HUJfd+b8D99HqjqvligkPPbVwWTKnjwzrW4yaPIJHgkP4qhtz7uzj/Nr0mb0sxZ
         SMCUPrCziDeQ8rO9AoHn5Ns3raau15mFm/eYOfQ9JZoCkWferPmsmS3BBOtjJriNfn43
         m724zl5nN+VpdUr4IpowTLgYrMm0ry6JRY0elN3+6vUBA/JcIG6JUf2oFhBp4X2+0sui
         LmcsjSq4oLm+nKPct9OK6GiW1SyDXQ8/Sk+BM/f3m1vWrA8t/U6jF8gS8XV2VvQiWhsZ
         JP6w==
X-Gm-Message-State: AOAM533IaN6HlkGhLlPHAzdZogxHzpjU4iKGP9msO0J4f8rkizO727Wc
        Cekade5IPhfXvc21eULqVWprOFZywFS8qRANuGL1iTqcJZpfnBWq1jBM0j9rarEvqvqAmgNA6OJ
        OqUc0IQCuu9PW1hW6kF7zG9C+
X-Received: by 2002:a5d:4052:0:b0:20a:d8b9:9d4b with SMTP id w18-20020a5d4052000000b0020ad8b99d4bmr25334659wrp.612.1652339422544;
        Thu, 12 May 2022 00:10:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybzz24sWU+LbkUCCmAALDO44blzojf0G/oD1KhTr1Rqygw7Qu9PimEjzomDbhyFzgqJYEPIg==
X-Received: by 2002:a5d:4052:0:b0:20a:d8b9:9d4b with SMTP id w18-20020a5d4052000000b0020ad8b99d4bmr25334634wrp.612.1652339422228;
        Thu, 12 May 2022 00:10:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id r6-20020adfdc86000000b0020c5253d8bdsm4144439wrj.9.2022.05.12.00.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:10:21 -0700 (PDT)
Message-ID: <c566dc2c-fc70-e410-5272-767fa28cbba4@redhat.com>
Date:   Thu, 12 May 2022 09:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     ying.huang@intel.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, Minchan Kim <minchan@kernel.org>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-3-linmiaohe@huawei.com>
 <525298ad-5e6a-2f8d-366d-4dcb7eebd093@redhat.com>
 <f5f933dc-450c-f3ac-34e6-d6dc1d901efd@huawei.com>
 <4cf144a9-fff5-d993-4fcb-7f2dfa6e71bb@redhat.com>
 <924de987-202b-a97e-e6d2-6bdab530f190@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
In-Reply-To: <924de987-202b-a97e-e6d2-6bdab530f190@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> If PG_isolated is still set, it will get cleared in the buddy when
>> freeing the page via
>>
>> 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> 
> Yes, check_free_page only complains about flags belonging to PAGE_FLAGS_CHECK_AT_FREE and PG_isolated
> will be cleared in the buddy when freeing the page. But it might not be a good idea to reply on this ?
> IMHO, it should be better to clear the PG_isolated explicitly ourselves.

I think we can pretty much rely on this handling in the buddy :)

> 
>>
>>>
>>>>
>>>>
>>>> Also, I am not sure how reliable that page count check is here: if we'd
>>>> have another speculative reference to the page, we might see
>>>> "page_count(page) > 1" and not take that path, although the previous
>>>> owner released the last reference.
>>>
>>> IIUC, there should not be such speculative reference. The driver should have taken care
>>> of it.
>>
>> How can you prevent any kind of speculative references?
>>
>> See isolate_movable_page() as an example, which grabs a speculative
>> reference to then find out that the page is already isolated by someone
>> else, to then back off.
> 
> You're right. isolate_movable_page will be an speculative references case. But the page count check here
> is just an optimization. If we encounter speculative references, it still works with useless effort of
> migrating to be released page.


Not really. The issue is that PAGE_FLAGS_CHECK_AT_FREE contains
PG_active and PG_unevictable.

We only clear those 2 flags if "page_count(page) == 1". Consequently,
with a speculative reference, we'll run into the check_free_page_bad()
when dropping the last reference.

This is just shaky. Special casing on "page_count(page) == 1" for
detecting "was this freed by the owner" is not 100% water proof.

In an ideal world, we'd just get rid of that whole block of code and let
the actual freeing code clear PG_active and PG_unevictable. But that
would require changes to free_pages_prepare().


Now I do wonder, if we ever even have PG_active or PG_unevictable still
set when the page was freed by the owner in this code. IOW, maybe that
is dead code as well and we can just remove the whole shaky
"page_count(page) == 1" code block.

Ccing Minchan, who added clearing of the pageflags at that point.

-- 
Thanks,

David / dhildenb

