Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6D57BC94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiGTRZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiGTRZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:25:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C781B25C75
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:25:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z3so3222656plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KVy1jSlav0FOqpeAQ11Wb/ZstcAqe1KYzN+PWSIXtU8=;
        b=CarY0uRd9wdPwbNAzGtbvccyFjlu6IcKFsrNhmsAsz4IKmj1HvPTZGXBuM449JvuxH
         f95ulwixlmjvYZgka2dXgVU2vH/1Dkszh2AYpltxXqeRLSU5B4ynoJE0H/FZzpj0iRPG
         kjrDt8Bk1UfKUtb7s5LXPvjJBC5CBCktCdr8Lpud12PhX5S5FAm2/+TQ4SIQbzH11Wi4
         RGMfBSz4MDDsmEk+FVRP9wXZR66ygynfm0VIEgCsRG+A+pPK3wgWplGE50TFgi92UESE
         Lya8B38DMjF8nkwZbEgwoYhdRyz15X5pMaLK/S+sUnwKevrwfwwMrdW1Aw/rPZkQ/uvh
         Sgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KVy1jSlav0FOqpeAQ11Wb/ZstcAqe1KYzN+PWSIXtU8=;
        b=LMZoq/+CuQuY0QJdekLAXCr9wxeU4YkiRI1kh1xIVopcScUpGh0Hi0pJubqIlR1reD
         kmZirMw+vp8XBwjR2WALE62imre/NQW90s11AqN1FoTHb/5PRDElS/f2iKTwB2z1H5nb
         36tS1l2Qbf/wlAzqi0sBwnWKnzGQf1SqKoBSdLq96ED3mFqzD3vO/kYrOzDFAhf4lAoz
         Ekgx0sQVeWdKwlYUy/K+5yY9WwP4NvYUK4oZJqKSCX0wfrE1qCXr9EA7MtXm0lcr4Hdd
         G5wN0cyvU77H7b/oFhbPLdOGaqp+pFEDkZeGmutPAAx6Udlo5MZjfB1OFReutVTKOSaZ
         cZzw==
X-Gm-Message-State: AJIora8RCf++8Q0SmRY0iAMvwtXwk523+BO4vfOphXJOIV8bQS098aiB
        r4S+i+NKseNT2zW4VinpMww=
X-Google-Smtp-Source: AGRyM1vuNFYUnTL4pLfVPY+7Q3tvAgLv/p7Egq2AmXWYJ3xqpA/0xROIZUHeJyVuqaYPK3GDdptMwQ==
X-Received: by 2002:a17:903:1ca:b0:16c:4e2f:9294 with SMTP id e10-20020a17090301ca00b0016c4e2f9294mr40602508plh.30.1658337948964;
        Wed, 20 Jul 2022 10:25:48 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.113])
        by smtp.gmail.com with ESMTPSA id z26-20020aa79e5a000000b00517c84fd24asm14211873pfq.172.2022.07.20.10.25.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:25:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC PATCH 03/14] mm/mprotect: allow exclusive anon pages to be
 writable
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <23a9d678-487e-5940-4cde-dc53d920fb48@redhat.com>
Date:   Wed, 20 Jul 2022 10:25:46 -0700
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6EB667E-590C-4B6C-A932-EF7C5F711755@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-4-namit@vmware.com>
 <23a9d678-487e-5940-4cde-dc53d920fb48@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 20, 2022, at 8:19 AM, David Hildenbrand <david@redhat.com> wrote:

> On 18.07.22 14:02, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Anonymous pages might have the dirty bit clear, but this should not
>> prevent mprotect from making them writable if they are exclusive.
>> Therefore, skip the test whether the page is dirty in this case.
>>=20
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Nick Piggin <npiggin@gmail.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> mm/mprotect.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 34c2dfb68c42..da5b9bf8204f 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -45,7 +45,7 @@ static inline bool can_change_pte_writable(struct =
vm_area_struct *vma,
>>=20
>> 	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
>>=20
>> -	if (pte_protnone(pte) || !pte_dirty(pte))
>> +	if (pte_protnone(pte))
>> 		return false;
>>=20
>> 	/* Do we need write faults for softdirty tracking? */
>> @@ -66,7 +66,8 @@ static inline bool can_change_pte_writable(struct =
vm_area_struct *vma,
>> 		page =3D vm_normal_page(vma, addr, pte);
>> 		if (!page || !PageAnon(page) || =
!PageAnonExclusive(page))
>> 			return false;
>> -	}
>> +	} else if (!pte_dirty(pte))
>> +		return false;
>>=20
>> 	return true;
>> }
>=20
> When I wrote that code, I was wondering how often that would actually
> happen in practice -- and if we care about optimizing that. Do you =
have
> a gut feeling in which scenarios this would happen and if we care?
>=20
> If the page is in the swapcache and was swapped out, you'd be =
requiring
> a writeback even though nobody modified the page and possibly isn't
> going to do so in the near future.

So here is my due diligence: I did not really encounter a scenario in =
which
it showed up. When I looked at your code, I assumed this was an =
oversight
and not a thoughtful decision. For me the issue is more of the =
discrepancy
between how a certain page is handled before and after it was pages out.

The way that I see it, there is a tradeoff in the way dirty-bit should
be handled:
(1) Writable-clean PTEs introduce some non-negligible overhead.
(2) Marking a PTE dirty speculatively would require a write back.

=E2=80=A6 But this tradeoff should not affect whether a PTE is writable, =
i.e.,
mapping the PTE as writable-clean should not cause a writeback. In other
words, if you are concerned about unnecessary writebacks, which I think =
is a
fair concern, then do not set the dirty-bit. In a later patch I try to =
avoid
TLB flushes on clean-writable entries that are write-protected.

So I do not think that the writeback you mentioned should be a real =
issue.
Yet if you think that using the fact that the page is not-dirty is a =
good
hueristics to avoid future TLB flushes (for P->NP; as I said there is a
solution for RW->RO), or if you are concerned about the cost of
vm_normal_page(), perhaps those are valid concerned (although I do not =
think
so).

--

[ Regarding (1): After some discussions with Peter and reading more =
code, I
thought at some point that perhaps avoiding having writable-clean PTE as
much as possible makes sense [*], since setting the dirty-bit costs ~550
cycles and a page fault is not a lot more than 1000. But with all the
mitigations (and after adding IBRS for retbless) page-fault entry is =
kind of
expensive.=20

[*] At least on x86 ]=
