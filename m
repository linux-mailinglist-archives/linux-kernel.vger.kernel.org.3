Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1105228CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiEKBN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiEKBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:13:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645C21AABC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:13:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y32so952634lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bz7T0QeLgAJ6DucemKvTFSRRlyGBkltInGSYnDXnR6E=;
        b=SITdpMnlNlx+3zL+SdaU/V7AVAmvkiqPssMcBSWZWWDUdtfPM2FI3GlFrfXkRXujBX
         9DWIF4Ur9OceQgYPcvcJD9fJw9kaCM0AzQ4sZUpZoprhUue1tO/tTqWR5hLzH1p6ksQR
         00Sf1wl28/tqU/6fg3271g6fUeNlfzqwzZNRgg52wEaXuyvenE+FO7wFGU35V0JkRyE/
         KeKZekt1aeYzaQ0P/YK4BNZk+xtI8SMHuieVKGSc8Vjj/SDBRoUU3xQ0u7y1HOm5z/Lx
         tGHJClst604ij70mzpHhoKbFU46qmOdfa5hyokCbDK1fsQLPyd7EbGxQ37aGOSA7H/7s
         ZRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bz7T0QeLgAJ6DucemKvTFSRRlyGBkltInGSYnDXnR6E=;
        b=iLpMTXKAxch4ZxbjtKen9fUyFcGw1qxEjU74mTOnj/YMVAGrtjmiANhljc52GmEaL5
         Q3uR/gpj++NVMgOWzHpvTbaQqSkT2j1qyLGUQo10ZXW4QY/vR0lrff22Msik0tl5khAx
         iQ7jROWcvF0VAim4m6Q0GWLb+KR8C10y0DBRUShiNpHOFL5frCcsqGeIPO/F2GEj5o20
         5VN+bt8+6EXBKGVUoU01v9YUBLzy9YRkkTg984zEHUinuEeJD5X9fzfMmmJw7DB0wQ0o
         /ATr3V3r6kitHXYEQreRy0N1yOHzPDmtC0/z2ewnZ8e9EfZ2KLunW7oCT+553Hle9v4M
         88KA==
X-Gm-Message-State: AOAM531aa8DvU3Yn65hQaJb9aa82Mg0hoYtHchweBsSzmFD16ncRUyTL
        QBmo9XBcrEiRmBWDjMBkPeqr6g==
X-Google-Smtp-Source: ABdhPJxs/icOeGtB0xTHmPLhJmWFLDgo13VXMOYoMaE6Q8CFmDYapX/c98WO7YQadPeColzl9WZUJg==
X-Received: by 2002:a05:6512:32ca:b0:473:cb3d:6ca2 with SMTP id f10-20020a05651232ca00b00473cb3d6ca2mr18143399lfg.261.1652231628067;
        Tue, 10 May 2022 18:13:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o9-20020ac24349000000b0047428dbea1csm56357lfl.303.2022.05.10.18.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:13:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 75072104757; Wed, 11 May 2022 04:15:35 +0300 (+03)
Date:   Wed, 11 May 2022 04:15:35 +0300
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
Subject: Re: [PATCHv5 08/12] x86/mm: Provide helpers for unaccepted memory
Message-ID: <20220511011535.or73rm6oviwa5niy@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-9-kirill.shutemov@linux.intel.com>
 <YnJfhiiHn+48H2vb@zn.tnic>
 <20220506161359.4j5j5fxrw53fdbyr@box.shutemov.name>
 <Ynqvtyjp77ywiI6f@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynqvtyjp77ywiI6f@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:32:23PM +0200, Borislav Petkov wrote:
> On Fri, May 06, 2022 at 07:13:59PM +0300, Kirill A. Shutemov wrote:
> > Failure to accept the memory is fatal. Why pretend it is not?
> > 
> > For TDX it will result in a crash on the first access. Prolonging the
> > suffering just make it harder to understand what happened.
> 
> Ok then. Does that panic message contain enough info so that the
> acceptance failure can be debugged?
> 
> Just "Cannot accept memory" doesn't seem very helpful to me...

Okay. Fair enough. I will change it to

			panic("Cannot accept memory: unknown platform.");

> 
> > That's true. Note also that the check is inherently racy. Other CPU can
> > get the range or subrange accepted just after spin_unlock().
> > 
> > The check indicates that accept_memory() has to be called on the range
> > before first access.
> > 
> > Do you have problem with a name? Maybe has_unaccepted_memory()?
> 
> I have a problem with the definition of this function, what it is
> supposed to do and how it is supposed to be used.
> 
> Right now, it looks weird and strange: is it supposed to check for *all*
> in-between (start, end)? It doesn't, atm, so what's the meaning of
> @start and @end then at all?

It checks if the range of memory requires accept_memory() call before it
can be accessed.

If any part of the range is not accepted, the call is required.
accept_memory() knows what exactly has to be done. Note that
accept_memory() call is harmless for any valid memory range.
It can be called on already accepted memory.

-- 
 Kirill A. Shutemov
