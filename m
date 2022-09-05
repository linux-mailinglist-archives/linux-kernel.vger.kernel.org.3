Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ECC5AD7CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiIEQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiIEQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:47:15 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A5952E6A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:47:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E6A1E3200922;
        Mon,  5 Sep 2022 12:47:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Sep 2022 12:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662396431; x=1662482831; bh=pp
        gpksPj3y7l/SkP6fbnYixZ5NsMp5i64ReQbaQaQMA=; b=yyKUbp7mX1moIfaL+p
        Xj8tS/Nfe1V1QB/SGnLAtDucoXuFalE54Hph/uQ5pG0G1QX8uJPbzUwN1j0P7iRf
        xHdEJYNmUhTQLECwNXPlBcddlmYT+L1SXkpbwGMelKrPhEbG9eHQLVsDGsl3O+sC
        znNaZKihayL6z6K6JELs6AoHmtTThG2SS959Qci7Tc++fGNCalZKfx63W2VQBtgb
        cQK4x+X9tzVnECI792C0A/mKnU0QzpeamMHSp9sdpadU4xe+O03Zfa431VL/ZTBS
        2BaUy2Af6rETdTspOpioZ5VkcYZbBazLhx8A/cvTh8wQhuQoztrnW4S4qwDv3HlT
        V0Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662396431; x=1662482831; bh=ppgpksPj3y7l/SkP6fbnYixZ5NsM
        p5i64ReQbaQaQMA=; b=PSxp21Edx/pX3ATvS2mm73/xkrQZtdTqPFBm18B07LwD
        3JA7dcjM8/4cx5hFRLIebxHTnU9ie7IG87yHrgaieVsLPktHh5FKNU3ccrUnxp7d
        EG/t2GbACzpJr4GmZvLo0h+ya4u5eNLuZ/rtPyE5vozlshabPeusk2K0yWwj7Xo0
        G5zDHRhvekVEU3pyaT5Z9iN08BkkqeJBaWxoQhohYf93/ScEOJUYHIC0t/OU1U0D
        HVkTuwRZtCOcE8EGZA7iNLeAXcnc8qhU3ZGNdtT6gNJOzIHkUx2XB+D1oOvTN0RJ
        JMwT2C9n/911A4FS4ulJvYah7QtUmQwqnWK12dk4Ng==
X-ME-Sender: <xms:DygWY0v8UGChFUFDzbIoUWSiY5tc3Nk7U-hgqipvUi9zMO0MXWRNTQ>
    <xme:DygWYxfqQKzsPVa5mlReUvY_v_85uJTSU2-W9YFv-9uF3JGiDKryCgs6gng4jOW3l
    UP6W91e3fRXgNcDOYE>
X-ME-Received: <xmr:DygWY_ytiGCPWplltKLBmoLcsjz-xp7-Vqq7RfgE1tXslznm3RRHji8IZESrlqyvhePN1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:DygWY3PotRfgutHzKLtRTrdeg2PLPqjT78Skdq2Layr8FQx2MEXzyQ>
    <xmx:DygWY08Pk8ezq-YroNLsLSe3jubZtJiYDxFxB12Dk6oM-oJ0OP3aFg>
    <xmx:DygWY_UaGTmhININo1VE8CluM4H7h6Pl_fotPrq1j9Iau_L8aKtl5g>
    <xmx:DygWY0Mk8Coqs_3KGKTOkvZJ9-6pqrYlt7AT78CPKUvwQcsbB_P5gg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Sep 2022 12:47:11 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0ED0E1044CD; Mon,  5 Sep 2022 19:47:08 +0300 (+03)
Date:   Mon, 5 Sep 2022 19:47:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20220905164708.ewx5lulbqdjrk3mx@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
 <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
 <20220905134457.a2f7uluq42frsgwe@box.shutemov.name>
 <YxYIAVx2qJLMDJlC@hirez.programming.kicks-ass.net>
 <20220905153517.k6ctaqqtkcyu2zmn@box.shutemov.name>
 <YxYZ6Q+JVg79aDNS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYZ6Q+JVg79aDNS@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:46:49PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 05, 2022 at 06:35:17PM +0300, Kirill A. Shutemov wrote:
> > What about something like this?
> > 
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > index 803241dfc473..868d2730884b 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -30,8 +30,10 @@ static inline bool pagefault_disabled(void);
> >   */
> >  #define untagged_addr(mm, addr)	({					\
> >  	u64 __addr = (__force u64)(addr);				\
> > -	s64 sign = (s64)__addr >> 63;					\
> > -	__addr &= (mm)->context.untag_mask | sign;			\
> > +	if (static_cpu_has(X86_FEATURE_LAM)) {				\
> > +		s64 sign = (s64)__addr >> 63;				\
> > +		__addr &= (mm)->context.untag_mask | sign;		\
> > +	}								\
> >  	(__force __typeof__(addr))__addr;				\
> >  })
> 
> Well, if you go throught the trouble of adding it, might as well use a
> regular static branch and only enable it once there's an actual user,
> no?

Fair enough. How about this?

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 803241dfc473..1a03c65a9c0f 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -22,6 +22,8 @@ static inline bool pagefault_disabled(void);
 #endif
 
 #ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
+
 /*
  * Mask out tag bits from the address.
  *
@@ -30,8 +32,10 @@ static inline bool pagefault_disabled(void);
  */
 #define untagged_addr(mm, addr)	({					\
 	u64 __addr = (__force u64)(addr);				\
-	s64 sign = (s64)__addr >> 63;					\
-	__addr &= (mm)->context.untag_mask | sign;			\
+	if (static_branch_unlikely(&tagged_addr_key)) {			\
+		s64 sign = (s64)__addr >> 63;				\
+		__addr &= (mm)->context.untag_mask | sign;		\
+	}								\
 	(__force __typeof__(addr))__addr;				\
 })
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 337f80a0862f..63194bf43c9a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -742,6 +742,9 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+DEFINE_STATIC_KEY_FALSE(tagged_addr_key);
+EXPORT_SYMBOL_GPL(tagged_addr_key);
+
 static void enable_lam_func(void *mm)
 {
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
@@ -813,6 +816,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	}
 
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	static_branch_enable(&tagged_addr_key);
 out:
 	mutex_unlock(&mm->context.lock);
 	mmap_write_unlock(mm);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
