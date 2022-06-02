Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B953BB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiFBPcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiFBPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:31:56 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C7BCA4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:31:52 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f83983782fso55139777b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Knz9JmJqm4EucxNHcnCzTZMEqb1eXMDB2BBmxOvSfo=;
        b=A5BEurTXTqPI2SJfMM+0Og5mkfT1VMkGbC38WlggmdEdOivuFGZMJrBOEArKLrgmjd
         ispcV5TBg8MDV6Pw1F93Jo101+POqcpuj3mm1Cx7/NWgjNEQVIrUM26/JOdE6eIM9PNe
         NK5jB9oLoo+rd+ELGFkAdAstHirBUwRDd0X1CRUyvyl4zf02btaqHCrhk1Mo3f2mp9p1
         PwcArktmbaggGkq20umNK6JKAtWRVvfsfnKee0/0oA68IQr72FAwhg3zsPurigPZynB4
         WrPeKRvKMWcdQNpGntCfhvjn3oaDTMSsKRF5TSZ/yGtFOgxPk0tMfTtjbfikgukep6cx
         7O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Knz9JmJqm4EucxNHcnCzTZMEqb1eXMDB2BBmxOvSfo=;
        b=6CeU/mLpgXLD6QON6xbooSQ+6RRfc7aUIPtVUwtJGm3YdYS/PUFhTzsaVIwMV3kqq3
         1uZOacuQ/k4/cmyCuPNN66yj2HAFUkcIKu9ylzKvSeWtl71FuFqlCG3M+nPGVyJSlNaT
         20M9M0LqD1+rXSUUX5N5u/ahXDSj4k0iMBkErQ2l7Q00ckmN1HoaS6JNcMNAkGTrxvCB
         +RAnceiy0XvOWLam4xotaNrDL1EB1X+LErZME5DRCnz11eVye1GerwDKidTCUO9Tc301
         nItPUaw1MAKHZrUpBasZbGyM2F2AD+ul0hV5CfGAq1Pbq0pMzYn99aig4x9tf6qpgG5r
         c6/g==
X-Gm-Message-State: AOAM531tNiCZYFcaDjt0DZ9iXDIUkhtFFSK7rV9RVUTL627nHbrwH18i
        0PLUwJC+dCLa9DmVix2vKbdexHVwZ1MOdSpJBNTiuw==
X-Google-Smtp-Source: ABdhPJyDgn+XcjAIve032i0v41nPDh9/gB1Ke2pcinTpAdoGGtfFIm2nBM+7mIhCzFsvqob6zbUErmaGn6ssSdJrp54=
X-Received: by 2002:a0d:ca08:0:b0:30c:b11b:8cfc with SMTP id
 m8-20020a0dca08000000b0030cb11b8cfcmr6352036ywd.362.1654183911131; Thu, 02
 Jun 2022 08:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com> <YnE4ZzzVrxUnr3Uv@zn.tnic>
 <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name> <YnpGnMoviGoK4Ucq@zn.tnic>
 <CAAH4kHYRxgUNnGRUO473q02q3akLzgiTvbA2qKEP5jq6jFV-uA@mail.gmail.com>
 <Yn4ed1gupKmNz2jn@zn.tnic> <20220513144515.fx2cvo3rjued3vy5@black.fi.intel.com>
 <PH0PR11MB5064B561086BE6350CC1DCDCC5CF9@PH0PR11MB5064.namprd11.prod.outlook.com>
 <CAAH4kHbU4FJ=veYQxncdpYD837M90vq2o2saVaUCJ6=pfuNRpA@mail.gmail.com>
 <0c545c5f-3540-1441-7a7d-359b6795f43a@amd.com> <CAAH4kHYj9WOKngeXYL=KnNb1fXa-MaFGTBGZcBX726Od858Q3A@mail.gmail.com>
 <19ac7bbc-82f1-8350-8638-163303d682b1@amd.com>
In-Reply-To: <19ac7bbc-82f1-8350-8638-163303d682b1@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 2 Jun 2022 08:31:40 -0700
Message-ID: <CAAH4kHbPyCAxwQgqPpgDQ3bEioHZ+WboUMGTHazxC9f9jEEwWg@mail.gmail.com>
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     "Xu, Min M" <min.m.xu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        "Gao, Jiaqi" <jiaqi.gao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rodel, Jorg" <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 5:51 AM Gupta, Pankaj <pankaj.gupta@amd.com> wrote:
> AFAIU the unaccepted memory also stays in buddy (first via slow path)
> and should be accounted automatically in free?
>

No, the last patch adds unaccepted mem as a differently accounted memory type.

> >
> > So when I see 2044MB free vs 7089MB free in my VMs, the two are
> > roughly 5GB different.
>
> Is it possible all memory got allocated with memblock? Maybe some
> variable tests to validate with '/proc/meminfo | grep UnacceptedMem'
> would give you more clue.
>

free -k parses /proc/meminfo for MemFree and SwapFree in
/proc/meminfo, so it sounds like it should also add in UnacceptedMem.
We'll try that. Thanks.




--
-Dionna Glaze, PhD (she/her)
