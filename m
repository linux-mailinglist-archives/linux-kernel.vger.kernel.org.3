Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8546A593412
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiHORea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHORe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:34:27 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63EF24098
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:34:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 355FB3200978;
        Mon, 15 Aug 2022 13:34:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 13:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660584863; x=1660671263; bh=s8
        F5Li3vLXtiHsgPNRcWkpFl7ut43BURsDBMgZOTsU8=; b=DHsHchmeMXQCRyU3aM
        jlgJK7s49Lft57hqXe0uWIZHN/kg1Ax2mynbSaBkHuCzuZ4xEYU0flcw3CpQblID
        0jaqwrjiTD5mhBczkgm00mg9sLvqAkYalWHtYfOnU3JalKNldaYzMjiJ/JgH1jy1
        npa9ANx3eL37kYoY/29vdqecJ1eUA4562ZNAGeLCkFjfe5wRJXW6++eG6Hz+Rooi
        J4zRs/tOOoFEcX1nZlyprspioJMVf5wSYnS/7ud56zYegS61KINMBoV239zGQxMu
        eHWvgU0pifa41kNe8XFnHKdswe9zLRqM80R+HRP4iKKiFhXtcvFF0hLVvgyytQRM
        P1GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660584863; x=1660671263; bh=s8F5Li3vLXtiHsgPNRcWkpFl7ut4
        3BURsDBMgZOTsU8=; b=bp4pJT2YbiY6d4r7eCyBP33QhuR3vchYjmgT1pFZI5/G
        t0PuyUkiSpSroZQNlN516Sh8RdI29lBLDAQ+Go4Yz5MI1YLoUK0xyvapX2aQofHJ
        RVAyPsWRq1z6E8O18hstgsV9k1mWwq1d4XjtzHZX9RTijjqGzpSHLfwoHkHqo6Sy
        wskaCoWTxDnO5iTunxMEKxCiem17W42rkPUfUox11vIdy7aiXfbjhdNQSH07tzZU
        +O0OOVnFXjuY6Cc9bL6H2DpC78vNSGRGX5h57oA9RkUdiYOn/3TsC7eQ7Fuc59zv
        uMBF0WPAreIXTqNBg4kEWx9mxhpcAgyGUSWHMowVBg==
X-ME-Sender: <xms:n4P6YhPyL_8xwu5wRGTzrwWZRXpA5wziWtc4u-1UzQQoCzM8uwVrAg>
    <xme:n4P6Yj9AYaZ0FeJmgGrItKHM78wn3pRzJ9Hp5Gv9tCwbdjO1duhPYINTMv2HEOYbe
    SUecB1DPjTxo9zJGyg>
X-ME-Received: <xmr:n4P6YgRNlQpjWqmIRziFRjQ-lgwUNi0rzNmyUHNMx6_hT8ITjv5kyqDAYlLv31Flbz72xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:n4P6YtvOVmHz46Casle9b3B6OpQUux3mrg0y7SRGk1A2o15lUvXnBw>
    <xmx:n4P6YpeZ9kdvBoKAnJPVRTgkYX6kqY3EkAXYZnB-HOdrlcqYjL-46Q>
    <xmx:n4P6Yp2rFzyW_Jdje4JUPbcgYq20eagXHpsYw_51gBmLAd2yQzsetg>
    <xmx:n4P6Yk2Ye5ipPffW6UIIV1B8CRiQ-ZlTaHWLBbYGaeyd5ePzrgpveQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 13:34:22 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0F94E104A4B; Mon, 15 Aug 2022 20:37:25 +0300 (+03)
Date:   Mon, 15 Aug 2022 20:37:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 04/11] x86/mm: Handle LAM on context switch
Message-ID: <20220815173725.ph6ogtqneiqwqek7@box.shutemov.name>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-5-kirill.shutemov@linux.intel.com>
 <YvpNQSEtu+Tbqrpd@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvpNQSEtu+Tbqrpd@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:42:25PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 07:17:56AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index c1e31e9a85d7..fdc0b69b5da7 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -154,17 +154,18 @@ static inline u16 user_pcid(u16 asid)
> >  	return ret;
> >  }
> >  
> > -static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
> > +static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
> >  {
> >  	if (static_cpu_has(X86_FEATURE_PCID)) {
> > -		return __sme_pa(pgd) | kern_pcid(asid);
> > +		return __sme_pa(pgd) | kern_pcid(asid) | lam;
> >  	} else {
> >  		VM_WARN_ON_ONCE(asid != 0);
> > -		return __sme_pa(pgd);
> > +		return __sme_pa(pgd) | lam;
> >  	}
> >  }
> >  
> > -static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
> > +static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
> > +					      unsigned long lam)
> >  {
> >  	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
> >  	/*
> > @@ -173,7 +174,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
> >  	 * boot because all CPU's the have same capabilities:
> >  	 */
> >  	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
> > -	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
> > +	return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
> >  }
> 
> Looking at this; I wonder if we want something like this:
> 
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -157,6 +157,7 @@ static inline u16 user_pcid(u16 asid)
>  static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
>  {
>  	if (static_cpu_has(X86_FEATURE_PCID)) {
> +		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
>  		return __sme_pa(pgd) | kern_pcid(asid) | lam;
>  	} else {
>  		VM_WARN_ON_ONCE(asid != 0);
> @@ -167,14 +168,13 @@ static inline unsigned long build_cr3(pg
>  static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
>  					      unsigned long lam)
>  {
> -	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
>  	/*
>  	 * Use boot_cpu_has() instead of this_cpu_has() as this function
>  	 * might be called during early boot. This should work even after
>  	 * boot because all CPU's the have same capabilities:
>  	 */
>  	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
> -	return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
> +	return build_cr3(pgd, asid, lam) | CR3_NOFLUSH;
>  }

Looks sane, but seems unrelated to the patch. Is it okay to fold it
anyway?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
