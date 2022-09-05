Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AA05AD6D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiIEPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiIEPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:47:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3648C88
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fg+XnDXSnqRCu9Mai3sCVJ/hy6+I8T4qZe1klnldH0E=; b=O/HtuUvV3KD/LNUQwARMDwjHJV
        dPFQsqg/DhExbykZiQfU+NspxB4AFyTc8AHX+wzXnMVbSCG9Rl6mEZ2aXoy4xYNS2LHisCdY3AClj
        jqIV9t2+PE6K+T5ECBOZm90//MvD9HqEvYhpaDqUeko1plcLPoijv3QB4rUrzjXHSPocnGMI0mZLU
        okdZsfdTCcBAoSHE9NUNdTjv62EZuCiPUYIT3rWHDL/1lVCFe97j9dUAMO4hOeQMONJrZR9BdaUnu
        vNW2npHJiSGDmg3t/HzVcumUIL/nHPOBffW5SodeCmQ7yrC3ATLxM1m5MAwfjk+7Qz7jQ690HDUkA
        9NmoiTMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVEJH-009meN-CX; Mon, 05 Sep 2022 15:46:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC0E430030F;
        Mon,  5 Sep 2022 17:46:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 906012B972612; Mon,  5 Sep 2022 17:46:49 +0200 (CEST)
Date:   Mon, 5 Sep 2022 17:46:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Bharata B Rao <bharata@amd.com>, ananth.narayan@amd.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YxYZ6Q+JVg79aDNS@hirez.programming.kicks-ass.net>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
 <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
 <20220905134457.a2f7uluq42frsgwe@box.shutemov.name>
 <YxYIAVx2qJLMDJlC@hirez.programming.kicks-ass.net>
 <20220905153517.k6ctaqqtkcyu2zmn@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905153517.k6ctaqqtkcyu2zmn@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 06:35:17PM +0300, Kirill A. Shutemov wrote:
> What about something like this?
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 803241dfc473..868d2730884b 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -30,8 +30,10 @@ static inline bool pagefault_disabled(void);
>   */
>  #define untagged_addr(mm, addr)	({					\
>  	u64 __addr = (__force u64)(addr);				\
> -	s64 sign = (s64)__addr >> 63;					\
> -	__addr &= (mm)->context.untag_mask | sign;			\
> +	if (static_cpu_has(X86_FEATURE_LAM)) {				\
> +		s64 sign = (s64)__addr >> 63;				\
> +		__addr &= (mm)->context.untag_mask | sign;		\
> +	}								\
>  	(__force __typeof__(addr))__addr;				\
>  })

Well, if you go throught the trouble of adding it, might as well use a
regular static branch and only enable it once there's an actual user,
no?
