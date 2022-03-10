Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128104D42B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiCJIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiCJIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A3813687C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646901366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdlbI2z0RghsFTWZjvxfS4BIInXiDN0dAMJn9Yvl9ms=;
        b=Ypi38RE7k5kIB8XQ2TbYeXUHXzL+IwMMcrmytvzRvYZrduAFS8nBTM4woRDbkuYPHkw+46
        aPhygsd9ziWuearKOR6fPs8gnuqqcDW7ksbQtWHv+t40LdNDxvWPYxgv3zrWO23n9kQGVJ
        u6vzgf/xum4tlSTz/kdUfUqZyRh5gPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-vsefvOMMP5WNTW_a_-hGBQ-1; Thu, 10 Mar 2022 03:36:05 -0500
X-MC-Unique: vsefvOMMP5WNTW_a_-hGBQ-1
Received: by mail-wm1-f70.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so3773748wma.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=SdlbI2z0RghsFTWZjvxfS4BIInXiDN0dAMJn9Yvl9ms=;
        b=l3cD9TvgLGky9ilsWOy+zG0/nk6hq6C0rPcRUMMKLnCm1ByGSmJ+fKA6sxPFZIETyi
         b8GpYF1Nv1pT7ZeNAMJ4utOJnywu6bz0U50bT2wEXHPIXVetOznONQehn3dRqONjwZBU
         wRc/0dffFwl12nvhmGBkJLIILSJsTPWn+ptr2UyF+yFNIVj3AcIsdxcG/HhSMkwmxwSo
         JnmdqHzB/Pw0BQQ3rjFJfVlzXu7u4XGLDAFpivjMuXpNp1c45MT1eCxHFWjBWQO4WH/2
         jM4jUji1hwf5AZtRN0LSoXbodj0rdENEXU919NUfMd5UnsowlC1yADxv5kKE7hmKpXSZ
         qNxA==
X-Gm-Message-State: AOAM533feB11to4xXBqKD1uQPgrWSR0mAfp2fy5Aiudn0hY+FyCduCa0
        A+U2caAqj0YN3oaRyT34syK3kES8BvGqOCbGGEnypn2T/rD7ECpxHgt2qQDc5AYU5Di8sZkkD9F
        Lj6ORHpL0mBcdb4cfmbnTcFzH
X-Received: by 2002:a05:6000:1a88:b0:203:8de9:47cc with SMTP id f8-20020a0560001a8800b002038de947ccmr597577wry.182.1646901363981;
        Thu, 10 Mar 2022 00:36:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0/MVki2Z/ZQZyp83Cw46INv+11717p3ZQf2EERKrA2i3GnigoGYETZX7KVL9NMjBmjgCyWg==
X-Received: by 2002:a05:6000:1a88:b0:203:8de9:47cc with SMTP id f8-20020a0560001a8800b002038de947ccmr597565wry.182.1646901363670;
        Thu, 10 Mar 2022 00:36:03 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b001f1f3330fc5sm3692426wrb.28.2022.03.10.00.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 00:36:03 -0800 (PST)
Message-ID: <f6730c85-096d-c523-661e-bb2ad80d96fe@redhat.com>
Date:   Thu, 10 Mar 2022 09:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YikTHqjv4S6ZQ3Fv@casper.infradead.org>
 <CAHk-=wiKSXZyKu+LhZjXp+UnDa7kcOyPPG+C8n3K-3AQ3KgMhA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] Free up a page flag
In-Reply-To: <CAHk-=wiKSXZyKu+LhZjXp+UnDa7kcOyPPG+C8n3K-3AQ3KgMhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.22 23:07, Linus Torvalds wrote:
> On Wed, Mar 9, 2022 at 12:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> We're always running out of page flags.  Here's an attempt to free one
>> up for the next time somebody wants one.
> 
> Ugh. This is too ugly for words.
> 
> I wouldn't mind something along the conceptual lines of "these bits
> are only used for this type", but I think it would need to be much
> more organized and explicit, not this kind of randomness.
> 
> For example, quite a few of the page bits really only make sense for
> the "page cache and anonymous pages" kind.
> 
> I think this includes some really fundamental bits like the lock bit
> (and the associated waiters bit), along with a lot of the "owner" aka
> "this can be used by the filesystem" bits.
> 
> I think it _also_ includes all the LRU and workingset bits etc.
> 
> So if we consider that kind of case the "normal" case, the not-normal
> case is likely (a) slab, (b) reserved pages and (c) zspages.,
> 
> Which is pretty close to your "xyzzy" bit (I think you came to the
> same list of "slab or reserved" conclusion because of the fundamental
> issues above), but my point is that I think this approach is
> acceptable if we make it much less random, and make it a lot more
> explicit and thought through.
> 
> And we'd probably need to actually *verify* that we don't do things
> like lock (or LRU) those non-normal pages.
> 

Looking at isolate_movable_page(), I think we can easily end up locking
random pages temporarily. And especially non-lru page migration makes
use of it as well.

Personally, I'd not try restricting PG_lock and PG_waiter for specific
page types, it IMHO a way to generic infrastructure.

Other page flags are different and we already reuse them in different
context: e.g., reusing PG_uptodate for buddy pages via PG_reported.

-- 
Thanks,

David / dhildenb

