Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E851DBF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442835AbiEFPcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381187AbiEFPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D194C689AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:28:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so13164446lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zft6jLRsO2R4fi/u6eN2DfU9nqCVAT62ZsK14nFpt1E=;
        b=XDOiXFe386wjEOozpamYgEKo6bjtMbmjBf6MAneBln9fKLJlP6D2htacG8pzD1PGag
         BDq35Fa8Jpg8S9B46om+RPRvalMJRvhTP12mCthVw04+GIgsTZZ7yVjRl0C2uaZpdQHC
         8OpoKg0LwaxmGb/ePwtsDwYTb3jaSpG+mwpzDih1r/KU1JVhv8MR88J3nqjoxUySV0OI
         5N4XU13sXdHYAnCl7C6y700kjlTOas6pb2SdDml26o3R7qJD6Z+elI87woyqaQY5fKXw
         jj2vMHlsbxuxthwiM0wNModQBoVRqRPRT7CB8psqAq0/tw5mU99TYQsucmHQg68j/agn
         GQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zft6jLRsO2R4fi/u6eN2DfU9nqCVAT62ZsK14nFpt1E=;
        b=NnBiyqJ07bgRU+OoUl32PKJxx8cJqbPhf+r6D7Hb4Z0x1Tj/pCWcTxz5jLqVq70z/f
         j+3DY3GjJb4j4wpwi3f+phVoUeHAgxEo5DfANxrt3HLtAwNPhROh/r59IELhaMahO2aJ
         gfwJGUsEiiNtf/vbHKAT8CcOMbi/0fdXJQfaNa1jBMp/uzcMRSIHg7E8T0H4l4CPUhmf
         ieGd2O7OYsfLZylCIvpkUejNHRDHb2kqntCX3zQBwjaZENkUVm6QAQtrq++rWUxUDUQP
         KtmuHVgkvANNbhbFq8YYkU8OxkRTzfdnNBvUB1wUhZfhc8doq7i58lVlZsw/zbWkK0/Z
         dwJw==
X-Gm-Message-State: AOAM5327DrhtG9+CQJsw+DATGCyRpZRjpegk0fM69Mf5u68EEaAesDdu
        3ja8b9Wq+73aeVH3b2i7f4Brng==
X-Google-Smtp-Source: ABdhPJzSks1evkqP1ANajMwXUMiRnp5YNHTtlO8WobyEatT1ULtkq78uH626+6mTFAvCVPK3HC3lUw==
X-Received: by 2002:a05:6512:12c9:b0:473:c4c1:5558 with SMTP id p9-20020a05651212c900b00473c4c15558mr2929618lfg.75.1651850908074;
        Fri, 06 May 2022 08:28:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2494b000000b0047255d2118dsm721772lfi.188.2022.05.06.08.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 08:28:27 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8AB91104AFD; Fri,  6 May 2022 18:30:13 +0300 (+03)
Date:   Fri, 6 May 2022 18:30:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20220506153013.e6v4q2qhuhqumfiu@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <YnE4ZzzVrxUnr3Uv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnE4ZzzVrxUnr3Uv@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 04:12:55PM +0200, Borislav Petkov wrote:
> On Mon, Apr 25, 2022 at 06:39:28AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 411b268bc0a2..59db90626042 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -725,10 +725,20 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >  		 * but in practice there's firmware where using that memory leads
> >  		 * to crashes.
> >  		 *
> > -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> > +		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
> > +		 * supported) are guaranteed to be free.
> >  		 */
> > -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> > +
> > +		switch (md->type) {
> > +		case EFI_CONVENTIONAL_MEMORY:
> > +			break;
> > +		case EFI_UNACCEPTED_MEMORY:
> > +			if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> > +				break;
> >  			continue;
> > +		default:
> > +			continue;
> > +		}
> 
> Is there any special reason for this to be a switch-case or can it
> simply be a compound conditional if (bla...) ?

The equivalent 'if' statement is something like:

		if (md->type != EFI_CONVENTIONAL_MEMORY &&
		    !(md->type == EFI_UNACCEPTED_MEMORY && IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)))
		    continue;

I find it harder to follow.

Do you want me to change to the 'if' anyway?

-- 
 Kirill A. Shutemov
