Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60988496457
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351197AbiAURoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351827AbiAURn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:43:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30783C061748
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:43:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l16so9880915pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5yBj3WKsDqrKvhosut7Au96eMd8ifdmMwiAx6WznJJg=;
        b=MSfbGULULNWFoZz9zq8jbfTsWmcNlHiBq5Bc91hYYPr/DnYNj3TaEvIeRKo36wbzGO
         O74mJZMpnhLyohm66AKQF6IPcIsTtZFHCmkmtV7nqp7kpWbtZRHBOalXltHKn4MhLB6y
         TfWODrdzwd5VVKBlUBB4RkQ8XjD/3OUqnQr6cIdGgOEPyk7O9CTG/x3j77ZxlqIDdNxH
         WNgjEVbbFztybma6V3PFrTC/h+jKqzPfFQCgkPkgIeYC8yTdVoo+kT9DrggXwESdKGC6
         qrWg0c5RURFDcDqzj3YW1r/mlNEFF3fSRIWahbI6fnVWLK66Mrc84YCeQw4Yw9pWxTZz
         6F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5yBj3WKsDqrKvhosut7Au96eMd8ifdmMwiAx6WznJJg=;
        b=rZOnX5y2/pwbKh1du0FiLUvIxfP99GentTexuhcdmVt9lzumkpp5HiptoMNv5YpEFY
         2xQEGYX0ISZwcO6eOoQjrogVmDOFlbSGxXzqWx9To5LgCHkmzhsAc5ubc++dr7Y9SsZ+
         nZdFp7wduxc2aAcb3uJ/buvHspFZrWRL9CVurABWbFlHpT+o2bzfsSX0Gh6c3utaQeIM
         qtIZgTN9lZcVWvjpWCkNA6bAGudsqQb+caJsHmYQ9H3dzRoG2j192dKLNextokIgQU8Y
         K4QPU3DQemesEOK18Azz+0SEJe5k8JhFVzlMoEcJUDq8Il7Z57Jui00Bp4c/9FfjzAeM
         B68A==
X-Gm-Message-State: AOAM531MtVyVVLSS822erTRly3ZfNdFOordnh+sfSavbWvIgDMFStnUC
        v239GQBYA7USTDzR6bgUxdk=
X-Google-Smtp-Source: ABdhPJyBGtAYRb3J3bCVGT7+zDw56OdBPKGmybQTfiuUh57u9/gsTdmlL70vhudKKUFWdh+Sze8Qhg==
X-Received: by 2002:a17:902:ea0b:b0:14a:f5ba:1e5e with SMTP id s11-20020a170902ea0b00b0014af5ba1e5emr4823317plg.125.1642787036351;
        Fri, 21 Jan 2022 09:43:56 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id y21sm7652058pfi.78.2022.01.21.09.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jan 2022 09:43:55 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <03b0ed0c-51af-1e68-350c-19a3b38a6e48@redhat.com>
Date:   Fri, 21 Jan 2022 09:43:54 -0800
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C28EAA21-0EBB-45BC-8B93-F2290BCA6CF5@gmail.com>
References: <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
 <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
 <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
 <9071d5a8-ed2d-5cf5-5526-43fe7dd377ec@redhat.com>
 <YenA7Xzd2G2OYvqz@casper.infradead.org>
 <da2846a1-f950-d330-7ada-ad3c9abfde74@redhat.com>
 <42a9b72d-093e-c35c-f4b5-b321a666e67d@redhat.com>
 <288FB900-A688-4EDB-95C6-E63B6E0A15D1@gmail.com>
 <7a18f74f-9dc2-f23d-4f1c-c7a9217f8317@redhat.com>
 <03b0ed0c-51af-1e68-350c-19a3b38a6e48@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2022, at 1:01 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
>>>=20
>>> I did hack something similar and it solved the problem, but I felt =
it is
>>> a hack. If the thread is scheduled on another core, or if the write =
fault
>>> is triggered by another thread it wouldn=E2=80=99t work.
>>=20
>> Yes, it will not match easily. One question would be how often it =
would
>> help in practice and if it would be worth the price.
>>=20
>=20
>=20
> I did some more testing and I have to admit that your reproducer is
> really good at finding corner cases.
>=20
> Assume we try to handle LRU as discussed ... what I get is a delta
> during the test: ./forceswap 2 100000 1
>=20
>=20
> anon_wp_reuse 920
> -> we were able to reuse
> anon_wp_copy_count 0
> -> we failed the final page_count() =3D=3D 1 check
> anon_wp_copy_count_early 634
> -> we failed the early page_count() check considering swapcache and =
lru
> anon_wp_copy_lock 1
> -> we failed trylock
> anon_wp_copy_lru 19
> -> we failed to clear the lru cache reference
> anon_wp_copy_writeback 99974
> -> we failed to clear the swapcache reference due to concurrent
>   writeback
> anon_wp_copy_swapcache 0
> -> we failed to clear the swapcache reference for other reasons
>=20
> So, yeah, we mostly always hit writeback in forceswap.c.
> reuse_swap_page() would have been able to reuse the page if the swap
> backend would have supported concurrent writes during writeback (IIUC,
> zswap doesn't).
>=20
> But I think triggering that case that often really is an oddity about
> the test case.

I am glad you find it useful (not my greatest piece of work).

IIRC, I encountered the scenario you describe. It happens when you use
a device driver that uses async operations (most of them). If you use
pmem, it does not happen.

This behavior is not intentional, anyhow.

