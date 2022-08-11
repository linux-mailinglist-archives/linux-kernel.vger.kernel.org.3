Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79D4590860
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiHKVzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiHKVzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:55:46 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146111447
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:55:44 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id f10so7448262uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=u3u7luPR9C1c21z1wcEFU9ERQpt0EtbUvjlQMy/wwkU=;
        b=WHnAQw3Fn+MhoaqG0bfhnnVecOudD4nKJomuJkJtLlPc73RGk16RaZEsZCo0AyKYAG
         hLT55YNLUNBmyB7qfq9ukOUKEp+KSrAg5X8ZBJE5l805apiOOv22gupHbyg4DAWjLyzT
         8bCnmti2bbfTONXj0S5O2a5tlaij4d2C0TjSSZfl2HxlTfCbEVgXOm7QLCateFha975K
         9yrRtke8GyUrs/F8ExY/T0IqEMspYDpaI5DSmYvYardrSHIxk8BONM91hh0mmv6I/VhO
         h62YLXCmLV5J9pIxKqGXNKtbPS4+Luq4ECo+Zpgwf634ERs/7PE318BbIPq+RX+I3Asa
         Um9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=u3u7luPR9C1c21z1wcEFU9ERQpt0EtbUvjlQMy/wwkU=;
        b=tToEgN/6VfejZW77kmVZYnIF9SyQ8hGfo2fX2s+ssw4dQ/NRKQ643i0hX7JpNlYTef
         is9C7PJMoXshAYqatxZiGcpU1oUp1IrpbOjjws6X9WCvC721HREJ4DxR+aQTx6p2TM4P
         xbHHuEgBUCcDqRL9nDxV1gTMZWzeJrEpt3Ji3ySd79Fr6LWoI6BRytbuX0TXEdnenmO9
         l3gEt6FDS30IyOYb141UccfOkPztTb6XcNPAkn0qKh+0Zaf+coAE2bHI/LGF0dXlLNWH
         j2MrfMMl2kzzEC6PTzlO7n1+J2Edr6ETL34cz4OUBzBlB7IyHd3iiNgR8hBC1swtAaQ4
         g07g==
X-Gm-Message-State: ACgBeo3ynmWD+92PmCS8ASnor//me2SWUi+C5OpNIAz6e+EYAAu2jykf
        EUwlwX/2Sp7KjdPpKKsduTQe2laj36OTY0uSPc5i+g==
X-Google-Smtp-Source: AA6agR6Tl+w+Cq6fu3hieYhhq29AyLFFQMUDA63A0mOeqSL+4TzW/EZ7q2sgSksfPwbPM376pPSol9onTGk92ef9F1I=
X-Received: by 2002:a9f:2bcd:0:b0:387:471e:c4c1 with SMTP id
 f13-20020a9f2bcd000000b00387471ec4c1mr640310uaj.113.1660254943981; Thu, 11
 Aug 2022 14:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com> <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
 <CAHbLzkqGq6LDDSCcFTJW9_O8dfAMje8_W6ddpDP9ESDQWUb07w@mail.gmail.com>
 <F28E23D0-C635-4A49-91EE-100AAA8C9EAD@fb.com> <CAOUHufYeuMN9As58BVwMKSN6viOZKReXNeCBgGeeL6ToWGsEKw@mail.gmail.com>
 <868F0874-70E8-4416-B39B-DA74C9D76A40@fb.com> <CAOUHufas1o1Ez9EDSjjxsO-w6Ph6Km8R8yOX+1_c=4LvG6DEWw@mail.gmail.com>
 <DD679B3A-BDF7-4EBD-AAC2-A663057AC8E3@fb.com> <CAOUHufbD-9PpQ+kuD=-8z-ptsrprjyThpkFe+4_NtFnzAjDG9g@mail.gmail.com>
 <DEB2F4F2-7F62-48F0-914D-5F71BFDBCBEE@fb.com> <3195C304-2140-4E5D-890D-AC55653193E5@fb.com>
In-Reply-To: <3195C304-2140-4E5D-890D-AC55653193E5@fb.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 11 Aug 2022 15:55:07 -0600
Message-ID: <CAOUHufaggjiYAywB646N5Rj48eSJDjir8oLwDVu039ymbLm0PA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>
Cc:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 1:20 PM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote:
>
> Hi Yu,
>
> I=E2=80=99ve updated your patch set from last year to work with folio and=
 am testing it now. The functionality in split_huge_page() is the same as w=
hat I have. Was there any follow up work done later?

Yes, but it won't change the landscape any time soon (see below). So
please feel free to continue along your current direction.

> If not, I would like to incorporate this into what I have, and then resub=
mit. Will reference the original patchset. We need this functionality for t=
he shrinker, but even the changes to split_huge_page() by itself it should =
show some performance improvement when used by the existing deferred_split_=
huge_page().

SGTM. Thanks!

A side note:

I'm working on a new mode: THP=3Dauto, meaning the kernel will detect
internal fragmentation of 2MB compound pages to decide whether to map
them by PMDs or split them under memory pressure. The general workflow
of this new mode is as follows.

In the page fault path:
1. Compound pages are allocated as usual.
2. Each is mapped by 512 consecutive PTEs rather than a PMD.
3. There will be more TLB misses but the same number of page faults.
4. TLB coalescing can mitigate the performance degradation.

In khugepaged:
1. Check the dirty bit in the PTEs mapping a compound page, to
determine its utilization.
2. Remap compound pages that meet a certain utilization threshold by
PMDs in place, i.e., no migrations.

In the reclaim path, e.g., MGLRU page table scanning:
1. Decide whether compound pages mapped by PTEs should be split based
on their utilizations and memory pressure, e.g., reclaim priority.
2. Clean subpages should be freed directly after split, rather than swapped=
 out.

N.B.
1. This workflow relies on the dirty bit rather examining the content of a =
page.
2. Sampling can be done by periodically switching between a PMD and
512 consecutive PTEs.
3. It only needs to hold mmap_lock for read because this special mode
(512 consecutive PTEs) is not considered the split mode.
4. Don't hold your breath :)

Other references:
1. https://www.usenix.org/system/files/atc20-zhu-weixi_0.pdf
2. https://www.usenix.org/system/files/osdi21-hunter.pdf
