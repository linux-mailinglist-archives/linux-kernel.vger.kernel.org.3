Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71248DD12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiAMRo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiAMRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:44:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED810C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:44:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t24so25880074edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFoGln4GPtAHnUxFY/ors8ny9KKsd5+31evPartr4oQ=;
        b=KedncrSCaadRSyFLntxCTXi9z2IIgRLPvIJOHrOOwaHKy8Aobcpbbyw/o5qWtHsFx9
         1pQ8ax77ONX1HZ0kM7HrZfEUKEXngbnBIhIQAggDl9GgDj0PTV0AzdaB/O6FG/igexaP
         tLSO/1ZeLhoMPWJuSxTlzmJxuVLGSMYD4NEh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFoGln4GPtAHnUxFY/ors8ny9KKsd5+31evPartr4oQ=;
        b=QnlCNj04M3159WxhqXnOCMFG9Q3pg+8ePY0I+3Oxd9V2S/IMUTYOzTEO0BjZmZVhTo
         k3Jont4C+Y8pxN/DH5hMZCnF7qXYbO2fzhji35bFkAwJHxUK4t4s9W/v89GCZ60kYXss
         e4jY9U7akqJBTbADQGwxqwShaGMXxVYmDHdhEX0w3pOggy1QqSJGEp+hSduOMaW87jfT
         RcAB9Cg6r6Ox+n5qdoDdl3MdmICj70UAozLVLtnRsfxIAb5E1vIbmi8e2qkYq+IECLxh
         RsKK/xItYkc3hkhiZP98Zcb5ZKNa0b+FF3l5tJ6e2OcP5cxluF5NZM59Y0c8hnN1dC03
         4/Bg==
X-Gm-Message-State: AOAM531bReUxfx0Suk4u/+6vinByeMBFk4/FfijnaWwA7ZJSPjKW2QN5
        73XSxVQyPLEx85QybLzHhsI4xyE1nTfmgAV/
X-Google-Smtp-Source: ABdhPJypNZvoq1AG/poHu1gSWx75Uets384pNlHuu+Wz66EtSP+NWnYlpXbDHJtNpyi/JM+QjSAfGA==
X-Received: by 2002:a50:ff10:: with SMTP id a16mr5135373edu.275.1642095863355;
        Thu, 13 Jan 2022 09:44:23 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id k22sm1445084edv.22.2022.01.13.09.44.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 09:44:21 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id o3so11483177wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:44:21 -0800 (PST)
X-Received: by 2002:a5d:6951:: with SMTP id r17mr4798730wrw.274.1642095861186;
 Thu, 13 Jan 2022 09:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org> <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com> <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
 <c3f34084-7315-e0c5-55db-d1cb006979f4@redhat.com>
In-Reply-To: <c3f34084-7315-e0c5-55db-d1cb006979f4@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jan 2022 09:44:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjv+beg2gRNdERANGfaGcqwDzzVD5RDD07FcrE5c6k-XA@mail.gmail.com>
Message-ID: <CAHk-=wjv+beg2gRNdERANGfaGcqwDzzVD5RDD07FcrE5c6k-XA@mail.gmail.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:25 AM David Hildenbrand <david@redhat.com> wrote:
>
> I might be missing something, but it's not only about whether we can remove
> the page from the swap cache, it's about whether we can reuse the page
> exclusively in a process with write access, avoiding a COW. And for that we
> have to check if it's mapped somewhere else already (readable).

No.

The "try to remove from swap cache" is one thing. That uses the swap count.

The "see if we can reuse this page for COW" is a completely different
test, and that's the "page_count() == 1" one.

The two should not be mixed up with each other. Just don't do it.
There's no reason - except for legacy confusion that should be
actively avoided and removed.

IOW, the COW path would do

 trylock - copy if fails
 try to remove from swap cache
 if page_count() is now 1, we can reuse it

Note how the "try to remove from swap cache" is entirely independent
of whether we then reuse it or not.

And yes, we can have optimistic other tests - like not even bothering
to trylock if we can see that the page-count is so elevated that it
makes no difference and trying to remove from swap cache would be just
pointless extra work (both the removal itself, and then potentially
later re-additions).

But those should be seen for what they are - not important for
semantics, only a "don't bother, this page has so many users that we
already know that removing the swapcache one doesn't make any
difference at all".

Now, it's possible that I'm missing something, but I think this kind
of clarity is very much what we should aim for. Clear rules, no mixing
of "can I COW this" with "can I remove this from the swap cache".

And now I need to start my travel nightmare, so I'll be effectively
offline for the next 24 hours ;(

              Linus
