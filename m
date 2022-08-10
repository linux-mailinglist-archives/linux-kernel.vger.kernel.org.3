Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19258E96E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiHJJS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiHJJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 290F7AE208
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660123102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uiFPFiP6Hf6PNS9QuyB3HMvVy2bvN3qOXGUpbbFgOo=;
        b=WMsr9Hq7aRv4rTzzKsUA/D5fNnE4iJqf2r5hxrdV6cFvSQ4hmPxySg8r73xTSSXe8VwtSd
        OLpHBmNu7IKdfgrFQNRSpT5tj9bTuN39fz+WRU47Du2Yk6f5rdAbGxR7U26zhoQQR49YzD
        hNUXSphrAnlezoZ4A/fIN1/L4xH/eGA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-AU-FBpNSPA-kZKxCp87uKw-1; Wed, 10 Aug 2022 05:18:18 -0400
X-MC-Unique: AU-FBpNSPA-kZKxCp87uKw-1
Received: by mail-wm1-f71.google.com with SMTP id x17-20020a05600c21d100b003a32dda6577so365001wmj.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=0uiFPFiP6Hf6PNS9QuyB3HMvVy2bvN3qOXGUpbbFgOo=;
        b=u4cys1tm9H6vwcMkn6YE/CqSEY+tldnIT4PKrQHDuN/9q4IvaRpiIDJyrYdFHih4/S
         TyvxqPwtmJQ+i7pLvckw44GlHUkzy/TvOw+BmtopmB0ZM7091mRI7LThYRjipAQOY+bW
         4aLMMLNrZcVersmoYV6iSg0tP4foWRvgD6lJLZLGHysyCq3MrWED5wJDFcfB8pI8kI6T
         x0liTQqz8K3abhGb6YrcHIebgujxszoH1ODONS0iAJOu2PkynnS51iCo1zjHnqU07w5x
         EzSiLHUTLcEmlOB6dhoX+ZXy2qnuUDipn2D/pY+4WJvZ9zXyP6K8EGZTXhTleynoKN+a
         A9Nw==
X-Gm-Message-State: ACgBeo2ZWA7zyVpHkF7kJxMRM70oviLTGV6oaXnnQzSjXIdAbMnfF4XT
        vND3RPClTzIzSB0AAA0hm6ie0oBjxW/tpbaP6oaOD7qhHfTndC2U7Fp05H2ExWgzgvRCp91l2Jo
        BUS3lonaaytRGrHosHksyk+7J
X-Received: by 2002:a5d:61d0:0:b0:220:839f:dc95 with SMTP id q16-20020a5d61d0000000b00220839fdc95mr16183065wrv.241.1660123097766;
        Wed, 10 Aug 2022 02:18:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4w5nqH68Aak/Fd8pzrx9X+dRdxqFW9Ts+JdPHPB8s/CPVnYHbTHvx8DKBRDt9uCEvZ7YPAmQ==
X-Received: by 2002:a5d:61d0:0:b0:220:839f:dc95 with SMTP id q16-20020a5d61d0000000b00220839fdc95mr16183044wrv.241.1660123097498;
        Wed, 10 Aug 2022 02:18:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b003a5317f07b4sm1727479wms.37.2022.08.10.02.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:18:17 -0700 (PDT)
Message-ID: <b314c287-5fc2-9f61-53f6-33282a2bed92@redhat.com>
Date:   Wed, 10 Aug 2022 11:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mm/gup: fix FOLL_FORCE COW security issue and remove
 FOLL_COW
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220809205640.70916-1-david@redhat.com>
 <afab7f23d10145b590aef44b3242db64@AcuMS.aculab.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <afab7f23d10145b590aef44b3242db64@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.22 11:12, David Laight wrote:
> From: David Hildenbrand
>> Sent: 09 August 2022 21:57
> ...
> 
> These two functions seem to contain a lot of the same tests.

Yes, but after Linus and I discussed to not even reuse is_cow_mapping()
but instead to spell it out, I refrained from factoring common checks
out here to harm readability.

[...]

> 
> Perhaps only the initial call (common success path?) should
> be inlined?
> With the flags and vma tests being moved to an inline helper.

Do we really care enough to hurt readability? I mean, most things here
are simple bit checks, not expensive function calls.

inline is only a hint to the compiler after all. Please correct me if
I'm wrong.


Now, I don't have any strong opinion, but I do want to make progress for
this because -stable trees still need fixing and I'll be posting the
reproducer on Monday.


Thanks

-- 
Thanks,

David / dhildenb

