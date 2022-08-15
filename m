Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C075951A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiHPFFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiHPFEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:04:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F218DC04
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:03:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so178839pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=je9mkTd7hK9getobpinLs+IwDRRu6tp5EWDUYT/znxA=;
        b=S4kstyT5ya1G60oqBCS4kOWjOPbd/1oj1NF42PQ/N+lgI6ykau/pCdSRLa+keQoBaS
         ImmmkcX3Zfp11vHkCcPMHm2jmJNLihnMe0bReHPfh8JbAAzZkDUn/J/2QWt3VVJjWpCr
         PTmUrGryJggALRRwrbIj8LQQgsn29MgBMRQMHPOY4DzHJ1E+7bF3t4oiH9vAoEEVAkow
         nw6AJR2BwnlV/HcHjStl5eVON5+EBs5gDgPEREtG5mMTqxjOTvwNgok0uAPsACFqcl56
         Lawtkygv+S6s1iVWyn5x3EHnt41c7L5Q6jWqCO4I9EP8pc/oG2rhfw/CkFPZ/mUSIY4D
         8cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=je9mkTd7hK9getobpinLs+IwDRRu6tp5EWDUYT/znxA=;
        b=5VJYfp++4WYu8438RLK4FaYMf8SNnJdcdT/uAxQYasnvfJhmaPLXII3q/ezq3JJAMi
         gFNBxcWYcjlrKhN0I9+6JYIquYVEmtFqGX97rKyMGrqvNDKJJ2VSHfjjdLbV2ynFRCRo
         XFGsFf32lLd1qamhsGCsw5CAwIvU93Qx37qbYA7/TD3VR4Tioa8StNPGreMYcuW5yVVS
         Z/pHe5K1RnecjcIDRYuU5w7UodVjBriGZgndn1Q/aj+vp84wWCSm86cTeOG6viCvcKXk
         sljtRhgOV8AMbS442v8dJ5x54J/2xOKKBOdZ1IigAYNX8B4agdQTduxRh6pR1TukKs99
         MTyA==
X-Gm-Message-State: ACgBeo2ztN3nHxmGAVnq6Ni8hJPg41Chlqz1H2eubhG9WBxwkWRClPcq
        av1o2YOs53hitiHre++S2M6n1jjF9h5CFg==
X-Google-Smtp-Source: AA6agR44+ifgWCDgmkrzaLC4LcN0Pzmv1dnZPiz9dx0VkCSF+V99u1IA17b1bjC3rh7w1WfFZsIzuQ==
X-Received: by 2002:a17:90b:390f:b0:1f4:e394:8c18 with SMTP id ob15-20020a17090b390f00b001f4e3948c18mr19648896pjb.141.1660597384068;
        Mon, 15 Aug 2022 14:03:04 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b0016dbb878f8asm7420251plg.82.2022.08.15.14.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 14:03:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <5B21352C-2BE6-4070-BB6B-C1B7A5D4D225@gmail.com>
Date:   Mon, 15 Aug 2022 14:03:01 -0700
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E37036E0-566E-40C7-AD15-720CDB003227@gmail.com>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-6-peterx@redhat.com> <YvUeB0jc6clz59z5@xz-m1.local>
 <87pmh6dwdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YvqcGq44oonHNyCO@xz-m1.local>
 <5B21352C-2BE6-4070-BB6B-C1B7A5D4D225@gmail.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2022, at 1:52 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> On Aug 15, 2022, at 12:18 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
>> On Fri, Aug 12, 2022 at 10:32:48AM +0800, Huang, Ying wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>=20
>>>> On Tue, Aug 09, 2022 at 06:00:58PM -0400, Peter Xu wrote:
>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>> index 27fb37d65476..699f821b8443 100644
>>>>> --- a/mm/migrate_device.c
>>>>> +++ b/mm/migrate_device.c
>>>>> @@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t =
*pmdp,
>>>>> 			else
>>>>> 				entry =3D make_readable_migration_entry(
>>>>> 							=
page_to_pfn(page));
>>>>> +			if (pte_young(pte))
>>>>> +				entry =3D =
make_migration_entry_young(entry);
>>>>> +			if (pte_dirty(pte))
>>>>> +				entry =3D =
make_migration_entry_dirty(entry);
>>>>> 			swp_pte =3D swp_entry_to_pte(entry);
>>>>> 			if (pte_present(pte)) {
>>>>> 				if (pte_soft_dirty(pte))
>>>>=20
>>>> This change needs to be wrapped with pte_present() at least..
>>>>=20
>>>> I also just noticed that this change probably won't help anyway =
because:
>>>>=20
>>>> (1) When ram->device, the pte will finally be replaced with a =
device
>>>>     private entry, and device private entry does not yet support =
A/D, it
>>>>     means A/D will be dropped again,
>>>>=20
>>>> (2) When device->ram, we are missing information on either A/D =
bits, or
>>>>     even if device private entries start to suport A/D, it's still =
not
>>>>     clear whether we should take device read/write into =
considerations
>>>>     too on the page A/D bits to be accurate.
>>>>=20
>>>> I think I'll probably keep the code there for completeness, but I =
think it
>>>> won't really help much until more things are done.
>>>=20
>>> It appears that there are more issues.  Between "pte =3D *ptep" and =
pte
>>> clear, CPU may set A/D bit in PTE, so we may need to update pte when
>>> clearing PTE.
>>=20
>> Agreed, I didn't see it a huge problem with current code, but it =
should be
>> better in that way.
>>=20
>>> And I don't find the TLB is flushed in some cases after PTE is =
cleared.
>>=20
>> I think it's okay to not flush tlb if pte not present.  But maybe =
you're
>> talking about something else?
>=20
> I think Huang refers to situation in which the PTE is cleared, still =
not
> flushed, and then A/D is being set by the hardware.
>=20
> At least on x86, the hardware is not supposed to do so. The only case =
I
> remember (and sometimes misremembers) is with KNL erratum, which =
perhaps
> needs to be considered:
>=20
> =
https://lore.kernel.org/all/20160708001911.9A3FD2B6@viggo.jf.intel.com/

I keep not remembering this erratum correctly. IIRC, the erratum says =
that
the access/dirty might be set, but it does not mean that a write is =
possible
after the PTE is cleared (i.e., the dirty/access might be set on the
non-present PTE, but the access itself would fail). So it is not an =
issue in
this case - losing A/D would not impact correctness since the access =
should
fail.

Dave Hansen hates when I get confused with this one, but I cc him if he
wants to confirm.

[ Having said all of that, in general the lack of regard to
  mm->tlb_flush_pending is always concerning in such functions. ]=
