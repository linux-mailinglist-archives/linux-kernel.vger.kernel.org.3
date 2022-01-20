Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7FF4953E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbiATSLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiATSLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:11:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24004C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:11:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v11-20020a17090a520b00b001b512482f36so3669347pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gOcU0/BmRHJufgVqOwLZIOl2kit84wG17JB0ji+wG/E=;
        b=CXjw6VHLcXH9kggASFK9BPv3lhbEXdku5/He1K+ExRoI5XhJbAha1pWu3vN2jCZfj0
         IFusV5YaZ3jKD/JSHQsyzj/ANjLsQ7ZVYUFpUrmD+u35VIK8vaCI2E0PYwTEDgpGfaok
         /tv0vSJvbOkVr/LaboT3SrxqaWWIi/UQ7iDWaWYJxUHuFdm58HnU56ADnNLuiQe+/k4U
         jGMqgWaw7GC+5vtl0zaWN1Okf5fy1EMW2uW0Cz3ltbSPfo6fYX81LT+m0Eatl7RIkvk/
         jBMWJRs36igUM/wpf9j2ES3yZcSCJsLizrAoM9eIaYCPLfEWnXjcUphzNQdHIAWZTq1W
         vlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gOcU0/BmRHJufgVqOwLZIOl2kit84wG17JB0ji+wG/E=;
        b=bHDJjDepJKNDywl7QsynZaZesR8ssGQV5ySsjNeX36qPPJZ+xnNBLmkfMo8fYvbM40
         OTcNPbUoCcrU+rxRgAUiP177vH+9bZ4jMXmyavyi/xl58oalmuXAdWLKK8qIz+/ZrZ/1
         E3awqBzTFs7AoZeSz03GB5NMavJ5VFe2JCGxUEpO5in0QOt6UrvimH7tLpMpH5wytXJl
         2Jii1jf0XeIG/qq8+mr+V8SWRtpdkDyG/UoLkYnNqVi7GjjANiftr0ePi+U+1uKzZbm0
         BcZ1avd/DY1zm1Vai8GB0hCkObLzb3vXHxhnzsTShFgu/5eJUJ84t8dAok+qbU7nyEsd
         TMQA==
X-Gm-Message-State: AOAM532t1RtQ0PXKNiWnHvsFi+i2qpenVmeUwqQ/xfRl28RcYE+78NCG
        XUiwG+x3iz8r6+RqsQoPHzE=
X-Google-Smtp-Source: ABdhPJxd5EtHygpRB84GizgP0wSPnE6KtTe40W37fhj4/78BDcGz25kp4Qs6sK/1IyfnbvzWdBcXww==
X-Received: by 2002:a17:902:8b8b:b0:149:6d32:4b4c with SMTP id ay11-20020a1709028b8b00b001496d324b4cmr39794880plb.8.1642702268453;
        Thu, 20 Jan 2022 10:11:08 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id kx11sm2496449pjb.1.2022.01.20.10.11.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 10:11:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
Date:   Thu, 20 Jan 2022 10:11:06 -0800
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
 <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2022, at 10:00 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 20.01.22 18:48, Nadav Amit wrote:
>>=20
>>> On Jan 20, 2022, at 6:15 AM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 17.01.22 14:31, zhangliang (AG) wrote:
>>>> Sure, I will do that :)
>>>=20
>>> I'm polishing up / testing the patches and might send something out =
for discussion shortly.
>>> Just a note that on my branch was a version with a wrong condition =
that should have been fixed now.
>>>=20
>>=20
>> Sorry for being late for the discussion.
>>=20
>> David, does any of it regards the lru_cache_add() reference issue =
that I
>> mentioned? [1]
>=20
> No, unfortunately not in that part of my work. *Maybe* we could also =
try
> to handle that reference similarly to the swapcache, but the question =
is
> if we can't wait for PageAnonExclusive.
>=20
> Right now I have the following in mind to get most parts working as
> exptected:
>=20
> 1. Optimize reuse logic for the swapcache as it seems to be easy
> 2. Streamline COW logic and remove reuse_swap_page() -- fix the CVE =
for
>   THP.
> 3. Introduce PageAnonExclusive and allow FOLL_PIN only on
>   PageAnonExclusive pages.
> 4. Convert O_DIRECT to FOLL_PIN
>=20
> We will never ever have to copy a page PageAnonExclusive page in the =
COW
> handler and can immediately reuse it without even locking the page. =
The
> existing reuse logic is essentially then used to reset =
PageAnonExclusive
> on a page (thus it makes sense to work on it) where the flag is not =
set
> anymore -- or on a fresh page if we have to copy.
>=20
> That implies that all these additional references won't care if your =
app
> doesn't fork() or KSM isn't active. Consequently, anything that
> read-protects anonymous pages will work as expected and should be as
> fast as it gets.
>=20
> Sounds good? At least to me. If only swap/migration entries wouldn't =
be
> harder to handle than I'd wish, that's why it's taking a little and =
will
> take a little longer.

Thanks for the quick response. I would have to see the logic to =
set/clear
PageAnonExclusive to fully understand how things are handled.

BTW, I just saw this patch form PeterZ [1] that seems to be related, as
it deals with changing protection on pinned pages.


[1] =
https://lore.kernel.org/linux-mm/20220120160822.666778608@infradead.org/=
