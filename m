Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056C6588822
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiHCHnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiHCHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:43:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC228E15
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:42:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso1157061pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yZyRNrOtmJn2R9oPRcJXRCnJ2GUbITB77EurprO2OQI=;
        b=Ot1NjR/UkHIDQeGzZnG3pPKCxE57l/N5qwvNLfad66Bn3n5u8eg7oDqIVa8nEWvc2d
         CY4qXmToL6CmKvbzgmXCRnFM+soJ44AKdA6qwPV4aVRAoIcIhIOBh474KLF5E1r5J4RK
         PpphwE2cffnx6mUv5tz/ym9DeWhTjZMIXTGzrZdLErT9kqUbPNeBWtiW551TjPpaEToa
         ov2nZOxydaj58+HG7z1NocYCfOS5ZpVUp8DZmKlR8YbloLCMHvbVluaKaEcMxm0b6+13
         cnIfr+GIULENfKMun0SPEU3cQGCYlF2+TeQ354oHU1KdRVt5b04DC1hB5uI36Ug+esZ+
         YFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yZyRNrOtmJn2R9oPRcJXRCnJ2GUbITB77EurprO2OQI=;
        b=Dgvta4W/aCLHPC55jUwmOFU+99FZeK5u+d0QFCAh9auTBxbJ83HXKTTAYVmQh0hXui
         vLZA7HG5NZK/FsmcUckASSvkaHQeS/a7ZRu8e3DCLfE0qMN8o58XbyTeBQ/gRtukkQJ1
         dXD82nC4wa+4XPo41RbTbvssGSzcqtmttL9sfWJWpaipFQFMdZzcZiJ0Otc0AgqHHRXD
         MbWxM0qDc8jrBvw1ymhC6IUmEcvRq50jNMXYGS3otf2vqaeXWwYyae8FGFn5Rm0Ays6C
         vJSBHy4t4FBZJud4QvJQrqeGVWBL7pL9pQ4F1D42+WeB4MvyCqJMM+gACV3Ov3+pjqaD
         v2Sw==
X-Gm-Message-State: ACgBeo38YLxUUPW2p20ZHJGAgvHJXbV3As2sfMqmlfCN1yz98tz/usAI
        dLsOPNBlhvUQKE1ocO3zfZ4=
X-Google-Smtp-Source: AA6agR7zBK03yU4nvnvfaX28GT3DJcs+OhaxcL2kojdQXR/eKF9gfPomgJ3BMZAa7AbLxE0hvWtF8A==
X-Received: by 2002:a17:902:cec1:b0:16d:c4f2:66c5 with SMTP id d1-20020a170902cec100b0016dc4f266c5mr24747092plg.20.1659512577878;
        Wed, 03 Aug 2022 00:42:57 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id q30-20020a631f5e000000b0041c6541383dsm2536258pgm.60.2022.08.03.00.42.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:42:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220803012159.36551-3-peterx@redhat.com>
Date:   Wed, 3 Aug 2022 00:42:54 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEBB9DDB-3D67-42BD-BD16-4264F40760CD@gmail.com>
References: <20220803012159.36551-1-peterx@redhat.com>
 <20220803012159.36551-3-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 2, 2022, at 6:21 PM, Peter Xu <peterx@redhat.com> wrote:

> When page migration happens, we always ignore the young bit settings =
in the
> old pgtable, and marking the page as old in the new page table using =
either
> pte_mkold() or pmd_mkold().
>=20
> That's fine from functional-wise, but that's not friendly to page =
reclaim
> because the moving page can be actively accessed within the procedure. =
 Not
> to mention hardware setting the young bit can bring quite some =
overhead on
> some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the =
bit.
>=20
> Actually we can easily remember the young bit configuration and =
recover the
> information after the page is migrated.  To achieve it, define a new =
bit in
> the migration swap offset field to show whether the old pte has young =
bit
> set or not.  Then when removing/recovering the migration entry, we can
> recover the young bit even if the page changed.
>=20
> One thing to mention is that here we used max_swapfile_size() to =
detect how
> many swp offset bits we have, and we'll only enable this feature if we =
know
> the swp offset can be big enough to store both the PFN value and the =
young
> bit.  Otherwise the young bit is dropped like before.

I gave it some more thought and I am less confident whether this is the =
best
solution. Not sure it is not either, so I am raising an alternative with
pros and cons.

An alternative would be to propagate the access bit into the page (i.e.,
using folio_set_young()) and then set it back into the PTE later (i.e.,
based on folio_test_young()). It might even seem that in general it is
better to always set the page access bit if folio_test_young().

This can be simpler and more performant. Setting the access-bit would =
not
impact reclaim decisions (as the page is already considered young), =
would
not induce overheads on clearing the access-bit (no TLB flush is needed =
at
least on x86), and would save the time the CPU takes to set the access =
bit
if the page is ever accessed (on x86).

It may also improve the preciseness of page-idle mechanisms and the
interaction with it. IIUC, page-idle does not consider migration =
entries, so
the user would not get indication that pages under migration are not =
idle.
When page-idle is reset, migrated pages might be later reinstated as
=E2=80=9Caccessed=E2=80=9D, giving wrong indication that the pages are =
not-idle, when in
fact they are.

On the negative side, I am not sure whether other archs, that might =
require
a TLB flush for resetting the access-bit, and the overhead of doing =
atomic
operation to clear the access-bit, would not induce more overhead than =
they
would save.

One more unrelated point - note that remove_migration_pte() would always =
set
a clean PTE even when the old one was dirty=E2=80=A6

