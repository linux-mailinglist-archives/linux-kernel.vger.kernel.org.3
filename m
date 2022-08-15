Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB459515E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 06:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiHPE4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 00:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiHPEzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:55:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D11A6246
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:52:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r69so7490931pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=c+KhdgocO4zsjTWrfEV5k5L4Uxolaa6Gk/jRei7Y/Oc=;
        b=TS0+ZzP9+U3VDMoCF/KWdxpkXkeK9XBjuv9Qdin0izW547qxfmT/bA8xx8wwbmRPMm
         YyFvlXPDcb6xeyzuuSZDKfFQKR10Ww7hlSNSuWjku2HbH5tCvGdTad7S0zdd/exgT3Kp
         DkK4/aWC25K2HvXNWn8tHyUzcfbT+pB+7idD9/9SgIxfRJ5pHqTz9Jo8n+NT0fyVGIgw
         QYuKP8CDazls33bgYYwojsdwRcP+pKigDbNeoXK9tC0bRsPLjSnXrv5j0leIwJrCMiUk
         4jQvMS6q3J3P2CwxlMjJH/k948lSu4TjZYlZXfrN5CQEgANr0UvLmqB7qtsyUPvvrNr9
         cUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=c+KhdgocO4zsjTWrfEV5k5L4Uxolaa6Gk/jRei7Y/Oc=;
        b=MO2Fx7OJrDxJQl958OzLF8LqRwvTofQWIk6Ia+R/dQ9KpDQxOzHQ/MCH9tTRSxDwgV
         gY+w+jAubIXcNkxX0VIiAkSBoEcvyrzHAFsNPerBNLrTxqR8XWTsAtW4pR9CSQEulnUC
         SqlXEYc1A/N0FQMZgMK2E5xPE4Ky89N0WUWzr/mnL0BcrGqR2mAHCOMJ5hsdWTzP8OSk
         C+XpOy8qVQU+cCPV+487TsgTsJvHlC10IgYfg6xcUbtZalsOCCwAht1kbGZhdnyzXYVw
         HLaPGaV6NifAhqT/kurMTOdbWjOZ8ef0SUj4XLgiDXoFMmN8BzOWoe6xXp2rxP1ElMfa
         5FQQ==
X-Gm-Message-State: ACgBeo0nCMeTb8GRYI3JZ5OSqJLtAvu9qp54BhWCz6b2ra8FFCnC7Ltt
        /ba66Snln0l67rNw0NficcI=
X-Google-Smtp-Source: AA6agR7rwQ+jhfuSVG+xP3HP1o2g8wJCiy47OwluqMsTQl2gJNobuOXBh1yf09JSr8vzaFu8WioaYA==
X-Received: by 2002:a63:cf0d:0:b0:429:983d:272a with SMTP id j13-20020a63cf0d000000b00429983d272amr1746473pgg.209.1660596772468;
        Mon, 15 Aug 2022 13:52:52 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902f78200b0016d1f474653sm7437465pln.52.2022.08.15.13.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 13:52:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YvqcGq44oonHNyCO@xz-m1.local>
Date:   Mon, 15 Aug 2022 13:52:49 -0700
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B21352C-2BE6-4070-BB6B-C1B7A5D4D225@gmail.com>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-6-peterx@redhat.com> <YvUeB0jc6clz59z5@xz-m1.local>
 <87pmh6dwdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YvqcGq44oonHNyCO@xz-m1.local>
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

On Aug 15, 2022, at 12:18 PM, Peter Xu <peterx@redhat.com> wrote:

> On Fri, Aug 12, 2022 at 10:32:48AM +0800, Huang, Ying wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>>> On Tue, Aug 09, 2022 at 06:00:58PM -0400, Peter Xu wrote:
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index 27fb37d65476..699f821b8443 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -221,6 +221,10 @@ static int migrate_vma_collect_pmd(pmd_t =
*pmdp,
>>>> 			else
>>>> 				entry =3D make_readable_migration_entry(
>>>> 							=
page_to_pfn(page));
>>>> +			if (pte_young(pte))
>>>> +				entry =3D =
make_migration_entry_young(entry);
>>>> +			if (pte_dirty(pte))
>>>> +				entry =3D =
make_migration_entry_dirty(entry);
>>>> 			swp_pte =3D swp_entry_to_pte(entry);
>>>> 			if (pte_present(pte)) {
>>>> 				if (pte_soft_dirty(pte))
>>>=20
>>> This change needs to be wrapped with pte_present() at least..
>>>=20
>>> I also just noticed that this change probably won't help anyway =
because:
>>>=20
>>>  (1) When ram->device, the pte will finally be replaced with a =
device
>>>      private entry, and device private entry does not yet support =
A/D, it
>>>      means A/D will be dropped again,
>>>=20
>>>  (2) When device->ram, we are missing information on either A/D =
bits, or
>>>      even if device private entries start to suport A/D, it's still =
not
>>>      clear whether we should take device read/write into =
considerations
>>>      too on the page A/D bits to be accurate.
>>>=20
>>> I think I'll probably keep the code there for completeness, but I =
think it
>>> won't really help much until more things are done.
>>=20
>> It appears that there are more issues.  Between "pte =3D *ptep" and =
pte
>> clear, CPU may set A/D bit in PTE, so we may need to update pte when
>> clearing PTE.
>=20
> Agreed, I didn't see it a huge problem with current code, but it =
should be
> better in that way.
>=20
>> And I don't find the TLB is flushed in some cases after PTE is =
cleared.
>=20
> I think it's okay to not flush tlb if pte not present.  But maybe =
you're
> talking about something else?

I think Huang refers to situation in which the PTE is cleared, still not
flushed, and then A/D is being set by the hardware.

At least on x86, the hardware is not supposed to do so. The only case I
remember (and sometimes misremembers) is with KNL erratum, which perhaps
needs to be considered:

https://lore.kernel.org/all/20160708001911.9A3FD2B6@viggo.jf.intel.com/

