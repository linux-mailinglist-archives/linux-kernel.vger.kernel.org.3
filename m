Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754B6578F49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiGSAcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGSAb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:31:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF81FCF9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:31:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j67so1292516ybb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lsamAysK+D7t3yFkcKTH1MEIBtg3Azfl3puoX8VWXY=;
        b=N1Wbe909IAYh0k1c0q3IBpwrF0vkTzYBojcD7NeJU3RTBP0OrIsiUGrpT4h6qpZf3V
         QDNioz9XC8Lw6egH20udd0+qOkhomryPva44T+r4z2lA6qfIU4I5Mg8K+C4gXTGyqnI8
         PaJkgvRSpy7dY3eV9EsscgTCZSVRB9yK9+KDqyVBzAHl7MO+vOkp8oYMiCZG5jeOqATi
         ItXnvm4JA9a8YY6Rz+vn/NRS5OFaBHdLX2V7ycQLodgUMBJiv64oguOV0wW5asLGQpsa
         hNL7a8Sz/P584O+kqiTPBOOiNjbUc3zZVYochBrQFUpXJzYhScAP2rwRC4JBqRIxix4f
         0PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lsamAysK+D7t3yFkcKTH1MEIBtg3Azfl3puoX8VWXY=;
        b=3pT+jXbMvqrHWcal+C/yykgaDWCpyxiH2nMatJ0bC783588ESKFyjuJ5XndpvaFvgk
         tZ4KE0XbNXnD9FsRPhE6WM2DUUMlwqUoX8xt5aD/+mAaYrxDwsvRlelaPhLTVsIzk3Oi
         NGc/bx8PsqUOXXsev986mo+Suyo54pfQPZVp+jYNdmxvSvx1ZgH4O5zIaPOwNSciuQAn
         JTpot2aL9MHquz2U9JA053h+4VNIcONEcYhiCL5zFIgD/tVgGId7vHoIG7JgBi+9WnHI
         8THnek/+49fYSA8+6dHahd2Asp1grF+m1k415CqTkAYd4POK6XWS9o8+FTag5zkbV916
         Ii9w==
X-Gm-Message-State: AJIora8NO22EBdwq0mWD/P+iChxdvWzOuhp0tFCPEz9BYE/ln01fEaYY
        j2HACCVuiJOzTi9QfE36CtMxLDSdYLGzDlamu7pzHQ==
X-Google-Smtp-Source: AGRyM1u6jw/9GsvIFrdn5mPqwawQg/dodMYn3j8iTaH/WO8OEZs9/9EuC+uiSYhsKacsWERu9bEQQbbDOA9kVERpeSQ=
X-Received: by 2002:a25:868b:0:b0:670:830c:15aa with SMTP id
 z11-20020a25868b000000b00670830c15aamr40509ybk.297.1658190715594; Mon, 18 Jul
 2022 17:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <20220627113019.3q62luiay7izhehr@black.fi.intel.com> <CAMj1kXHD5XBAS1aBjzg1RCeK6qgtanUSED_xyTZ0v1j+UShMKw@mail.gmail.com>
 <20220627122230.7eetepoufd5w3lxd@black.fi.intel.com> <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
 <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com> <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com> <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
In-Reply-To: <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 18 Jul 2022 17:31:44 -0700
Message-ID: <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think we should make it obvious from a kernel image if it supports
> > unaccepted memory (with UTS_VERSION or other way).
> >

Something I didn't address in my previous email: how would the UEFI
know where the kernel is to parse this UTS_VERSION out when it's
booting a bootloader before Linux gets booted?

-- 
-Dionna Glaze, PhD (she/her)
