Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28838466618
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358427AbhLBPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358364AbhLBPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:05:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8175C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:02:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so116850583eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYZ7pWgwTOlBPwdzrVeymAp5SE5b/mIikVc6NSRBjCw=;
        b=HRnTKCfbWner7J+VmRmLdy1476/grLkVshDTtXe7fezto/zYKSM+ddX/zHJHcLPMb7
         BIzAPfa9pDaQydC7Bz2V+xcQ5SJ27hzrnhvB9LJ34I1jkanZhb3DE678CX+nw5gw+F7g
         Ags3PFyEFvujKFZQzZYsqYlHgW+pJQbwMqZO+PlJJJXTrpgFQgZY998hw1E87G0ChqEh
         0mIirNv2W2xWNZZzl+fDcAY1R4pEebH+DegaDYcd4upmMvqCMvIatEMadjkbayqdJD9K
         DwQ6e3PB6BYmseF1ND0D5R7Wa3d1xiJD7qOYHTP336A7rX7tIBU6oH2ahziEumyAkLwd
         qqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYZ7pWgwTOlBPwdzrVeymAp5SE5b/mIikVc6NSRBjCw=;
        b=VMV5TzbSgYCT3nED4fV9/XNXgvltjUPDYx33yU8yPS+LHfAsptKktc9kRTWmbsI7XD
         4L0wKS1JRbr8olB1RPqB0znlF2HTPjQDBWx5FubjA1uNjssd9kVfhCN0pUQVSGXTzOcR
         ksSL7JkjTAsGQ3coyOhcmI9W2lMVjUNdS0urXqmVzozQ0U7h9M5ya3lL6OOnPhNFLIf/
         nQWs38VDXbjvcCfgjIrxOAuSjLh0iXj2kRG3Rx0kT1IfBMu4BivplGTbNOr0NaejaV0a
         1kpT1+kfhAX/F3bomdWsIpKuCsPnEmeAKqdIHYg90bwuSljbmkkXbsxLHf3fdcanrlr/
         FHIQ==
X-Gm-Message-State: AOAM53289gSSWSHcL7sjId2vlBq+VNkBpS+NP/PsNSW+QNwNAvfLXVCf
        ll9lvb0BMWtFhJsF57pcG6tdMbZ3Uqjp3nClKYBO2g==
X-Google-Smtp-Source: ABdhPJzISUJXAYYlwt7qgLHvDKRCxJBIRO2E6l4Dwkxhcg2vX2iO31Xme1Hbgi7zcirqWaPFG5JzLfERq/4QuJTctqE=
X-Received: by 2002:a17:906:58ce:: with SMTP id e14mr15259368ejs.525.1638457306497;
 Thu, 02 Dec 2021 07:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-4-pasha.tatashin@soleen.com> <f81a6434-9f38-947e-02a8-9a9191285e52@kernel.org>
 <cadf2582-3004-92b9-ab5a-cb39259fa36c@kernel.org> <CA+CK2bBfcrxDyxnV+xc680AP+sJGHSpong6a+b_vvWcRsB2CcA@mail.gmail.com>
 <a0968570-a25a-a7e3-3ee5-b7275286c9d1@kernel.org> <172f894c-01ab-cd9f-3292-1ba811f7222a@kernel.org>
In-Reply-To: <172f894c-01ab-cd9f-3292-1ba811f7222a@kernel.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 Dec 2021 10:01:10 -0500
Message-ID: <CA+CK2bCGHBCO8+y_4E9LwV2C0bE_c0o3P4-9BXBASYFSYMpVrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86: mm: add x86_64 support for page table check
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 5:05 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 02. 12. 21, 10:59, Jiri Slaby wrote:
> > On 01. 12. 21, 14:55, Pasha Tatashin wrote:
> >> On Wed, Dec 1, 2021 at 3:44 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >>>
> >>> On 01. 12. 21, 9:00, Jiri Slaby wrote:
> >>>> On 23. 11. 21, 22:48, Pasha Tatashin wrote:
> >>>>> Add page table check hooks into routines that modify user page tables.
> >>>>
> >>>> Hi,
> >>>>
> >>>> I bisected to this as this causes crashes during modules load:
> >>>
> >>> And it's not enough to unset CONFIG_PAGE_TABLE_CHECK_ENFORCED. I had to
> >>> unset CONFIG_PAGE_TABLE_CHECK completely to get rid of this.
> >>
> >> Hi,
> >>
> >> Thanks for reporting this. Seems like module load for some reasons
> >> does not like the static branches. However, I was not able to repro
> >> this. Could you please share your config and the module that you were
> >> loading?
> >
> > It's the openSUSE's -next config:
> > https://raw.githubusercontent.com/openSUSE/kernel-source/linux-next/config/x86_64/vanilla
> >
> >
> > But with CONFIG_IWLMEI=n (as that fails to link).
> >
> > One has to load i915, other modules (71 on my system) are apparently fine.
> >
> > i915 tries to patch your `page_table_check_disabled' which is defined as
> > `DEFINE_STATIC_KEY_TRUE_RO':
> >  > jump_label_add_module: key=__tracepoint_mmap_lock_released
> > (ffffffff93f36d88) mod=0000000000000000
> >  > jump_label_add_module: key=hugetlb_free_vmemmap_enabled_key
> > (ffffffff94873560) mod=0000000000000000
> >  > jump_label_add_module: key=devmap_managed_key (ffffffff94902700)
> > mod=0000000000000000
> >  > jump_label_add_module: key=page_table_check_disabled
> > (ffffffff939da760) mod=0000000000000000
> >  > BUG: unable to handle page fault for address: ffffffff939da768
>
> Provided you EXPORT page_table_check_disabled and it can be used from
> modules, it can be barely marked as RO. So the below indeed fixes the
> problem for me:
>
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -18,7 +18,7 @@ struct page_table_check {
>   static bool __page_table_check_enabled __initdata =
>
> IS_ENABLED(CONFIG_PAGE_TABLE_CHECK_ENFORCED);
>
> -DEFINE_STATIC_KEY_TRUE_RO(page_table_check_disabled);
> +DEFINE_STATIC_KEY_TRUE(page_table_check_disabled);

Makes sense, thanks! I will remove _RO in the next version.

Pasha
