Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5926D57BF22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiGTUWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGTUWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:22:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5A2D1E8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:22:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso3165112pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DHXC5nqXXeAHRQ2EELeV2u1wYvoNpIJGu0NbYI1JGbY=;
        b=lyGREuuhbOTh+OMQIPD88iy01t69N8RI/ajGSoWG3Hywiym24ujD3zlZ/s0K860/+h
         xnXLzxjYfSLoqFd66Vi75Dn/03IA9s+cp30A6QAktmqt92IZ9XRkWyXQLnpvqnxLfr0X
         x+Fzi1MfqhRe4QMQ0WyZjcIm70R4RoTPsw5n4sWmIPTITGvicgOubsUvnutyD4FOPrga
         0luDL0/dSos/iuIg7KtprCAFgyaa6Ca5C3b064sOoQ3mHvQm2cjuRN5K8D2PNNEUsyx/
         8kcuTp6gtfKnxZcL9F1mF5iTI09CEEZBOo3mdqBXroTcikRIIRZZtoVerg/0RcegZz7V
         QAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DHXC5nqXXeAHRQ2EELeV2u1wYvoNpIJGu0NbYI1JGbY=;
        b=xFBGGOSmRFv3rlgkSCJMIFUVJiiqpd3e5Ft4dSlC1Qa/XcFsloWxj5oYix7EZj57e7
         I5KHj+ZbCVlGLeuIlDGvGe5E8RAMZ6puPuoWc8fftKuIs+MsZD8Ab00heeuf3apnntDT
         +prJyFyP97m1RXBma539BbYvbzd7dLTa1HyYiOwgS++wtJ8kc4nO9wPH9qbUxNA8ztO4
         srcRNDO+7arDzNYN8BAw1KIKX4c3HscipIdVLKIjMuZqlukMvi9aIOaotcYDN6+iuvhL
         mr1u+cpWPmTwvJ4broxVtxCGCh+kqiICBqB5EDO2yrx6bsiKqtGlnN4mPRUsyARKLqWo
         wYcg==
X-Gm-Message-State: AJIora/KNf0kudJhyfTfGXVf6VV96hnrioTRMhkxcQIltPHWx6LJSN6i
        PBHnC0R4oK0kF/eNBaVoLFU=
X-Google-Smtp-Source: AGRyM1smWNZVA6D3HKFBJbvrCnr2a8Mjx7pjyxZXp/gQMNGJPdv5AWEOl/zfxKF856Rf5Evl7HCHMA==
X-Received: by 2002:a17:902:7c04:b0:16c:2e00:395a with SMTP id x4-20020a1709027c0400b0016c2e00395amr40844416pll.123.1658348537951;
        Wed, 20 Jul 2022 13:22:17 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.113])
        by smtp.gmail.com with ESMTPSA id x194-20020a6286cb000000b0052ad49292f0sm50416pfd.48.2022.07.20.13.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2022 13:22:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <4ad140b5-1d5b-2486-0893-7886a9cdfd76@redhat.com>
Date:   Wed, 20 Jul 2022 13:22:15 -0700
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
Message-Id: <95320077-52CF-4CB0-92F9-523E1AE74A3D@gmail.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com> <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
 <Ytf+zIxVPTVXTZdp@xz-m1.local>
 <2b4393ce-95c9-dd3e-8495-058a139e771e@redhat.com>
 <YthUYF3invrjlzUc@xz-m1.local>
 <69022bad-d6f1-d830-224d-eb8e5c90d5c7@redhat.com>
 <YthcC78q1hdd7mNT@xz-m1.local>
 <4ad140b5-1d5b-2486-0893-7886a9cdfd76@redhat.com>
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

On Jul 20, 2022, at 12:55 PM, David Hildenbrand <david@redhat.com> =
wrote:

> On 20.07.22 21:48, Peter Xu wrote:
>> On Wed, Jul 20, 2022 at 09:33:35PM +0200, David Hildenbrand wrote:
>>> On 20.07.22 21:15, Peter Xu wrote:
>>>> On Wed, Jul 20, 2022 at 05:10:37PM +0200, David Hildenbrand wrote:
>>>>> For pagecache pages it may as well be *plain wrong* to bypass the =
write
>>>>> fault handler and simply mark pages dirty+map them writable.
>>>>=20
>>>> Could you elaborate?
>>>=20
>>> Write-fault handling for some filesystems (that even require this
>>> "slow path") is a bit special.
>>>=20
>>> For example, do_shared_fault() might have to call page_mkwrite().
>>>=20
>>> AFAIK file systems use that for lazy allocation of disk blocks.
>>> If you simply go ahead and map a !dirty pagecache page writable
>>> and mark it dirty, it will not trigger page_mkwrite() and you might
>>> end up corrupting data.
>>>=20
>>> That's why we the old change_pte_range() code never touched
>>> anything if the pte wasn't already dirty.
>>=20
>> I don't think that pte_dirty() check was for the pagecache code. For =
any fs
>> that has page_mkwrite() defined, it'll already have =
vma_wants_writenotify()
>> return 1, so we'll never try to add write bit, hence we'll never even =
try
>> to check pte_dirty().
>=20
> I might be too tired, but the whole reason we had this magic before my
> commit in place was only for the pagecache.
>=20
> With vma_wants_writenotify()=3D0 you can directly map the pages =
writable
> and don't have to do these advanced checks here. In a writable
> MAP_SHARED VMA you'll already have pte_write().
>=20
> We only get !pte_write() in case we have vma_wants_writenotify()=3D1 =
...
>=20
>  try_change_writable =3D vma_wants_writenotify(vma, =
vma->vm_page_prot);
>=20
> and that's the code that checked the dirty bit after all to decide --
> amongst other things -- if we can simply map it writable without going
> via the write fault handler and triggering do_shared_fault() .
>=20
> See crazy/ugly FOLL_FORCE code in GUP that similarly checks the dirty =
bit.

I thought you want to get rid of it at least for anonymous pages. No?

>=20
> But yeah, it's all confusing so I might just be wrong regarding
> pagecache pages.

Just to note: I am not very courageous and I did not intend to change
condition for when non-anonymous pages are set as writable. That=E2=80=99s=
 the
reason I did not change the dirty for non-writable non-anonymous entries =
(as
Peter said). And that=E2=80=99s the reason that setting the dirty bit =
(at least as I
should have done it) is only performed after we made the decision on the
write-bit.

IOW, after you made your decision about the write-bit, then and only =
then
you may be able to set the dirty bit for writable entries. Since the =
entry
is already writeable (i.e., can be written without a fault later =
directly
from userspace), there should be no concern of correctness when you set =
it.

