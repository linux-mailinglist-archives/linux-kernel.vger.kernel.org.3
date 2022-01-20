Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35B495383
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiATRtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiATRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:48:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A402C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:48:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h12so6575274pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=heGH2liwYeCVUcWukb6EpDtm1zadgMNDqt2eox+7pWc=;
        b=brgRAWWO7gC1UKbwS50JJf0+G6U6nF/slfpvQimG+jXSv2HGviZa9tdLMImpDRa5FV
         TbFtlPBhXoAk4rVOjw/wBxpJhQ7UvFT8YtKleMiL25EoWSupvh62f/vDD1TZU1aFDEcl
         g6l1RWO7N1Fxwi/KRccGFD8/uCfU7Yoq5s4OTg0D8jgKoR+HfrCZhW4wWoD1dbKHf5lD
         rNfJJhV/i49FMYm5pdDVuEa7zWcyk7s26NJ2Mlzj3xrUZcTkgXQsyKVnC+d0eCbliHwM
         RaD0IPDjtYmf59f4e+O2DZDoQ0kW4wMWIGQpywY6IS6r0OKZirghAp9bIKcqW79kvgGV
         neQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=heGH2liwYeCVUcWukb6EpDtm1zadgMNDqt2eox+7pWc=;
        b=NqmK3eBL5QBE3UL1hIqokDaYo5T0++q0DoEZJiMNsJl+TCj/SkDu9L1kn0y6p6Np0J
         fBCzZZhlHuFCN3+lR4/lwrYR6R8tesgKTo+yxqUubar+kPxUZXtPzBM3rTWy7LwuBpdI
         EpzKErhN1/FQjcRwrg4xNckGVsEW0zQj3/3c1rBRrbe1wgTvP43UVPYRWAGRZmus66T4
         IXE0IK25DH10RdRCzESD+6lzCAzkkBZmPPAiMFMyDlbFyaJOobjY3ItDU4xuasdPeAEE
         xovh13vwQ3ySPEozjgHnrPflJsV9P2FkDvjvYU6gjD9sq7b+POalTnYIlZQeTWCbv5So
         D7RA==
X-Gm-Message-State: AOAM533XKn7tEfMsyH3IQMj8AE+NY7joBA1SmKO+jcm5e/tcQHhwbw07
        hPP1iFrC8iV5YvMNLFjMXEQ=
X-Google-Smtp-Source: ABdhPJzyobnH69tRqfsYfWWnD8saKrtlbJKZRjLnwZm0USBh0gKwesmZNKH+heVPV4448zyIC29m/g==
X-Received: by 2002:a17:90b:4ad1:: with SMTP id mh17mr12163935pjb.160.1642700934309;
        Thu, 20 Jan 2022 09:48:54 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id v8sm9534524pju.51.2022.01.20.09.48.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 09:48:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
Date:   Thu, 20 Jan 2022 09:48:52 -0800
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
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
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 20, 2022, at 6:15 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 17.01.22 14:31, zhangliang (AG) wrote:
>> Sure, I will do that :)
>=20
> I'm polishing up / testing the patches and might send something out =
for discussion shortly.
> Just a note that on my branch was a version with a wrong condition =
that should have been fixed now.
>=20

Sorry for being late for the discussion.

David, does any of it regards the lru_cache_add() reference issue that I
mentioned? [1]

Seems to me that any solution should also regard this problem, or am I
missing something?

Thanks,
Nadav

[1] =
https://lore.kernel.org/linux-mm/0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmai=
l.com/=
