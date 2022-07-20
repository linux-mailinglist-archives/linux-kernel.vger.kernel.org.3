Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CF57BF60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGTU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:56:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75A51A0C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:56:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k16so1323185pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mHaGFbnLm/HHSB9m9KzlAPd69oojkOy770c7wzvC1Fw=;
        b=P9USMlKdzsb6njhud8gzcwJukaFuFSGmGAYxzQU/GCU008LOZ63VA9e0MkfMPtgKec
         qeaK4ORAkYC0bKMqWCKiKS3Nm/PkyrAEkClB0AEDZbX1M/QWBmxl7yGfsfgMvQtzIbEr
         /a8XKGlQp5F3LZzA6DZYH6i8umf/xfdWPFgOVTIjliC6AiAdx2bFnMdE+T6e1U86tk41
         OKrqhQTjAujSOe5ccqPuga+Nfn65vzYXhf3n6+R6y8Lki1+aKx6atpeGNulYldt0NDv0
         BndVaLXlEe0s2UHHf6qOsoaOVQZscy8FavFcA6Bt+djdXmcCdfej6hsYvGT6Ck6NdlrH
         Ixhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mHaGFbnLm/HHSB9m9KzlAPd69oojkOy770c7wzvC1Fw=;
        b=qGQWriGFjMF8RRaR/eJXoULYEFdwYAcRsoks51OuRvuEqCLC9kRZ1wXFtVXP4KDJoJ
         69QH0nkJBCQuOpj1/KDyqUyalIJo9rb5xIaq9pE4+8N79i+w3U6Jf5Si0uBQNkUXfmRw
         L1WvXlXWYROQ3yIfEegIqWI7vBwFusKoLp8a9yDSECCKC+jWwj0hGCe/DuqBTmLXj7nY
         IeDl4Ri/8nXqZ+rfxV7jeogFporeUmL78NKNJFk1DKgypjciJ0wokSQAyOCGHti/P/pQ
         1GHGJvqbYNnau6hZZawqJzcEf3ATaw8Zi0cMl4VMbwFblBSjeushPtYIk+vtp7tuezEe
         lMgQ==
X-Gm-Message-State: AJIora9sdudE6lCLaZwAUve8cANpLVGcn4cLh66Y2QEuKulUanhX5a4o
        5LDgc1xYvVBYYwHH2ax98zA=
X-Google-Smtp-Source: AGRyM1s4n0/ZegBQV/OS265a+KNNVpjLj6yr1o0p2xY9RssykRbBmwqz6QKEv5S208C6V/fggJ6pqg==
X-Received: by 2002:a17:90a:e68c:b0:1f2:124d:1143 with SMTP id s12-20020a17090ae68c00b001f2124d1143mr7404851pjy.22.1658350598955;
        Wed, 20 Jul 2022 13:56:38 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.113])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b0016bc947c5b7sm18458plg.38.2022.07.20.13.56.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2022 13:56:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <468a7114-7541-0d5e-c1fc-083bbb95e78d@redhat.com>
Date:   Wed, 20 Jul 2022 13:56:35 -0700
Cc:     Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F56D4014-7FE2-4C60-9CFA-A7E7B684098B@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com> <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
 <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
 <YthUYF3invrjlzUc@xz-m1.local>
 <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
 <YthcC78q1hdd7mNT@xz-m1.local>
 <4ad140b5-1d5b-2486-0893-7886a9cdfd76@redhat.com>
 <95320077-52CF-4CB0-92F9-523E1AE74A3D@gmail.com>
 <468a7114-7541-0d5e-c1fc-083bbb95e78d@redhat.com>
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

On Jul 20, 2022, at 1:38 PM, David Hildenbrand <david@redhat.com> wrote:

> On 20.07.22 22:22, Nadav Amit wrote:
>> On Jul 20, 2022, at 12:55 PM, David Hildenbrand <david@redhat.com> =
wrote:
>>=20
>>> On 20.07.22 21:48, Peter Xu wrote:
>>>> On Wed, Jul 20, 2022 at 09:33:35PM +0200, David Hildenbrand wrote:
>>>>> On 20.07.22 21:15, Peter Xu wrote:
>>>>>> On Wed, Jul 20, 2022 at 05:10:37PM +0200, David Hildenbrand =
wrote:
>>>>>>> For pagecache pages it may as well be *plain wrong* to bypass =
the write
>>>>>>> fault handler and simply mark pages dirty+map them writable.
>>>>>>=20
>>>>>> Could you elaborate?
>>>>>=20
>>>>> Write-fault handling for some filesystems (that even require this
>>>>> "slow path") is a bit special.
>>>>>=20
>>>>> For example, do_shared_fault() might have to call page_mkwrite().
>>>>>=20
>>>>> AFAIK file systems use that for lazy allocation of disk blocks.
>>>>> If you simply go ahead and map a !dirty pagecache page writable
>>>>> and mark it dirty, it will not trigger page_mkwrite() and you =
might
>>>>> end up corrupting data.
>>>>>=20
>>>>> That's why we the old change_pte_range() code never touched
>>>>> anything if the pte wasn't already dirty.
>>>>=20
>>>> I don't think that pte_dirty() check was for the pagecache code. =
For any fs
>>>> that has page_mkwrite() defined, it'll already have =
vma_wants_writenotify()
>>>> return 1, so we'll never try to add write bit, hence we'll never =
even try
>>>> to check pte_dirty().
>>>=20
>>> I might be too tired, but the whole reason we had this magic before =
my
>>> commit in place was only for the pagecache.
>>>=20
>>> With vma_wants_writenotify()=3D0 you can directly map the pages =
writable
>>> and don't have to do these advanced checks here. In a writable
>>> MAP_SHARED VMA you'll already have pte_write().
>>>=20
>>> We only get !pte_write() in case we have vma_wants_writenotify()=3D1 =
...
>>>=20
>>> try_change_writable =3D vma_wants_writenotify(vma, =
vma->vm_page_prot);
>>>=20
>>> and that's the code that checked the dirty bit after all to decide =
--
>>> amongst other things -- if we can simply map it writable without =
going
>>> via the write fault handler and triggering do_shared_fault() .
>>>=20
>>> See crazy/ugly FOLL_FORCE code in GUP that similarly checks the =
dirty bit.
>>=20
>> I thought you want to get rid of it at least for anonymous pages. No?
>=20
> Yes. Especially for any MAP_PRIVATE mappings.
>=20
> If you want to write to something that's not mapped writable in a
> MAP_PRIVATE mapping it
> a) Has to be an exclusive anonymous page
> b) The pte has to be dirty

Do you need both conditions to be true? I thought (a) is sufficient (if
the soft-dirty and related checks succeed).

>=20
> In any other case, you clearly missed to COW or the modifications =
might
> get lost if the PTE is not dirty.
>=20
> MAP_SHARED is a bit more involved. But whether the pte is dirty might =
be
> good enough ... but this needs a lot more care.
>=20
>>> But yeah, it's all confusing so I might just be wrong regarding
>>> pagecache pages.
>>=20
>> Just to note: I am not very courageous and I did not intend to change
>> condition for when non-anonymous pages are set as writable. That=E2=80=99=
s the
>> reason I did not change the dirty for non-writable non-anonymous =
entries (as
>> Peter said). And that=E2=80=99s the reason that setting the dirty bit =
(at least as I
>> should have done it) is only performed after we made the decision on =
the
>> write-bit.
>=20
> Good. As long as we stick to anonymous pages I roughly know what we we
> can and cannot do at this point :)
>=20
>=20
> The problem I see is that detection whether we can write requires the
> dirty bit ... and whether to set the dirty bit requires the =
information
> whether we can write.
>=20
> Again, for anonymous pages we should be able to relax the "dirty"
> requirement when detecting whether we can write.

That=E2=80=99s all I wanted to do there.

>=20
>> IOW, after you made your decision about the write-bit, then and only =
then
>> you may be able to set the dirty bit for writable entries. Since the =
entry
>> is already writeable (i.e., can be written without a fault later =
directly
>> from userspace), there should be no concern of correctness when you =
set it.
>=20
> That makes sense to me. What keeps confusing me are architectures with
> and without a hw-managed dirty bit ... :)

I don=E2=80=99t know which arch you have in your mind. But the moment a =
PTE is
writable, then marking it logically/architecturally as dirty should be
fine.

But=E2=80=A6 if the Exclusive check is not good enough for private+anon =
without
the =E2=80=9Clogical=E2=80=9D dirty bit, then there would be a problem.=20=



