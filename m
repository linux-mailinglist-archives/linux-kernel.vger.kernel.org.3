Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945895B2387
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiIHQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiIHQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:23:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010FF8274
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:23:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nc14so39249815ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bdMeN6FnqK1npcK6VCQhFv3779r/x2/CSa4ry5MamXU=;
        b=jM4kqEGLo0x4c9SugkK2RZKbi8J75NwCzwL+WzDAvgOr3Awyy2M5reAUlyKUIwSmVQ
         J9BI623JbDsn4hxWXBzGM83644hklSb/eJHFal/qOnvs0cA5VWs+JZrHroKPGVlfzABE
         QM900Eal8QIX1v9trvzd3GY/4kUfcnb02cpp+9UP+vtuyX7zS4gRkhFcNNcpX4EOp1t5
         KVrLCi1YIyLUM44gXELwOOnu8pLYGYFBJo7roHRlNiMDIxL9Nd9BiMUzAjSEqOPoCp7r
         BJxtczTXopJ0WpmOUI5eQgMgYSP427DqVjx3c6Ov43PItJTNHC8ZNQdB7GqzQYkfhnxz
         qxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bdMeN6FnqK1npcK6VCQhFv3779r/x2/CSa4ry5MamXU=;
        b=KXOoDOUoJi0AXhCCHF6L4Yuks+bV2ny7KGRiAfvfmdbWXrgDeubTdQ35MiyA7Rmj7T
         Pc+67InK5MlzyFaydk2kXmFiVmdsd//mDWY2A9PqjKe3x2DBZKWhb2eo7y3ELFLxi+7h
         Hgfl62XMz1gqJPyTgJtW+ImJRY6CrAAzcX3oSuEBCOyA2a+/Yd1JZou6tvwtz9qWHe3T
         NkI/mhBZrtVC4IQ1IclVvY5dyYaDHe9u4yMw58OlOaKmKWvXDI23B/Ie1RaRHCn7tr18
         7UX5pV8rEyxlI+mgreh1Jas1b2QokDZG5fpTOfq4uq8f11CXdK+Azpys54gvkxdSt9zF
         m4Qg==
X-Gm-Message-State: ACgBeo0XMXRrSO+KkvhVRzKOU4UEVZj7o23UEyPE6glQfTF1vnCbzI6W
        FFYIeobCw6ENtRglnlnVedS6Ej4HEQ5yT8t3gadRCA==
X-Google-Smtp-Source: AA6agR5TviwaWPrrPIjyGF6zpvI4oDr1TURdLxrCAE9HpPDgDYml5qDeUiGF2d+s09eD9ex7BL2ntp4DzywuHlwtCbg=
X-Received: by 2002:a17:907:948f:b0:770:639:fbd1 with SMTP id
 dm15-20020a170907948f00b007700639fbd1mr6304073ejc.255.1662654198886; Thu, 08
 Sep 2022 09:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com> <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net> <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com> <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com> <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
 <YxncAElGrPEGRYg1@linux.ibm.com>
In-Reply-To: <YxncAElGrPEGRYg1@linux.ibm.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 8 Sep 2022 09:23:07 -0700
Message-ID: <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Looks like the first access to the memory map fails, although I think
> it's not in INIT_LIST_HEAD() but rather in init_page_count().
>
> I'd start with making sure that page_alloc::memmap_alloc() actually returns
> accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the memory map
> will poisoned in this function, so my guess is it'd crash there.
>

That's a wonderful hint, thank you! I did not run this test
CONFIG_DEBUG_VM set, but you think it's possible it could still be
here?

> --
> Sincerely yours,
> Mike.



-- 
-Dionna Glaze, PhD (she/her)
