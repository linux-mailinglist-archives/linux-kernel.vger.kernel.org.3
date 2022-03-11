Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F64D69BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiCKUyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCKUyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:54:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE21EDA14
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:53:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so12096360pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iHGGTD8PyTVJNiJh8Y1TqDmvdURAM0MJZFSp08G78Is=;
        b=OmeYL54C6iNXt9LA5vp8y8mnjIFX2umARAfHq156jOatkVuSmDuZIwkS7f2FW0qwaM
         5ZcUlJrxBhu2aRiZalij+7oG7d8AjI8f/+p3yjZccOkt16ApsErI2vLxyuKS6DuL/2dF
         XewBS297splmdPZ0m9Tf4z1eJIcZx+4akKT6g2aj67G5AJJXej6AjUlZn8pE7Xix+uW9
         +wHOlFU0fia6lsu9e/MAehDrINiQnCIHHF1csnbTAW/Bycm1C9QSB31Vecjarp+QCVOP
         HiORxMdyYLmTdnvP+r5VuzNjUvSiT1vhHOd/KScpx8we9rsWuGWTtNNy49EIk5zYOuNt
         Ra1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iHGGTD8PyTVJNiJh8Y1TqDmvdURAM0MJZFSp08G78Is=;
        b=cYnG1rl4XZY3DkNd6v6XaMaKBku8ec+fayiFDboCX0PHEMF1Ba2DBjaTOtENKJjoAF
         8sbczRLfrcXT/MJgpYc3XX+7x9IGetMRWcjn6bnKXQN+Tp3dMVCclC7UdN9WfWU60F+B
         sf07KYbLIHMSyCT73uQ9Pbrt4zsVGYhEGEyH+mYOklrMHiRVwFPzB05pXpfH3AWvunYM
         z5it5GZbzsnYj34YUzSOv1a9ZwD1PedRkpOqUB+2dswFfyqrFRlqA0aPQwpwkSvIhcYF
         Z8I1WsWZYDEUQwzn69hpqxSDobBMGvpu4tXXPF+6HpECLVzfFEOZi3A0u7QphHdAkJoi
         Ss/g==
X-Gm-Message-State: AOAM530kDTfVCwjngomPMghu6O+Mjnl9jIki44QrRzCC7q9wdZ67Eoja
        /vdrJvVAZ6tl5HQYIUjHkfheLjEOW/I=
X-Google-Smtp-Source: ABdhPJxyNiCIk7FbxSXHe8ETZAAIY9TdBqDpTX658H+y+43oFI+tublXZJqo5GDPLxBqu4SZR0vqAw==
X-Received: by 2002:a17:902:744c:b0:153:29de:55aa with SMTP id e12-20020a170902744c00b0015329de55aamr8245142plt.2.1647032012678;
        Fri, 11 Mar 2022 12:53:32 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s15-20020a63af4f000000b0037c8875108dsm9332340pgo.45.2022.03.11.12.53.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2022 12:53:31 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RESEND PATCH v3 5/5] mm: avoid unnecessary flush on
 change_huge_pmd()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <e5f84691-3475-1cbd-e46c-163bf594a4bc@intel.com>
Date:   Fri, 11 Mar 2022 12:53:30 -0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2252098-2EE1-4F8D-A1A2-A49EE8FD18A7@gmail.com>
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-6-namit@vmware.com>
 <e5f84691-3475-1cbd-e46c-163bf594a4bc@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2022, at 12:41 PM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> On 3/11/22 11:07, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Calls to change_protection_range() on THP can trigger, at least on =
x86,
>> two TLB flushes for one page: one immediately, when pmdp_invalidate() =
is
>> called by change_huge_pmd(), and then another one later (that can be
>> batched) when change_protection_range() finishes.
>>=20
>> The first TLB flush is only necessary to prevent the dirty bit (and =
with
>> a lesser importance the access bit) from changing while the PTE is
>> modified. However, this is not necessary as the x86 CPUs set the
>> dirty-bit atomically with an additional check that the PTE is (still)
>> present. One caveat is Intel's Knights Landing that has a bug and =
does
>> not do so.
>=20
> First of all, thank you for your diligence here.  This is a super
> obscure issue.  I think I put handling for it in the kernel and I'm =
not
> sure I would have even thought about this angle.
>=20
> That said, I'm not sure this is all necessary.
>=20
> Yes, the Dirty bit can get set unexpectedly in some PTEs.  But, the
> question is whether it is *VALUABLE* and needs to be preserved.  The
> current kernel code pretty much just lets the hardware set the Dirty =
bit
> and then ignores it.  If it were valuable, ignoring it would have been =
a
> bad thing.  We'd be losing data on today's kernels because the =
hardware
> told us about a write that happened but that the kernel ignored.
>=20
> My mental model of what the microcode responsible for the erratum does
> is something along these lines:
>=20
> 	if (write)
> 		pte |=3D _PAGE_DIRTY;
> 	if (!pte_present(pte))
> 		#PF
>=20
> The PTE is marked dirty, but the write never actually executes.  The
> thread that triggered the A/D setting *also* gets a fault.
>=20

This makes perfect sense. I guess I misunderstood or forgot the erratum.
But feel free to recheck. It would allow to remove the KNL check, and
probably the first patch in this series. But I don=E2=80=99t think it =
would
allow to get rid of pmdp_invalidate_ad() since I do not fell comfortable
just to use pmdp_establish() directly: I do not know about other
architectures well enough to say that they have the same atomicity
guarantees when it comes to A/D bits.

> I'll double-check with some Intel folks to make sure I'm not missing
> something.  But, either way, I don't think we should be going to this
> much trouble for the good ol' Xeon Phi.  I doubt there are many still
> around and I *REALLY* doubt they're running new kernels.
>=20
> *If* we need this (and I'm not convinced we do), my first instinct =
would
> be to just do this instead:
>=20
> 	clear_cpu_cap(c, X86_FEATURE_PSE);
>=20
> on KNL systems.  If anyone cares, they know where to find us.

I think that it is not necessary and your understanding of the erratum
is the right one. Let me know if you find it is not the case.

BTW: Thanks for the quick response, and sorry for the time it took me
to send v3.

