Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0E956AD4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiGGVMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiGGVM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:12:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C3D2FFCE;
        Thu,  7 Jul 2022 14:12:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k30so16556487edk.8;
        Thu, 07 Jul 2022 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7lBX2NVyR4wLZQ7armge/PHuuUWSeFzw9RQb5K1xo8=;
        b=WtBL5NKziFNuFTThNyyKxNqq993+zYRIUkT4vjvf6Boey1TYr16Iy6Kg5WLl0accKf
         M3R3r0q5cjZhKBrhC9F9Pts9C/B1qSR9RpD87Et+zf1VDKnlCjjQtaOl+FxU5cHCdQFE
         qNvHSRvgbBlLaOzHhWtRzkJOzd6WJ3Pjb8lA48fKI1LdbRfNt4V2peiD0LbFdI/eU0BO
         Hikqrd9EUNEUs/L5yQnYPwFDZW7qx3ed2N1uIurkM9Ul1Wntrc5LOR9dQeXdpfT9Kjmg
         JtRAfK2OS+/rk+0JTFTLdpdFS88Nke5QOhX6rtFm/D/ylsf/SIIBskXzaByujWUh0b9c
         SnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7lBX2NVyR4wLZQ7armge/PHuuUWSeFzw9RQb5K1xo8=;
        b=DzxBdO3dxLcqcfvL3/3ljhb6k1IFgLrDyJlPbxLcBRoU7FFFL1ur0sTPv0JL/XoEIE
         t8hM0fSaTV0E2HwshM2kInFzhBrZUASOtKRgf1PUe98bCceKVmtkd1T9MV7/Aw6Cv11+
         lpFtYq5cNmzz/Km4l2pxZr2VrrBc5DZDpHbppbF5J8vJvYMnNaWVEqJ6e98wtlhYmDnm
         wr+WKINWz9mSXrdptxhmMmcUGzOVBBb3FOONUafqP6SVWA0dHqxaU0YJQNO6Vn+OPcKw
         zB/d0cmsDfWIksicjzwaKwQH0bB74FgxNKjfVCW7KG0d4tAJjkWyopKjtq2/FlYrxTyy
         oMaw==
X-Gm-Message-State: AJIora9J/T6imWWFIoK8xozmy9a0sXAYo4IiR6xxvOXOkIHNWzo0MXv0
        wDOiCAGtjI1Dw1bSXmWMNtokU0pvP9NUaAcFRPGVBbld9/98uQ==
X-Google-Smtp-Source: AGRyM1uu3GWZeriqyMwRw43BUsAdyD5/Ff+Q6S+6/8raxI7MhcRy13mOivlcRjUlnjBx7zoR3TsKjCB8RuKwpaY+71w=
X-Received: by 2002:a05:6402:42cb:b0:43a:5df2:bb5d with SMTP id
 i11-20020a05640242cb00b0043a5df2bb5dmr138776edc.36.1657228345125; Thu, 07 Jul
 2022 14:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125242.425242-1-21cnbao@gmail.com> <20220707125242.425242-4-21cnbao@gmail.com>
 <be65d342-0d4d-473c-2ba8-bc58b708bfac@intel.com>
In-Reply-To: <be65d342-0d4d-473c-2ba8-bc58b708bfac@intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 8 Jul 2022 09:12:14 +1200
Message-ID: <CAGsJ_4zdAjBVbmWXC_M=530QwC=SnuK9783dcaNSCywZAJwgsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: rmap: Extend tlbbatch APIs to fit new platforms
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>, x86 <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        Yicong Yang <yangyicong@hisilicon.com>, huzhanyuan@oppo.com,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        real mz <realmz6@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 4:43 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/7/22 05:52, Barry Song wrote:
> >  static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> > -                                     struct mm_struct *mm)
> > +                                     struct mm_struct *mm,
> > +                                     struct vm_area_struct *vma,
> > +                                     unsigned long uaddr)
> >  {
>
> It's not a huge deal, but could we pass 'vma' _instead_ of 'mm'?  The
> implementations could then just use vma->vm_mm instead of the passed-in mm.

Yes, Dave. Peter made the same suggestion in 4/4.
will get this fixed in v2.

Thanks
Barry
